From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 17:50:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>
  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org> 
 <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>
  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>
  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com>
 <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
 <428E745C.30304@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 02:48:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZI9r-0002Ct-RX
	for gcvg-git@gmane.org; Sat, 21 May 2005 02:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVEUAst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 20:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVEUAst
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 20:48:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:41438 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261438AbVEUAs1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 20:48:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4L0mKjA007857
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 17:48:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4L0mJuw011361;
	Fri, 20 May 2005 17:48:19 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <428E745C.30304@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


[ Thomas added to cc, since he seems to have also worked on this ]

On Fri, 20 May 2005, H. Peter Anvin wrote:
> 
> Here is my "main" OSS CVS repository; look at the syslinux module.  It 
> has at least some minor branching.

Ok, "cvsps" output scares me. I wonder what

	WARNING: Invalid PatchSet 775, Tag syslinux-2_12-pre7:
	    memdisk/init32.asm:1.3=after, memdisk/Makefile:1.26=before. Treated as 'before'
	WARNING: Invalid PatchSet 775, Tag syslinux-2_12-pre7:
	    memdisk/init32.asm:1.3=after, memdisk/e820test.c:1.7=before. Treated as 'before'
	...

means..

Also, your syslinux repo is interesting and shows another thing: doing a

	cvsps -g -p separate

ends badly with

	Directing PatchSet 938 to file separate/938.patch
	cvs rdiff: failed to read diff file header /tmp/cvso8PswZ for mdiskchk.com,v: end of file
	system command returned non-zero exit status: 1: aborting

which doesn't look very promising and causes an empty diff for
mdiskck.com. Trying with --cvs-direct shows the reason:

	Index: syslinux/sample/mdiskchk.com
	===================================================================
	RCS file: 
	/home/torvalds/src/osscvs/cvsroot/syslinux/sample/mdiskchk.com,v
	retrieving revision 1.1
	retrieving revision 1.2
	diff -u -r1.1 -r1.2
	Binary files /tmp/cvsU6MGU0 and /tmp/cvsiskFVR differ

which shows that anything that bases itself of diffs (ie uses "-g" with
cvsps) is just doomed to failure, since there's no good way to handle
binary data. Both Kay's and Thomas' scripts try to do the "-g" thing, 
that's just not right.

So the cvs->git thing would need to be based on the actual objects, which 
obviously fits git quite well, but I was really hoping to have cvsps give 
some nice intermediate format..

So it looks like we should avoid the diff format, and instead use

	cvsps -p separate

and then just parse the "Members" thing and turning each of them either
into a "delete"  (for ->.*DEAD) or "cvs checkout -rxxx" (for ".*->xxx").

Handling branches by literally treating them as different heads in git 
sounds quite simple, and indeed it looks like the basic logic for cvs->git 
translation would be

	for-each-patch-from-cvsps
	do
		git-read-tree -m branchname-from-patch
		git-update-cache -f -u -q -a
		for-each-member-in-patch
		do
			if [ DEAD ]; then
				rm member
				git-update-cache --remove member
			else
				cvs co -rREV member
				git-update-cache --add member
			fi
			cat commit-message-from-patch | 
				git-commit-tree $(git-write-tree) -p branchname-from-patch > .git/revs/heads/branchname-from-patch
		done
	done

which looks like it should work, and handle binary files right.

There seems to be two questions:

 - what to do about branch creation (ie a branch name we haven't seen
   before): it looks like cvsps doesn't tell you what the _originating_
   branch was for a new branch (that may be my confusion - maybe you can't
   create branches off branches in CVS?)

   For syslinux, it looks like you can always base it on HEAD, or possibly 
   just the previous patch (which looks like it is always HEAD). The above 
   pseudo-script will actually do that automatically, simply by virtue of
   the "git-read-tree -m" at the top of the loop failing when the
   branchname doesn't exist yet.

 - whether to bother to create merge entries for when somebody tried to 
   merge a branch back or forth in CVS. 

   CVS fundamentally doesn't have the notion of such a thing, and cvsps 
   can't either. But we could try to guess, based on the commit message, 
   perhaps.

   NOTE! Such a "merge" would not have any real GIT merge functionality 
   what-so-ever. It would just introduce a second parent into the commit, 
   nothing more.

Bah. What crud.

		Linus
