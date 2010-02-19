From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 6/6] Use git_mkstemp_mode instead of plain mkstemp to create object files
Date: Sat, 20 Feb 2010 00:21:58 +0100
Message-ID: <1266621718-4879-6-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq7hq8stjt.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 20 00:25:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NicED-0000O4-P5
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 00:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224Ab0BSXZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 18:25:41 -0500
Received: from mx1.imag.fr ([129.88.30.5]:41566 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755872Ab0BSXZl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 18:25:41 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o1JNJvA4018195
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 20 Feb 2010 00:19:57 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NicAk-0001DO-9R; Sat, 20 Feb 2010 00:22:10 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NicAk-0001Ha-7n; Sat, 20 Feb 2010 00:22:10 +0100
X-Mailer: git-send-email 1.7.0.rc2.92.gb6a04
In-Reply-To: <vpq7hq8stjt.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 20 Feb 2010 00:19:57 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140500>

We used to unnecessarily give the read permission to group and others,
regardless of the umask, which isn't serious because the objects are
still protected by their containing directory, but isn't necessari
either.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 sha1_file.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 657825e..3316f28 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2206,7 +2206,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 	}
 
 out:
-	if (set_shared_perm(filename, (S_IFREG|0444)))
+	if (adjust_shared_perm(filename))
 		return error("unable to set permission to '%s'", filename);
 	return 0;
 }
@@ -2262,7 +2262,7 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 	}
 	memcpy(buffer, filename, dirlen);
 	strcpy(buffer + dirlen, "tmp_obj_XXXXXX");
-	fd = mkstemp(buffer);
+	fd = git_mkstemp_mode(buffer, 0444);
 	if (fd < 0 && dirlen && errno == ENOENT) {
 		/* Make sure the directory exists */
 		memcpy(buffer, filename, dirlen);
@@ -2272,7 +2272,7 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
 
 		/* Try again */
 		strcpy(buffer + dirlen - 1, "/tmp_obj_XXXXXX");
-		fd = mkstemp(buffer);
+		fd = git_mkstemp_mode(buffer, 0444);
 	}
 	return fd;
 }
-- 
1.7.0.rc2.92.gb6a04
