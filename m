From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Expand the rename(2) workaround in mingw to cover case
	change in filename
Date: Mon, 8 Jun 2009 22:32:48 +0200
Message-ID: <20090608203248.GA22972@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 22:33:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDlWh-0004u7-Im
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 22:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbZFHUcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 16:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbZFHUcx
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 16:32:53 -0400
Received: from mout3.freenet.de ([195.4.92.93]:47637 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbZFHUcw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 16:32:52 -0400
Received: from [195.4.92.16] (helo=6.mx.freenet.de)
	by mout3.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1MDlWV-0006rI-QH; Mon, 08 Jun 2009 22:32:51 +0200
Received: from x7a70.x.pppool.de ([89.59.122.112]:53914 helo=tigra.home)
	by 6.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1MDlWV-0004da-ED; Mon, 08 Jun 2009 22:32:51 +0200
Received: from blimp.localdomain (blimp.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 50A04277D8;
	Mon,  8 Jun 2009 22:32:49 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 042CA36D28; Mon,  8 Jun 2009 22:32:48 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121100>

Windows, being a case-confused operating system, sometimes has
problems renaming directory entries with only change in the case
of their characters. Try to work the problem around by using an
intermediate file.

---

NOT TESTED. Can't. My Windows broke again. Not even compile-tested.

And sorry for somewhat extended Cc:. Thought the problem need a little
more experienced attention (then again, maybe it doesn't).

That's a response to Bug 228 (which is properly "WONTFIX",
if you ask my opinion):

    http://code.google.com/p/msysgit/issues/detail?id=228

I don't like it, but it is the same what people usually forced to do
anyway, so here it is.

It has a racing problem which can cause the original file be renamed
into a temporary name (as returned by mkstemp):

    - the rename of the source name to temp name succeeds
    - the rename of temp name to destination name fails (i.e. it
      exists and is open)

It is not fixable (because the atomicity of rename(2) is broken by the
intermediate name and two separate calls to rename involved).
I could have tried to rename back to source, but got fed up with
another Windows stupidity and gave up.

 compat/mingw.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e190fdd..ad60dff 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -931,21 +931,12 @@ int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz)
 	return connect(s, sa, sz);
 }
 
-#undef rename
-int mingw_rename(const char *pold, const char *pnew)
+static int move_file_replace(const char *pold, const char *pnew)
 {
 	DWORD attrs, gle;
 	int tries = 0;
 	static const int delay[] = { 0, 1, 10, 20, 40 };
 
-	/*
-	 * Try native rename() first to get errno right.
-	 * It is based on MoveFile(), which cannot overwrite existing files.
-	 */
-	if (!rename(pold, pnew))
-		return 0;
-	if (errno != EEXIST)
-		return -1;
 repeat:
 	if (MoveFileEx(pold, pnew, MOVEFILE_REPLACE_EXISTING))
 		return 0;
@@ -982,6 +973,60 @@ repeat:
 	return -1;
 }
 
+#undef rename
+int mingw_rename(const char *pold, const char *pnew)
+{
+	int fd, rc = -1;
+	char *p, *tmp = NULL;
+
+	/*
+	 * Try native rename() first to get errno right.
+	 * It is based on MoveFile(), which cannot overwrite existing files.
+	 */
+	if (!rename(pold, pnew))
+		return 0;
+	if (errno != EEXIST)
+		return -1;
+	/*
+	 * Windows' case-insensitivity does not allow it to directly
+	 * do a rename where the only change in the file name is
+	 * the change of a letter case. Work this around with a
+	 * temporary file.
+	 */
+	if (!dst) {
+		errno = EINVAL;
+		goto fail;
+	}
+	tmp = malloc(strlen(dst) + 7 /* reserved for template */);
+	if (!tmp) {
+		errno = ENOMEM;
+		goto fail;
+	}
+	strcpy(tmp, dst);
+	p = tmp + strlen(dst);
+	for (p = tmp + strlen(dst); p > tmp; --p)
+		if ('\\' == *p || '/' == *p) {
+			++p;
+			break;
+		}
+	strcpy(p, "XXXXXX")
+	fd = mkstemp(tmp);
+	if (fd < 0)
+		goto fail;
+	close(fd);
+	if (move_file_replace(src, tmp)) {
+		rc = errno;
+		unlink(tmp);
+		errno = rc;
+		rc = -1;
+		goto fail;
+	}
+	rc = move_file_replace(tmp, dst);
+fail:
+	free(tmp);
+	return rc;
+}
+
 struct passwd *getpwuid(int uid)
 {
 	static char user_name[100];
-- 
1.6.3.2.214.g82a9d
