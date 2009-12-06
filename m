From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 (resend) 3/3] git-gui: work from the .git dir
Date: Sun,  6 Dec 2009 09:06:41 +0100
Message-ID: <1260086801-4331-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1260086801-4331-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 09:08:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHC9u-0002wZ-7A
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 09:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbZLFIHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 03:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbZLFIHn
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 03:07:43 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:18173 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932361AbZLFIHl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 03:07:41 -0500
Received: by fg-out-1718.google.com with SMTP id 19so933965fgg.1
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 00:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Y7VpbsR7sTf+SoeuDKSuTE7GrxsoJDGH7ZuCYOzUD2U=;
        b=OXZgHrzTM9A3eG4RzNdPmGWzDnm6pkWkSINlg6AXVaxoD7a0IfuUOpR5ZUHRDAlGG6
         31iaF1kYzkFv4UPWFFPfoTx9PCUmrrr0wfwVVW5g4qsKYTTGU/PpKxfn0UfEkZhUfmUj
         bsqwSpL2OlLcZCZf/c027cLTkGWwiDsEVtJYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UjBW6hz+8YX8a84/vsOcC4itvY7w9xUuGhR5i4I2M+onaBPUxX+0HaQlsNsage3Wu0
         cin3N/ySXEbrXxyas4V9OuXaM9d+vYdgNr/jv1pHhHgNrtPMegnrTyok7Kuyj/5p3oZQ
         QyhjHWiiFWewpHBPOyiAbJnb43kpXLHcmJ8a4=
Received: by 10.86.159.37 with SMTP id h37mr4265520fge.79.1260086866710;
        Sun, 06 Dec 2009 00:07:46 -0800 (PST)
Received: from localhost (host-78-13-51-245.cust-adsl.tiscali.it [78.13.51.245])
        by mx.google.com with ESMTPS id d6sm6556982fga.14.2009.12.06.00.07.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Dec 2009 00:07:46 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.295.g3a4e71
In-Reply-To: <1260086801-4331-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134652>

When git-gui is run from a .git dir, _gitdir would be set to "." by
rev-parse, something that confuses the worktree detection.

Fix by expanding the value of _gitdir to pwd in this special case.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-gui/git-gui.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 99ca4c0..0497e38 100755
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
1.6.5.4
