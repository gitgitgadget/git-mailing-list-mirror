From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 6/7] mergetools: Fix difftool/mergetool --tool-help listing for vim
Date: Fri, 25 Jan 2013 01:43:53 -0800
Message-ID: <1359107034-14606-7-git-send-email-davvid@gmail.com>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:44:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyfpy-00082T-AD
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826Ab3AYJoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:44:20 -0500
Received: from mail-ia0-f173.google.com ([209.85.210.173]:44149 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab3AYJoP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:44:15 -0500
Received: by mail-ia0-f173.google.com with SMTP id l29so285805iag.32
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=GTV7Rcw5w6lek8XnBJbRcNdJCJs/S06DgqpycGOI0/M=;
        b=naH3WsVB42/c30hps3qFJGXUT/RVWdmKc1lguz36PKVoS4Jp0mjwTZANPXWENZi0IB
         YhLcZaCDd3Yy6GlwAymmrUxl2pp+jr1JjhnHMKKUBP+AmZES2UrOnZKm04/IgBqtglcD
         hgCs89GXiKWv9hf0iLsrEp0sMu9IqnU7rIgICbWXIzVYra0szUKFz/UqAwp7MmlLYt+d
         ZvxS28Sphr7iNypITFMArWy4OSLZhUhjh9ddkRzPtZsZEEy30P0XmvuGQ6bbdcVvJsDy
         CXyQOZesFhV/CnQwmZvHUnVU83Yyhr/92THML41FHWZhxAe3K3xtlDIXq3GrndVeaszb
         gtJQ==
X-Received: by 10.50.12.169 with SMTP id z9mr3579310igb.7.1359107054618;
        Fri, 25 Jan 2013 01:44:14 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id gs6sm314611igc.11.2013.01.25.01.44.12
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 01:44:13 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.367.g22b1720.dirty
In-Reply-To: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214529>

"git difftool --tool-help" and "git mergetool --tool-help" incorreclty
list "vim" as being an unavailable tool.  This is because they attempt
to find a tool named according to the mergetool scriptlet instead of the Git-
recognized tool name.

vimdiff, vimdiff2, gvimdiff, and gvimdiff2 are all provided by the "vim"
scriptlet.  This required git-mergetool--lib to special-case it when
setting up the tool.

Remove the exception for "vim" and allow the scriptlets to be found
naturally by using symlinks to a single "vimdiff" scriptlet.  This
causes the --tool-help option to correctly list vimdiff, vimdiff2,
gvimdiff, and gvimdiff2 in its output.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh       | 9 +--------
 mergetools/gvimdiff         | 1 +
 mergetools/gvimdiff2        | 1 +
 mergetools/{vim => vimdiff} | 0
 mergetools/vimdiff2         | 1 +
 5 files changed, 4 insertions(+), 8 deletions(-)
 create mode 120000 mergetools/gvimdiff
 create mode 120000 mergetools/gvimdiff2
 rename mergetools/{vim => vimdiff} (100%)
 create mode 120000 mergetools/vimdiff2

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 4c1e129..db8218a 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -44,14 +44,7 @@ valid_tool () {
 }
 
 setup_tool () {
-	case "$1" in
-	vim*|gvim*)
-		tool=vim
-		;;
-	*)
-		tool="$1"
-		;;
-	esac
+	tool="$1"
 	mergetools="$(git --exec-path)/mergetools"
 
 	# Load the default definitions
diff --git a/mergetools/gvimdiff b/mergetools/gvimdiff
new file mode 120000
index 0000000..2a72558
--- /dev/null
+++ b/mergetools/gvimdiff
@@ -0,0 +1 @@
+vimdiff
\ No newline at end of file
diff --git a/mergetools/gvimdiff2 b/mergetools/gvimdiff2
new file mode 120000
index 0000000..2a72558
--- /dev/null
+++ b/mergetools/gvimdiff2
@@ -0,0 +1 @@
+vimdiff
\ No newline at end of file
diff --git a/mergetools/vim b/mergetools/vimdiff
similarity index 100%
rename from mergetools/vim
rename to mergetools/vimdiff
diff --git a/mergetools/vimdiff2 b/mergetools/vimdiff2
new file mode 120000
index 0000000..2a72558
--- /dev/null
+++ b/mergetools/vimdiff2
@@ -0,0 +1 @@
+vimdiff
\ No newline at end of file
-- 
1.8.1.1.367.g22b1720.dirty
