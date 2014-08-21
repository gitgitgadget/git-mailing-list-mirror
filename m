From: Jeff King <peff@peff.net>
Subject: [PATCH v2] send-pack: take refspecs over stdin
Date: Thu, 21 Aug 2014 08:21:20 -0400
Message-ID: <20140821122120.GA17600@peff.net>
References: <20140821121709.GA15299@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 14:21:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKRMs-0001V5-PM
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 14:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbaHUMVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 08:21:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:56172 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751006AbaHUMVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 08:21:22 -0400
Received: (qmail 18924 invoked by uid 102); 21 Aug 2014 12:21:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Aug 2014 07:21:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2014 08:21:20 -0400
Content-Disposition: inline
In-Reply-To: <20140821121709.GA15299@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255608>

On Thu, Aug 21, 2014 at 08:17:10AM -0400, Jeff King wrote:

>  Documentation/git-send-pack.txt | 13 ++++++++++++-
>  builtin/send-pack.c             | 27 +++++++++++++++++++++++++++
>  remote-curl.c                   |  8 +++++++-
>  t/t5541-http-push-smart.sh      | 15 +++++++++++++++
>  4 files changed, 61 insertions(+), 2 deletions(-)

Whoops. Forgot to actually add the battery of individual send-pack
tests. Here's a re-send.

-- >8 --
Subject: send-pack: take refspecs over stdin

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
 Documentation/git-send-pack.txt | 13 +++++-
 builtin/send-pack.c             | 27 ++++++++++++
 remote-curl.c                   |  8 +++-
 t/t5408-send-pack-stdin.sh      | 92 +++++++++++++++++++++++++++++++++++++++++
 t/t5541-http-push-smart.sh      | 15 +++++++
 5 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100755 t/t5408-send-pack-stdin.sh

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
diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
new file mode 100755
index 0000000..e8737df
--- /dev/null
+++ b/t/t5408-send-pack-stdin.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+test_description='send-pack --stdin tests'
+. ./test-lib.sh
+
+create_ref () {
+	tree=$(git write-tree) &&
+	test_tick &&
+	commit=$(echo "$1" | git commit-tree $tree) &&
+	git update-ref "$1" $commit
+}
+
+clear_remote () {
+	rm -rf remote.git &&
+	git init --bare remote.git
+}
+
+verify_push () {
+	git rev-parse "$1" >expect &&
+	git --git-dir=remote.git rev-parse "${2:-$1}" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'setup refs' '
+	cat >refs <<-\EOF &&
+	refs/heads/A
+	refs/heads/C
+	refs/tags/D
+	refs/heads/B
+	refs/tags/E
+	EOF
+	for i in $(cat refs); do
+		create_ref $i || return 1
+	done
+'
+
+# sanity check our setup
+test_expect_success 'refs on cmdline' '
+	clear_remote &&
+	git send-pack remote.git $(cat refs) &&
+	for i in $(cat refs); do
+		verify_push $i || return 1
+	done
+'
+
+test_expect_success 'refs over stdin' '
+	clear_remote &&
+	git send-pack remote.git --stdin <refs &&
+	for i in $(cat refs); do
+		verify_push $i || return 1
+	done
+'
+
+test_expect_success 'stdin lines are full refspecs' '
+	clear_remote &&
+	echo "A:other" >input &&
+	git send-pack remote.git --stdin <input &&
+	verify_push refs/heads/A refs/heads/other
+'
+
+test_expect_success 'stdin mixed with cmdline' '
+	clear_remote &&
+	echo A >input &&
+	git send-pack remote.git --stdin B <input &&
+	verify_push A &&
+	verify_push B
+'
+
+test_expect_success 'cmdline refs written in order' '
+	clear_remote &&
+	test_must_fail git send-pack remote.git A:foo B:foo &&
+	verify_push A foo
+'
+
+test_expect_success '--stdin refs come after cmdline' '
+	clear_remote &&
+	echo A:foo >input &&
+	test_must_fail git send-pack remote.git --stdin B:foo <input &&
+	verify_push B foo
+'
+
+test_expect_success 'refspecs and --mirror do not mix (cmdline)' '
+	clear_remote &&
+	test_must_fail git send-pack remote.git --mirror $(cat refs)
+'
+
+test_expect_success 'refspecs and --mirror do not mix (stdin)' '
+	clear_remote &&
+	test_must_fail git send-pack remote.git --mirror --stdin <refs
+'
+
+test_done
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
