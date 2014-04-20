From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 2/2] blame: use different blame_date_width for different locale
Date: Mon, 21 Apr 2014 00:13:53 +0800
Message-ID: <07e4dcdc98b5eb9c78b9ed53bf2adc3b33139b67.1398010052.git.worldhello.net@gmail.com>
References: <cover.1398010052.git.worldhello.net@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 18:14:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbuOO-00026t-86
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 18:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbaDTQOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 12:14:49 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:47725 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbaDTQOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 12:14:23 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so2949961pab.6
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 09:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mOPRBxZgCqlsAzYFw4rti1bxpBzDOEyBsTevGwMQyMU=;
        b=qQJO4ce6EvPcB+SbCeCkMYqkJR+nVrT/+IBTKPQSS2IKaXCroI6xD6TY6X44vhHOO4
         ByaenT+XlvFLv5LuvBgAdxekW2/PemevzSa3W8TNggt/twktoGAq4cj+RekJ/oP1dR80
         F25kEBm8HXs3+I26BnUnsyQLfZd5OI4KKS4fEsmX/z/sJeavngOKQrp9+r5oQAF6bGo1
         aExjEgBg6E5vqMq15jmOIhVNZlDkw6i7deypLbykFAGxbx6xuzIqbIsnpg1LknswIHHF
         7aceKAjwxQc12S915WE4adSuVTcCoKVi6/+HCjZyO88zP9H9Nq0gAAqjn8gHb/SQSn4y
         TWKA==
X-Received: by 10.66.66.66 with SMTP id d2mr33062458pat.24.1398010462867;
        Sun, 20 Apr 2014 09:14:22 -0700 (PDT)
Received: from localhost.localdomain ([114.241.217.8])
        by mx.google.com with ESMTPSA id dy7sm173141497pad.9.2014.04.20.09.14.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Apr 2014 09:14:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc0.3.g444188f.dirty
In-Reply-To: <cover.1398010052.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1398010052.git.worldhello.net@gmail.com>
References: <CACsJy8BTBwqFZUU3i3cuv40B6AHw5SRY9DZN2PoKL4XzgEL2eA@mail.gmail.com> <cover.1398010052.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246553>

When show date in relative date format for `git blame`, the max display
width of datetime is set as the length of the string "Thu Oct 19
16:00:04 2006 -0700" (30 characters long).  But actually the max width
for C locale is only 22 (the length of string "x years, xx months ago").
And for other locale, it maybe smaller.  E.g. For Chinese locale, only
needs 16-character width.

Set blame_date_width as the display width of _("4 years, 11 months
ago"), so that translators can make the choice.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/blame.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 0a0a858..9350ea3 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2340,7 +2340,15 @@ parse_done:
 		blame_date_width = sizeof("2006-10-19");
 		break;
 	case DATE_RELATIVE:
-		/* "normal" is used as the fallback for "relative" */
+		/* TRANSLATORS: what we care about is not the content itself,
+		   but the display width of this string.  We use the width of
+		   the string as the max width of the datetime in relative
+		   format.  For English and many other languages, "4 years,
+		   11 months ago" is the longest one among "89 seconds ago",
+		   "89 minites ago", "35 hours ago", "13 days ago", "10 weeks
+		   ago", "in the future" and many others. */
+		blame_date_width = utf8_strwidth(_("4 years, 11 months ago")) + 1; /* add the null */
+		break;
 	case DATE_LOCAL:
 	case DATE_NORMAL:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
-- 
2.0.0.rc0.3.g444188f.dirty
