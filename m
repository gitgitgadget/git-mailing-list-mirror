From: Jeff King <peff@peff.net>
Subject: Re: git push keeps writing after server failure
Date: Fri, 12 Jun 2015 14:20:45 -0400
Message-ID: <20150612182045.GA23698@peff.net>
References: <CAJo=hJvzjnLFhF4REBzX=pgFamBfu7hZeZidy_8Rmi_DwwR4Nw@mail.gmail.com>
 <20150612181256.GB9242@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 20:20:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3TZV-0006VN-Md
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 20:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799AbbFLSUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 14:20:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:45365 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755789AbbFLSUs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 14:20:48 -0400
Received: (qmail 2411 invoked by uid 102); 12 Jun 2015 18:20:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 13:20:48 -0500
Received: (qmail 16726 invoked by uid 107); 12 Jun 2015 18:20:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 14:20:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jun 2015 14:20:45 -0400
Content-Disposition: inline
In-Reply-To: <20150612181256.GB9242@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271510>

On Fri, Jun 12, 2015 at 02:12:56PM -0400, Jeff King wrote:

> > $ git push --all git@github.com:spearce/wk.git
> > Counting objects: 2752427, done.
> > Delta compression using up to 12 threads.
> > Compressing objects: 100% (442684/442684), done.
> > remote: fatal: pack exceeds maximum allowed size
> > Writing objects: 100% (2752427/2752427), 5.28 GiB | 8.86 MiB/s, done.
> > Total 2752427 (delta 2225007), reused 2752427 (delta 2225007)
> > fatal: The remote end hung up unexpectedly
> > fatal: The remote end hung up unexpectedly
> > 
> > Notice GitHub prints "remote: fatal: pack exceeds maximum allowed
> > size". That interrupted my "Writing objects" progress meter, and then
> > git push just kept going and wrote really really fast (170 MiB/s!)
> > until the entire pack was sent.
> 
> Sounds like it's writing to a closed fd, then. Which makes sense; I
> think we should hang up the socket after writing the "fatal" message
> above.

For reference, here's the patch implementing the max-size check on the
server. It's on my long list of patches to clean up and send to the
list; I never did this one because of the unpack-objects caveat
mentioned below.

The death happens in index-pack. I think receive-pack should notice that
and bail (closing the socket), but it's possible that it doesn't.

There's also a git-aware proxying layer at GitHub between clients and
git-receive-pack these days. It's possible that it is not properly
hanging up until it sees EOF from the client.

If any of those things are true, then it is a GitHub-specific problem
(which I still want to fix, but it is not something git upstream needs
to care about).

-- >8 --
Date: Tue, 4 Sep 2012 12:01:06 -0400
Subject: [PATCH] receive-pack: allow a maximum input size to be specified

Receive-pack feeds its input to index-pack, which will
happily accept as many bytes as a sender is willing to
provide. Let's allow an arbitrary cutoff point where we will
stop writing bytes to disk (they're still left in the
tmp_pack, but cleaning that can easily be done outside of
receive-pack).

Note that this doesn't handle the git-unpack-objects code
path at all (because GitHub sets transfer.unpacklimit to 1,
so we never unpack pushed objects anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c   |  5 +++++
 builtin/receive-pack.c | 14 +++++++++++++-
 t/t5528-push-limits.sh | 27 +++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100755 t/t5528-push-limits.sh

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dd1c5c9..054a144 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -70,6 +70,7 @@ static struct progress *progress;
 static unsigned char input_buffer[4096];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
+static off_t max_input_size;
 static unsigned deepest_delta;
 static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
@@ -167,6 +168,8 @@ static void use(int bytes)
 	if (signed_add_overflows(consumed_bytes, bytes))
 		die("pack too large for current definition of off_t");
 	consumed_bytes += bytes;
+	if (max_input_size && consumed_bytes > max_input_size)
+		die("pack exceeds maximum allowed size");
 }
 
 static const char *open_pack_file(const char *pack_name)
@@ -1148,6 +1151,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 					opts.off32_limit = strtoul(c+1, &c, 0);
 				if (*c || opts.off32_limit & 0x80000000)
 					die("bad %s", arg);
+			} else if (!prefixcmp(arg, "--max-input-size=")) {
+				max_input_size = strtoul(arg + 17, NULL, 10);
 			} else
 				usage(index_pack_usage);
 			continue;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0afb8b2..e64b8d2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -31,6 +31,7 @@ static int transfer_fsck_objects = -1;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
+static off_t max_input_size;
 static int report_status;
 static int use_sideband;
 static int quiet;
@@ -113,6 +114,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.maxsize") == 0) {
+		max_input_size = git_config_ulong(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -832,9 +838,10 @@ static const char *unpack(void)
 			return NULL;
 		return "unpack-objects abnormal exit";
 	} else {
-		const char *keeper[7];
+		const char *keeper[8];
 		int s, status, i = 0;
 		char keep_arg[256];
+		char max_input_arg[256];
 		struct child_process ip;
 
 		s = sprintf(keep_arg, "--keep=receive-pack %"PRIuMAX" on ", (uintmax_t) getpid());
@@ -848,6 +855,11 @@ static const char *unpack(void)
 		keeper[i++] = "--fix-thin";
 		keeper[i++] = hdr_arg;
 		keeper[i++] = keep_arg;
+		if (max_input_size) {
+			snprintf(max_input_arg, sizeof(max_input_arg),
+				 "--max-input-size=%lu", max_input_size);
+			keeper[i++] = max_input_arg;
+		}
 		keeper[i++] = NULL;
 		memset(&ip, 0, sizeof(ip));
 		ip.argv = keeper;
diff --git a/t/t5528-push-limits.sh b/t/t5528-push-limits.sh
new file mode 100755
index 0000000..c2f6d77
--- /dev/null
+++ b/t/t5528-push-limits.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='check input limits for pushing'
+. ./test-lib.sh
+
+test_expect_success 'create known-size commit' '
+	test-genrandom foo 1024 >file &&
+	git add file &&
+	test_commit one-k
+'
+
+test_expect_success 'create remote repository' '
+	git init --bare dest &&
+	git --git-dir=dest config receive.unpacklimit 1
+'
+
+test_expect_success 'receive.maxsize rejects push' '
+	git --git-dir=dest config receive.maxsize 512 &&
+	test_must_fail git push dest HEAD
+'
+
+test_expect_success 'bumping limit allows push' '
+	git --git-dir=dest config receive.maxsize 4k &&
+	git push dest HEAD
+'
+
+test_done
-- 
2.4.2.752.geeb594a
