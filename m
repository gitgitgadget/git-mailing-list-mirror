From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make -s flag to show-diff a no-op.
Date: Wed, 27 Apr 2005 16:05:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271600280.18901@ppc970.osdl.org>
References: <7vfyxbeuwt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504271520150.18901@ppc970.osdl.org> <7v64y7etko.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 00:58:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQvTd-0008UD-Ug
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 00:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVD0XDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 19:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVD0XDO
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 19:03:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:11170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262084AbVD0XDH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 19:03:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RN33s4026506
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 16:03:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RN32eH016059;
	Wed, 27 Apr 2005 16:03:02 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64y7etko.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Junio C Hamano wrote:
> 
> When I know which path I am interested in,
> 
>     $ diff-tree -p <tree-1> <tree-2> ls-tree.c
> 
> would still get the benefit of not descending down into ppc and
> mozilla-sha1 subdirectories, if I am not mistaken.

It won't. It will see that those two aren't interesting, because they 
don't match the pathname, so it will ignore them regardless of whether 
there is a -r or not.

> Think of the kernel sources, and I would say leaving the option
> of not recursing down is a good thing.

Well, if you give pathnames, it's always going to limit recursion to only 
those subdirectories that match one of them. 

And if you don't give pathnames, then nor recursing will do something 
pretty strange, ie give a diff of only the files in the top-level 
directory, and totally ignore the subdirectories that did change:

	torvalds@ppc970:~/v2.6/linux> diff-tree e8108c98dd6d65613fa0ec9d2300f89c48d554bf $(cat .git/HEAD)
	*040000->040000 tree    d44b45026cd1c9530a78756b11d6bb9a78718cc3->474afcccb9cac147aa3b95a9afdd91c2edb139f5      arch
	*040000->040000 tree    2394cd732a73c793ba93c32be6e7f058bd7171d8->da5f26fc8b12defe39e58b76e8087281effbf6bf      drivers
	*040000->040000 tree    8d5010b0ff2b7325131536c63ed04071a563e310->cf51450069a2ab187b611599d1a0e037f176c6c3      fs
	*040000->040000 tree    a06b4fb363dcfd3225cfe3ac3a0aa02e8d628975->c27a22db91b056499a5c1198ace432768475b5bd      include

and then

	torvalds@ppc970:~/v2.6/linux> diff-tree -p e8108c98dd6d65613fa0ec9d2300f89c48d554bf $(cat .git/HEAD)
	<no output what-so-ever>

where showing things as if nothing changed seems to be actively _wrong_, 
I'd say..

		Linus
