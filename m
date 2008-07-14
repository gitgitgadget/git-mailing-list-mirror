From: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
Subject: [PATCH] Make git-add -i accept ranges like 7-
Date: Mon, 14 Jul 2008 19:06:24 +0100
Message-ID: <1216058784-32584-1-git-send-email-ciaran.mccreesh@googlemail.com>
Cc: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 20:07:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KISSS-00044a-GW
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 20:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbYGNSGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 14:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752442AbYGNSGd
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 14:06:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:11182 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbYGNSGc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 14:06:32 -0400
Received: by ug-out-1314.google.com with SMTP id h2so274242ugf.16
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+xT6v+j7cv61PiMotytIHrJBmWOJAHHjlqKRMm/Fc08=;
        b=Ch2Q08YtDL5aVurLAx1Qy3EQCAcWLKpN3djBg87FwVri9Jvohdb92tpqgtBTgE9e3c
         rRxWxhug6N/WXNKLyTMZrncios21e89yr9fAeAvadJ/m5qothhdpNj9q7rPin3V7xamF
         MGunwDQJwJ5Ogq5AoR6T/eCbqCfQr8PFZuQQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=tZ0ARj/9/pXUlYRx8uTk/4uaWL4LF41IGet7F73FIm1zs6PZwpE5BbFw0RKXZnZbg5
         A1EA6yao8tIVCaqel6P6Bp97qKCeoH9a88S94v2yyLayj6VMlrs9Yk6DA9GIkQ/7sR/G
         9cDCv9/oUjhvck15wpOqNKBpbKt0InO4Vdwuo=
Received: by 10.66.239.16 with SMTP id m16mr1870151ugh.9.1216058791045;
        Mon, 14 Jul 2008 11:06:31 -0700 (PDT)
Received: from localhost.localdomain ( [92.235.187.79])
        by mx.google.com with ESMTPS id o1sm1904580uge.2.2008.07.14.11.06.29
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 11:06:30 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88441>

git-add -i ranges expect number-number. But for the supremely lazy, typing in
that second number when selecting "from patch 7 to the end" is wasted effort.
So treat an empty second number in a range as "until the last item".

Signed-off-by: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
---
 Documentation/git-add.txt |    5 +++--
 git-add--interactive.perl |    6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 46dd56c..3558905 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -187,8 +187,9 @@ update::
    "Update>>".  When the prompt ends with double '>>', you can
    make more than one selection, concatenated with whitespace or
    comma.  Also you can say ranges.  E.g. "2-5 7,9" to choose
-   2,3,4,5,7,9 from the list.  You can say '*' to choose
-   everything.
+   2,3,4,5,7,9 from the list.  If the second number in a range is
+   omitted, all remaining patches are taken.  E.g. "7-" to choose
+   7,8,9 from the list.  You can say '*' to choose everything.
 +
 What you chose are then highlighted with '*',
 like this:
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 801d7c0..72a8858 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -406,9 +406,9 @@ sub list_and_choose {
 			if ($choice =~ s/^-//) {
 				$choose = 0;
 			}
-			# A range can be specified like 5-7
-			if ($choice =~ /^(\d+)-(\d+)$/) {
-				($bottom, $top) = ($1, $2);
+			# A range can be specified like 5-7 or 5-.
+			if ($choice =~ /^(\d*)-(\d*)$/) {
+				($bottom, $top) = ($1, length($2) ? $2 : 1 + @stuff);
 			}
 			elsif ($choice =~ /^\d+$/) {
 				$bottom = $top = $choice;
-- 
1.5.6.2
