From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitk: UTF-8 support
Date: Sun, 27 Nov 2005 16:12:51 -0800
Message-ID: <7vr7917hq4.fsf@assigned-by-dhcp.cox.net>
References: <1132719301.12227.5.camel@dv>
	<7v64qi50sw.fsf@assigned-by-dhcp.cox.net>
	<20051123235315.oht0zjidc4ccg8gs@webmail.spamcop.net>
	<7v1x16y36r.fsf@assigned-by-dhcp.cox.net>
	<20051124021231.nrg8448gk8w4owk8@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 01:14:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgWe2-00084K-9d
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 01:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVK1AMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 19:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVK1AMx
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 19:12:53 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:37550 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751161AbVK1AMx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 19:12:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128001125.YDVP17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 27 Nov 2005 19:11:25 -0500
To: Pavel Roskin <proski@gnu.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12836>

Pavel Roskin <proski@gnu.org> writes:

>> And as I suggested in another message (in the died-out thread
>> about gitweb), we could have i18n.commitEncoding in the
>> configuration to help gitk and gitweb.  I think that is the same
>> as your "other option".
>
> Yes.  Then my patch needs to be changed to set encoding to that setting and only
> if it's present.

The following patch on top of your patch has seen only very
light testing, but it seems to do the right thing for my
repository with utf-8 commit messages and another with euc-jp
commit messages.  For the latter, I needed to do:

	$ git-repo-config i18n.commitencoding euc-jp

-- >8 --
[PATCH] gitk: Use i18n.commitencoding configuration item.

Hardcoding "utf-8" in the script breaks projects that use local
encoding, so allow setting i18n.commitEncoding.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/gitk b/gitk
index b53a5c5..2242216 100755
--- a/gitk
+++ b/gitk
@@ -3669,7 +3669,14 @@ set datemode 0
 set boldnames 0
 set diffopts "-U 5 -p"
 set wrcomcmd "git-diff-tree --stdin -p --pretty"
-set gitencoding "utf-8"
+
+set gitencoding ""
+catch {
+    set gitencoding [exec git-repo-config --get i18n.commitencoding]
+}
+if {$gitencoding == ""} {
+	set gitencoding "utf-8"
+}
 
 set mainfont {Helvetica 9}
 set textfont {Courier 9}
