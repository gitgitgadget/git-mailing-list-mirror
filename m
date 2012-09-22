From: Stefan Haller <stefan@haller-berlin.de>
Subject: [PATCH] gitk: Work around empty back and forward images when buttons are disabled
Date: Sat, 22 Sep 2012 09:46:48 +0200
Message-ID: <1348300008-90717-1-git-send-email-stefan@haller-berlin.de>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 09:47:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFKQr-0003qR-1y
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 09:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952Ab2IVHrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 03:47:12 -0400
Received: from server90.greatnet.de ([83.133.96.186]:55681 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab2IVHrL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 03:47:11 -0400
Received: from localhost.localdomain (dslb-088-073-094-229.pools.arcor-ip.net [88.73.94.229])
	by server90.greatnet.de (Postfix) with ESMTPA id C91843B0E8E;
	Sat, 22 Sep 2012 09:47:09 +0200 (CEST)
X-Mailer: git-send-email 1.7.12.1.399.gae20e0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206198>

On Mac, the back and forward buttons show an empty rectange instead of
a grayed-out arrow when they are disabled. The reason is a Tk bug on Mac
that causes disabled images not to draw correctly (not to draw at all,
that is); see
<https://groups.google.com/forum/?fromgroups=#!topic/comp.lang.tcl/V-nW1JBq0eU>.

To work around this, we explicitly provide gray images for the disabled
state; I think this looks better than the default stipple effect that you
get on Windows as well, but that may be a matter of taste.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 gitk | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index d93bd99..e7723db 100755
--- a/gitk
+++ b/gitk
@@ -2161,7 +2161,7 @@ proc makewindow {} {
     trace add variable sha1string write sha1change
     pack $sha1entry -side left -pady 2
 
-    image create bitmap bm-left -data {
+    set bm_left_data {
 	#define left_width 16
 	#define left_height 16
 	static unsigned char left_bits[] = {
@@ -2169,7 +2169,7 @@ proc makewindow {} {
 	0x0e, 0x00, 0xff, 0x7f, 0xff, 0x7f, 0xff, 0x7f, 0x0e, 0x00, 0x1c, 0x00,
 	0x38, 0x00, 0x70, 0x00, 0xe0, 0x00, 0xc0, 0x01};
     }
-    image create bitmap bm-right -data {
+    set bm_right_data {
 	#define right_width 16
 	#define right_height 16
 	static unsigned char right_bits[] = {
@@ -2177,11 +2177,16 @@ proc makewindow {} {
 	0x00, 0x38, 0xff, 0x7f, 0xff, 0x7f, 0xff, 0x7f, 0x00, 0x38, 0x00, 0x1c,
 	0x00, 0x0e, 0x00, 0x07, 0x80, 0x03, 0xc0, 0x01};
     }
-    ${NS}::button .tf.bar.leftbut -image bm-left -command goback \
-	-state disabled -width 26
+    image create bitmap bm-left -data $bm_left_data
+    image create bitmap bm-left-gray -data $bm_left_data -foreground "#999"
+    image create bitmap bm-right -data $bm_right_data
+    image create bitmap bm-right-gray -data $bm_right_data -foreground "#999"
+
+    ${NS}::button .tf.bar.leftbut -image [list bm-left disabled bm-left-gray] \
+	-command goback -state disabled -width 26
     pack .tf.bar.leftbut -side left -fill y
-    ${NS}::button .tf.bar.rightbut -image bm-right -command goforw \
-	-state disabled -width 26
+    ${NS}::button .tf.bar.rightbut -image [list bm-right disabled bm-right-gray] \
+	-command goforw -state disabled -width 26
     pack .tf.bar.rightbut -side left -fill y
 
     ${NS}::label .tf.bar.rowlabel -text [mc "Row"]
-- 
1.7.12.1.399.gae20e0d
