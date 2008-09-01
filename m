From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 00/12] Towards a better merge resolution support
Date: Mon, 1 Sep 2008 13:34:16 +0200
Message-ID: <20080901113416.GA8610@blimp.localhost>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com> <20080901094412.GB3993@blimp.local> <7vod38w3q6.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 13:35:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka7gr-00072i-MA
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 13:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbYIALeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 07:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYIALeT
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 07:34:19 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:56172 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYIALeS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 07:34:18 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20lf4ka7
Received: from tigra.home (Fab22.f.strato-dslnet.de [195.4.171.34])
	by post.webmailer.de (klopstock mo18) (RZmta 16.47)
	with ESMTP id 507030k81AbbPe ; Mon, 1 Sep 2008 13:34:16 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id A8705277AE;
	Mon,  1 Sep 2008 13:34:16 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id A092536D1D; Mon,  1 Sep 2008 13:34:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vod38w3q6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94576>

Junio C Hamano, Mon, Sep 01, 2008 12:38:25 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > ... IOW, copy the commit
> > resolution from some other merge commit. Maybe can be a way to use
> > rerere mechanism with that?
> 
> If you know which merge I did you want to steal from, you can prime your
> rerere database by pretending to be me, doing the merge.  Something like:
> 
> 	$ git checkout $merge^1 ;# detach to the parent of merge
>         $ git merge $merge^2 ;# pretend you were me to redo it
>         $ git diff -R $merge | git apply --index ;# and get what I did

I ended up using

    $ git checkout Merge^1
    $ git merge Merge^2
    $ git diff -R Merge | git apply
    $ git diff -R Merge --name-only -z | git update-index -z --stdin
    $ git rerere

Just git apply --index complained about the files missing from the
index:

    $ git tag Merge c5e2ace70271b481632aaf987361027ca4592df6
    $ gco Merge^1
    Previous HEAD position was c5e2ace... Merge branch 'jc/better-conflict-resolution' into next
    HEAD is now at 2392877... Merge branch 'master' into next
    $ git merge Merge^2
    Auto-merging Documentation/config.txt
    Auto-merging Documentation/git-checkout.txt
    CONFLICT (content): Merge conflict in Documentation/git-checkout.txt
    Auto-merging builtin-checkout.c
    CONFLICT (content): Merge conflict in builtin-checkout.c
    Auto-merging builtin-merge-recursive.c
    Auto-merging t/t6023-merge-file.sh
    Auto-merging t/t7201-co.sh
    CONFLICT (content): Merge conflict in t/t7201-co.sh
    Auto-merging xdiff-interface.c
    Auto-merging xdiff-interface.h
    Recorded preimage for 'Documentation/git-checkout.txt'
    Recorded preimage for 'builtin-checkout.c'
    Recorded preimage for 't/t7201-co.sh'
    Automatic merge failed; fix conflicts and then commit the result.
    $ git diff -R Merge |git apply --index
    error: Documentation/git-checkout.txt: does not exist in index
    error: builtin-checkout.c: does not exist in index
    error: t/t7201-co.sh: does not exist in index

> 	$ git rerere ;# have rerere record the resolution

Well, it works, but it's a bit of work and hard to automate (needs a
working tree). An option to merge:

    $ git merge <branch>
    conflict ... investigate ... find a resolution in <resolution>
    $ git reset --hard
    $ git merge --rerere <resolution> branch
    check... Ok.
    $ git commit

or rerere:

    $ git merge <branch>
    conflict ... investigate ... find a resolution in <resolution>
    $ git rerere <resolution>
    $ git reset --hard
    $ git merge <branch>
    check... Ok.
    $ git commit

These could be more convenient.
