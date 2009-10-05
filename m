From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH RESEND] git submodule add: make the <path> parameter optional
Date: Mon, 05 Oct 2009 12:28:29 +0200
Message-ID: <4AC9CA4D.7020909@web.de>
References: <4AB8E8D4.40105@web.de> <7vbpl2srw9.fsf@alter.siamese.dyndns.org> <4AC8E0A8.4000901@web.de> <alpine.DEB.1.00.0910042304060.4985@pacific.mpi-cbg.de> <7vtyyek4nz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 12:35:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mukv4-0000TH-2m
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 12:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbZJEK3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 06:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758622AbZJEK3P
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 06:29:15 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40284 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758694AbZJEK3O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 06:29:14 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id DEDBF1251ACE8;
	Mon,  5 Oct 2009 12:28:36 +0200 (CEST)
Received: from [80.128.124.99] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Muko0-0000xo-00; Mon, 05 Oct 2009 12:28:36 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <7vtyyek4nz.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18pJngWBsTy3sg6mg01CeYAxAZIC8VsGmduVoyc
	sW0qPAl4wjU7IY3uuQdTi01pjVtQipzBV/WM1HZT3oVNYrNcNE
	D+tzzytpBgHItrDliz+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129551>

Junio C Hamano schrieb:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> So far, I started submodules by cloning them, doing everything in the 
>> other files needed to integrate, and then actually wondered why "git 
>> submodule add" could not simply take the (relative) path to the 
>> checked-out submodule and deduce the URL from the corresponding config?
> 
> Let me try to rephrase the above to see if I understand what you are
> doing.  When building a top-level superproject that uses two submodules
> from other places, you would do:
> 
> 	$ git init toplevel
>         $ cd toplevel
>         $ git clone $overthere submodule1
>         $ git clone $elsewhere submodule2
>         $ edit Makefile common.h
>         $ git add Makefile common.h submodule1 submodule2
> 
> and by "the corresponding config", you mean "submodule1/.git/config
> already records that it came from $overthere, and there is no reason to
> say it again in 'git submodule add $overthere submodule1'".

Right, no reason to use git submodule add here. But in this example
submodule1 & submodule2 aren't real submodules, because the .gitmodules
file is not created. Or am i missing something?


> If that is the case, I think it is a very sane argument.  It also makes me
> wonder why we need "git submodule add" as a separate step to begin with
> (i.e. "git add" Porcelain could do that behind the scene), but that is
> probably a separate topic.

I think we need git submodule add because it is doing much more than
a plain git add. It also does the clone and creates the .gitmodules
file needed later.

My everyday use case looks different. When i start a new project where
i want to use two of libraries living in their own git repo, i do:

   $ git init toplevel
   $ cd toplevel
   $ git submodule add git://mygitserver/submodule1.git submodule1
   $ git submodule add git://mygitserver/submodule2.git submodule2
   $ git commit -m 'Initial setup with submodule1 & submodule2'

After the submodule add submodule1, submodule2 and .gitmodules are
added to the index and the two repositories are cloned, so i just
have to do a commit when ready.

And with my patch the two submodule add lines read:

   $ git submodule add git://mygitserver/submodule1.git
   $ git submodule add git://mygitserver/submodule2.git

Which then resembles the command i would use when i want to clone them
on their own:

   $ git clone git://mygitserver/submodule1.git


>> So I would actually vote for making the <repository> parameter optional...
> 
> In your "git submodule add submodule1", it would be quite clear that it is
> a local path and <repository> is being omitted.  On the other hand, if you
> said "git submodule add $overthere" without submodule1, because $overthere
> is not likely to be an in-tree path, it also would be clear that it is
> omitting the path.  IOW, these two typesavers are not mutually exclusive.
> 
> In real life, it is very likely $overthere does _not_ end with submodule1,
> and your suggestion would probably be more useful than the patch under
> discussion, I think.

Actually, for me $overthere is _always_ a treeish path (e.g. ends with
submodule1 or submodule1.git). And almost always i have no reason to
name the local directory different than the repo.


Jens
