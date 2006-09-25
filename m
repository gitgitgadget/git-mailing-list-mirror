From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH] gitk: Fix nextfile() and more
Date: Mon, 25 Sep 2006 22:46:52 +0900
Message-ID: <873bag12k3.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 25 15:49:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRqnj-00057d-BR
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 15:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWIYNrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 09:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWIYNrF
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 09:47:05 -0400
Received: from mail.parknet.jp ([210.171.160.80]:19721 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751171AbWIYNrC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Sep 2006 09:47:02 -0400
X-AuthUser: hirofumi@parknet.jp
Received: from ibmpc.myhome.or.jp ([210.171.168.39]:3734)
	by parknet.jp with [XMail 1.21 ESMTP Server]
	id <SAC09> for <git@vger.kernel.org> from <hirofumi@mail.parknet.co.jp>;
	Mon, 25 Sep 2006 22:46:57 +0900
Received: from duaron.myhome.or.jp (duaron.myhome.or.jp [192.168.0.2])
	by ibmpc.myhome.or.jp (8.13.8/8.13.8/Debian-2) with ESMTP id k8PDkr0M032357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 25 Sep 2006 22:46:55 +0900
Received: from duaron.myhome.or.jp (localhost [127.0.0.1])
	by duaron.myhome.or.jp (8.13.8/8.13.8/Debian-2) with ESMTP id k8PDkruF032324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 25 Sep 2006 22:46:53 +0900
Received: (from hirofumi@localhost)
	by duaron.myhome.or.jp (8.13.8/8.13.8/Submit) id k8PDkqqQ032323;
	Mon, 25 Sep 2006 22:46:52 +0900
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27737>

Hi,

The current nextfile() jumps to last hunk, but I think this is not
intention, probably, it's forgetting to add "break;". Right?  And this
patch also adds prevfile(), it jumps to previous hunk.

The following part is just my favorite the key-binds, it doesn't matter.

+    bind . <Control-p> "$ctext yview scroll -1 units"
+    bind . <Control-n> "$ctext yview scroll 1 units"
+    bind . <Alt-v> "$ctext yview scroll -1 pages"
+    bind . <Control-v> "$ctext yview scroll 1 pages"
+    bindkey P prevfile
+    bindkey N nextfile

What do you think of this?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 gitk |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff -puN gitk~gitk-key-emacs gitk
--- git/gitk~gitk-key-emacs	2006-09-25 22:31:51.000000000 +0900
+++ git-hirofumi/gitk	2006-09-25 22:31:51.000000000 +0900
@@ -672,6 +672,10 @@ proc makewindow {} {
     bind . <Control-Key-Down> "allcanvs yview scroll 1 units"
     bind . <Control-Key-Prior> "allcanvs yview scroll -1 pages"
     bind . <Control-Key-Next> "allcanvs yview scroll 1 pages"
+    bind . <Control-p> "$ctext yview scroll -1 units"
+    bind . <Control-n> "$ctext yview scroll 1 units"
+    bind . <Alt-v> "$ctext yview scroll -1 pages"
+    bind . <Control-v> "$ctext yview scroll 1 pages"
     bindkey <Key-Delete> "$ctext yview scroll -1 pages"
     bindkey <Key-BackSpace> "$ctext yview scroll -1 pages"
     bindkey <Key-space> "$ctext yview scroll 1 pages"
@@ -690,6 +694,8 @@ proc makewindow {} {
     bindkey <Key-Return> {findnext 0}
     bindkey ? findprev
     bindkey f nextfile
+    bindkey P prevfile
+    bindkey N nextfile
     bind . <Control-q> doquit
     bind . <Control-f> dofind
     bind . <Control-g> {findnext 0}
@@ -4440,12 +4446,26 @@ proc getblobdiffline {bdf ids} {
     }
 }
 
+proc prevfile {} {
+    global difffilestart ctext
+    set prev [lindex $difffilestart 0]
+    set here [$ctext index @0,0]
+    foreach loc $difffilestart {
+	if {[$ctext compare $loc >= $here]} {
+	    $ctext yview $prev
+	    break
+	}
+	set prev $loc
+    }
+}
+
 proc nextfile {} {
     global difffilestart ctext
     set here [$ctext index @0,0]
     foreach loc $difffilestart {
 	if {[$ctext compare $loc > $here]} {
 	    $ctext yview $loc
+	    break
 	}
     }
 }
_
