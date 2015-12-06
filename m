From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/2] gitk: match ttk fonts to gitk fonts
Date: Sun,  6 Dec 2015 13:25:22 +0100
Message-ID: <1449404723-27177-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1449404723-27177-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 06 13:26:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5YOL-0007Cl-Gk
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 13:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbbLFMZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 07:25:42 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34098 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbbLFMZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 07:25:33 -0500
Received: by wmvv187 with SMTP id v187so131322582wmv.1
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 04:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PuIXOMakPk5GHnZ7U9xkxxXdyuKM3bNEU1ALK8nHTRQ=;
        b=ZrS8LhSe9zTWBomwQUkGYrIKvvMEazQzigQA/FBCkJWr+RcSkH7ULDOdlsejxn/E/r
         aAIkdUOOqzzP7bbiGMy9ppzR/DA+4BlmyIR0LCbh+/n/C/Ols48XhxbK4t1Lm0k6892X
         TWqPKTIj2y9nxNJNA9tWRxXenofjitfx6nNUd4F5olpCkTcn3s/DndE4CizD4lEE5yd5
         e8nRPJ0xYpEqR3/P+Iea6eZ8JKustUMR4lRM/KLyPh1DdW/5NMv7LEq//72fnmxR92lq
         c+9+x7NOidD6Ga5K1x8MAMfpjO9uNeVyqdjKUlJzIqFhG5VCiBnm5Qqc65A160o0paC4
         19EQ==
X-Received: by 10.28.51.83 with SMTP id z80mr16180331wmz.54.1449404732247;
        Sun, 06 Dec 2015 04:25:32 -0800 (PST)
Received: from localhost ([151.54.54.213])
        by smtp.gmail.com with ESMTPSA id qm9sm20269168wjc.39.2015.12.06.04.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2015 04:25:31 -0800 (PST)
X-Mailer: git-send-email 2.6.3.659.gfdd8f28
In-Reply-To: <1449404723-27177-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282049>

The fonts set in setoptions aren't consistently picked up by ttk, who
uses its own predefined fonts. This is noticeable when switching
between using and not using ttk with custom fonts or in HiDPI settings
(where the default TTK fonts do _not_ respect tk sclaing).

Fix by mapping the ttk fontset to the one used by gitk internally.
---
 gitk | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/gitk b/gitk
index fcc606e..e04264b 100755
--- a/gitk
+++ b/gitk
@@ -1943,6 +1943,8 @@ proc confirm_popup {msg {owner .}} {
 }
 
 proc setoptions {} {
+    global use_ttk
+
     if {[tk windowingsystem] ne "win32"} {
         option add *Panedwindow.showHandle 1 startupFile
         option add *Panedwindow.sashRelief raised startupFile
@@ -1965,6 +1967,18 @@ proc setoptions {} {
     option add *Listbox.font mainfont startupFile
 }
 
+proc setttkstyle {} {
+    eval font configure TkDefaultFont [fontflags mainfont]
+    eval font configure TkTextFont [fontflags textfont]
+    eval font configure TkHeadingFont [fontflags mainfont]
+    eval font configure TkCaptionFont [fontflags mainfont] -weight bold
+    eval font configure TkTooltipFont [fontflags uifont]
+    eval font configure TkFixedFont   [fontflags textfont]
+    eval font configure TkIconFont    [fontflags uifont]
+    eval font configure TkMenuFont    [fontflags uifont]
+    eval font configure TkSmallCaptionFont [fontflags uifont]
+}
+
 # Make a menu and submenus.
 # m is the window name for the menu, items is the list of menu items to add.
 # Each item is a list {mc label type description options...}
@@ -12356,6 +12370,10 @@ if {![info exists have_ttk]} {
 set use_ttk [expr {$have_ttk && $want_ttk}]
 set NS [expr {$use_ttk ? "ttk" : ""}]
 
+if {$use_ttk} {
+    setttkstyle
+}
+
 regexp {^git version ([\d.]*\d)} [exec git version] _ git_version
 
 set show_notes {}
-- 
2.6.3.659.gfdd8f28
