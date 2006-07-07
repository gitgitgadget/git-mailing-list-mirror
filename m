From: Stephan Feder <sf@b-i-t.de>
Subject: [PATCH] Teach --text option to diff
Date: Fri, 07 Jul 2006 12:33:57 +0200
Message-ID: <11522684373987-git-send-email-sf@b-i-t.de>
Reply-To: Stephan Feder <sf@b-i-t.de>
X-From: git-owner@vger.kernel.org Fri Jul 07 12:34:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fyney-0006QT-3I
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 12:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWGGKeF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 06:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWGGKeE
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 06:34:04 -0400
Received: from mail.medianet-world.de ([213.157.0.167]:40072 "HELO
	mail.medianet-world.de") by vger.kernel.org with SMTP
	id S1750992AbWGGKeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 06:34:03 -0400
Received: (qmail 8636 invoked by uid 1011); 7 Jul 2006 10:34:02 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(-2.5/5.0):. 
 Processed in 0.432627 secs); 07 Jul 2006 10:34:02 -0000
X-Spam-Status: No, hits=-2.5 required=5.0
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de) (213.157.15.184)
  by mail.medianet-world.de with SMTP; 7 Jul 2006 10:34:01 -0000
Received: from localhost.localdomain (groa.b-i-t.de [192.168.168.40])
	by mail.b-i-t.de (Postfix) with ESMTP id 253B1713B;
	Fri,  7 Jul 2006 12:33:57 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.gbc483
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23422>

Add new item text to struct diff_options.
If set then do not try to detect binary files.

Signed-off-by: Stephan Feder <sf@b-i-t.de>
---

I have to send patches of binary data to a customer but the builtin diff
was no help in this case.

Notes:

1. The shorthand -a for --text is not implemented. Is there a conflicting
shorthand?

2. For diffstat --text is ignored. It seems pointless because binary
patch data is not for human consumption anyway.

3. No documentation yet. If the patch is accepted I will add a short
description. To Documentation/diff-options.txt?

Regards
    Stephan


 diff.c |    5 ++++-
 diff.h |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index f0450a8..1f0219d 100644
--- a/diff.c
+++ b/diff.c
@@ -723,7 +723,7 @@ static void builtin_diff(const char *nam
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2)) {
+	if (!o->text && (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2))) {
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
@@ -1561,6 +1561,9 @@ int diff_opt_parse(struct diff_options *
 		options->output_format |= DIFF_FORMAT_PATCH;
 		options->full_index = options->binary = 1;
 	}
+	else if (!strcmp(arg, "--text")) {
+		options->text = 1;
+	}
 	else if (!strcmp(arg, "--name-only"))
 		options->output_format |= DIFF_FORMAT_NAME;
 	else if (!strcmp(arg, "--name-status"))
diff --git a/diff.h b/diff.h
index d557394..f80f646 100644
--- a/diff.h
+++ b/diff.h
@@ -42,6 +42,7 @@ struct diff_options {
 	unsigned recursive:1,
 		 tree_in_recursive:1,
 		 binary:1,
+		 text:1,
 		 full_index:1,
 		 silent_on_remove:1,
 		 find_copies_harder:1,
-- 
1.4.1.gbc483
