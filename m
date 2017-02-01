Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F731FAAD
	for <e@80x24.org>; Wed,  1 Feb 2017 02:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750980AbdBACQh (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 21:16:37 -0500
Received: from smtpq5.tb.mail.iss.as9143.net ([212.54.42.168]:52532 "EHLO
        smtpq5.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750937AbdBACQg (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 31 Jan 2017 21:16:36 -0500
Received: from [212.54.42.116] (helo=lsmtp2.tb.mail.iss.as9143.net)
        by smtpq5.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <carlo@alinoe.com>)
        id 1cYjca-0002vs-Ss; Wed, 01 Feb 2017 02:22:04 +0100
Received: from h172167.upc-h.chello.nl ([62.194.172.167] helo=mail9.alinoe.com)
        by lsmtp2.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <carlo@alinoe.com>)
        id 1cYjca-0000kl-Qm; Wed, 01 Feb 2017 02:22:04 +0100
Received: from carlo by mail9.alinoe.com with local (Exim 4.86_2)
        (envelope-from <carlo@alinoe.com>)
        id 1cYjcZ-0001Ai-Ut; Wed, 01 Feb 2017 02:22:03 +0100
Date:   Wed, 1 Feb 2017 02:22:03 +0100
From:   Carlo Wood <carlo@alinoe.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: git push failing when push.recurseSubmodules on-demand and git
 commit --amend was used in submodule.
Message-ID: <20170201022203.4b6489de@hikaru>
In-Reply-To: <xmqqvasxwee1.fsf@gitster.mtv.corp.google.com>
References: <20170129203348.1a8c0722@hikaru>
        <xmqqvasxwee1.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: carlo@alinoe.com
X-SA-Exim-Scanned: No (on mail9.alinoe.com); SAEximRunCond expanded to false
X-SourceIP: 62.194.172.167
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.2 cv=YdnN30Zf c=1 sm=1 tr=0 a=Sr+rG1RSRvb2GKWoPpN/Zg==:17 a=kj9zAlcOel0A:10 a=n2v9WMKugxEA:10 a=ybZZDoGAAAAA:8 a=BjFOTwK7AAAA:8 a=EVCXfVEeQiveO_vonTMA:9 a=CjuIK1q_8ugA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=N3Up1mgHhB-0MyeZKEz1:22
 none
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 29 Jan 2017 17:00:22 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> I suspect the submodule folks would say it is working as intended,
> if \
> 
>  - you made a commit in the submodule;
>  - recorded the resulting commit in the superproject;
>  - you amended the commit in the submodule; and then
>  - you did "push, while pushing out in the submodule as needed" from
>    the superproject.

This is not what I'm doing.
This is what I'm doing (see my script):

  - you made a commit in the submodule;
  - recorded the resulting commit in the superproject;
  - you amended the commit in the submodule;
  - you record the amended commit in the superproject;  <=== !
  - you push the submodule out (or not, the on-demand does that
    anyway)
  - you try to push the superproject, but that fails,
    as long as you use recurseSubmodules=on-demand.

> 
> There are two commits in the submodule that are involved in the
> above scenario, and the first one before amending is needed by the
> other participants of the project in order for them to check out
> what you are trying to push in the superproject, because that is
> what the superproject's tree records.

I never pushed anything of that, so the other participants don't
know, nor have, the pre-amended commit.

It is true that the superproject THINKS that the pre-amended commit
is a normal commit though: the last recorded (amended) commit is
internally listed as being on top of the amended commit (which is
incorrect). This is why the superproject assumes that the current
add commit of the submodule needs the pre-amended commit to be
available too. This is not correct however, it is not needed to
be available to others and does not need to be pushed to a remote.

> I think you have two options.
> 
>  1. If the amend was done to improve things in submodule but is not
>     quite ready, then get rid of that amended commit and restore the
>     branch in the submodule to the state before you amended, i.e.
>     the tip of the branch will become the same commit as the one
>     that is recorded in the superproject.  Then push the submodule
>     and the superproject out.  After that, move the submodule branch
>     to point at the amended commit (or record the amended commit as
>     a child of the commit you pushed out).

That would work, but would be a horrible workaround for an existing
bug :p

>  2. If the amend is good and ready to go, "git add" to update the
>     superproject to make that amended result the one that is needed
>     in the submodule.

This was already done, also in the script that I provided.
Yet, the push in the superproject is still rejected.

-- 
Carlo Wood <carlo@alinoe.com>
