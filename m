From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Tue, 11 Mar 2008 21:46:30 -0800
Message-ID: <402c10cd0803112246q4ec98018pe9a34b95e32cf1@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
	 <7vk5k9eqax.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 06:47:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZJnz-000257-Iz
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 06:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbYCLFqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 01:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbYCLFqc
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 01:46:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:25246 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbYCLFqc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 01:46:32 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2733888fga.17
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 22:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yOGdcCW0opbcj0eCwDKsEwUQWqKPluMm76nVRIWjMJs=;
        b=GFnFjPiBbSf7Rwup82ziVIqu6ANw00K6WtUmCxcfcRu/xPH58fu8RrjNG775KF7yixQJt7MZtq4vuVwuSWP96fxudupwnmCweKRMB0cCMtUo/YqQWnU/QQxfOAdfwOp+jyd9WSOpLn9TE5vVyRJpK0DLbc0WgR2imfXW+1h9Dj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hzYbWHBeMjbXDvA2e46uHB557fwT9FsQZl0+KOMwWVmQa6ZdnUsCzdG73+LmU97unIo5lAJq9DaIquQ2Pn8sBnL9kod143ryrCC6eZPEUFPsYllqevWm18sDiv6tq8Sljzrpj0bAyJ3AgAP4azBLmNPzcmq14UEMn2SrHlK71rw=
Received: by 10.82.108.9 with SMTP id g9mr18792662buc.4.1205300790309;
        Tue, 11 Mar 2008 22:46:30 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Tue, 11 Mar 2008 22:46:30 -0700 (PDT)
In-Reply-To: <7vk5k9eqax.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76926>

On Mon, Mar 10, 2008 at 10:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Sverre Hvammen Johansen" <hvammen@gmail.com> writes:
>
>  > @@ -153,8 +153,8 @@ parse_config () {
>  >               --summary)
>  >                       show_diffstat=t ;;
>  >               --squash)
>  > -                     test "$allow_fast_forward" = t ||
>  > -                             die "You cannot combine --squash with --no-ff."
>  > +                     test "$fast_forward" = allow ||
>  > +                             die "You cannot combine --squash with --ff=never."
>
>  Why does the user get this message after saying --ff=only?

Bug.  What should the semantic be?  To me it makes sense that a squash
oweride the ff options instead of giving a error, but specifying a ff
option after --squash is an error.

>  How does this code parse "git merge --ff my_other_branch"?

It is getting late so I need to get back to you about this.

>  Shouldn't you issue the same error message for these two inputs?
>
>         "git merge --ff=never --squash"
>         "git merge --squash --ff=never"

Allow the first one since --ff=never can be in the config file and
give error on the last one.

>  What does this complex double loop compute differently from what "git
>  show-branch --independent" gives you?  Aside from that you will run slower
>  but you can take more than 25 branches?

The main issue is that show-branch --independent does not give me the
desired order for these branches.  I want the first branch to be head
or something that can be fast forwarded from head.  The second branch
should be the next branch in the specified list that have not been
eliminated or something that can be fast forwarded from this, and so
on and so forth.  This is an absolute requirement for the first
argument (head).  If show-branch had a documented order and meet the
absolute requirement above I would prefer show-branch --independentr
instead of this nasty loop.

>  More generally, I doubt it is really useful to let the user throw millions
>  of potentially duplicate refs and have the merge silently record a
>  filtered out results.  Yes, you made the process of culling duplicates too
>  chatty in the above part of the patch, and fmt-merge-msg will hopefully
>  still show what the user gave on the command line, but the heads used by
>  the real merge process now is very different from it.  The merge comment
>  is totally disconnected from the reality.  Why is this an improvement?

We already do this in the case where we have head pluss one branch.
If it results in only one real parent we throw one of them away
resulting in a fast forward or an "up to date".  The suggested patch
is just a generalization over this to the case where we have head and
more than one branch.

>  If the goal is to allow Octopus that is more complex than the simplest
>  kind, don't.  Octopus was deliberately written to allow the most simple
>  kind and nothing else for a reason: bisectability.

That is not the goal.

>  The user should know what he is merging; throwing many heads that he does
>  not even know how they relate to each other, and call the resulting mess a
>  merge feels like a sure way to encourage a bad workflow.

We do merges all the time without knowing what we actually are
merging.  That is something that happen in many work flows.  I assume
that you don't want a real merge in the case that you are "up to date"
with your remote or your head can be fast forward.  For the users
convenience we do a fast forward or report it to be "up to date".
Exactly the same argument holds where there are more than one remote
involved.  The user may not know who is ahead and who is behind and he
usually want the commit to record a simple history as possible.

>  > +then
>  > +     real_parents="$@"
>  > +     ff_head=$head
>  > +else
>  > +     find_real_parents "$@"
>  > +fi
>
>  This part is simply unacceptable.  At least please do not needlessly call
>  find_real_parents in the most common case of giving only one remote head.

I now keep common_b in common so subsequent calls to git merge-base
--all can be optimized away for the most common case.

-- 
Sverre Hvammen Johansen
