From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v3] git-am: fix maildir support regression: accept email file as patch
Date: Thu, 16 Jul 2009 00:19:36 +0200
Message-ID: <1654b578a7e045b564c46df4abb6e2196422c2b2.1247696294.git.nicolas.s.dev@gmx.fr>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 16 00:20:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRCpk-0007mX-5j
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 00:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbZGOWUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 18:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbZGOWUF
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 18:20:05 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:52596 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbZGOWUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 18:20:04 -0400
Received: by ewy26 with SMTP id 26so4425749ewy.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=9fuj8uZNEal3OCPRW4KqgfRu/D1R2tL0nYepsH8H/PE=;
        b=r2OFeU/BaZxYpHclcyzRr8GbdF0HZSo5JVL1GB4wLkPXqzwA2u5nD+zbu66tLMXK1v
         JEJ9jckdGXJYDZldBEIU1Q2DE8WSdtJ54sIJFUyl8zcQwESiNvAqDB9VOvq3o1whzn2i
         7wRl2pqok4Mo4aH2S7A/fGpg17SRr39Rk3YTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=lamknJandyX+BT30AN4wqMslrNr+wanGK5CVK0WSh5vQwYQyWJSOLKw7EmBdcyaJoP
         DvGILbuBR9VnJNP3iJ3u63IZbtnnQFr2Q7g4lV44rFgGZmBunZFgHXcuNAZvybk8o3bg
         pzcciyVU+OO/vulNguYoP7UTmpDNXbdKm7Hdw=
Received: by 10.210.86.1 with SMTP id j1mr8773607ebb.61.1247696401452;
        Wed, 15 Jul 2009 15:20:01 -0700 (PDT)
Received: from localhost (91-164-136-30.rev.libertysurf.net [91.164.136.30])
        by mx.google.com with ESMTPS id 7sm5127941eyg.54.2009.07.15.15.19.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 15:20:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc0.128.g69018
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123338>

Patch format detection introduced by a5a6755a1d4707bf2fab7752e5c974ebf63d086a
may refuse valid patches.

We keep detection on the first three lines. Emails may have:
 - header fields in a random order;
 - folded lines.

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---
 git-am.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index d64d997..6190297 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -146,6 +146,7 @@ clean_abort () {
 }
 
 patch_format=
+is_email=
 
 check_patch_format () {
 	# early return if patch_format was set from the command line
@@ -191,6 +192,22 @@ check_patch_format () {
 			esac
 			;;
 		esac
+		# Keep maildir workflows support.
+		# Emails may have header fields in random order.
+		is_email='true'
+		for line in "$l1" "$l2" "$l3"
+		do
+			printf "$line" |
+				# The line may be a folded line
+				sed -e '/^$/q' -e '/^[ ]/d' |
+				grep -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||
+				is_email='false'
+		done
+		# next treatments don't differ from mailbox format
+		if [ $is_email == 'true' ]
+		then
+			patch_format=mbox
+		fi
 	} < "$1" || clean_abort
 }
 
-- 
1.6.4.rc0.128.g69018
