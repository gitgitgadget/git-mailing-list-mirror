From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add "git-update-ref" to update the HEAD (or other) ref
Date: Sun, 25 Sep 2005 12:05:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509251153090.3308@g5.osdl.org>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sun Sep 25 21:06:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJboy-0001Yr-Fr
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 21:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVIYTFl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 15:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVIYTFl
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 15:05:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50089 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932267AbVIYTFl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2005 15:05:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8PJ5a4s013857
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 25 Sep 2005 12:05:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8PJ5ZWZ025542;
	Sun, 25 Sep 2005 12:05:35 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9275>



On Sun, 25 Sep 2005, Linus Torvalds wrote:
>
> This is a careful version of the script stuff that currently just
> blindly writes HEAD with a new value.

Btw, in case it wasn't clear from the patch, this only introduced 
mechanism, it didn't actually use it in any script.

But the point of the exercise is to move towards using git-update-ref in 
places like git-fetch.sh, which currently are doing some of it by hand 
(and not handling symlinks etc).

So you should be able to do something like

	..
	old=$(git-rev-parse --verify "$refname^0") >& /dev/null
	if [ "$old" ]; then
		mb=$(git-merge-base $new $old)
		if [ "$mb" != "$old" ]; then
			echo "$new is not a fast-forward of $old"
			[ "$force" ] || exit 1
			old=
		fi
	fi
	git-update-ref "$refname" $new $old

and the actual update phase will re-verify that "old" is still valid (if 
it exists at all).

Doing it by hand works, of course, but for example, if we have two
symlinks pointing to the same ref, the current locking in git-fetch.sh is
broken - it may lock the _symlink_, but since the other one _also_ points 
to the same thing, there's no locking of the _target_.

git-update-ref should do things like that right. Famous last words ;)

			Linus
