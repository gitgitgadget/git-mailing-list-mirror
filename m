From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] git-add--interactive: print message if there are no untracked files
Date: Thu, 22 Jan 2015 01:03:24 +0600
Message-ID: <1421867004-31672-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:03:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0Z2-0006XE-I1
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbbAUTDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:03:37 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:45544 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbbAUTDf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:03:35 -0500
Received: by mail-la0-f54.google.com with SMTP id hv19so2586971lab.13
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 11:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=r/2ARkyB87O5xp5NfZ5dbluqATY2AvXremEm2ic04f0=;
        b=f9vNxqIfVSsY1x0ooFvsZLDoOOCRVKveRlzioSpibEobrwfP0vPjKyToxrCudEZS94
         CbfxxKVwaDfJZn6VnLed2cZWoj6vSaMBhL117KRhXWXYSPoLgWGITR46K+VlXf+oM8RN
         ZBmz80MElvvcW3z3wT0BbFqhzSPjW0OiaffkCOPLKHMVZdXd2jGpkGA/Hp4w/j4kVg4d
         YaKWZ35+s4NEYD+mBKdVSwtLz3uNUK8u6KbemSFOPnXPmYXss/LTZYfMWBBS3pk6nkgg
         pQhVJ0MrdRFE40AdnzTY8iAjkokLH/JHmT4nMPuICKb2SsIhbKnYeej6yJtp2xwtbWDv
         qefw==
X-Received: by 10.112.185.101 with SMTP id fb5mr46147775lbc.12.1421867014373;
        Wed, 21 Jan 2015 11:03:34 -0800 (PST)
Received: from localhost.localdomain ([147.30.87.232])
        by mx.google.com with ESMTPSA id w3sm5715413lag.35.2015.01.21.11.03.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jan 2015 11:03:33 -0800 (PST)
X-Mailer: git-send-email 2.3.0-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262742>

If user selects 'add untracked' and there are no untracked files,
"Add untracked>>" opens. But it does not make sense in this case, because there
are no untracked files. So let's print message and exit from "add untracked" mode.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 git-add--interactive.perl | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 94b988c..1a6dcf3 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -724,11 +724,15 @@ sub revert_cmd {
 }
 
 sub add_untracked_cmd {
-	my @add = list_and_choose({ PROMPT => 'Add untracked' },
-				  list_untracked());
-	if (@add) {
-		system(qw(git update-index --add --), @add);
-		say_n_paths('added', @add);
+	if (system(qw(git ls-files --others --exclude-standard --))) {
+		my @add = list_and_choose({ PROMPT => 'Add untracked' },
+					  list_untracked());
+		if (@add) {
+			system(qw(git update-index --add --), @add);
+			say_n_paths('added', @add);
+		}
+	} else {
+		print "No untracked files.\n";
 	}
 	print "\n";
 }
-- 
2.3.0.rc1.247.gb53aa6f
