From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Mon, 18 Apr 2016 12:33:39 -0700
Message-ID: <CAGZ79kZDg9a=xr1gYa=kooYvk-ufyGAVubqbRoRpOnC38FzLSg@mail.gmail.com>
References: <1460761306-18794-1-git-send-email-sbeller@google.com>
	<1460761306-18794-3-git-send-email-sbeller@google.com>
	<xmqqd1pq74ys.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xq_Uei_ybEjJ=PPWtruk5uB5Dp2KajA=5G6TSWU0_g2kw@mail.gmail.com>
	<xmqq60ve67sc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 21:33:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asEvY-0003kN-VH
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 21:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbcDRTdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 15:33:41 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34014 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcDRTdk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 15:33:40 -0400
Received: by mail-io0-f172.google.com with SMTP id 2so205199981ioy.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 12:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=094DX0ieHC/zvWhY6Rh+eRZnEnN1SgtvZYedrAy+Kvk=;
        b=Vvj8uQoPAVdM/D2WSBwzbGSjRAjrBNImdV+K8hotrcy4lnrM1WOfE11oj39LBJ8/tv
         B696NTMjqvibPXN4ZYpzC4PE0w+lpZcF0Lo1l1tMHZZpN+dUOu+X0wHB4DNxuHHy3fNR
         Uf+Wo/jpw2R5LbqnQEc0OG0UUggyWtNfSoihI4fmQJoObprHhaSlHY66ff0K3HzbE/Ow
         wvknms/+uxKUBtIWS57ZRV+3APThRXasEj2+I2eHe0a6I33o7RlZIV+ZTSD70O5gau/3
         aPbnQOPjE+G+I/J9h42cLnAUOlF4hYN00BjSduV2cbjVqiauFAzinGy93JdNUlQIvXVR
         Jz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=094DX0ieHC/zvWhY6Rh+eRZnEnN1SgtvZYedrAy+Kvk=;
        b=akbtNBZYX5UulOo22A/LpLt49p4FilrcGTS17GfgvHVbP94k/KJh5m4eT4JVupBx3k
         KAaDsTmxTbNpVuznEU1q1GRLzZ8DeagVsquBvnci9LRT0a4F+LWYMCxn/EDGMndVBKC8
         DBghPcMsgBuQzF9sLFbC+Am5A+QJwzD6mwgEfm/WS/mDoUWHO0foBL+6MW8NzN28U79d
         L6WIAjVKNCNj8PVg/YmzCWeEgj9m1YhwSIRTEh/YN8EJGyxrnqyWATTWaAZvHHdQPM2F
         Yi12ILTFBAXYdTbC94Bs6F1QEGpCyglqkCqzfuvG9YpQjIwII1ZgR3aAvA2JP+54BcGT
         5f7Q==
X-Gm-Message-State: AOPr4FXJuQ5JcYzGk8cFdWOoW0yaqSqTfya0HFaJQ2YHiPyr33gYQfdIEG+n9oQc5ZavdNvollPHuekPWesp4+xy
X-Received: by 10.107.18.227 with SMTP id 96mr36774011ios.174.1461008019213;
 Mon, 18 Apr 2016 12:33:39 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Mon, 18 Apr 2016 12:33:39 -0700 (PDT)
In-Reply-To: <xmqq60ve67sc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291822>

On Mon, Apr 18, 2016 at 12:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> I think we're going to make use of xdl_blankline instead of this or
>> our own "is_emptyline"
>
> OK, so perhaps either of you two can do a final version people can
> start having fun with?

Junios proposal seems to be on top of my latest series sent out,
I'll squash it in and send it out as a final version if you don't mind
(though I'll do it later today; currently diving into Gerrits Java)

>
> By the way, I really do not want to see something this low-level to
> be end-user tweakable with "one bit enable/disable"; the end users
> shouldn't have to bother [1].

Ok. Thanks for fixing that mistake.

> I left it in but renamed after "what"
> it enables/disables, not "how" the enabled thing works, to clarify
> that we have this only as a developers' aid.


>
> *1* I am fine with --compaction-heuristic=(shortest|blank|...) that
> allows a choice among many as a developers' aid, but I do not think
> this topic is there yet.

This doesn't bode well with
    > +--compaction-heuristic::
    > +--no-compaction-heuristic::

in the future? I'd rather have
    +--compaction-heuristic=none
    +--compaction-heuristic=lastEmptyLine
such that we don't have to worry about further experiments (or matured
heuristics) later?
