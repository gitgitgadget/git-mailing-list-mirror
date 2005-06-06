From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: new read-tree questions.
Date: Mon, 6 Jun 2005 08:04:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506060748390.1876@ppc970.osdl.org>
References: <7v64wrvpt4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 17:01:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfJ4I-0002fd-Kk
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 16:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVFFPCr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 11:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVFFPCr
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 11:02:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:64747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261494AbVFFPC3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 11:02:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j56F2IjA012190
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 6 Jun 2005 08:02:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j56F2Hv4030438;
	Mon, 6 Jun 2005 08:02:18 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64wrvpt4.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 6 Jun 2005, Junio C Hamano wrote:
>
> I am trying to understand the new git-read-tree, by using
> git-resolve-script as an example and also reading read-tree.c; I
> am somewhat confused.

It _is_ a confusing piece of code. You don't see it in the revision 
history, but I threw away a lot of trials that were crapola.

> * two-way merge (git-read-tree -m $H $M)
> 
> My understanding is that the current index is allowed to be
> empty, but if it is not, they are kept at stage0, and each of
> them must match $H and must be up-to-date if the merge involves
> them.

The rule really boils down to: "no information that only existed in the
old 'stag0' must be lost".

So that means that an empty old stage0 is always fine.

It also means that if the old stage0 exactly matches the result, then 
that's also always fine (regardless of the state of the actual checked out 
file: we've not _changed_ anything).

But it means that if the old stage0 gets deleted or over-written, then the 
information that the old stage0 _used_ to have needs to be encoded either 
in the result _or_ it needs to have been there in the original tree, ie 
the "loss" of information needs to be in the merge itself.

See? It's ok to drop information if that drop is encoded in the merge
itself ("we're merging a delete"), but it's _not_ ok to drop information
that wasn't part of the merge ("we're merging a delete where the index
file described something more than what was in the original tree")

Does that clarify what I'm aiming for? It may not clarify the code (which 
may or may not match my aims ;), but at least it hopefully clarifies what 
the _point_ of the code was supposed to be.

> To summarize my understanding of what should happen for each
> path:
> 
>   stage0 (index)  stage1 ($H)             stage2 ($M)
> ------------------------------------------------------------
>   no such path    no such path            no such path
>   * this does not happen (the code would not see such thing).

Yeah, I htink I get this right ;)

>   ----------------------------------------------------------
>   no such path    no such path            exists
>   * take $M without complaining.

Yes.

>   ----------------------------------------------------------
>   no such path    exists                  (does not matter)   *0*
>   * although index does not match $H, we do not reject, so
>     that a merge can happen on an empty cache.  We take $M.

Right. We didn't lose anything hugely important. 

In theory this could be a delete that we've missed, and we could add a 
flag to actually reject this case. However, it's always easy to "recover" 
deletes (just delete it again ;), so the loss of information is absolutely 
minimal, and it allows starting from an empty index file.

But this is debatable. We could reject it if you prefer that, and if you 
want to make it a command line flag I'll definitely apply the patch.

>   ----------------------------------------------------------
>   exists          no such path            no such path
>   * reject, because index does not match $H.

Exactly. The end result would have dropped the existing data, and the 
_merge_ didn't contain that drop, so we reject that.

>   ----------------------------------------------------------
>   exists          no such path            exists (index!=$M)
>   * reject, because index does not match $H.

Yes.

>   ----------------------------------------------------------
>   exists          no such path            exists (index=$M)   *1*
>   * take $M (same as "keep stage0").

This one is questionable. I think it should be accepted simply because 
there's no point in not accepting it.

>   ----------------------------------------------------------
>   exists          exists (index!=$H)      (does not matter)
>   * reject, because index does not match $H.

Yes.

>   ----------------------------------------------------------
>   exists          exists (index=$H)       no such path        *2*
>   * path is removed.

Yes. This drops the information, but since the merge contained that 
_exact_ drop, that's what we want it to do. This one is not questionable 
at all (except I got it wrong at one stage ;)

>   ----------------------------------------------------------
>   exists          exists (index=$H)       exists
>   * take stage2.

Yes. 

> Does the above matrix represent the intended behaviour?
> 
> I think I understand why we would want *0*, but this asymmetry
> feels wrong.

Yup, you got it.

> I am having trouble with the case *1*.

The fact that you're having trouble is good, it means you realize that 
reversing the merge doesn't get you the original state.

> Also I am not sure if the code does the right thing for case
> *2*.  If I am reading the code right, for such a path, we will
> see stage0 and stage1, and at that point say seen_stage1 = 1 and
> keep stage0 entry in "old".  Then we continue on to the next
> path.  When it happens to be:

You're right. I messed up. Again. And the test-case I used for this 
happened to not care (I think it may have been the only file, and as such 
the next path never happened).

Anyway, you definitely get the idea.

Another way of encoding the rules: we _should_ eventually aim for a
situation where if a git-read-tree succeeds (even if it leaves crap
entries in the tree), we should be able to do a

	git-read-tree -u -m <OLDHEAD>

and get back to the old state - or at least "close enough" (right now "-u"  
doesn't do anything for the single-tree case, and "-m" complains about
unmerged entries, but the point isn't that it works today, the point is 
what should be possible at some point ;)

		Linus
