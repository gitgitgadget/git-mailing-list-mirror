Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A177620248
	for <e@80x24.org>; Tue, 19 Mar 2019 11:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfCSL3S (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 07:29:18 -0400
Received: from mail.javad.com ([54.86.164.124]:54630 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfCSL3S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 07:29:18 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 786113E9E8;
        Tue, 19 Mar 2019 11:29:16 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=U1jcmwrv;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1552994956;
        bh=IvQzC8g7hBItJ4Dv4Xdrd14K2UKyccDFRBNr/gS9XjM=; l=2944;
        h=Received:From:To:Subject;
        b=U1jcmwrv9H40sqTq1NrcJcOjRSlYcvMoseWEouGrzzQcSCKIPUk+aNyapXoNrrfLR
         vypiL2Obqaggn7Pre7MN0BJFKaTch1uFr6oI8OYYG7OyxDa61W2fpVsWZbgl+7qRpE
         2J9aNPwl82QIIiKlbS4p1UDimP3v0ZQypBpiO/9I=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1h6Cvi-0008SD-LL; Tue, 19 Mar 2019 14:29:14 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m 1' is specified
References: <87efh0pdln.fsf@javad.com>
        <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 19 Mar 2019 14:29:14 +0300
In-Reply-To: <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 21 Jun 2018 08:54:17 -0700")
Message-ID: <8736nj2jcl.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

[It's been a while since this discussion, and recently I've got some
thoughts and questions about "first-parent" issues in general, below.]

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> When cherry-picking multiple commits, it's impossible to have both
>> merge- and non-merge commits on the same command-line. Not specifying
>> '-m 1' results in cherry-pick refusing to handle merge commits, while
>> specifying '-m 1' fails on non-merge commits.
>
> Allowing "-m1" even when picking a single parent commit, because
> the 1-st parent is defined for such a commit, makes sense, espeially
> when running a cherry-pick on a range, exactly for the above reason.
> It is slightly less so when cherry-picking a single commit, but not
> by a large margin.
>
> I think the original reasoning for requiring "-m $n" not present,
> especially because cherry-pick was originally for replaying only a
> single commit, was because it would lead somebody to propose that
> the command should behave as if -m1 is always given (and when trying
> to cherry-pick a merge relative to its second parent, give -m2 to
> override it), which in turn encourage the 'first-parent is special'
> world-view from the tool-side.  IOW, "The worldview to treat the
> first-parent chain specially is correct, because Git has many
> features to work with that worldview conveniently" was something we
> wanted to avoid; rather "Such and such workflows benefit from
> treating the first-parent chain specially, so let's add features to
> do so" was we wanted to do, and of course, back then cherry-pick
> that allows mixture of merges and single-parent commits to be
> picked, which would have made the need to do something like this
> patch does felt greater, did not exist.
>
> Now, it appears, at least to me, that the world pretty much accepted
> that the first-parent worldview is often very convenient and worth
> supporting by the tool, so the next logical step might be to set
> opts->mainline to 1 by default (and allow an explicit "-m $n" from
> the command line to override it).  But that should happen after this
> patch lands---it is logically a separate step, I would think.

I think that "first-parent is special" is the way to go indeed for
porcelain, as it does make many thing easier and more convenient[*].

Is there a road-map already outlined in that direction, I wonder?

OTOH, for plumbing, it's rather keeping the original pure-DAG
"symmetrical merges" approach that seems to be the right thing to do.

[*] One example that immediately comes to mind is "git log -p" for a
merge commit. I doesn't currently (as of v2.10) show the first-parent
diff, for whatever reason. "git log -p -m --first-parent" is needed to
get the answer to most "obvious" question: what (merge) commit did to my
mainline? "git show" has its own issues.

-- Sergey
