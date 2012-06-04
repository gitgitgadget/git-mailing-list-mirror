From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] improve no-op push output
Date: Mon, 04 Jun 2012 09:35:30 -0700
Message-ID: <7vzk8jt4q5.fsf@alter.siamese.dyndns.org>
References: <20120530120804.GA3501@sigill.intra.peff.net>
 <7vr4u1zhcz.fsf@alter.siamese.dyndns.org>
 <20120604125126.GD27676@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 18:35:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbaFm-0005op-LQ
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 18:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760939Ab2FDQfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 12:35:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48144 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755294Ab2FDQfd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 12:35:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2B81815C;
	Mon,  4 Jun 2012 12:35:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UUoaqxqDcFgE3YyerZeIBWSAgnQ=; b=G/Zy43
	2AxSpnY3efonaQe3YtFxtwApAR1t0f2yvdSdmEJHFEZ53/aS/qylLrBgeGrDeeSy
	RwgZBYvewg5/zGlLmCofyOKwwC5UBOKjZVFTB6U+dt56jzdDBaxccxogvyRS7YWC
	KKxGnx9E0MhOWJ1pM+nCUT4vXX5dhmeFBhrDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dyhUY9/vOZ1Gw17mL3unUXeViy8s1ho8
	3ON/F9iHCpRs1eDM7G0CURYiyac+V0UJaJZpWXY5jG6AFCnPSwuCy7gdNL/lUgVr
	CQEdazaLGBrfE6ObtCL3bp9P/poV+ske46pv/TRy8tMR06+Xi77VgY7KBDRF57cH
	vm3JMCAUURY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98FF7815B;
	Mon,  4 Jun 2012 12:35:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7B8E8159; Mon,  4 Jun 2012
 12:35:31 -0400 (EDT)
In-Reply-To: <20120604125126.GD27676@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 4 Jun 2012 08:51:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D4B36D2-AE63-11E1-8B4B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199145>

Jeff King <peff@peff.net> writes:

> So I think we would really need to break down each potentially confusing
> case, and come up with a solution for each. I think we can divide the
> push configuration into three cases: matching, single (which includes
> "upstream", "simple", and "current"), or custom refspecs. Let's ignore
> the final one for now. It's relatively rare, and probably the most
> common use is mirroring (in which case we know we pushed everything,
> anyway). And then we have a few potential confusing situations:

Does "single" include "upstream", "simple" and "current", or does it
consists of these three and nothing else? I think it is the latter,
and I mean the latter in the remainder of my response. Specifically,
I would exclude the case where you have remote.$there.push that only
pushes one ref from "single".

>   1. We are on a detached HEAD; the user expects their current work to
>      be pushed, but it is not. With the "single" cases, we should
>      already error out.

All the "single" cases should error out when run on a detached HEAD
(otherwise they should be fixed).

I have a feeling that it is not the best approach to classify the
"detached HEAD" as a special failure mode for "single".  If you view
"single" as "push the curent branch out, but the name of the
destination ref may be different depending on the mode", the
detached HEAD case is just a natural extension of the error case
"nothing is specified to be updated from this state, hence we error
out".

>      For the "matching" case, we don't want to error
>      out, but it might be worth printing a warning to say "by the way,
>      your HEAD is detached", whether everything is up-to-date or not.

Both "matching" and "specific remote.$there.push" cases are "it does
not matter what branch happens to be checked out; I am giving you
the set of refs I want to push out by default", so even though you
said you ignore the specific refspec case, they fall into the same
category here.

I find the above an unnecessarily roundabout way to help people who
expect the current branch to always be involved in an unnamed push
to say "your HEAD is detached"; it requires them to be intelligent
enough to connect "HEAD detached", "no current branch" and "hence
nothing pushed".  A more direct way "detached HEAD not pushed" may
be better.

>   2. We are on a branch; the user expects it to be pushed, but it is
>      not. This can't happen with the "single" cases, since they always
>      push HEAD (or fail). For matching, again, a solution might be "by
>      the way, your HEAD was not pushed", with the same caveats as above.

Yes, "by the way, your current branch was not pushed" is much better
than "HEAD is detached" you wrote in 1.

>   3. We are on a branch; the user expects some other branch X to be
>      pushed, but it is not.
>      ... So I think the right solution is to just
>      be more specific; say "X is up-to-date", or just show the
>      single-line status table.

OK.

>      For the "matching" case, it's much harder.
>
>      If we show them the whole description of what happened and hoping
>      they notice that their branch is not included.  When something
>      actually gets pushed, we show the status table already, and they
>      may or may not look through it to find the branch in question
>      (indeed, they may not even be trying to push X at the time, but
>      rather may later say "Hey, I thought I pushed everything; why is X
>      not here?).

We can cover both the "here are the list" and the "everything
up-to-date" cases with "(current branch not pushed)" (or "detached
HEAD not pushed)".

>   1. For a single-ref push, always mention the ref name, even if it is
>      up-to-date. My previous patch showed the status table, but we could
>      also just tweak the "Everything up-to-date" to say "Ref X is
>      up-to-date".

I think this is a sane thing to do in any case.

>   2. Introduce a "push.warnMatch" config option, which can be set to one
>      of:
>
>        - "none"; the current behavior
>
>        - "branches"; mention all unmatched refs which are in refs/heads

Doesn't this assume that among many existing branches, what are not
pushed are minority (hence it is easier to spot the presense of the
interesting branch in the output, than to spot the absense of the
list of updated ones)? I am not convinced if that is the case, and I
doubt it would be very useful.

An alternative might be to show the usual list of refs with [up to date]
marks even when we currently say "Everything up-to-date", like "push -v"
does.  I.e. instead of:

        $ git push ko
        Everything up-to-date

we can say

	$ git push ko
	To: kernel.org:/pub/scm/git/git.git
        = [up to date]      maint -> maint
        = [up to date]      master -> master
        = [up to date]      next -> next
        = [up to date]      pu -> pu

omitting "Pushing to $where" at the beginning and "Everything up-to-date"
at the end of the "push -v" output.

>        - "head"; mention the current HEAD if it is unmatched

This might be a sane thing to do unconditionally, especially if it
can be done without taking too much screen real estate.
