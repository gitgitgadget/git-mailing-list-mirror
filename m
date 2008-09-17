From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI,GITK) 3/8] git-gui: Allow forcing display encoding for diffs using a submenu.
Date: Thu, 18 Sep 2008 01:07:34 +0400
Message-ID: <1221685659-476-4-git-send-email-angavrilov@gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
 <1221685659-476-2-git-send-email-angavrilov@gmail.com>
 <1221685659-476-3-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 23:12:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg4IS-0003an-RY
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 23:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbYIQVJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 17:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754086AbYIQVJH
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 17:09:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:53356 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbYIQVJA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 17:09:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2125237fgg.17
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ki6sk+ZVe9ToscW1xpHSuhSr3EOOdHL19N8KSGK7dkY=;
        b=bnMvLkiwMa78I2ECh8M2bD/33k9mJTlgRndhIuPQ9tmYiG4HhiP9z8LZxJK4+0AW6N
         8OAnE63Kw8F0FyZpfmFh+nhRGvnWaUb2whWTe6YLXKuJ3Eb3v/ODVzVeJQruzuRxP6ax
         dYpdVQVfyZsY00kfZ4EfY4MylzPAF3hrUYcLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KQrwnPYM+7ucNAid8xHYehyfqFFAxode3HzyxMeYIv0vjXdwwpQW8/HR6oTUpj2Iyr
         YZ/o2dpQcjUpLjgDLhe1Kwqn1aqQME5HqThC+ABxqRXdpkxMJmtDCGkstYZ0DzxPefCO
         e0bwrHmzpWCkKjCeowGSIwLNdUcrePUYfpz4M=
Received: by 10.180.215.9 with SMTP id n9mr2327851bkg.59.1221685738692;
        Wed, 17 Sep 2008 14:08:58 -0700 (PDT)
Received: from localhost.localdomain ( [92.255.85.78])
        by mx.google.com with ESMTPS id z10sm17426586fka.15.2008.09.17.14.08.57
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 14:08:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1221685659-476-3-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96141>

Add a submenu to allow dynamically changing the encoding to use
for diffs. Encoding settings are remembered while git-gui runs.
The rules are:

1) Encoding set for a specific file overrides gitattributes.
2) Last explicitly set value of the encoding overrides gui.encoding

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh       |    8 ++++++++
 lib/diff.tcl     |    9 +++++++++
 lib/encoding.tcl |   29 +++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 444990b..3bbb4f1 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2937,6 +2937,14 @@ proc create_common_diff_popup {ctxm} {
 		-command {incr_font_size font_diff 1}
 	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 	$ctxm add separator
+	set emenu $ctxm.enc
+	menu $emenu
+	build_encoding_menu $emenu [list force_diff_encoding]
+	$ctxm add cascade \
+		-label [mc "Encoding"] \
+		-menu $emenu
+	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+	$ctxm add separator
 	$ctxm add command -label [mc "Options..."] \
 		-command do_options
 }
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 8fefc5d..b616296 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -40,6 +40,15 @@ proc reshow_diff {} {
 	}
 }
 
+proc force_diff_encoding {enc} {
+	global current_diff_path
+	
+	if {$current_diff_path ne {}} {
+		force_path_encoding $current_diff_path $enc
+		reshow_diff
+	}
+}
+
 proc handle_empty_diff {} {
 	global current_diff_path file_states file_lists
 
diff --git a/lib/encoding.tcl b/lib/encoding.tcl
index 2c1eda3..b2ee38c 100644
--- a/lib/encoding.tcl
+++ b/lib/encoding.tcl
@@ -321,13 +321,38 @@ proc tcl_encoding {enc} {
     return {}
 }
 
+proc force_path_encoding {path enc} {
+	global path_encoding_overrides last_encoding_override
+
+	set enc [tcl_encoding $enc]
+	if {$enc eq {}} {
+		catch { unset last_encoding_override }
+		catch { unset path_encoding_overrides($path) }
+	} else {
+		set last_encoding_override $enc
+		if {$path ne {}} {
+			set path_encoding_overrides($path) $enc
+		}
+	}
+}
+
 proc get_path_encoding {path} {
-	set tcl_enc [tcl_encoding [get_config gui.encoding]]
+	global path_encoding_overrides last_encoding_override
+
+	if {[info exists last_encoding_override]} {
+		set tcl_enc $last_encoding_override
+	} else {
+		set tcl_enc [tcl_encoding [get_config gui.encoding]]
+	}
 	if {$tcl_enc eq {}} {
 		set tcl_enc [encoding system]
 	}
 	if {$path ne {}} {
-		set enc2 [tcl_encoding [gitattr $path encoding $tcl_enc]]
+		if {[info exists path_encoding_overrides($path)]} {
+			set enc2 $path_encoding_overrides($path)
+		} else {
+			set enc2 [tcl_encoding [gitattr $path encoding $tcl_enc]]
+		}
 		if {$enc2 ne {}} {
 			set tcl_enc $enc2
 		}
-- 
1.6.0.20.g6148bc
