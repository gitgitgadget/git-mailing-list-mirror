From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] diff: remove ternary operator evaluating always to true
Date: Thu,  8 Aug 2013 20:31:44 +0200
Message-ID: <1375986704-11441-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 08 20:31:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7V01-0000vF-BX
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 20:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966076Ab3HHSbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 14:31:45 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:42130 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966036Ab3HHSbo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 14:31:44 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so1683999eek.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 11:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZbXNXjJdLxkKNrPQ91c3SKdEYmLx4HDwUyLEDJEZ/vM=;
        b=w8IzGBK09bUl/VjHQLAdOSeLqSi7NUsjrx5tD7s1P+TQyKEh2OuiCZJ/KRFbtLnVX+
         +5bibuEP/eZtIatQfkyQoxooTL+6yMICYi+TocO4BaCsTN326Qal/8VYhYR+nSfyF2jY
         5SIUywd7pXJKBRgbnjuz6kTBYIFH+YZaaVFhrFhp7rNvsqBYRVPnFC+lCplxfYTyaT5f
         e3HXTZAlvZxAA0GlXP4sNU9MiBxXisjWIhWdZxShPv7GI9bYG3kErAb8ZeHIrK1eI3nS
         0Cpmyi+Ik1EMv5pXqLvsqu9gsXSKaGXjwZECc74Vrfo/HoezFM+/z2V1Sb/qtxKTtBNt
         T6VQ==
X-Received: by 10.14.199.3 with SMTP id w3mr1847841een.33.1375986703366;
        Thu, 08 Aug 2013 11:31:43 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id r48sm14378816eev.14.2013.08.08.11.31.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 11:31:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.25.gd121ba2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231916>

The line being changed is deep inside the function builtin_diff.
The variable name_b, which is used to evaluate the ternary expression
must evaluate to true at that position, hence the replacement with
just name_b.

The name_b variable only occurs a few times in that lengthy function:
As a parameter to the function itself:
	static void builtin_diff(const char *name_a,
				 const char *name_b,
				...
The next occurrences are at:
	/* Never use a non-valid filename anywhere if at all possible */
	name_a = DIFF_FILE_VALID(one) ? name_a : name_b;
	name_b = DIFF_FILE_VALID(two) ? name_b : name_a;

	a_one = quote_two(a_prefix, name_a + (*name_a == '/'));
	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));

In the last line of this block 'name_b' is dereferenced and compared
to '/'. This would crash if name_b was NULL. Hence in the following code
we can assume name_b being non-null.

The next occurrence is just as a function argument, which doesn't change
the memory, which name_b points to, so the assumption name_b being not
null still holds:
	emit_rewrite_diff(name_a, name_b, one, two,
				textconv_one, textconv_two, o);

The next occurrence would be the line of this patch. As name_b still must
be not null, we can remove the ternary operator.


Inside the emit_rewrite_diff function there is a also a line
	ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
which was also simplified as there is also a dereference before the
ternary operator.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 266112c..80f8439 100644
--- a/diff.c
+++ b/diff.c
@@ -669,7 +669,7 @@ static void emit_rewrite_diff(const char *name_a,
 	memset(&ecbdata, 0, sizeof(ecbdata));
 	ecbdata.color_diff = want_color(o->use_color);
 	ecbdata.found_changesp = &o->found_changes;
-	ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
+	ecbdata.ws_rule = whitespace_rule(name_b);
 	ecbdata.opt = o;
 	if (ecbdata.ws_rule & WS_BLANK_AT_EOF) {
 		mmfile_t mf1, mf2;
@@ -2372,7 +2372,7 @@ static void builtin_diff(const char *name_a,
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = want_color(o->use_color);
 		ecbdata.found_changesp = &o->found_changes;
-		ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
+		ecbdata.ws_rule = whitespace_rule(name_b);
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.opt = o;
-- 
1.8.4.rc1.25.gd121ba2
