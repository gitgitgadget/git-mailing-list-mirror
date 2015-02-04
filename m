From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: [PATCH v2] ewah: fix building with gcc < 3.4.0
Date: Wed, 4 Feb 2015 09:23:16 +0100
Message-ID: <1423038196-804-1-git-send-email-tgc@statsbiblioteket.dk>
References: <xmqqlhkepsyl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 09:23:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIvFB-000152-R2
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 09:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbbBDIXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2015 03:23:20 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:11776 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753983AbbBDIXT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Feb 2015 03:23:19 -0500
Received: from throll.localdomain (172.18.234.199) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.3.389.2; Wed, 4 Feb 2015 09:23:16 +0100
Received: by throll.localdomain (Postfix, from userid 3000)	id 87F17400EB4;
 Wed,  4 Feb 2015 09:23:16 +0100 (CET)
X-Mailer: git-send-email 2.2.2
In-Reply-To: <xmqqlhkepsyl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263348>

The __builtin_ctzll function was added in gcc 3.4.0.
This extends the check for gcc so that use of __builtin_ctzll is only
enabled if gcc >= 3.4.0.

Signed-off-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
---
v2:
Add S-o-b

v1:
I noticed this on RHEL3 during 2.0.0rc phase but I see that the same
issue was noticed on Debian Sarge:
http://article.gmane.org/gmane.comp.version-control.git/255190
RHEL3 ships with gcc 3.2.3.

With this patch git can build on RHEL3 provided cURL support is disabled.

 ewah/ewok.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ewah/ewok.h b/ewah/ewok.h
index f6ad190..13c6e20 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -47,7 +47,8 @@ static inline uint32_t ewah_bit_popcount64(uint64_t x)
 	return (x * 0x0101010101010101ULL) >> 56;
 }
 
-#ifdef __GNUC__
+/* __builtin_ctzll was not available until 3.4.0 */
+#if defined(__GNUC__) && (__GNUC__ > 3 || (__GNUC__ == 3  && __GNUC_MINOR > 3))
 #define ewah_bit_ctz64(x) __builtin_ctzll(x)
 #else
 static inline int ewah_bit_ctz64(uint64_t x)
-- 
2.2.2
