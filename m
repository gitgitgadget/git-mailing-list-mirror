From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) v2 1/5] git-gui: Implement system-wide configuration handling.
Date: Sun, 16 Nov 2008 21:46:47 +0300
Message-ID: <1226861211-16995-2-git-send-email-angavrilov@gmail.com>
References: <1226861211-16995-1-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 19:50:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1mhI-0001g2-JI
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 19:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbYKPSs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 13:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbYKPSs6
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 13:48:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:22132 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbYKPSs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 13:48:57 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1819459fgg.17
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 10:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UtOvTB9NQMeACRJAE8JSwXrJbAgrddHDbVs5azX20vQ=;
        b=WhWaA37ljC1tNe/FU8CyZVLkiZB+q1dCu1xeFyookBxOrFH2vTfx59qzKvJfg7Ybsl
         Vv2B53GW9I9adMZ4sunsESi116aakbbgwk1BaVj0kNKg2C7vu7CuaHHJtaSR2ef4sQ5s
         hDCDPMf4kjmXxpdn/ZGAV1HA1YZRN4qO8MZyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tQcjNLIM5az/RQwr9IXJOgoQwBMQ/kDvEP6AdpfsILnOVKe3GgeU17PU9JkKm58mZ2
         dyN8kDdt5a8CIBXYzOPyEI9EKD8xdZ8csi3EpvlM0XMpKooqvMqgRO+2Qag6ol9zZdxw
         bLMUb1hRbjmBEVV6cmjfxEg/4A+IvICws2qIE=
Received: by 10.181.239.8 with SMTP id q8mr799945bkr.109.1226861335144;
        Sun, 16 Nov 2008 10:48:55 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id z15sm3020368fkz.16.2008.11.16.10.48.52
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 10:48:53 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
In-Reply-To: <1226861211-16995-1-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101151>

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
