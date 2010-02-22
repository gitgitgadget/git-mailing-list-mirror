From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 6/6] Use git_mkstemp_mode instead of plain mkstemp to create object files
Date: Mon, 22 Feb 2010 23:32:16 +0100
Message-ID: <1266877936-13537-7-git-send-email-Matthieu.Moy@imag.fr>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: nhat minh le <nhat.minh.le@huoc.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 22 23:36:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njgsr-0001WC-Bu
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787Ab0BVWgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:36:04 -0500
Received: from mx2.imag.fr ([129.88.30.17]:39333 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754458Ab0BVWgB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 17:36:01 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o1MMUCbi028158
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Feb 2010 23:30:12 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NjgpM-0007kr-Re; Mon, 22 Feb 2010 23:32:32 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NjgpM-0003XW-QR; Mon, 22 Feb 2010 23:32:32 +0100
X-Mailer: git-send-email 1.7.0.54.gb6a04.dirty
In-Reply-To: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 22 Feb 2010 23:30:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o1MMUCbi028158
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1267482612.89993@PiYIYo5+lsVgqwMYDxIQSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140727>

We used to unnecessarily give the read permission to group and others,
regardless of the umask, which isn't serious because the objects are
still protected by their containing directory, but isn't necessary
either.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 sha1_file.c            |    6 +++---
 t/t1304-default-acl.sh |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

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
diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 8472dbb..cc30be4 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -54,7 +54,7 @@ test_expect_success 'Setup test repo' '
 	git commit -m "init"
 '
 
-test_expect_failure 'Objects creation does not break ACLs with restrictive umask' '
+test_expect_success 'Objects creation does not break ACLs with restrictive umask' '
 	# SHA1 for empty blob
 	check_perms_and_acl .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
 '
-- 
1.7.0.54.gb6a04.dirty
