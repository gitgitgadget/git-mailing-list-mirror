From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] archive: limit ourselves during remote requests
Date: Tue, 15 Nov 2011 16:48:40 -0500
Message-ID: <20111115214840.GB20624@sigill.intra.peff.net>
References: <20111115214159.GA20457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 22:48:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQQs3-0001zO-En
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 22:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756370Ab1KOVsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 16:48:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42815
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753588Ab1KOVsm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 16:48:42 -0500
Received: (qmail 10370 invoked by uid 107); 15 Nov 2011 21:48:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Nov 2011 16:48:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2011 16:48:40 -0500
Content-Disposition: inline
In-Reply-To: <20111115214159.GA20457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185491>

Originally, the call-chain of an upload-archive invocation
was like:

  cmd_archive (on local machine)
    run_remote_archiver (local)
      cmd_upload_archive (on remote machine)
	run_upload_archive (remote)
	  write_archive (remote)

And write_archive knew that it could be remotely invoked,
and didn't trust the arguments given to it when doing
anything security-critical.

Since c09cd77 (upload-archive: use start_command instead of
fork, 2011-10-24), we exec a git-archive subprocess, and the
call-chain is now:

  cmd_archive (local)
    run_remote_archiver (local)
      cmd_upload_archive (remote)
        cmd_archive (in a sub-process)
          write_archive

The arbitrary arguments we get from the client are passed
through cmd_archive via the command-line of git-archive.
Unlike write_archive, cmd_archive was never taught not to
trust the remote arguments. Among the many horrible things a
malicious client could do were:

  - accessing another repository as the user running on the
    server, using "--remote"

  - execute arbitrary code as the user running on the server
    using "--remote --exec"

  - overwrite arbitrary files using "--output"

This patch causes cmd_archive to respect the remote-request
flag immediately and chain to write_archive, ignoring any
other options.

Signed-off-by: Jeff King <peff@peff.net>
---
This is the minimal required to fix it.

I mentioned already the alternative of allowing through only known-good
arguments in upload-pack's prepare_argv. I don't like that because it
means we have to know about every option that write_archive is OK with.

I think a more sensible solution would be a new command, "git
upload-archive--remote", which is just a very stripped-down version of
git-archive (i.e., it _only_ calls write_archive). Or it could even be
spelled "git upload-archive --remote-request". But the point is that
git-archive never needed to worry about security before.  We
shouldn't be polluting it with security code; we should be bypassing it
going to write_archive directly.

For the tests, checking each failure mode is perhaps overkill, but I
want to be double sure that this doesn't ever regress.

 builtin/archive.c   |    9 +++++++++
 t/t5000-tar-tree.sh |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index fce20a1..ee2fb54 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -104,6 +104,15 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, local_opts, NULL,
 			     PARSE_OPT_KEEP_ALL);
 
+	/*
+	 * We want to ignore all other parsed options in the remote case, as
+	 * they come from an arbitrary client. Therefore we shouldn't do things
+	 * like write files based on --output, or make new --remote
+	 * connections.
+	 */
+	if (is_remote)
+		return write_archive(argc, argv, prefix, 0, NULL, 1);
+
 	if (output)
 		create_output_file(output);
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 723b54e..5679c79 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -317,6 +317,45 @@ test_expect_success 'malicious clients cannot un-remote themselves' '
 	test_must_fail git upload-archive . <evil-request >remote.tar.foo
 '
 
+# Again, we have to hand-craft our malicious request. Since parsing
+# the output to determine that we did indeed get subrepo would be hard,
+# instead we use an easier test: try to get a branch only in the subrepo,
+# which must fail if our hack doesn't work.
+test_expect_success 'malicious clients cannot access repos via --remote' '
+	git init subrepo &&
+	(cd subrepo &&
+	 test_commit subrepo &&
+	 git branch only-in-subrepo
+	) &&
+	{
+		echo "0021argument --remote=../subrepo"
+		echo "001dargument only-in-subrepo" &&
+		printf "0000"
+	} >evil-request &&
+	test_must_fail git upload-archive . <evil-request >evil-output
+'
+
+test_expect_success 'malicious clients cannot exec code via --remote' '
+	{
+		echo "0021argument --remote=../subrepo"
+		echo "0026argument --exec=echo foo >hax0red"
+		echo "0012argument HEAD" &&
+		printf "0000"
+	} >evil-request &&
+	test_might_fail git upload-archive . <evil-request >evil-output &&
+	test_path_is_missing .git/hax0red
+'
+
+test_expect_success 'malicious clients cannot trigger --output on server' '
+	{
+		echo "001dargument --output=p0wn3d"
+		echo "0012argument HEAD" &&
+		printf "0000"
+	} >evil-request &&
+	git upload-archive . <evil-request >remote.tar &&
+	test_path_is_missing .git/p0wn3d
+'
+
 if $GZIP --version >/dev/null 2>&1; then
 	test_set_prereq GZIP
 else
-- 
1.7.7.3.8.g38efa
