From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [PATCH] gitk: Do not select file list entries during diff loading
Date: Sat, 27 Oct 2012 00:03:55 +0200
Message-ID: <508B08CB.5060702@arcor.de>
References: <20120918234611.GA5544@bloggs.ozlabs.ibm.com> <1348078647-22516-1-git-send-email-stefan@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stefan Haller <stefan@haller-berlin.de>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 00:04:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRs15-0000AP-GA
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 00:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966620Ab2JZWEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 18:04:23 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:53391 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966617Ab2JZWEW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Oct 2012 18:04:22 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mx.arcor.de (Postfix) with ESMTP id 9EA532D6535;
	Sat, 27 Oct 2012 00:04:21 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 9D6A628A3EA;
	Sat, 27 Oct 2012 00:04:21 +0200 (CEST)
Received: from [10.0.0.4] (188-22-33-156.adsl.highway.telekom.at [188.22.33.156])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-07.arcor-online.net (Postfix) with ESMTPA id 2C5A5108691;
	Sat, 27 Oct 2012 00:04:21 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-07.arcor-online.net 2C5A5108691
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1351289061; bh=4jaCZay3bydxuvfO1u5Fi3dcXy+gwAh46UmbtG9deUU=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=njjlj67UPh4Sel3vis4/Kj/e5Id4L/M7WrrGUT2aBBFkMZazq8lmGty0Ppf/l/8os
	 Ww7PDz4Sg3MVjAk1S64T86W2X/QiGyCutK2v7zaXzbXr5XwRYjhIwF9GKPvxYpvGaB
	 8bZEv7kPN/t8/bo9UjcIHMxGSvwpaCwrQoNYROI0=
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <1348078647-22516-1-git-send-email-stefan@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208493>

Scrolling notification works by callingscrolltext{}
with with 2 values between 0 and 1
for the beginning and the end of the view relative to the total length.
When a long diff with several files is loaded,
the diff view length is updated several times
and causes executions of scrolltext{} even when
the current view never changed.

Every time scrolltext{} is executed,
a entry in the file list is selected and scrolled to.

This makes it impossible for a user to scroll the file list
while a long diff is still loading.

Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
---
Hi,

i used v3 of the Synchronize patch (+ the 2 fixes on top)
for some time now on mingw,
but i found a slight problem for my usage.

While the diff is loaded, the file list on the right side always scrolls up.
When a single revision touches hundreds of files [1] the loading takes
quite long.
During the diff loading i want to scroll down in the file list to the
relevant file i
am interested in. But the file list jumps up all the time.

Please review/test the patch carefully before applying,
since i do not often work with tcl/tk :-)
(Or suggest better ways to solve this problem)

Greetings Peter

[1] I imported history of a historic project. Each release is represented
by a single commit. Thus one commit contains a lot of files/big amount
of changes.
But most times i am interested in only a single file in the middle of
the file list.

 gitk-git/gitk | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index b294c9e..621db87 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -8004,7 +8004,7 @@ proc nextfile {} {

 proc clear_ctext {{first 1.0}} {
     global ctext smarktop smarkbot
-    global ctext_file_names ctext_file_lines
+    global ctext_file_names ctext_file_lines ctext_last_scroll_pos
     global pendinglinks

     set l [lindex [split $first .] 0]
@@ -8020,6 +8020,7 @@ proc clear_ctext {{first 1.0}} {
     }
     set ctext_file_names {}
     set ctext_file_lines {}
+    set ctext_last_scroll_pos -1
 }

 proc settabs {{firstab {}}} {
@@ -8162,21 +8163,24 @@ proc
suppress_highlighting_file_for_current_scrollpos {} {
 }

 proc scrolltext {f0 f1} {
-    global searchstring cmitmode ctext
+    global searchstring cmitmode ctext ctext_last_scroll_pos
     global suppress_highlighting_file_for_this_scrollpos

+    .bleft.bottom.sb set $f0 $f1
+    if {$searchstring ne {}} {
+	searchmarkvisible 0
+    }
+
     set topidx [$ctext index @0,0]
+    if {$topidx eq $ctext_last_scroll_pos} return
+    set ctext_last_scroll_pos $topidx
+
     if {![info exists suppress_highlighting_file_for_this_scrollpos]
 	|| $topidx ne $suppress_highlighting_file_for_this_scrollpos} {
 	highlightfile_for_scrollpos $topidx
     }

     catch {unset suppress_highlighting_file_for_this_scrollpos}
-
-    .bleft.bottom.sb set $f0 $f1
-    if {$searchstring ne {}} {
-	searchmarkvisible 0
-    }
 }

 proc setcoords {} {
@@ -11643,6 +11647,7 @@ set autoselect 1
 set autosellen 40
 set perfile_attrs 0
 set want_ttk 1
+set ctext_last_scroll_pos -1

 if {[tk windowingsystem] eq "aqua"} {
     set extdifftool "opendiff"
-- 
1.8.0.rc2.251.g3315d86
