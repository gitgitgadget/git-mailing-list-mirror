From: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
Subject: [PATCH,v2] Make git-add -i accept ranges like 7-
Date: Mon, 14 Jul 2008 19:29:37 +0100
Message-ID: <1216060177-8757-1-git-send-email-ciaran.mccreesh@googlemail.com>
References: <7vfxqcgwni.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org,
	Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 14 20:31:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KISpK-00048s-HP
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 20:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbYGNSaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 14:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736AbYGNSaJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 14:30:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:14891 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527AbYGNSaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 14:30:07 -0400
Received: by ug-out-1314.google.com with SMTP id h2so276793ugf.16
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5qTzeZKRd/xV4YTBCByZyNqTKig5d54SuD1JalNDGo4=;
        b=piJn8D5wHxd8JL9TNSJLl5hIPCDzPvK6c3RikISRlRPxARzGYxM1MLq6JLGi3lBtpp
         KbkJo7jYsdwTEVtY1nRS0+AECjtJPc9OuZhC+97nAUMZLMs1k7vSkYxjoL7kdyyGwDVg
         mwwh4Y1PRLbYskidBKw7CumgNz7hwo1zFAWcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kNSoLi9cl6JhlMsVvswkgLaxLD+frgmIn+SQMzsNbMwQ4j29QOinbUcG5aXPgTy04i
         x6sKH1aAHMPF/8S+hPLE6ZZcT3WF/NpMwwBM336pOC+zgB8Y2GfM9qmSDVEk8NDxNvUo
         AXHKYDHu0NYWG6xkCRvgqGpxcUNHAsrYqlmcw=
Received: by 10.67.115.14 with SMTP id s14mr1865661ugm.59.1216060201996;
        Mon, 14 Jul 2008 11:30:01 -0700 (PDT)
Received: from localhost.localdomain ( [92.235.187.79])
        by mx.google.com with ESMTPS id t35sm1905263uge.28.2008.07.14.11.29.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 11:29:55 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <7vfxqcgwni.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88444>

git-add -i ranges expect number-number. But for the supremely lazy, typing in
that second number when selecting "from patch 7 to the end" is wasted effort.
So treat an empty second number in a range as "until the last item".

Signed-off-by: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
---
Oops, my bad.

Attempt 2 changes the regex to require a number in the first half of the range.
I was planning to allow for -7, meaning 'up to 7', but this collides with - at
the start being used to unchoose things. There's not much point adding a
special thing for 'from the start' though, since '1' is only one character to
type.

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
index 801d7c0..a6a5c52 100755
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
+			if ($choice =~ /^(\d+)-(\d*)$/) {
+				($bottom, $top) = ($1, length($2) ? $2 : 1 + @stuff);
 			}
 			elsif ($choice =~ /^\d+$/) {
 				$bottom = $top = $choice;
-- 
1.5.6.2
