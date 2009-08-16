From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 3/3] git-gui: work from the .git dir
Date: Mon, 17 Aug 2009 01:58:48 +0200
Message-ID: <1250467128-29839-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 01:59:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McpdI-0006yb-8m
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 01:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791AbZHPX7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 19:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755640AbZHPX7E
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 19:59:04 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:34823 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354AbZHPX7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 19:59:03 -0400
Received: by mail-bw0-f222.google.com with SMTP id 22so2030748bwz.18
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 16:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TLVB2Zz1D9W6+k0WZlecZkuXUs/FzZzFC28ap21If0o=;
        b=XcykeB07BHwplFIwm/p3c998lPBRPBQ9CUd82ZCIXwaG+CT4yjMB0uLa4VrD2g/mHY
         TFxQnsrQ9CsKsTzSuANxnd5hao6P/kjc3kK7leKdRbPlwtsATLfaNsWtz25aI8SaYMnu
         iq5e6X/+UAMS73Xf5toJorwc6rYdFs0Om4Vds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GbV9LXWr3W9xeWQHOWG+Dff24NsfvQ9j0VPSV9gC97ep43l1Xf/uIn0kbkWNU0DNN5
         0S+Agc7lMh0oEYx1z5707hxnVvBExdnB9/cx0YQ4jR3MxzWZNftnxclI5Q8g5KLgsTkO
         VBhnqsV1mWTFp/mByc7EJwMnfEPZUNJW9rV08=
Received: by 10.102.253.15 with SMTP id a15mr1080936mui.50.1250467144362;
        Sun, 16 Aug 2009 16:59:04 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-24-143.clienti.tiscali.it [94.37.24.143])
        by mx.google.com with ESMTPS id s10sm16833618muh.17.2009.08.16.16.59.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 16:59:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.177.g695987
In-Reply-To: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126098>

When git-gui is run from a .git dir, _gitdir would be set to "." by
rev-parse, something that confuses the worktree detection.

Fix by expanding the value of _gitdir to pwd in this special case.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-gui/git-gui.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 38b11c1..fbad6fd 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1100,6 +1100,8 @@ if {[catch {
 		set _prefix {}
 		}]
 	&& [catch {
+		# beware that from the .git dir this sets _gitdir to .
+		# and _prefix to the empty string
 		set _gitdir [git rev-parse --git-dir]
 		set _prefix [git rev-parse --show-prefix]
 	} err]} {
@@ -1108,6 +1110,14 @@ if {[catch {
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
1.6.4.177.g695987
