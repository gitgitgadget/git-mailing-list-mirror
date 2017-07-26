Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3094720899
	for <e@80x24.org>; Wed, 26 Jul 2017 08:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751040AbdGZIG3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 04:06:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53228 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750886AbdGZIG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 04:06:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAC6F7F5A1;
        Wed, 26 Jul 2017 04:06:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jmhds3pe8DXKUpEp1w0i2mPZnLo=; b=kD+VEH
        HLcQ37z/L6jXDFCpuSZ4s8xrYJddusCYZhuDv5xlPDEdr7n6ayj3O/KRaYWdbnma
        VCbgQmJ4WODfCjV0nBAGeeWde55aTaTeaVLo9Kx0D0GJN/VHKabcfXhPD6eCK/78
        /Es9v1t4VitAEl0v5iOVLZXQ3cGyq7Rj2ktO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bMrr/2XTTkiNcUhVuYS9+/nRJk9gpjOp
        o74LS/BiSYtn/nYpI1P1Xxa+kBlPQMEuolmQePMf091Z9QiGiHsVKMvIcvqmiQrG
        6rpJKsT8oCn7jirBThMMWCzCo89qUey4y5tgTZ65YXPJZvPzj2II9f/rjzzWca7U
        Fzi6fJLdgk8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D160A7F5A0;
        Wed, 26 Jul 2017 04:06:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 282707F59F;
        Wed, 26 Jul 2017 04:06:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Raman Gupta <rocketraman@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC] Git rerere and non-conflicting changes during conflict resolution
References: <17c46229-3b64-34f1-30fa-d40b77e1c054@gmail.com>
        <20170725175202.ar4ykqoadbihwb2w@sigill.intra.peff.net>
        <xmqqo9s8uuth.fsf@gitster.mtv.corp.google.com>
        <20170725205843.bi6kyqjlzyodmxuq@sigill.intra.peff.net>
Date:   Wed, 26 Jul 2017 01:06:16 -0700
In-Reply-To: <20170725205843.bi6kyqjlzyodmxuq@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 25 Jul 2017 16:58:43 -0400")
Message-ID: <xmqq60eftyfb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D98886C-71D9-11E7-B198-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hrm. That doesn't quite work, though. Because if your <A,B> are the
> merge, then merging a topic to next will get an "A" that is a merge
> commit from next. But that commit will never end up in master. What's
> causing the conflict is really some "A" that is in the history between
> the merge base and "A" (but we don't know which).

There may be a misunderstanding.  When I said the key <A,B> is a
pair of branch names, I didn't mean 'A' to be the name of an
integration branch (e.g. 'pu') and 'B' to be the name of a topic.
Rather, both 'A' and 'B' are the names of topic branches.  

IOW, instead of having refs/merge-fix/sd/branch-copy that says "I
know when I merge sd/branch-copy to pu or jch, there is a semantic
conflict with some unnamed topic that is likely to be already in
there", i.e. keying with only a single topic name, the ideal I
presented would say 'sd/branch-copy and mh/packed-ref-store topics
are both by themselves OK, but when merged together, the end result
of textual merge needs to be further fixed up by cherry-picking this
change', by keying a change with a pair of topic names,
sd/branch-copy (which introduces a new method in the ref backend
vtable) and mh/packed-ref-store (which adds a new ref backend).  The
latter does not know the need for the new method, and the former
does not know the need to implement its new method in a new backend,
so a merge needs a trivial implementation of the new method added to
the new backend, which is what refs/merge-fix/sd/branch-copy does.

And better yet, instead of A=sd/branch-copy B=mh/packed-ref-store,
we could point at the exact commit on each of these branches that
introduce the semantic conflict.  I would probably pick these two

  A=52d59cc6 ("branch: add a --copy (-c) option to go with --move (-m)", 2017-06-18)
  B=67be7c5a ("packed-backend: new module for handling packed references", 2017-06-23)

so when we are on commit X that has A but not B, and are trying to
merge branch Y that has B but not A, we want the merge-fix to kick
in.  Walking "rev-list --left-right X...Y" and noticing A and B in
the output would be a way to notice it.


[footnote]

*1* https://github.com/gitster/git/ should mirror these refs in the
    refs/merge-fix/ hierarchymentioned in the body of this article.


