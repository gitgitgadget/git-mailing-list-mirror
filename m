From: Remi Rampin <remirampin@gmail.com>
Subject: [PATCH 2/2] Makes _do_open2 set _gitdir to actual path
Date: Mon,  2 Feb 2015 12:24:43 -0500
Message-ID: <1422897883-11036-2-git-send-email-remirampin@gmail.com>
References: <CAMto89CHf4OT_S05SaRrVRZvF-PH2_6DrcEpdGiUfaRGutJQHw@mail.gmail.com>
 <1422897883-11036-1-git-send-email-remirampin@gmail.com>
Cc: Remi Rampin <remirampin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 18:25:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIKkE-000244-RB
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 18:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbbBBRY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 12:24:59 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:35511 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbbBBRY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 12:24:57 -0500
Received: by mail-qa0-f43.google.com with SMTP id v10so30080115qac.2
        for <git@vger.kernel.org>; Mon, 02 Feb 2015 09:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KwnKn5TCvGE03HgSYsY5lbac9XF3FHn8gOaNYHJ0aeU=;
        b=LDKF3amUApqrjoU2BflrbSe3g+YogF/kuRH62vJ2LYmkPu6w+TMUKZoQlVRskixHIy
         dCuNeKVnJBRxTq1le0qMJgxh0MMFcrOqEvM1BKuQILmE1WMszFcYAoXf5pIOS1ydHzqB
         VhwanfbNqkeVmDR0GsYbpvbZy/xFkg6xA6gdfHsgKOXNKDWdjwGeV6so+978mE19AeKf
         UdBY3Zlj5BH2lFpYr47Nudz26uY+TIk7UIuQPhgqfqjX8hzt9slhqrTDLK1qy7wcU8nB
         GS4q89rTMtttr+MBvkgXdasQBHgWr4Y+njRYGiRI26IiVFzVC2LImx34xYW2g/N4tqGC
         TBgQ==
X-Received: by 10.140.21.48 with SMTP id 45mr41329789qgk.87.1422897897102;
        Mon, 02 Feb 2015 09:24:57 -0800 (PST)
Received: from vebian.poly.edu (remram.poly.edu. [128.238.102.168])
        by mx.google.com with ESMTPSA id r10sm9950101qan.42.2015.02.02.09.24.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Feb 2015 09:24:56 -0800 (PST)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1422897883-11036-1-git-send-email-remirampin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263264>

If _is_git had to follow "gitdir: ..." files to reach the actual Git
directory, we set _gitdir to that final path.
---
 lib/choose_repository.tcl | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 49ff641..641068d 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -338,13 +338,17 @@ method _git_init {} {
 	return 1
 }
 
-proc _is_git {path} {
+proc _is_git {path {outdir_var ""}} {
+	if {$outdir_var ne ""} {
+		upvar 1 $outdir_var outdir
+	}
 	if {[file isfile $path]} {
 		set fp [open $path r]
 		gets $fp line
 		close $fp
 		if {[regexp "^gitdir: (.+)$" $line line link_target]} {
-			return [_is_git [file join [file dirname $path] $link_target]]
+			set link_target_abs [file join [file dirname $path] $link_target]
+			return [_is_git $link_target_abs outdir]
 		}
 		return 0
 	}
@@ -352,12 +356,14 @@ proc _is_git {path} {
 	if {[file exists [file join $path HEAD]]
 	 && [file exists [file join $path objects]]
 	 && [file exists [file join $path config]]} {
+		set outdir $path
 		return 1
 	}
 	if {[is_Cygwin]} {
 		if {[file exists [file join $path HEAD]]
 		 && [file exists [file join $path objects.lnk]]
 		 && [file exists [file join $path config.lnk]]} {
+			set outdir $path
 			return 1
 		}
 	}
@@ -1103,7 +1109,7 @@ method _open_local_path {} {
 }
 
 method _do_open2 {} {
-	if {![_is_git [file join $local_path .git]]} {
+	if {![_is_git [file join $local_path .git] actualgit]} {
 		error_popup [mc "Not a Git repository: %s" [file tail $local_path]]
 		return
 	}
@@ -1116,7 +1122,7 @@ method _do_open2 {} {
 	}
 
 	_append_recentrepos [pwd]
-	set ::_gitdir .git
+	set ::_gitdir $actualgit
 	set ::_prefix {}
 	set done 1
 }
-- 
1.9.5.msysgit.0
