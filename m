From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 3/5] git-gui: work from the .git dir
Date: Sat, 23 Jan 2010 11:03:36 +0100
Message-ID: <1264241018-6616-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1264241018-6616-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 11:04:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcrB-0000WZ-8I
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 11:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab0AWKES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 05:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754764Ab0AWKEO
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 05:04:14 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:41615 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750Ab0AWKEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 05:04:10 -0500
Received: by bwz27 with SMTP id 27so1657551bwz.21
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 02:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gmUuxG/ikQjj8gijKQxg6bLhadtgOztRHL6VF2EKTtM=;
        b=Wmws9tpiuyYM36osEB0q+dt4QGE+GYM7zK6EEvbuZUef6RwoMqo/haBOBKrxETxOc6
         nbqi84u4bArxm+KFgxdzFTUYbdKmuYRYiIOA/6tJfjo67XoVrXSC85l1NhX9AULyeFeG
         ELd5xoGtEZ8RXB1DrW6PXvrSjgjQZfxbIdM4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=r0nqQ5vIMcYCVpk4kqxpgGunqmFuhzdaPFE4U05WG/YprDYfBXCr5gP6Y6B5g7aZsr
         h/HoWKedh9TNif6muAf9y/t9OEwn+tnVEpH01smy+/OQzxllKZ2e0cnbtNAdE41lGA0h
         ejstSzWF5DmzRWw8fT3TcD/VZ0p2xWEXiX5HI=
Received: by 10.204.11.15 with SMTP id r15mr723034bkr.40.1264241048745;
        Sat, 23 Jan 2010 02:04:08 -0800 (PST)
Received: from localhost ([151.60.177.52])
        by mx.google.com with ESMTPS id 13sm1348897bwz.10.2010.01.23.02.04.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 02:04:08 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.295.g3a4e71
In-Reply-To: <1264241018-6616-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137830>

When git-gui is run from a .git dir, _gitdir would be set to "." by
rev-parse, something that confuses the worktree detection.

Fix by expanding the value of _gitdir to pwd in this special case.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-gui/git-gui.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index d0dff40..c5c787d 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1102,6 +1102,8 @@ if {[catch {
 		set _prefix {}
 		}]
 	&& [catch {
+		# beware that from the .git dir this sets _gitdir to .
+		# and _prefix to the empty string
 		set _gitdir [git rev-parse --git-dir]
 		set _prefix [git rev-parse --show-prefix]
 	} err]} {
@@ -1110,6 +1112,14 @@ if {[catch {
 	choose_repository::pick
 	set picked 1
 }
+
+# we expand the _gitdir when it's just a single dot (i.e. when we're being
+# run from the .git dir itself) lest the routines to find the worktree
+# get confused
+if {$_gitdir eq "."} {
+	set _gitdir [pwd]
+}
+
 if {![file isdirectory $_gitdir] && [is_Cygwin]} {
 	catch {set _gitdir [exec cygpath --windows $_gitdir]}
 }
-- 
1.6.6.rc1.295.g3a4e71
