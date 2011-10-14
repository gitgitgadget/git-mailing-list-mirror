From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 3/3] git-gui: new config to control staging of untracked files
Date: Fri, 14 Oct 2011 21:25:21 +0200
Message-ID: <03727ea04f20c953e7de3f84ab1724a8360ca2c4.1318620267.git.bert.wesarg@googlemail.com>
References: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
 <446a8233349fd7d084fd01bf1176a4073ff17593.1318620267.git.bert.wesarg@googlemail.com>
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 21:25:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REnNz-0002ST-N9
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 21:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670Ab1JNTZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 15:25:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59108 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153Ab1JNTZb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 15:25:31 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt19so353915bkb.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 12:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=83fCA4kLPKWS1oCZNv92AT+sZgdopR8E7Bmrac59CMk=;
        b=Gbo8ykGVVphFwm2RIeOK7SNyMPgIGGO0nPnmiZ294zKAgoy2OSw5BSu8plMHfKIP+R
         XtEOaJmoABlrGwBOycsmPVb9JwQ+qlIQ2zLLLa6++t5Hvr/hTrsWeuE831BEu3nmqNX0
         VIVqRU8CBTlx7GqxD/H2xAnf/fUEoFkpAXYlw=
Received: by 10.204.154.156 with SMTP id o28mr7799772bkw.12.1318620331200;
        Fri, 14 Oct 2011 12:25:31 -0700 (PDT)
Received: from localhost (p5B2AD5F0.dip.t-dialin.net. [91.42.213.240])
        by mx.google.com with ESMTPS id rc12sm9384788bkb.10.2011.10.14.12.25.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 12:25:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
In-Reply-To: <446a8233349fd7d084fd01bf1176a4073ff17593.1318620267.git.bert.wesarg@googlemail.com>
In-Reply-To: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
References: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183601>

The default is the current "ask".

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh     |    1 +
 lib/index.tcl  |   14 +++++++++++++-
 lib/option.tcl |   18 ++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index f897160..77deff7 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -859,6 +859,7 @@ set font_descs {
 	{fontui   font_ui   {mc "Main Font"}}
 	{fontdiff font_diff {mc "Diff/Console Font"}}
 }
+set default_config(gui.stageuntracked) ask
 
 ######################################################################
 ##
diff --git a/lib/index.tcl b/lib/index.tcl
index 014acf9..45094c2 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -367,7 +367,19 @@ proc do_add_all {} {
 		}
 	}
 	if {[llength $untracked_paths]} {
-		set reply [ask_popup [mc "Stage also untracked files?"]]
+		set reply 0
+		switch -- [get_config gui.stageuntracked] {
+		no {
+			set reply 0
+		}
+		yes {
+			set reply 1
+		}
+		ask -
+		default {
+			set reply [ask_popup [mc "Stage also untracked files?"]]
+		}
+		}
 		if {$reply} {
 			set paths [concat $paths $untracked_paths]
 		}
diff --git a/lib/option.tcl b/lib/option.tcl
index 3807c8d..719103a 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -156,6 +156,7 @@ proc do_options {} {
 		{i-0..99 gui.commitmsgwidth {mc "Commit Message Text Width"}}
 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
 		{c gui.encoding {mc "Default File Contents Encoding"}}
+		{s gui.stageuntracked {mc "Staging of untracked files"} {list "yes" "no" "ask"}}
 		} {
 		set type [lindex $option 0]
 		set name [lindex $option 1]
@@ -208,6 +209,23 @@ proc do_options {} {
 				}
 				pack $w.$f.$optid -side top -anchor w -fill x
 			}
+			s {
+				set opts [eval [lindex $option 3]]
+				${NS}::frame $w.$f.$optid
+				${NS}::label $w.$f.$optid.l -text "$text:"
+				if {$use_ttk} {
+					ttk::combobox $w.$f.$optid.v \
+						-textvariable ${f}_config_new($name) \
+						-values $opts -state readonly
+				} else {
+					eval tk_optionMenu $w.$f.$optid.v \
+						${f}_config_new($name) \
+						$opts
+				}
+				pack $w.$f.$optid.l -side left -anchor w -fill x
+				pack $w.$f.$optid.v -side right -anchor e -padx 5
+				pack $w.$f.$optid -side top -anchor w -fill x
+			}
 			}
 		}
 	}
-- 
1.7.6.789.gb4599
