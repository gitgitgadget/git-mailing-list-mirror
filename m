From: Junio C Hamano <junkio@cox.net>
Subject: Re: SCSI trees, merges and git status
Date: Mon, 18 Apr 2005 16:23:24 -0700
Message-ID: <7vmzrvsm8j.fsf@assigned-by-dhcp.cox.net>
References: <1113856118.4998.70.camel@mulgrave>
	<Pine.LNX.4.58.0504181429570.15725@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Apr 19 01:19:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNfWz-0006Xb-3I
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 01:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVDRXXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 19:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVDRXXy
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 19:23:54 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:28891 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261190AbVDRXXv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 19:23:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418232324.PFTU4787.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Apr 2005 19:23:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504181429570.15725@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 18 Apr 2005 14:39:09 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Merged. Here's the command line history:

LT> 	~/git/git-pull-script \
LT>        rsync://www.parisc-linux.org/~jejb/scsi-rc-fixes-2.6.git

Maybe it is just me, but I have this setup:

    $ /bin/ls -lF .git
    total 20
    -rw-rw-r--  1 junio src     41 Apr 18 16:03 HEAD
    -rw-rw-r--  1 junio junio   41 Apr 18 15:07 MERGE_HEAD
    -rw-------  1 junio src   2720 Apr 18 16:03 index
    lrwxrwxrwx  1 junio src     18 Apr 18 15:55 objects -> ../../.git/objects/

My point being that .git/objects is a symbolic link and shares
object database with somewhere else.

However the "Getting object database" part trashed this symlink
when I tried to pull from my other repo locally.  I am wondering
it the following might be a better alternative.  A possible
downside in this approach is that you would not pull .git/heads
and .git/tags (i.e. Pesky stuff) from the remote anymore.  Is it
a problem (I am also CC'ing Petr to hear his opinion on this).

If not, please apply.

[PATCH] Do not let rsync obliterate .git/object symbolic link.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
git-pull-script: e27215d3978635558c63859495d97f8114b4ece3
--- a/git-pull-script
+++ b/git-pull-script
@@ -6,7 +6,7 @@
 merge_repo=$1
 
 echo "Getting object database"
-rsync -avz --ignore-existing $merge_repo/ .git/
+rsync -avz --ignore-existing $merge_repo/objects/. .git/objects/.
 
 echo "Getting remote head"
 rsync -avz $merge_repo/HEAD .git/MERGE_HEAD

