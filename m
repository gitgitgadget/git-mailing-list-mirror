From: lists@haller-berlin.de (Stefan Haller)
Subject: [PATCH] git-gui: Work around freeze problem with dialogs in Mac OS X
Date: Tue, 21 Sep 2010 10:26:44 +0200
Message-ID: <1jp5xs1.ebxa6718bj9huM%lists@haller-berlin.de>
References: <1jogy2y.tfhl6g1eq9mylM%lists@haller-berlin.de>
Cc: git@vger.kernel.org, dsteffen@apple.com (Daniel A Steffen)
To: patthoyts@users.sourceforge.net (Pat Thoyts),
	das@users.sourceforge.net (Daniel A. Steffen)
X-From: git-owner@vger.kernel.org Tue Sep 21 10:27:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxyBu-0007Ep-7P
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 10:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416Ab0IUI0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 04:26:51 -0400
Received: from mail.ableton.net ([62.96.12.115]:40013 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755703Ab0IUI0u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 04:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=btBD/3qBZAQlf5ZbXAqd698oZdupvfrSe91eINg7boI=;
	b=iG6lKKXbAzbN8UYYrVdqzsCLOR7jHT6XyaZzF3dhbjKZGuWh1z2bXowP9BaqA5oRynUo4A1m6pTG4hjHM4u3SuUtFY0baCTvUIcShTevb0JgimBupHalCCmzC1x10yoyHWk1pD7bHjm79AtaAU7Vi0bD/8IC8uTLoxmMtET2IfI=;
Received: from macbook-stk.office.ableton.com ([10.1.12.2])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1OxyBY-0006hE-WA; Tue, 21 Sep 2010 10:26:45 +0200
In-Reply-To: <1jogy2y.tfhl6g1eq9mylM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156696>

Tk 8.5 on Mac OS X has a bug whereby a dialog opened from a key
binding will hang; see issue 3044863 in the Tk issue tracker.
<http://sourceforge.net/tracker/?func=detail&aid=3044863&group_id=12997&atid=112997>

To work around this, we perform commands that open a dialog after
a brief delay; 150 ms seems to be a good compromise between short
enough as to be not annoying, and long enough to reliably work
around the issue.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 git-gui.sh |   39 +++++++++++++++++++++++++++------------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 4617f29..394c2a0 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3560,6 +3560,21 @@ if {[info exists repo_config(gui.wmstate)]} {
    catch {wm state . $repo_config(gui.wmstate)}
 }
 
+proc mac_freeze_workaround {cmd} {
+   if {[is_MacOSX] && $::have_tk85} {
+       # Tk 8.5 on Mac OS X has a bug whereby a dialog opened from a key
+       # binding will hang; see issue 3044863 in the Tk issue tracker.
+       # <http://sourceforge.net/tracker/?func=detail&aid=3044863&group_id=12997&atid=112997>
+       #
+       # To work around this, we perform commands that open a dialog after a brief
+       # delay; 150 ms seems to be a good compromise between short enough as to be
+       # not annoying, and long enough to reliably work around the issue.
+       after 150 $cmd
+   } else {
+       $cmd
+   }
+}
+
 # -- Key Bindings
 #
 bind $ui_comm <$M1B-Key-Return> {do_commit;break}
@@ -3567,8 +3582,8 @@ bind $ui_comm <$M1B-Key-t> {do_add_selection;break}
 bind $ui_comm <$M1B-Key-T> {do_add_selection;break}
 bind $ui_comm <$M1B-Key-u> {do_unstage_selection;break}
 bind $ui_comm <$M1B-Key-U> {do_unstage_selection;break}
-bind $ui_comm <$M1B-Key-j> {do_revert_selection;break}
-bind $ui_comm <$M1B-Key-J> {do_revert_selection;break}
+bind $ui_comm <$M1B-Key-j> {mac_freeze_workaround do_revert_selection;break}
+bind $ui_comm <$M1B-Key-J> {mac_freeze_workaround do_revert_selection;break}
 bind $ui_comm <$M1B-Key-i> {do_add_all;break}
 bind $ui_comm <$M1B-Key-I> {do_add_all;break}
 bind $ui_comm <$M1B-Key-x> {tk_textCut %W;break}
@@ -3606,16 +3621,16 @@ bind $ui_diff <Control-Key-f> {catch {%W yview scroll  1 pages};break}
 bind $ui_diff <Button-1>   {focus %W}
 
 if {[is_enabled branch]} {
-   bind . <$M1B-Key-n> branch_create::dialog
-   bind . <$M1B-Key-N> branch_create::dialog
-   bind . <$M1B-Key-o> branch_checkout::dialog
-   bind . <$M1B-Key-O> branch_checkout::dialog
-   bind . <$M1B-Key-m> merge::dialog
-   bind . <$M1B-Key-M> merge::dialog
+   bind . <$M1B-Key-n> {mac_freeze_workaround branch_create::dialog}
+   bind . <$M1B-Key-N> {mac_freeze_workaround branch_create::dialog}
+   bind . <$M1B-Key-o> {mac_freeze_workaround branch_checkout::dialog}
+   bind . <$M1B-Key-O> {mac_freeze_workaround branch_checkout::dialog}
+   bind . <$M1B-Key-m> {mac_freeze_workaround merge::dialog}
+   bind . <$M1B-Key-M> {mac_freeze_workaround merge::dialog}
 }
 if {[is_enabled transport]} {
-   bind . <$M1B-Key-p> do_push_anywhere
-   bind . <$M1B-Key-P> do_push_anywhere
+   bind . <$M1B-Key-p> {mac_freeze_workaround do_push_anywhere}
+   bind . <$M1B-Key-P> {mac_freeze_workaround do_push_anywhere}
 }
 
 bind .   <Key-F5>     ui_do_rescan
@@ -3625,8 +3640,8 @@ bind .   <$M1B-Key-s> do_signoff
 bind .   <$M1B-Key-S> do_signoff
 bind .   <$M1B-Key-t> do_add_selection
 bind .   <$M1B-Key-T> do_add_selection
-bind .   <$M1B-Key-j> do_revert_selection
-bind .   <$M1B-Key-J> do_revert_selection
+bind .   <$M1B-Key-j> {mac_freeze_workaround do_revert_selection}
+bind .   <$M1B-Key-J> {mac_freeze_workaround do_revert_selection}
 bind .   <$M1B-Key-i> do_add_all
 bind .   <$M1B-Key-I> do_add_all
 bind .   <$M1B-Key-minus> {show_less_context;break}
-- 
1.7.3.4.g200b9
