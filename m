From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Nesting a submodule inside of another...
Date: Tue, 12 Jul 2011 21:23:13 +0200
Message-ID: <4E1C9F21.6070300@web.de>
References: <CAEBDL5XQDehUyqKoazxy+YVHh_2iAyt9aE-77H1jZg4oujMJgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Tue Jul 12 21:23:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgiYC-0003H5-Vh
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 21:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab1GLTXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 15:23:16 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:52119 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179Ab1GLTXP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 15:23:15 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 8B6B0193BF67F;
	Tue, 12 Jul 2011 21:23:13 +0200 (CEST)
Received: from [93.240.106.180] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QgiY5-0005Yl-00; Tue, 12 Jul 2011 21:23:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CAEBDL5XQDehUyqKoazxy+YVHh_2iAyt9aE-77H1jZg4oujMJgw@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19DWwjQdbVzvPJeXBMrrRWP74q909DlhZBCBljs
	dAQKKLiVIC7HQ/0MTbESwk4C7Zpd0epxLZwzLqn1ZdGma+p9cP
	Dg4DhS47gjnPGU73ngqw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176968>

Am 12.07.2011 14:01, schrieb John Szakmeister:
> I've got a project where we have several frameworks involved, and
> external modules we want to pull into the framework tree.  We'd like
> to make use of submodules and have something like this:
>     top-level/            <-- .gitmodules lives here
>         src/
>         framework1/   <-- a submodule
>             module/     <-- another submodule
>         framework2/   <-- a submodule
>             module2/    <-- another submodule
> 
> Currently, git fails trying to do this.  It's not happy about
> .gitmodules living at the top-level and nesting a submodule inside of
> another[1].  Is there a technical reason that this is not allowed?

Submodules are repositories of their own, so their work tree is outside
the superproject's work tree. You're attempting to have a submodule of
the superproject inside another submodule of the superproject, but this
won't work because it does not live in the superproject's work tree (as
that doesn't include submodules and their subdirectories).

To have nested submodules you must add "module" as a submodule of
"framework1" and "module2" as a submodule of "framework2". Then git
will handle them just fine (assuming you use the --recursive option for
"git submodule update" and friends). Of course that means that if you
want to record a new commit of a sub-submodule in the superpoject, you'll
have to commit that in it's parent submodule first and then can record
that commit in the superproject. (But if "framework1" wouldn't depend on
a specific version of "module", there would be no reason to put it inside
it in the first place, right?)

> Limiting the traversal up the tree, etc.?  I've worked around the lack
> of support to do this for now, but it would be really nice if we could
> do such a thing.

I can't think of a sane way to make that work.

> [1]  I may generate a patch for the error message, as the current
> implementation obscures the real error message.  When I try this, git
> says:
>     The following path is ignored by one of your .gitignore files:
>     framework1/module
>     Use -f if you really want to add it.
> 
>     After some careful debugging, I found out the real error message
> was about this sort of nesting being disallowed.

But at least since 1.6.2 git should issue a meaningful error message.
With current master I get:

$ git add sub/file
fatal: Path 'sub/file' is in submodule 'sub'

What version are you using?
