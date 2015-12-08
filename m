From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/2] gitk: match ttk fonts to gitk fonts
Date: Tue,  8 Dec 2015 08:05:50 +0100
Message-ID: <1449558351-15038-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <CAPig+cSwWxLMRh7e231svhtiJQH-5WuMO+3Y5x-e9tEOyHtqDg@mail.gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 08:06:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6CLa-0008S6-Dp
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 08:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095AbbLHHF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 02:05:58 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34866 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744AbbLHHF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 02:05:57 -0500
Received: by wmuu63 with SMTP id u63so169280520wmu.0
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 23:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ziZR+3rpizsr8gLDLUxubQ/rzSQ9PNN11x4Lu7EjXM0=;
        b=T7lmS/S0fgzoqXpVYFo4UvpXKVK1vdlxsPj7j6wplKm6N+DHueINf4g9IlteTrkEK+
         H4vyn8fHoluNQk6fJsXNhYQ6nKdyfWPW2U+Zx7AoTLk5Akagwo7amGTEUGwb9sXcAiwW
         u5j4h8aY53lPOiXK2MaUrZ1zoaBZiKq6hW0qLrLGQc6sAgGD7OghDpBArVAbjZJA0roW
         qT5w7fJQ3f4QxW1fX2EVjaQAyLHks1ahAqDkpeLT7V5dCD+3b/7TpvFEzpHGZASK1JCP
         JFgZXHFqujrUISEccg08lh3zqTQSjt/cKEXiKQ8++MGvDqT3RlIir1lUHWYsJVMEhz8F
         zdBA==
X-Received: by 10.28.174.68 with SMTP id x65mr23907349wme.51.1449558355916;
        Mon, 07 Dec 2015 23:05:55 -0800 (PST)
Received: from localhost ([151.54.54.213])
        by smtp.gmail.com with ESMTPSA id a76sm19977590wma.19.2015.12.07.23.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2015 23:05:55 -0800 (PST)
X-Mailer: git-send-email 2.6.3.659.gfdd8f28
In-Reply-To: <CAPig+cSwWxLMRh7e231svhtiJQH-5WuMO+3Y5x-e9tEOyHtqDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282147>

The fonts set in setoptions aren't consistently picked up by ttk, who
uses its own predefined fonts. This is noticeable when switching
between using and not using ttk with custom fonts or in HiDPI settings
(where the default TTK fonts do _not_ respect tk sclaing).

Fix by mapping the ttk fontset to the one used by gitk internally.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
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
