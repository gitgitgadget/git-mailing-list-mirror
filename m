From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] sha1_name: stop hard-coding 40-character hex checks
Date: Sat, 15 Jun 2013 23:08:25 +0530
Message-ID: <1371317906-3991-2-git-send-email-artagnon@gmail.com>
References: <1371317906-3991-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 19:40:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnuSp-0002G9-LQ
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 19:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323Ab3FORkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 13:40:21 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62109 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab3FORkT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 13:40:19 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so1595001pab.13
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 10:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6fSbhzxkwRCl51tEqgsBSvs8QVhmyC3yRc7mSxViaus=;
        b=DzZql+yPiw4/o2EbGSSwfdJIS3fnY4NoG3ABjprskbYdgAQkoFToDc2NIqmjacTkYq
         Saf4SZ9k7Zy40eGLcHuRFViOx5Ls3j78SzduCJTaIhv9hw/JJroiJfJTQbUsMVE/+xom
         jE3yKmLOanImvDobmWGi1SHk4VtsEHomsc9FrNXKfoTaRifNi5Ra5Dm03zgZTc8hKrVK
         I8HPYFnQMPlmpaw0gjO3zmS8D4/rWKfmOdh4Iws8MOAm3AUP9Z4URO9DwF+njnbn5+rg
         5nA/uCtQpp909a6SZMSW5slzY3yTRey8W88T3sI5rVhRxHo8d3ii1/gb7zZsAWUbsvNv
         AEsA==
X-Received: by 10.68.129.10 with SMTP id ns10mr7055470pbb.13.1371318018547;
        Sat, 15 Jun 2013 10:40:18 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id ri8sm7032290pbc.3.2013.06.15.10.40.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 10:40:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.438.g96d34e8
In-Reply-To: <1371317906-3991-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227963>

In two places, get_sha1_basic() assumes that strings are possibly sha1
hexes if they are 40 characters long, and calls get_sha1_hex() in these
two cases.  This 40-character check is ugly and wrong: there is nothing
preventing a revision or branch name from being exactly 40 characters.
Replace it with a call to the more robust get_short_sha1().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 90419ef..d862af3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -451,7 +451,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	int refs_found = 0;
 	int at, reflog_len, nth_prior = 0;
 
-	if (len == 40 && !get_sha1_hex(str, sha1)) {
+	if (!get_short_sha1(str, strlen(str), sha1, GET_SHA1_QUIETLY)) {
 		refs_found = dwim_ref(str, len, tmp_sha1, &real_ref);
 		if (refs_found > 0 && warn_ambiguous_refs) {
 			warning(warn_msg, len, str);
@@ -492,9 +492,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		int detached;
 
 		if (interpret_nth_prior_checkout(str, &buf) > 0) {
-			detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
+			detached = get_short_sha1(buf.buf, buf.len, sha1, GET_SHA1_QUIETLY);
 			strbuf_release(&buf);
-			if (detached)
+			if (detached != SHORT_NAME_NOT_FOUND)
 				return 0;
 		}
 	}
-- 
1.8.3.1.438.g96d34e8
