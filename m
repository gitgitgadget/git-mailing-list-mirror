From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] fsck: give accurate error message on empty loose object files
Date: Mon,  6 Feb 2012 17:24:52 +0100
Message-ID: <1328545492-13429-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqfwf6en6e.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 06 17:25:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuRNX-0006Wc-I8
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 17:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473Ab2BFQZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 11:25:11 -0500
Received: from mx2.imag.fr ([129.88.30.17]:48476 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab2BFQZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 11:25:10 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q16GM3u5020201
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 Feb 2012 17:22:03 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1RuRNA-0005Ml-Ca; Mon, 06 Feb 2012 17:24:56 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1RuRNA-0003VE-9c; Mon, 06 Feb 2012 17:24:56 +0100
X-Mailer: git-send-email 1.7.9.111.gf3fb0.dirty
In-Reply-To: <vpqfwf6en6e.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 06 Feb 2012 17:22:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q16GM3u5020201
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1329150128.84895@L6NJg2MLm3PRYVWVvSzHyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190077>

Since 3ba7a065527a (A loose object is not corrupt if it
cannot be read due to EMFILE), "git fsck" on a repository with an empty
loose object file complains with the error message

  fatal: failed to read object <sha1>: Invalid argument

This comes from a failure of mmap on this empty file, which sets errno to
EINVAL. Instead of calling xmmap on empty file, we display a clean error
message ourselves, and return a NULL pointer. The new message is

  error: object file .git/objects/09/<rest-of-sha1> is empty
  fatal: loose object <sha1> (stored in .git/objects/09/<rest-of-sha1>) is corrupt

The second line was already there before the regression in 3ba7a065527a,
and the first is an additional message, that should help diagnosing the
problem for the user.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 sha1_file.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 88f2151..fafc187 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1202,6 +1202,11 @@ void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 
 		if (!fstat(fd, &st)) {
 			*size = xsize_t(st.st_size);
+			if (*size == 0) {
+				/* mmap() is forbidden on empty files */
+				error("object file %s is empty", sha1_file_name(sha1));
+				return NULL;
+			}
 			map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
 		}
 		close(fd);
-- 
1.7.9.111.gf3fb0.dirty
