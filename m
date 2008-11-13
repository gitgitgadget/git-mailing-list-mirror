From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 1/3] git-gui: Implement system-wide configuration handling.
Date: Thu, 13 Nov 2008 22:35:48 +0300
Message-ID: <1226604950-18667-2-git-send-email-angavrilov@gmail.com>
References: <1226604950-18667-1-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 20:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0i2L-00079I-Il
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 20:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300AbYKMTiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 14:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755222AbYKMTiF
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 14:38:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:29585 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814AbYKMTiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 14:38:00 -0500
Received: by fg-out-1718.google.com with SMTP id 19so860538fgg.17
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 11:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UtOvTB9NQMeACRJAE8JSwXrJbAgrddHDbVs5azX20vQ=;
        b=rf6UigTI+6nzaTAFVBviAMULSgtu7TCii6cmfOkY9yJBgne7hMOyWxbwDKhNbZMUm8
         IVmrPyfrxnox3k6RrvXphBio11GLuakpRUjt2XeA41UCI4k8QkqPyHGNLznQ24+yjbrf
         oM8P3UhmAVFpVNsBHmZBpXd+6fqTR+cUUqZU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RigqLjpuIVu86rnMvjQKyB5uO/oGWbsufX7xwCKwMyNktHKQISJQMq8bD0BQ4M5p0Q
         MTgExL+I3vC9+pG9QhBMgkx8molFTqRMAipnllufamKHn5CUgHPgN74ZyK1rE84CcNSw
         yYlXeXbe6Mys2cjf8tVEw1V+QFNjJ8IvS9iV4=
Received: by 10.181.152.14 with SMTP id e14mr21670bko.189.1226605077621;
        Thu, 13 Nov 2008 11:37:57 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id h2sm5268685fkh.11.2008.11.13.11.37.54
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 11:37:56 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
In-Reply-To: <1226604950-18667-1-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100903>

With the old implementation any system-wide options appear
to be set locally in the current repository. This commit
adds explicit handling of system options, essentially
interpreting them as customized default_config.

The difficulty in interpreting system options stems from
the fact that simple 'git config' lists all values, while
'git config --global' only values set in ~/.gitconfig,
excluding both local and system options.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh     |   12 +++++++++---
 lib/option.tcl |   12 ++++++------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index cf9ef6e..34214b6 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -918,19 +918,25 @@ git-version proc _parse_config {arr_name args} {
 }
 
 proc load_config {include_global} {
-	global repo_config global_config default_config
+	global repo_config global_config system_config default_config
 
 	if {$include_global} {
+		_parse_config system_config --system
 		_parse_config global_config --global
 	}
 	_parse_config repo_config
 
 	foreach name [array names default_config] {
+		if {[catch {set v $system_config($name)}]} {
+			set system_config($name) $default_config($name)
+		}
+	}
+	foreach name [array names system_config] {
 		if {[catch {set v $global_config($name)}]} {
-			set global_config($name) $default_config($name)
+			set global_config($name) $system_config($name)
 		}
 		if {[catch {set v $repo_config($name)}]} {
-			set repo_config($name) $default_config($name)
+			set repo_config($name) $system_config($name)
 		}
 	}
 }
diff --git a/lib/option.tcl b/lib/option.tcl
index c80c939..1d55b49 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -25,7 +25,7 @@ proc config_check_encodings {} {
 
 proc save_config {} {
 	global default_config font_descs
-	global repo_config global_config
+	global repo_config global_config system_config
 	global repo_config_new global_config_new
 	global ui_comm_spell
 
@@ -49,7 +49,7 @@ proc save_config {} {
 	foreach name [array names default_config] {
 		set value $global_config_new($name)
 		if {$value ne $global_config($name)} {
-			if {$value eq $default_config($name)} {
+			if {$value eq $system_config($name)} {
 				catch {git config --global --unset $name}
 			} else {
 				regsub -all "\[{}\]" $value {"} value
@@ -284,17 +284,17 @@ proc do_options {} {
 }
 
 proc do_restore_defaults {} {
-	global font_descs default_config repo_config
+	global font_descs default_config repo_config system_config
 	global repo_config_new global_config_new
 
 	foreach name [array names default_config] {
-		set repo_config_new($name) $default_config($name)
-		set global_config_new($name) $default_config($name)
+		set repo_config_new($name) $system_config($name)
+		set global_config_new($name) $system_config($name)
 	}
 
 	foreach option $font_descs {
 		set name [lindex $option 0]
-		set repo_config(gui.$name) $default_config(gui.$name)
+		set repo_config(gui.$name) $system_config(gui.$name)
 	}
 	apply_config
 
-- 
1.6.0.3.15.gb8d36
