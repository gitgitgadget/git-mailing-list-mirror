From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-gui: Include version check and test for tearoff menu entry
Date: Mon, 14 Feb 2011 13:03:24 +0000
Message-ID: <878vxilndt.fsf_-_@fox.patthoyts.tk>
References: <20110212164344.GA19433@book.hvoigt.net>
	<AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com>
	<20110213134753.GC31986@book.hvoigt.net>
	<20110213135714.GE31986@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@gmail.com>,
	Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 15:08:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Poz6e-0003JT-TH
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 15:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab1BNOIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 09:08:44 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:44956 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754331Ab1BNOIm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 09:08:42 -0500
Received: from [172.23.170.142] (helo=anti-virus02-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Poz6W-0007jx-Ms; Mon, 14 Feb 2011 14:08:40 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1Poz6N-0007eG-3J; Mon, 14 Feb 2011 14:08:31 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 9090325005; Mon, 14 Feb 2011 14:08:30 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <20110213135714.GE31986@book.hvoigt.net> (Heiko Voigt's message
	of "Sun, 13 Feb 2011 14:57:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166713>

The --all option for git fetch was added in v1.6.6 so ensure we have a usable version before adding
the menu items.
Sometimes people use tearoff menus and these offset the entry indices by one.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---

Heiko Voigt <hvoigt@hvoigt.net> writes:
>It just came to my mind that I probably should implement a version check
>of the commandline to ensure that this option is available. Thats why I
>tagged only this patch with RFC.
>
>Cheers Heiko

The posted patch seems fine except that an error is reported if tearoff
menus are present. So this patch accommodates tearoff's. I looked up
when the --all option was added (1.6.6) and skip adding the menu entry
if we have an older version.

Seems to do the right thing.

 lib/remote.tcl |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/lib/remote.tcl b/lib/remote.tcl
index 817ca1b..b88f6e5 100644
--- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -233,6 +233,8 @@ proc make_sure_remote_submenues_exist {remote_m} {
 proc update_all_remotes_menu_entry {} {
 	global all_remotes
 
+	if {[git-version < 1.6.6]} { return }
+
 	set have_remote 0
 	foreach r $all_remotes {
 		set have_remote 1
@@ -243,27 +245,29 @@ proc update_all_remotes_menu_entry {} {
 	set prune_m $remote_m.prune
 	if {$have_remote} {
 		make_sure_remote_submenues_exist $remote_m
-		if {[$fetch_m entrycget 0 -label] ne "All"} {
+		set index [expr {[$fetch_m type 0] eq "tearoff" ? 1 : 0}]
+		if {[$fetch_m entrycget $index -label] ne "All"} {
 
-			$fetch_m insert 0 separator
-			$fetch_m insert 0 command \
+			$fetch_m insert $index separator
+			$fetch_m insert $index command \
 				-label "All" \
 				-command fetch_from_all
 
-			$prune_m insert 0 separator
-			$prune_m insert 0 command \
+			$prune_m insert $index separator
+			$prune_m insert $index command \
 	  			-label "All" \
 				-command prune_from_all
 		}
 	} else {
 		if {[winfo exists $fetch_m]} {
+			set index [expr {[$fetch_m type 0] eq "tearoff" ? 1 : 0}]
 			if {[$fetch_m type end] eq "separator"} {
 
-				delete_from_menu $fetch_m 0
-				delete_from_menu $fetch_m 0
+				delete_from_menu $fetch_m $index
+				delete_from_menu $fetch_m $index
 
-				delete_from_menu $prune_m 0
-				delete_from_menu $prune_m 0
+				delete_from_menu $prune_m $index
+				delete_from_menu $prune_m $index
 			}
 		}
 	}
-- 
1.7.4.47.gb308bf
