From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 2/2] blame: dynamic blame_date_width for different locales
Date: Tue, 22 Apr 2014 22:39:10 +0800
Message-ID: <2d4e186a742b03788a843b6afcd9fcd7575a5c37.1398177411.git.worldhello.net@gmail.com>
References: <cover.1398177411.git.worldhello.net@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>, Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 16:39:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcbrR-00089G-4O
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 16:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505AbaDVOjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 10:39:45 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:42715 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756392AbaDVOjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 10:39:43 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so1066151pdj.10
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zCjDYQs9cQ150KA5veyTOejZPR+bz9ebbnSEs7Ojroo=;
        b=UppIy4/wvxFezUw6ePAJpv0euKFFm9pMZBkFJ7gPtpgVXWEEWQ6Pim0SXGcmD9I9Gl
         nYVlGWDPdk/uhK9NmYpQNdl52c1DxbzX+m1j7mxZ/CdwGhjXb+MhNzl3r/0Ne/ZHB5w5
         Gie0xYvHIuUHX2hppSgqOH0fgnGaX0fhmcrnjF36WvJCMp/InbPKm0kx7cxAKH1SaUMS
         WaRH6TJWsFwyFyfXlQ8e8CQO9+JeB9hZyoQUU5Gowsb88tfHFuVE6/oUo94PKNaCu9Gz
         6K5w9LrM4KSYy1mU4ugy6phKIcmhQFrv2DzZXxJd6DduOaAXa5uuDCE0Cdmn4ud61lAn
         fYpg==
X-Received: by 10.68.231.229 with SMTP id tj5mr7712892pbc.101.1398177583481;
        Tue, 22 Apr 2014 07:39:43 -0700 (PDT)
Received: from localhost.localdomain ([124.207.10.6])
        by mx.google.com with ESMTPSA id ry10sm149802179pab.38.2014.04.22.07.39.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Apr 2014 07:39:41 -0700 (PDT)
X-Mailer: git-send-email 1.9.2.476.gff10cf3.dirty
In-Reply-To: <cover.1398177411.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1398177411.git.worldhello.net@gmail.com>
References: <xmqq38h6a3sk.fsf@gitster.dls.corp.google.com> <cover.1398177411.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246741>

When show date in relative date format for git-blame, the max display
width of datetime is set as the length of the string "Thu Oct 19
16:00:04 2006 -0700" (30 characters long).  But actually the max width
for C locale is only 22 (the length of string "x years, xx months ago").
And for other locale, it maybe smaller.  E.g. For Chinese locale, only
needs a half (16-character width).

Set blame_date_width as the display width of _("4 years, 11 months
ago"), so that translators can make the choice.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/blame.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 35e95db..128fc64 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2338,7 +2338,14 @@ parse_done:
 		blame_date_width = sizeof("2006-10-19");
 		break;
 	case DATE_RELATIVE:
-		/* "normal" is used as the fallback for "relative" */
+		/* TRANSLATORS: This string is used to tell us the maximum
+		   display width for a relative timestamp in "git blame"
+		   output.  For C locale, "4 years, 11 months ago", which
+		   takes 22 places, is the longest among various forms of
+		   relative timestamps, but your language may need more or
+		   fewer display columns. */
+		blame_date_width = utf8_strwidth(_("4 years, 11 months ago")) + 1; /* add the null */
+		break;
 	case DATE_LOCAL:
 	case DATE_NORMAL:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
-- 
1.9.2.476.gff10cf3.dirty
