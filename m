From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wt-status.c: set commitable bit if there is a meaningful merge.
Date: Tue, 16 Feb 2016 19:33:54 -0800
Message-ID: <xmqqr3gcj9i5.fsf@gitster.mtv.corp.google.com>
References: <72756249.nAoBccgOj7@thunderbird>
	<1455590305-30923-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Ovidiu Gheorghioiu <ovidiug@gmail.com>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 17 04:34:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVssL-0000bi-Qg
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 04:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933708AbcBQDd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 22:33:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933169AbcBQDd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 22:33:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6816446ADE;
	Tue, 16 Feb 2016 22:33:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7znqCmplaA0xhfq2rrJ8ttWb0MI=; b=Zi2xcs
	+zEItXU29uzIPxRIiSpdAXg5e/WRm5bwchvUyvjuiebAFHto2LRKiC83xVh0Hmhb
	rL5LuUxes90XULGgjlj7AvPikETMht59Psytvaj1I7nDHewnQ1d10LsJ4INQT7Fw
	zOW8chHUytVUpMOsrjztU3MqmbM3aHyOiL2KQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UzHWs27ix8ls/GYj+mHClP2TmT8kw0Ve
	IB37WfnbmLFL55aBqybFD/Lki9067jaJ0z7jmfnl/VQvbKSzoKMVP2oAb1mpRrCt
	bUef4qOK52h5wLooxcW/Pd9x26e1yXX9tFrFBhY4y19gZ4bPqSDR8heNC3AMOGjK
	ag15ahnNO2o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F2A646ADD;
	Tue, 16 Feb 2016 22:33:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C14AA46ADC;
	Tue, 16 Feb 2016 22:33:55 -0500 (EST)
In-Reply-To: <1455590305-30923-1-git-send-email-ischis2@cox.net> (Stephen
	P. Smith's message of "Mon, 15 Feb 2016 19:38:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45E97BA8-D527-11E5-B971-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286480>

"Stephen P. Smith" <ischis2@cox.net> writes:

> The 'commit --dry-run' and commit return values differed if a
> conflicted merge had been resolved and the commit would be the same as
> the parent.
>
> Update show_merge_in_progress to set the commitable bit if conflicts
> have been resolved and a merge is in progress.
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---

I think I mislead you into a slightly wrong direction.  While the
single liner does improve the situation, I think this is merely a
band-aid upon closer inspection.  For example, if you changed your
"commit --dry-run" in your test to "commit --dry-run --short", you
would notice that the test would fail.

In fact, "commit --dry-run" is already broken without this "a merge
ends up in a no-op" corner case.  The management of s->commitable
flag and dry_run_commit() that uses it are unfortunately more broken
than I originally thought.

If we check for places where s->committable is set, we notice that
there is only one location: wt_status_print_updated().  This function
runs an equivalent of "diff-index --cached" and flips s->committable
on when it sees any difference.

This function is only called from wt_status_print(), which in turn
is only called from run_status() in commit.c when the status format
is unspecified or set to STATUS_FORMAT_LONG.

So if you do this:

    $ git reset --hard HEAD
    $ >a-new-file && git add a-new-file
    $ git commit --dry-run --short; echo $?

you'd get "No, there is nothing interesting to commit", which is
clearly bogus.

I said s->committable is flipped on only when there is any change in
"diff-index --cached".  There is nothing that flips it off, by
noticing that there are unmerged paths, for example.  This is
another brokenness around "git commit --dry-run".  Imagine that you
are in a middle of a conflicted cherry-pick.  You did "git add" on a
resolved path and you still have another path whose conflict has not
been resolved.  If you run a "git commit --dry-run", you will hear
"Yes, you can make a meaningful commit", which again is clearly
bogus.

These things need to be eventually fixed, and I think the fix will
involve revamping how we compute s->committable flag.  Most likely,
we won't be doing any of that in any wt_status function whose name
has "print" or "show" in it.  As the original designer of the wt_*
suite (before these multiple output formats are added), I would say
everything should happen inside the "collect" phase, if we wanted to
make s->committable bit usable.

So in the sense, eventually the code updated by this patch will have
to be discarded when we fix the "commit --dry-run" in the right way,
but in the meantime, the patch does not make things worse, so let's
think about queuing it as-is for now as a stop-gap measure.

Thanks.
