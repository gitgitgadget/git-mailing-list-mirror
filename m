From: David Turner <dturner@twopensource.com>
Subject: [PATCH] git-gui: Make git-gui lib dir configurable at runtime
Date: Mon, 21 Jul 2014 14:20:09 -0400
Message-ID: <1405966809-30882-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 20:20:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9ICF-00077I-RV
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 20:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336AbaGUSUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 14:20:21 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:58768 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbaGUSUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 14:20:20 -0400
Received: by mail-qg0-f51.google.com with SMTP id a108so5848672qge.10
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 11:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pLTi+Ri9T5SLYVmm2UC+QZ7UvafeYVFlI0YKr7tnNQ8=;
        b=T29FvvFY0K4FRrRB8hHpgeEXFEaG1g0JpOvUeZrUjhMPQQJaqW/fbFOMCIbg0J3p48
         WSEhqMt/tSxIOdO1BrdnMuuB+d2WZKn2otyMrTZGcDpN73QdDKuibqlkSYGOZ+l54NLj
         AmX8Zn0VnLCILGZBvY86v+46l85dL8uns/thPgGXmDhqQaYZipvjwlVyIuqv1cnZZBo8
         s63UM/NdJZv/3MyzTP1VdsMdX04yzn0azjZxvLo5UH15MTOUwEQS2WIMA4axY8/G+hWw
         wFFsCNFZ1o4DMuGevZH4W3mpLCSCiY5B5tPMkdcSJOnqiXk1CnErM5rEpWrc59egqTg9
         +QpQ==
X-Gm-Message-State: ALoCoQlahK+Vp8+mDpWGPGCOYfrWQHNNxd5rBSaWmQ9EYWlsAwThdBUCvyOXlD9z9ABH8Dh4PlH5
X-Received: by 10.224.0.79 with SMTP id 15mr41922666qaa.56.1405966819488;
        Mon, 21 Jul 2014 11:20:19 -0700 (PDT)
Received: from leckie.office.twttr.net (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id k6sm16892646qge.2.2014.07.21.11.20.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jul 2014 11:20:18 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253987>

Introduce the GIT_GUI_LIB_DIR environment variable, to tell git-gui
where to look for TCL libs.  This allows a git-gui which has been
built with a prefix of /foo to be run out of directory /bar.  This is
the equivalent of GIT_EXEC_PATH or GITPERLLIB but for git-gui's TCL
libraries.

Signed-off-by: David Turner <dturner@twitter.com>
---
 git-gui/Makefile   | 3 ++-
 git-gui/git-gui.sh | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index cde8b2e..56bf9e2 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -177,7 +177,8 @@ git-gui: GIT-VERSION-FILE GIT-GUI-VARS
 	echo then >>$@+ && \
 	echo '	'echo \'git-gui version '$(GITGUI_VERSION)'\' >>$@+ && \
 	echo else >>$@+ && \
-	echo '	'exec \''$(libdir_SQ)/Git Gui.app/Contents/MacOS/$(subst \,,$(TKEXECUTABLE))'\' \
+	echo '	libdir="$$(GIT_GUI_LIB_DIR:-$(libdir_SQ))"' >>$@+ && \
+	echo '	'exec \"'$$libdir/Git Gui.app/Contents/MacOS/$(subst \,,$(TKEXECUTABLE))'\" \
 		'"$$0" "$$@"' >>$@+ && \
 	echo fi >>$@+ && \
 	chmod +x $@+ && \
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index b186329..6cbb36e 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -49,7 +49,11 @@ catch {rename send {}} ; # What an evil concept...
 ##
 ## locate our library
 
-set oguilib {@@GITGUI_LIBDIR@@}
+if { [info exists ::env(GIT_GUI_LIB_DIR) ] } {
+	set oguilib $::env(GIT_GUI_LIB_DIR)
+} else {
+	set oguilib {@@GITGUI_LIBDIR@@}
+}
 set oguirel {@@GITGUI_RELATIVE@@}
 if {$oguirel eq {1}} {
 	set oguilib [file dirname [file normalize $argv0]]
-- 
1.9.1
