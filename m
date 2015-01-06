From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] update-server-info: create info/* with mode 0666
Date: Mon, 5 Jan 2015 22:50:49 -0500
Message-ID: <20150106035048.GB20087@peff.net>
References: <20150106034702.GA11503@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Sokolovsky <paul.sokolovsky@linaro.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 04:51:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8LAW-0005vE-5u
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 04:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbbAFDuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 22:50:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:59313 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753364AbbAFDuv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 22:50:51 -0500
Received: (qmail 3778 invoked by uid 102); 6 Jan 2015 03:50:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jan 2015 21:50:51 -0600
Received: (qmail 6874 invoked by uid 107); 6 Jan 2015 03:51:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jan 2015 22:51:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jan 2015 22:50:49 -0500
Content-Disposition: inline
In-Reply-To: <20150106034702.GA11503@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262045>

Prior to d38379e (make update-server-info more robust,
2014-09-13), we used a straight "fopen" to create the
info/refs and objects/info/packs files, which creates the
file using mode 0666 (less the default umask).

In d38379e, we switched to creating the file with mkstemp
to get a unique filename. But mkstemp also uses the more
restrictive 0600 mode to create the file. This was an
unintended side effect that we did not want, and causes
problems when the repository is served by a different user
than the one running update-server-info (it is no longer
readable by a dumb http server running as `www`, for
example).

We can fix this by using git_mkstemp_mode and specifying
0666.  Note that we could also say "just use
core.sharedrepository", as we do call adjust_shared_perm
on the result before renaming it into place.  But that is
not very friendly. The shared-repo config is usually about
making things _writable_ for other users. Until d38379e,
there was no explicit config needed to serve an otherwise
readable repository, and we should consider it a
regression.

Signed-off-by: Jeff King <peff@peff.net>
---
 server-info.c          |  2 +-
 t/t1301-shared-repo.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/server-info.c b/server-info.c
index 31f4a74..34b0253 100644
--- a/server-info.c
+++ b/server-info.c
@@ -17,7 +17,7 @@ static int update_info_file(char *path, int (*generate)(FILE *))
 	FILE *fp = NULL;
 
 	safe_create_leading_directories(path);
-	fd = mkstemp(tmp);
+	fd = git_mkstemp_mode(tmp, 0666);
 	if (fd < 0)
 		goto out;
 	fp = fdopen(fd, "w");
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 86ed901..feff55e 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -111,6 +111,16 @@ do
 
 done
 
+test_expect_success POSIXPERM 'info/refs is readable in unshared repo' '
+	rm -f .git/info/refs &&
+	test_unconfig core.sharedrepository &&
+	umask 002 &&
+	git update-server-info &&
+	echo "-rw-rw-r--" >expect &&
+	modebits .git/info/refs >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 	umask 077 &&
 	git config core.sharedRepository group &&
-- 
2.2.1.425.g441bb3c
