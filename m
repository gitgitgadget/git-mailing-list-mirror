From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The merge from hell...
Date: Thu, 2 Feb 2006 00:44:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602020027400.21884@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org> 
 <e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com> 
 <Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
 <cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:45:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4a5M-0005Fl-8x
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 09:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423372AbWBBIoo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 03:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423380AbWBBIoo
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 03:44:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45725 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423372AbWBBIon (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 03:44:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k128iaDZ026079
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Feb 2006 00:44:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k128iZq3010314;
	Thu, 2 Feb 2006 00:44:35 -0800
To: Aneesh Kumar <aneesh.kumar@gmail.com>
In-Reply-To: <cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15498>



On Thu, 2 Feb 2006, Aneesh Kumar wrote:
> 
> Ok i tried using --cc. But then as per the man page if the
> optimization makes the all the hunks disapper then commit log is not
> show unless -m is used.

Ahh. You're mis-using git-diff-tree.

git-diff-tree will _never_ show the commit log if the diff ends up being 
empty. That can actually happen even for a regular commit, because we had 
some early bugs that allowed them.

See commit 69d37960b578be0a69383bd71d06c1fcfb86e8b9, for example. Notice 
how

	git-diff-tree --pretty 69d37960

is entirely silent, even though 

	git log 69d37960

clearly shows that the commit exists. I screwed up a commit, and 
effectively applied an empty patch (this was before git-apply would 
notice, and consider it an error - something I fixed very soon 
afterwards ;^).

> Is there a way to get the commit log printed.

Yes. What you should do is to do

	git-rev-list --parents --pretty

which gives the revision _log_ in pretty format. 

The difference between "git-rev-list --pretty" and "git-diff-tree 
--pretty" is really exactly that "git-rev-list" lists every revision, 
while git-diff-tree only lists revisions that _differ_ in the trees.

This, btw, is also really the main difference between doing a "git log" 
and doing a "git whatchanged". A "git log" shows all revisions (and uses 
"git-rev-list --pretty"). While "git whatchanged" shows what _changed_ 
(and uses "git-diff-tree --pretty").

For a revision tool like gitview, you want to use "git-rev-list --pretty".

[ SIDE NOTE! Actually, there's another format that you may find easier to 
  parse automatically: "git-rev-list --header". It uses the raw format, 
  and adds a NUL character between each rev. That makes things like the 
  date etc trivial to parse, and it's also slightly easier to see the end 
  of a commit message vs just a normal end-of-line. 

  So "gitk", for example, really parses the output of

	git-rev-list --header --topo-order --parents

  to generate the revision list. The "--topo-order" part guarantees that 
  all children will always be shown before any parents. ]

Hope that clarifies the issue.

		Linus
