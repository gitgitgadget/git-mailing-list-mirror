Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C25E209AA
	for <e@80x24.org>; Mon, 26 Sep 2016 11:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938386AbcIZLyB (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 07:54:01 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35960 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934676AbcIZLyA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Sep 2016 07:54:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 251B920508;
        Mon, 26 Sep 2016 07:53:59 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 26 Sep 2016 07:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=KEX2OrkWqlawBqdLtw3v69fU4EE=; b=H/JF3P
        OK3bKdtYuj9rF2kOYWESbWnH5HRe5uG6ZuebPjB8b+P2SrfDxBhjlLiA/hn9Jphi
        kQK720er3/ex/Jo26LGuzsPgWDCKV/GowP1J8CPJLhiBenorEKWPYoBKsk2Ev4XB
        dg02uf48dE1XnwI1lThqden/ju4STz/TKJehM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=KEX2OrkWqlawBqd
        Ltw3v69fU4EE=; b=QpMf+mCWf7+WuoJtPjRgEWplM79yH0LCSvQm5Nu4ZWL0TVJ
        PfOruXG/OhGKjBv4glgnLhR/5uldcoZQ7FV1zcoy0hXtm5oqs8NzYojWxJcuNN/P
        db+D0YKc99mYX+0R9thgJVySnJ+gqPd5ukLbeD0/2NLfxYr0pF2roX3jUeFE=
X-Sasl-enc: tXnNVBtdHFuezWemFdPv678FtjpYPHhAkt9NFkZBXDuv 1474890838
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9DB5CF29D1;
        Mon, 26 Sep 2016 07:53:58 -0400 (EDT)
Subject: Re: Request: Extra case for %G? format
To:     Alex <agrambot@gmail.com>, git@vger.kernel.org
References: <87d1js1pl1.fsf@gmail.com>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <f056af47-ca98-b35c-e343-9f246c0c8f5b@drmicha.warpmail.net>
Date:   Mon, 26 Sep 2016 13:53:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <87d1js1pl1.fsf@gmail.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex venit, vidit, dixit 25.09.2016 08:05:
> Hello all,
> 
> Could the %G? format differentiate between an unsigned commit and a
> signed commit that you're missing a public key for?
> 
> If `git show --format=%GG --no-patch <commit>' produces an output like
> the following:
> 
> gpg: Signature made <date> using RSA key ID <id>
> gpg: Can't check signature: public key not found

That is the "raw verification message from GPG for a signed commit" as
per git-log(1).

> Then currently %G? results in `N', the same as an unsigned commit.
> 
> In this case, could %G? please result in a new character? Perhaps `M'
> for "missing public key"?

Yes, and no.

Really, there are many different reasons why a signature couldn't be
checked, but gpg itself has these status results:

"For each signature only one of the three codes GOODSIG, BADSIG or
ERRSIG will be emitted" (doc/DETAILS in gpg's source).

ERRSIG comes with additional info (RC) that could be parsed for the reason.

Also, in addition to that line, there can be other lines with additional
information. So there is a lot that could potentially be shown (and *is*
shown with %GG). In the GOODSIG case, we parse the TRUST info to take
the trust model into account (and return U for untrusted good).

I wouldn't mind adding E to %G? in the ERRSIG case, even though one has
to look at %GG in any case (N or E) if one wants to have more details.

Cheers,
Michael

