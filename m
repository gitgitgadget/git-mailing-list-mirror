From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Fix git_mkstemp to return an error when path is too long.
Date: Thu, 26 Jul 2007 03:32:52 +0200
Message-ID: <46A7F9C4.7030004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 03:33:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDsE9-0002Zs-1D
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 03:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbXGZBdH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 21:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753330AbXGZBdH
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 21:33:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:6641 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757550AbXGZBdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 21:33:04 -0400
Received: by ug-out-1314.google.com with SMTP id j3so453550ugf
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 18:33:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=dDKYZ1c8klxrRvT3zbEJytAkdA2Y/3NHYStsrBeKC8oZjmLHttIJAVC9zFYAX+stNiKfsrq+5x6YQ4xPVSx/HMR6OkI4xmsGD8a1rfWZSgFVCk23sHZQlCl1p2ZhVOqZ231dCU0+jhbdg2dewtX3H8RCmxzARrilzWSqjPyzn0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ocmJ0i1DrRSAHCJK3ZiVBMoBG8XQcts8l66/R3lw2hXm6SQKdyIOw6Ld0kVop/o4Kh2onZIQYAis5iZzcxY/6k7+4jv7MKn8f7hiclI3EqIqJS9c6iJeUwJAdEJy61t4MHm4BRdNmJkMno+4U5TOz1mj1Vgc7vsTfYnnzq+YHKw=
Received: by 10.67.89.5 with SMTP id r5mr1785659ugl.1185413583695;
        Wed, 25 Jul 2007 18:33:03 -0700 (PDT)
Received: from ?192.168.0.194? ( [212.145.102.186])
        by mx.google.com with ESMTPS id i8sm1669004nfh.2007.07.25.18.33.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jul 2007 18:33:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53745>

Now the function returns -2 to the caller if the given buffer
is too short to save the entire path for the temporary file.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 diff.c |    2 ++
 path.c |    9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index cd6b0c4..8735467 100644
--- a/diff.c
+++ b/diff.c
@@ -1694,6 +1694,8 @@ static void prep_temp_blob(struct diff_tempfile *temp,
 	int fd;

 	fd = git_mkstemp(temp->tmp_path, PATH_MAX, ".diff_XXXXXX");
+	if (fd == -2)
+		die("path too long for temp-file");
 	if (fd < 0)
 		die("unable to create temp-file");
 	if (write_in_full(fd, blob, size) != size)
diff --git a/path.c b/path.c
index c4ce962..f33d15d 100644
--- a/path.c
+++ b/path.c
@@ -68,7 +68,8 @@ char *git_path(const char *fmt, ...)
 }


-/* git_mkstemp() - create tmp file honoring TMPDIR variable */
+/* git_mkstemp() - create tmp file honoring TMPDIR variable.
+ * return -2 if path is too long to have it concatenated. */
 int git_mkstemp(char *path, size_t len, const char *template)
 {
 	char *env, *pch = path;
@@ -79,12 +80,14 @@ int git_mkstemp(char *path, size_t len, const char *template)
 		pch += 5;
 	} else {
 		size_t n = snprintf(pch, len, "%s/", env);
-
+		if (n >= len)
+			return -2;
 		len -= n;
 		pch += n;
 	}

-	strlcpy(pch, template, len);
+	if (strlcpy(pch, template, len) >= len)
+		return -2;

 	return mkstemp(path);
 }
-- 
1.5.0
