From: Jeff King <peff@peff.net>
Subject: [PATCH] config: treat non-existent config files as empty
Date: Thu, 21 Oct 2010 10:45:44 -0400
Message-ID: <20101021144544.GA18901@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 16:45:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8wOK-0003GF-Ek
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 16:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758491Ab0JUOpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 10:45:05 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52928 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755185Ab0JUOpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 10:45:03 -0400
Received: (qmail 5835 invoked by uid 111); 21 Oct 2010 14:45:02 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 21 Oct 2010 14:45:02 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Oct 2010 10:45:44 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159510>

The git_config() function signals error by returning -1 in
two instances:

  1. An actual error occurs in opening a config file (parse
     errors cause an immediate die).

  2. Of the three possible config files, none was found.

However, this second case is often not an error at all; it
simply means that the user has no configuration (they are
outside a repo, and they have no ~/.gitconfig file). This
can lead to confusing errors, such as when the bash
completion calls "git config --list" outside of a repo. If
the user has a ~/.gitconfig, the command completes
succesfully; if they do not, it complains to stderr.

This patch allows callers of git_config to distinguish
between the two cases. Error is signaled by -1, and
otherwise the return value is the number of files parsed.
This means that the traditional "git_config(...) < 0" check
for error should work, but callers who want to know whether
we parsed any files or not can still do so.

Signed-off-by: Jeff King <peff@peff.net>
---
Another cleaned up re-post. Original discussion here:

  http://article.gmane.org/gmane.comp.version-control.git/128206

Your original questions/objections were:

  1. Does it still error on GIT_CONFIG=/nonexistent? I said then I
     hadn't tested. I just did, and it does still produce an error.

  2. You mentioned some other issues in the config code. While I agree
     they could be fixed, they are outside the scope of this patch,
     which does fix something we both agreed was a bug.

The original also had to fix up a callsite for the new semantics, but
that callsite is now gone.

 config.c               |    4 +---
 t/t1300-repo-config.sh |    8 ++++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 4b0a820..c63d683 100644
--- a/config.c
+++ b/config.c
@@ -871,9 +871,7 @@ int git_config(config_fn_t fn, void *data)
 	if (config_parameters)
 		found += 1;
 
-	if (found == 0)
-		return -1;
-	return ret;
+	return ret == 0 ? found : ret;
 }
 
 /*
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 074f2f2..6f6ed2d 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -289,6 +289,14 @@ test_expect_success 'working --list' \
 	'git config --list > output && cmp output expect'
 
 cat > expect << EOF
+EOF
+
+test_expect_success '--list without repo produces empty output' '
+	git --git-dir=nonexistent config --list >output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
 beta.noindent sillyValue
 nextsection.nonewline wow2 for me
 EOF
-- 
1.7.3.1.235.gdd6c0
