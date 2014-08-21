From: Jeff King <peff@peff.net>
Subject: [PATCH] send-pack: take refspecs over stdin
Date: Thu, 21 Aug 2014 08:17:10 -0400
Message-ID: <20140821121709.GA15299@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 14:17:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKRIr-0007uC-Kq
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 14:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbaHUMRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 08:17:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:56169 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754058AbaHUMRM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 08:17:12 -0400
Received: (qmail 18673 invoked by uid 102); 21 Aug 2014 12:17:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Aug 2014 07:17:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2014 08:17:10 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255607>

Pushing a large number of refs works over most transports,
because we implement send-pack as an internal function.
However, it can sometimes fail when pushing over http,
because we have to spawn "git send-pack --stateless-rpc" to
do the heavy lifting, and we pass each refspec on the
command line. This can cause us to overflow the OS limits on
the size of the command line for a large push.

We can solve this by giving send-pack a --stdin option and
using it from remote-curl.  We already dealt with this on
the fetch-pack side in 078b895 (fetch-pack: new --stdin
option to read refs from stdin, 2012-04-02). The stdin
option (and in particular, its use of packet-lines for
stateless-rpc input) is modeled after that solution.

Signed-off-by: Jeff King <peff@peff.net>
---
I had to fiddle with the numbers in the http test. Linux gives up to 1/4
of the configured stack ulimit as space for the cmdline, so I had to
pick a number big enough so that we had stack to run the actual
operation but small enough to limit the cmdline. The test as it is there
fails for me without this patch and succeeds with it. I suspect the
numbers are quite different on other systems, but I think it should at
least succeed everywhere with this patch. I'd also be fine with cutting
that test if it proves too flaky.

I tried originally bumping it to 50,000 tags to match the fetch-pack
test. But besides needing to protect it behind an EXPENSIVE prereq
(which means basically nobody is ever going to run it), it also seems to
trigger a nasty quadratic behavior in send-pack (6400 refs takes ~16s,
with the time quadrupling for each doubling of refs; the same operation
over a pipe takes 140ms).  Oddly, the behavior doesn't seem to trigger
when pushing over a local pipe, so it's presumably related to
stateless-rpc. It looked like were deep in match_refs, but I haven't
figured it out beyond that.

 Documentation/git-send-pack.txt | 13 ++++++++++++-
 builtin/send-pack.c             | 27 +++++++++++++++++++++++++++
 remote-curl.c                   |  8 +++++++-
 t/t5541-http-push-smart.sh      | 15 +++++++++++++++
 4 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index dc3a568..2a0de42 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -35,6 +35,16 @@ OPTIONS
 	Instead of explicitly specifying which refs to update,
 	update all heads that locally exist.
 
+--stdin::
+	Take the list of refs from stdin, one per line. If there
+	are refs specified on the command line in addition to this
+	option, then the refs from stdin are processed after those
+	on the command line.
++
+If '--stateless-rpc' is specified together with this option then
+the list of refs must be in packet format (pkt-line). Each ref must
+be in a separate packet, and the list must end with a flush packet.
+
 --dry-run::
 	Do everything except actually send the updates.
 
@@ -77,7 +87,8 @@ this flag.
 Without '--all' and without any '<ref>', the heads that exist
 both on the local side and on the remote side are updated.
 
-When one or more '<ref>' are specified explicitly, it can be either a
+When one or more '<ref>' are specified explicitly (whether on the
+command line or via `--stdin`), it can be either a
 single pattern, or a pair of such pattern separated by a colon
 ":" (this means that a ref name cannot have a colon in it).  A
 single pattern '<name>' is just a shorthand for '<name>:<name>'.
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f420b74..4b1bc0f 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -110,6 +110,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int flags;
 	unsigned int reject_reasons;
 	int progress = -1;
+	int from_stdin = 0;
 	struct push_cas_option cas = {0};
 
 	argv++;
@@ -169,6 +170,10 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				args.stateless_rpc = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--stdin")) {
+				from_stdin = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--helper-status")) {
 				helper_status = 1;
 				continue;
@@ -201,6 +206,28 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	}
 	if (!dest)
 		usage(send_pack_usage);
+
+	if (from_stdin) {
+		struct argv_array all_refspecs = ARGV_ARRAY_INIT;
+
+		for (i = 0; i < nr_refspecs; i++)
+			argv_array_push(&all_refspecs, refspecs[i]);
+
+		if (args.stateless_rpc) {
+			const char *buf;
+			while ((buf = packet_read_line(0, NULL)))
+				argv_array_push(&all_refspecs, buf);
+		} else {
+			struct strbuf line = STRBUF_INIT;
+			while (strbuf_getline(&line, stdin, '\n') != EOF)
+				argv_array_push(&all_refspecs, line.buf);
+			strbuf_release(&line);
+		}
+
+		refspecs = all_refspecs.argv;
+		nr_refspecs = all_refspecs.argc;
+	}
+
 	/*
 	 * --all and --mirror are incompatible; neither makes sense
 	 * with any refspecs.
diff --git a/remote-curl.c b/remote-curl.c
index 0fcf2ce..558b9fe 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -863,6 +863,7 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 	int i, err;
 	struct argv_array args;
 	struct string_list_item *cas_option;
+	struct strbuf preamble = STRBUF_INIT;
 
 	argv_array_init(&args);
 	argv_array_pushl(&args, "send-pack", "--stateless-rpc", "--helper-status",
@@ -880,17 +881,22 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 	for_each_string_list_item(cas_option, &cas_options)
 		argv_array_push(&args, cas_option->string);
 	argv_array_push(&args, url.buf);
+
+	argv_array_push(&args, "--stdin");
 	for (i = 0; i < nr_spec; i++)
-		argv_array_push(&args, specs[i]);
+		packet_buf_write(&preamble, "%s\n", specs[i]);
+	packet_buf_flush(&preamble);
 
 	memset(&rpc, 0, sizeof(rpc));
 	rpc.service_name = "git-receive-pack",
 	rpc.argv = args.argv;
+	rpc.stdin_preamble = &preamble;
 
 	err = rpc_service(&rpc, heads);
 	if (rpc.result.len)
 		write_or_die(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
+	strbuf_release(&preamble);
 	argv_array_clear(&args);
 	return err;
 }
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 73af16f..db19988 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -323,5 +323,20 @@ test_expect_success 'push into half-auth-complete requires password' '
 	test_cmp expect actual
 '
 
+run_with_limited_cmdline () {
+	(ulimit -s 128 && "$@")
+}
+
+test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
+
+test_expect_success CMDLINE_LIMIT 'push 2000 tags over http' '
+	sha1=$(git rev-parse HEAD) &&
+	test_seq 2000 |
+	  sort |
+	  sed "s|.*|$sha1 refs/tags/really-long-tag-name-&|" \
+	  >.git/packed-refs &&
+	run_with_limited_cmdline git push --mirror
+'
+
 stop_httpd
 test_done
-- 
2.1.0.346.ga0367b9
