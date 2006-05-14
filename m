From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Howto get the merge-base ?
Date: Sun, 14 May 2006 11:40:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605141122380.3866@g5.osdl.org>
References: <4fb292fa0605141021r20cefaa0he592b9c713ede333@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 14 20:40:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfLWI-00087T-Lf
	for gcvg-git@gmane.org; Sun, 14 May 2006 20:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWENSko (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 14:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWENSko
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 14:40:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751562AbWENSkn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 14:40:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4EIeftH001400
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 14 May 2006 11:40:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4EIeehW012696;
	Sun, 14 May 2006 11:40:41 -0700
To: Bertrand Jacquin <beber.mailing@gmail.com>
In-Reply-To: <4fb292fa0605141021r20cefaa0he592b9c713ede333@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19979>



On Sun, 14 May 2006, Bertrand Jacquin wrote:
> 
> I'm trying to know which commit it the parent of a merge.
> For exemple if I do that :
> 
>   o Merge
>  / \
> /   \
> |   |
> |   o Commit D
> |   |
> |   o Commit C
> |   |
> o   | Commit B
> \  /
>  \/
>  o Commit A
>  |
>  o Init
> 
> How could I know that ``Commit A'' is the merge-base of ``Merge'' ?

Well, Junio already answered, but I'd like to comment a bit further.

There may not be "one" merge-base. There can be several:

		Merge
		  |
		  A
		 / \
		B   C
		|\ /|
		| X |
		|/ \|
		D   E
		 \ /
		  F
		  |

Here the merge (A) has two equally good merge bases: D and E.

If you want all of these merge-bases, you need to add the "--all" flag to 
git-merge-base.

On the git archive, try this trivia shell pipeline:

	git-rev-list --parents HEAD |
		sed -n '/^[0-9a-f]* [0-9a-f]* [0-9a-f]*$/ p' |
		while read a b c
		do
			echo $a: $(git merge-base --all $b $c)
		done | less -S

and you'll be able to easily pick up examples of where there are real 
multiple merge bases. For example, commit 4da8cbc2.. has that.

If you want to examine _why_ it has multiple merge-bases, do:

	gitk 4da8cbc2 --not 5910e997 52b70d56

(where the two "not" commits are the merge bases for it) which shows that 
merge and the criss-crossing nature of the history leading up to it.

NOTE! Most of the time, multiple merge bases do not really matter all that 
much, and you'd get the same merge regardless of which one you would 
choose as the base. Still, they _can_ matter.

			Linus
