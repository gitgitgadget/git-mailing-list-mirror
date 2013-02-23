From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] diff: Fix rename pretty-print when suffix and prefix overlap
Date: Sat, 23 Feb 2013 17:48:45 +0100
Message-ID: <1361638125-11245-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 17:49:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9II2-0008VA-Q1
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 17:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759285Ab3BWQtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 11:49:01 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33943 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759275Ab3BWQs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 11:48:59 -0500
Received: by mail-wg0-f48.google.com with SMTP id 16so1336070wgi.27
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 08:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=dZtJVKRbfOGzfEuMROwABi6vr3bjJVM/vLdfLUmkNio=;
        b=ieeISgfWS9ZAxN5rbm4vU5X3xy+Du5DZO18QNOMAD1USrAd8XZ0ggtPo8DcsLxRnPT
         84qmE08wDngDO3xVp4yaIQcsqA232lMKKnP4F5EADLB+ZA2lQTlw1pqVl6hqHrtXqqub
         OLtlpA06d/SkNp6ITBZFiH0r4cvQNDzhTu4Q4WcXUhBGYuii0TzgbvGdAcmUrDxxG2QZ
         TWmlHjeMiCh4zTfSl2C4iLjjdi8YJ0/if/51hJ58Zf0xQrFDBYw86fo2pX92J01KlrbG
         Ka6hQJuSg0/Y4Lr5vsy7fREcHeQxY5DBGxLKjnpw4vAVlzGgNP/iYZl7DZh+kyNtnpzl
         FAIQ==
X-Received: by 10.180.74.228 with SMTP id x4mr3401736wiv.0.1361638138022;
        Sat, 23 Feb 2013 08:48:58 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id n10sm5017745wia.0.2013.02.23.08.48.55
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 08:48:56 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216901>

When considering a rename for two files that have a suffix and a prefix
that can overlap, a confusing line is shown. As an example, renaming
"a/b/b/c" to "a/b/c" shows "a/b/{ => }/b/c".

Currently, what we do is calculate the common prefix ("a/b/"), and the
common suffix ("/b/c"), but the same "/b/" is actually counted both in
prefix and suffix. Then when calculating the size of the non-common part,
we end-up with a negative value which is reset to 0, thus the "{ => }".

Do not allow the common suffix to overlap the common prefix and stop
when reaching a "/" that would be in both.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 diff.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 156fec4..80f4752 100644
--- a/diff.c
+++ b/diff.c
@@ -1290,7 +1290,16 @@ static char *pprint_rename(const char *a, const char *b)
 	old = a + len_a;
 	new = b + len_b;
 	sfx_length = 0;
-	while (a <= old && b <= new && *old == *new) {
+	/*
+	 * Note:
+	 * if pfx_length is 0, old/new will never reach a - 1 because it
+	 * would mean the whole string is common suffix. But then, the
+	 * whole string would also be a common prefix, and we would not
+	 * have pfx_length equals 0.
+	 */
+	while (a + pfx_length - 1 <= old &&
+	       b + pfx_length - 1 <= new &&
+	       *old == *new) {
 		if (*old == '/')
 			sfx_length = len_a - (old - a);
 		old--;
--
1.7.9.5
