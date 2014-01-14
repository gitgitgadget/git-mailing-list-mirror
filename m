From: Max Kirillov <max@max630.net>
Subject: [PATCH] git-gui: fallback right pane to packed widgets with Tk 8.4
Date: Wed, 15 Jan 2014 01:58:09 +0200
Message-ID: <20140114235809.GA15510@wheezy.local>
References: <CANJSc_uYm7f4LoZoMoVzcsmGrYnUy+2nXFL_cNWqQnwLb5J6mw@mail.gmail.com>
 <20140114011141.GF18964@google.com>
 <20140114065014.GA29816@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?Q?Beno=C3=AEt_Bourbi=C3=A9?= <benoit.bourbie@gmail.com>,
	git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Jan 15 00:58:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3DsD-0006zU-EO
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 00:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbaANX6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 18:58:18 -0500
Received: from p3plsmtpa06-09.prod.phx3.secureserver.net ([173.201.192.110]:47206
	"EHLO p3plsmtpa06-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751678AbaANX6Q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jan 2014 18:58:16 -0500
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa06-09.prod.phx3.secureserver.net with 
	id Dzy71n00D4CavkR01zyEQl; Tue, 14 Jan 2014 16:58:16 -0700
Content-Disposition: inline
In-Reply-To: <20140114065014.GA29816@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240425>

Since 918dbf58, git-gui crashes if started with Tk 8.4. The reason is that
tk < 8.5 does not support -stretch option for panedwindow.

Without the option it's not possible to properly expand the right half -
the commit area is expanded, while desired behavior is to expand the diff
area. So the whole feature should be disabled with Tk
version less than 8.5.

Signed-off-by: Max Kirillov <max@max630.net>
---
 git-gui/git-gui.sh | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index e2e710e..147be8c 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3196,18 +3196,28 @@ unset i
 
 # -- Diff and Commit Area
 #
-${NS}::panedwindow .vpane.lower -orient vertical
-${NS}::frame .vpane.lower.commarea
-${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1 -height 500
-.vpane.lower add .vpane.lower.diff
-.vpane.lower add .vpane.lower.commarea
-.vpane add .vpane.lower
-if {$use_ttk} {
-	.vpane.lower pane .vpane.lower.diff -weight 1
-	.vpane.lower pane .vpane.lower.commarea -weight 0
+if {$have_tk85} {
+	${NS}::panedwindow .vpane.lower -orient vertical
+	${NS}::frame .vpane.lower.commarea
+	${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1 -height 500
+	.vpane.lower add .vpane.lower.diff
+	.vpane.lower add .vpane.lower.commarea
+	.vpane add .vpane.lower
+	if {$use_ttk} {
+		.vpane.lower pane .vpane.lower.diff -weight 1
+		.vpane.lower pane .vpane.lower.commarea -weight 0
+	} else {
+		.vpane.lower paneconfigure .vpane.lower.diff -stretch always
+		.vpane.lower paneconfigure .vpane.lower.commarea -stretch never
+	}
 } else {
-	.vpane.lower paneconfigure .vpane.lower.diff -stretch always
-	.vpane.lower paneconfigure .vpane.lower.commarea -stretch never
+	frame .vpane.lower -height 300 -width 400
+	frame .vpane.lower.commarea
+	frame .vpane.lower.diff -relief sunken -borderwidth 1
+	pack .vpane.lower.diff -fill both -expand 1
+	pack .vpane.lower.commarea -side bottom -fill x
+	.vpane add .vpane.lower
+	.vpane paneconfigure .vpane.lower -sticky nsew
 }
 
 # -- Commit Area Buttons
-- 
1.8.4.2.1566.g3c1a064
