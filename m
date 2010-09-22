From: lists@haller-berlin.de (Stefan Haller)
Subject: [PATCH] git-gui: Work around freeze problem with dialogs in Mac OS X
Date: Wed, 22 Sep 2010 19:46:52 +0200
Message-ID: <1jp8k4n.1lz3bce9u857kM%lists@haller-berlin.de>
References: <1jogy2y.tfhl6g1eq9mylM%lists@haller-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 19:47:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyTPJ-00044i-3i
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 19:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab0IVRqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 13:46:55 -0400
Received: from mail.ableton.net ([62.96.12.115]:60671 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096Ab0IVRqy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 13:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:To; bh=y8WBPkx+PuYhDTSYVB3dXLaFYJda0PvgSXYKr8Gzvvk=;
	b=AW9E8PXdb57XxIqiWBBzFh8o4w1lC4lf3GXIFhjLYl6l+RWZYlHr6n2xMCAOj7lzUs2xuTO1XMghU8vsQPpg4xD40DPCJ6bflCZ71QKVkpXbXmvXt0msLRMn2lxRDy9hXdRiJqCtsXg4EP3aXnqhfavZqyFBsXJS5n4Wrz43IUc=;
Received: from dslb-088-073-104-214.pools.arcor-ip.net ([88.73.104.214] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1OyTPA-0004Fm-OE
	for git@vger.kernel.org; Wed, 22 Sep 2010 19:46:53 +0200
In-Reply-To: <1jogy2y.tfhl6g1eq9mylM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156812>

Tk 8.5 on Mac OS X has a bug whereby a dialog opened from a key
binding will hang; see issue 3044863 in the Tk issue tracker.
<http://sourceforge.net/tracker/?func=detail&aid=3044863&group_id=12997&atid=112997>

To work around this, we perform commands that open a dialog after
a brief delay; 150 ms seems to be a good compromise between short
enough as to be not annoying, and long enough to reliably work
around the issue.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
I already sent this two days ago, but it didn't seem to appear on the
list for some reason, so I'm resending it. Apologies if you see this
twice.

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

