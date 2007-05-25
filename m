From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn and SVK mirror between two repositories
Date: Fri, 25 May 2007 14:13:31 +1200
Message-ID: <4656464B.7010101@vilain.net>
References: <7d8fb81e0705241004u1c52fa7aub42d3793d4bfeaa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vinubalaji Gopal <vinubalaji@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 04:13:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrPJK-0002PN-GI
	for gcvg-git@gmane.org; Fri, 25 May 2007 04:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbXEYCNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 22:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbXEYCNn
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 22:13:43 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:36112 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbXEYCNn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 22:13:43 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 4850A13A3E1; Fri, 25 May 2007 14:13:41 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 15CF613A303;
	Fri, 25 May 2007 14:13:34 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <7d8fb81e0705241004u1c52fa7aub42d3793d4bfeaa7@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48333>

Vinubalaji,

You should be able to track both of the svn repositories as different
git-svn remotes.  You can then move patches between them with
git-format-patch and git-apply (or git-cherry-pick).

git-merge-base calculations won't work when operating like this - so
git-merge won't work - however the simple merge base token used by SVK
to track this would be easy to implement using git-tag and
git-update-ref, so you could get yourself something as useful as svk
smerge (which is really just mass cherry picking, using a token to
remember what it last picked).

A better implementation would be to allow git-svn to spot that the
repositories are tracking the same history and make sure they end up
with the same commits, then git-merge could work.

However, you are in a relatively obscure use case, most projects
wouldn't do this.  Note also that the merge tickets SVK would use are
not portable between different SVK mirrors so the merge information is
not retrievable for anyone other than the person who did the merge.  Use
"svn pg svk:merge svn://svn.paris.fr/" if you don't believe me... the
UUID and revision numbers in the property will not refer to revisions in
svn://svn.paris.fr/ but to the (private) SVN repository in the SVK depot.

Sam.


Vinubalaji Gopal wrote:
> Hi all,
>     I have been trying hard to find if it is possible to mirror (or
> clone in git-svn terms) two svn repositories and update changes from
> one to other or do even more complex operations with these two
> repositories. I did check the git-svn man page, but was lost without a
> proper example. Can someone please provide me with an example of using
> two svn repositories in git-svn and doing merge operations, etc .
> 
> I have used SVK for a long time and it was very much possible to use
> two svn repositories using the SVK FAQ entry as shown below:
> 
> Repository ONE in Paris, repository TWO in London and be able to
> create 2 mirrors then smerge both, doing it on a node in Berlin and
> using the mirror function?
> Sure. Simply do this:
> 
> svk mirror svn://svn.paris.fr/ //paris
> svk mirror svn://svn.london.uk/ //london
> 
> # pick a sensible base, or use --baseless
> svk smerge --base=1234 //paris //london
> 
> # ... and smerge between them normally ...
> svk smerge -I //london //paris
> svk smerge -I //paris //london
> 
> 
> 
