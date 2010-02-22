From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] git-gui: fix worktree initialization with empty prefix
Date: Mon, 22 Feb 2010 16:19:24 +0100
Message-ID: <1266851964-13044-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <vpqaav1llpn.fsf@bauges.imag.fr>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 16:19:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nja4Q-0002AB-8v
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 16:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865Ab0BVPTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 10:19:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:25226 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab0BVPTc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 10:19:32 -0500
Received: by fg-out-1718.google.com with SMTP id e21so384968fga.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 07:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bZYSvJrJ+viHEzWpn7JJP4WHcOtWHu4Y+xb0o0kp3tM=;
        b=SvhfsB+wL2fZ82n9AwnMRFG9PT6ZvzTFQdmjcCanVo1PweDBKf8B7bVOdCiIBGSOxW
         xYneppKfSpypGSEIb0baVYGxHHWltDozuL7SuFfBKNWEh3aFN+H1RzFMx2FSQw4H6WDN
         1zkhTKHMEMXv9oLGTGOCKDBPaypdr7aLAyL0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZY1MWnZiKaeuoU3jstUUumESlphFfaKFWCAH0UDZurwXpd655O89M6d89Qu5mI7BVM
         b08Z6mT+kAxBUMyR17EUQip81c+whNYS+v6mOUulWJRTG9O+HEiHVUgGX8ufxrXPz/Cz
         /PaUth/u5P1bTxhAEAk5G3eZb3u5d0Q26woFA=
Received: by 10.87.68.15 with SMTP id v15mr2278692fgk.64.1266851971333;
        Mon, 22 Feb 2010 07:19:31 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id d4sm9086480fga.5.2010.02.22.07.19.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 07:19:29 -0800 (PST)
X-Mailer: git-send-email 1.7.0.198.g1e558.dirty
In-Reply-To: <vpqaav1llpn.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140688>

This is sort of a chicken-and-egg problem, because we should only
bother setting the worktree if we are not in a bare repository, but
an unset worktree is one of the conditions we check to see if we have
a bare repository.

Maintain the same sequence of checks, but swap the check for bareness
support and bareness of repository, and check again for an unset
worktree if we are not in the bare case.
---
 git-gui/git-gui.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 7d54511..d9e1598 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1169,12 +1169,13 @@ if {$_prefix ne {}} {
 	}
 	set _gitworktree [pwd]
 	unset cdup
-} elseif {![is_enabled bare]} {
-	if {[is_bare]} {
+} elseif {[is_bare]} {
+	if {![is_enabled bare]} {
 		catch {wm withdraw .}
 		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n$_gitdir"]
 		exit 1
 	}
+} else {
 	if {$_gitworktree eq {}} {
 		set _gitworktree [file dirname $_gitdir]
 	}
-- 
1.7.0.198.g1e558.dirty
