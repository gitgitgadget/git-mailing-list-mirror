From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] rebase -i: fix cases ignoring core.commentchar
Date: Fri, 16 Aug 2013 17:44:07 -0400
Message-ID: <1376689447-78807-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 17 00:15:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VASIn-0000vH-Hs
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 00:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab3HPWPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 18:15:20 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:43866 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab3HPWPS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 18:15:18 -0400
Received: by mail-ie0-f175.google.com with SMTP id s9so4285471iec.20
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 15:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=HqVPtzq5f7/QbpmP/rqKKjoOLwnK76W33YzuVkTfkUg=;
        b=LBfsVEC7whe4IWviDC5kkACzjjWvyY8KFSipsoUx/tUX6hSvQ47E0bbARI3ReVSSHM
         gU+lE1c2mmaInKNsz9asuh7eo5Tu3yuzSZXYR2R5jU24VRCxY3arW7M7ClF7kKxaxX+2
         HvlClYQFCzEGRZ+Nml4BwRZ4GQl3vSl/nmpBTnsySaRo2Z3ymLFKy7CSCkTXTAcXsmxf
         Bb4nWfnY7Uh006yS+Tikgvq5sg4/npqmXydUPpfjO0scgvi7+AcFqLyttTVIBURrJvPi
         vuHT2UFdqEMUk6EGmnsNvi6tc4cyjbG5f6W8Rqx6aK2EddzPYFHSuD/A4+gIff8ncJuW
         9TyQ==
X-Received: by 10.50.119.70 with SMTP id ks6mr660538igb.22.1376689485431;
        Fri, 16 Aug 2013 14:44:45 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id y2sm1066736igl.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 14:44:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.500.gc3113b0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232438>

eff80a9fd990de36 (Allow custom "comment char", 2013-01-16) added general
core.commentchar support but forgot to update git-rebase--interactive to
respect it.  180bad3d10fe3a7f (rebase -i: respect core.commentchar,
2013-02-11) addressed this oversight but missed one instance of
hard-coded '#' comment character in skip_unnecessary_picks(). Fix this.

9a46c25bdbf79744 (rebase: interactive: fix short SHA-1 collision,
2013-08-12) added another instance of hard-coded '#' comment character
in transform_todo_ids().  Fix this, as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

While planning to work on a couple patches to address Junio's comments
on [1] (currently in 'next'), I realized that that series introduced a
small regression by ignoring core.commentchar and assuming that the todo
list comment character is unconditionally '#'. This patch fixes that
regression.

While fixing the regression, I also noticed that the original patch
(180bad3d10fe3a7f) which added core.commentchar support to rebase -i
missed one instance. This patch fixes that, as well.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/232146

 git-rebase--interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ea11e62..f246810 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -671,7 +671,7 @@ skip_unnecessary_picks () {
 				;;
 			esac
 			;;
-		3,#*|3,)
+		3,"$comment_char"*|3,)
 			# copy comments
 			;;
 		*)
@@ -693,7 +693,7 @@ transform_todo_ids () {
 	while read -r command rest
 	do
 		case "$command" in
-		'#'* | exec)
+		"$comment_char"* | exec)
 			# Be careful for oddball commands like 'exec'
 			# that do not have a SHA-1 at the beginning of $rest.
 			;;
-- 
1.8.4.rc3.500.gc3113b0
