From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT RFC] Changing patch@branch syntax
Date: Fri, 22 Jun 2007 16:59:05 +0100
Message-ID: <b0943d9e0706220859n2c2962ffy21464526a5ebd6cd@mail.gmail.com>
References: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0705220527x5d4c3d0fw2d0d66b37aab3f97@mail.gmail.com>
	 <20070522210020.GV19253@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070621230207.GD7730@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 17:59:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1lXU-0000Iw-U9
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 17:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757796AbXFVP7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 11:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757746AbXFVP7J
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 11:59:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:55515 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757717AbXFVP7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 11:59:08 -0400
Received: by ug-out-1314.google.com with SMTP id j3so839196ugf
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 08:59:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Iy2FpZ/bOSe0w3kHwThpOovkzoU2BT0a37dcRwDcR/+/CSInIPfn7V2IA9z6YB/ZRjoz+YoNyNcqMx5NEBYc684xSTWE5fVV9lf0vEswyHtkAVCvYbraX9OdqL0aLa1ckl+2XO4du60k+PCasLRYsyqwUAX35WMSigx7mXOacb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BzRCu49StSJd5mwZj/oa/0n31xd5Buv9vvHsoyxh00iWCVD7BGqzOr7RKex3QES8FMgBhmYNibl9FpAgtZ/2TXHaq2y/4cQPuv+OGwTFrkv5mPHlCb7HXy2+0ZXVdLvDfg9IyLo12i7xjVH16fPkIZCdby6hHfllgXYGPLj0zHM=
Received: by 10.67.118.8 with SMTP id v8mr2914579ugm.1182527945784;
        Fri, 22 Jun 2007 08:59:05 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Fri, 22 Jun 2007 08:59:05 -0700 (PDT)
In-Reply-To: <20070621230207.GD7730@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50705>

On 22/06/07, Yann Dirson <ydirson@altern.org> wrote:
> First, as a foreword, a bit if refactoring: I think we should use some
> sort of Stackable (maybe pick a better name) class as a parent for
> Patch and PatchSet.  Instances of a Stackable would be candidates to
> be members of a PatchSet.  That means we can have stacks within a
> stack, as well as stacks members of a pool.  But we also need a syntax
> to name stacks-(in-a-stack)*, and patches within them.

I'm OK with refactoring the code this way (the current code is based
on the initial prototype but it evolved a lot since then).

> So here is a new proposal, which I believe would address all current
> issues, at the expense of changing stgit syntax.  The idea is to use a
> single separator for all levels of Stackable objects, with an optional
> "patch id" (eg. //top) at the end when meaningful.  Only names would
> be possible to omit, separators would be mandatory to specify the
> nesting level.  That gives a syntax of:
>
>         [patchset]([:stackable]+(//id)?)*

I don't think I can write a regexp for it but I don't like the
mandatory ":" before the patch name (or stackable object). The main
reason is that one usually works on a branch with patch names, there
might be scripts+xargs involved and forcing the use of ":" would make
it more complicated.

I also don't think we need to make this distinction in the names as
different commands or options take different type of arguments:

stg show <patch>
stg series --branch <stack>

I'll try to express this with BNF (though I'm not an expert in this notation):

<name> ::= "" | [^\w.-]+
<attr> ::= top | top.old | bottom | bottom.old | log | ...
<nameattr> ::= <name> | <name>//<attr>

<stackable> ::= <nameattr> | <stackable>:<stackable>

If empty name (""), the current object for the level is used.

The above <stackable> is more generic. A patchset might have other
attributes or none at all (could have a "old" attribute if we decide
to keep older versions of a stack for example).

In terms of our patches, stacks etc.:

<pool> ::= <name>
<stack> ::= <name> | <pool>:<name>
<patch> ::= <nameattr> | <stack>:<nameattr>

I would introduce a <repo> in front of all the above (for which we
don't have any support) but this is somehow at a similar level to
<pool> in case we don't use a hydra. Or the <pool> can also be a
repository?

> Examples:
>
>         <stack>                 the named branch (git-compatible)

<patch> - named patch in the current patchset

>         <stack>:<patch>         named patch in named stack

OK

>         :<patch>                named patch in current patchset (currently just "<patch>")

OK, the same as <patch>

>         <stack>:                current (top) patch in named patchset

OK (maybe use should use "current" rather than "top" in the
description as it applies better to other stackable objects)

>         <pool>:<stack>:<patch>  fully-qualified patch in a named hydra

OK

>         ::                      top patch of the current stack of an hydra

OK (current patch of the current stack)

>         :<stack>://bottom.old   previous bottom of the top patch in the named stack of current pool

OK

-- 
Catalin
