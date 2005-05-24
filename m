From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 09:53:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
References: <428E49DD.406@zytor.com> <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>
 <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188>
 <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com>
 <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com>
 <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 18:56:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DacgT-0006B9-5G
	for gcvg-git@gmane.org; Tue, 24 May 2005 18:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVEXQza (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 12:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVEXQyp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 12:54:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:51656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261273AbVEXQwB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 12:52:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OGpsjA004082
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 09:51:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OGpqx9005537;
	Tue, 24 May 2005 09:51:53 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Linus Torvalds wrote:
> 
> Wait another few minutes and I'll commit my fix the problem with cvsps
> branch handling (and I need to escape '$' in <<EOFMSG handling).

Ok, committed. It takes a few minutes for the mirroring to pick it up, but 
you should soon see a commit that says

    cvs2git: escape <<EOF messages, and work around cvsps branch handling
    
    This escapes '$' characters in <<-handling, and gives preference to
    the new branch when cvsps incorrectly reports a commit as originating
    on an old branch.

and once you do, you should have something that works. 

Of course, I've still only tested it on syslinux, but it converts a 
syslinux CVS repo in 64 seconds for me, and now the result really _does_ 
look correct at least superficially. Ie I can see 1029 commits on HEAD, 
which is exactly what cvsps also reports.

And I see four different branches (HEAD is called "master" as per the 
normal naming):

	torvalds@ppc970:~/src/osscvs/syslinux> ll .git/refs/heads/
	total 16K
	-rw-rw-r--  1 torvalds torvalds 41 May 24 09:36 branch-1_xx
	-rw-rw-r--  1 torvalds torvalds 41 May 24 09:37 master
	-rw-rw-r--  1 torvalds torvalds 41 May 24 09:36 syslinux
	-rw-rw-r--  1 torvalds torvalds 41 May 24 09:36 syslinux-1_6x-1

and doing a 

	git-rev-tree branch-1_xx master syslinux syslinux-1_6x-1 | wc -l

reports 1046 total revisions (which also matches cvsps exactly).

So things look ok, but I haven't actually checked the _contents_ of the
tree, except to look that the pathces that "git-whatchanged -p" reports
look sane.

There's two remaining bad things:

 - name translation doesn't exist (so all of Peters changesets get 
   reported as author "hpa <hpa>")

 - the commit time will be the conversion time, not the original commit 
   time (but the _author_ time will be correct). I suspect that for a 
   conversion like this, we really should add support for GIT_COMMIT_DATE. 

   That would also make the archive conversion 100% reproducible, ie
   everybody should get the exact same objects (and thus the exact same
   SHA1 values) which is good.

I'll add the GIT_COMMIT_DATE thing, but the name translation is for 
somebody else.

		Linus
