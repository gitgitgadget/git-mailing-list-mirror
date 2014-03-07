From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] show_ident_date: fix always-false conditional
Date: Thu,  6 Mar 2014 20:35:24 -0500
Message-ID: <1394156124-3953-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 02:35:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLjhf-00081e-22
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 02:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbaCGBfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 20:35:55 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:56691 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbaCGBfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 20:35:54 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so3343090pde.38
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 17:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Nu9NDLcKuKfdM8CYvjZs1L3hhF66pqXEtuaZrbN8oO4=;
        b=tyCnM6eZ9Fxz8Q6g6F0i2cNdHFyuBR3tOpll0bQLAUVHWLXejk+s/o94mvfKsVgZ6V
         A71NwRKCqpDwvcjSYpxThgSAAOD2gkK+OnFGZim1/GeiOJ7EpPKuMC7YtKRKZFSq5Yys
         rUCstD5d1gGdhkCd1iLbAvD16PVOWQjDTNCO7+35BeNJO+WRbcOozGlo36+3Mb3Q24DK
         mEC5TaMMxVin7GaZnp59NikHHbG8vjqfk4F6rnsYPwW3Xc9iK7txmJ3YR4Hgpxgo4Vb6
         nyxjNEhaIfpKYay7m2ETh2HUU4uDmBFLydqvcsROSOZJzZ1K4q/Mou7hdcYw9qglbvtY
         WtPg==
X-Received: by 10.68.130.137 with SMTP id oe9mr18290346pbb.21.1394156153920;
        Thu, 06 Mar 2014 17:35:53 -0800 (PST)
Received: from floomp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id db3sm24583222pbb.10.2014.03.06.17.35.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Mar 2014 17:35:53 -0800 (PST)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243582>

1dca155fe3fa (log: handle integer overflow in timestamps, 2014-02-24)
assigns the result of strtol() to an 'int' and then checks it against
LONG_MIN and LONG_MAX, indicating underflow or overflow, even though
'int' may not be large enough to represent those values.

On Mac, the compiler complains:

    warning: comparison of constant 9223372036854775807 with
      expression of type 'int' is always false
      [-Wtautological-constant-out-of-range-compare]
      if (<<tz == LONG_MAX>> || tz == LONG_MIN)

Similarly for the LONG_MIN case. Fix this.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Alternately, the result of strtol() could be assigned temporarily to a
'long', compared against LONG_MIN and LONG_MAX, and then assigned to the
'int' "tz" variable. I chose the 'errno' approach instead because its
dead obvious, even to the most casual reader who hasn't checked the
strtol() man page, that it's handling a conversion failure. However, I
could go either way.

This patch is atop 'next'.

 pretty.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index 3b811ed..8903116 100644
--- a/pretty.c
+++ b/pretty.c
@@ -403,10 +403,10 @@ static const char *show_ident_date(const struct ident_split *ident,
 		date = strtoul(ident->date_begin, NULL, 10);
 	if (date_overflows(date))
 		date = 0;
-	else {
-		if (ident->tz_begin && ident->tz_end)
-			tz = strtol(ident->tz_begin, NULL, 10);
-		if (tz == LONG_MAX || tz == LONG_MIN)
+	else if (ident->tz_begin && ident->tz_end) {
+		errno = 0;
+		tz = strtol(ident->tz_begin, NULL, 10);
+		if (errno)
 			tz = 0;
 	}
 	return show_date(date, tz, mode);
-- 
1.8.3.2
