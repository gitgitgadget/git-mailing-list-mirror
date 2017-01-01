Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0948A20441
	for <e@80x24.org>; Sun,  1 Jan 2017 02:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754626AbdAACkg (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 21:40:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53220 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754612AbdAACkf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 21:40:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D40075D16C;
        Sat, 31 Dec 2016 21:40:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FT2ejORkV/L4ZNpFmRSy7GEa2Pc=; b=afxa9A
        WtGvjlsL5NG/7a4hc1MVi917vFK7nSL4IQcd6+EJ6ZAXipZLY6t2GDna7swdJTrJ
        fV3U+EC+egnBpyRzt/RkH+78aSXR43/IXFix8bX+5wKIZK3rkfYAKxf9QHLtuZb6
        MjCI9comeZ41EiHxv2bLOaJVcc8INwbOfKoYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tb0/jVL6eZbm3xondVqU5YYxUvnXT0rn
        qY6hYyKgoBGdVJ9sxofJguqZSk5Kge6g2mDww+pu2AiYUlnrHwngXbplNNJvE2PK
        R8c1WDsHR58vCEFs/b8S4ETqop3gmNl23av4ndboB2SmXUOTIeKL+xoeTecthaC5
        vqk0vNIEH2U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD37A5D16B;
        Sat, 31 Dec 2016 21:40:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E0565D16A;
        Sat, 31 Dec 2016 21:40:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: Rebasing multiple branches at once
References: <20161231081433.3zo6lrsjsu2qho4u@glandium.org>
Date:   Sat, 31 Dec 2016 18:40:33 -0800
In-Reply-To: <20161231081433.3zo6lrsjsu2qho4u@glandium.org> (Mike Hommey's
        message of "Sat, 31 Dec 2016 17:14:33 +0900")
Message-ID: <xmqqmvfb4i5a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB628DAE-CFCB-11E6-8D59-E17F7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> So I now have:
>
> A---G
> \---B---C---D---E
>             \---F
>
> If I do the dumb thing, which is to do `git rebase master E` and `git
> rebase master F`, I end up with:
>
> A---G---B'---C'---D'---E'
>     \---B"---C"---D"---F'
>

What people seem to do is to teach the branch that ends with F that
its upstream is the local branch that ends with E, so that they can
be lazy when rebasing a branch that knows its upstream.  I suspect
that you would end up with

A---G---B'--C'--D'--E'--F'

instead if it is done naively, but if you really care that the
branch that ends with F does not have E, you presumably want to have
the branch that ends at D its own identity, so

 (1) 'master' or whatever that used to end at A and now its tip is
     at G;

 (2) the branch that ends at D whose upstream is 'master';

 (3) the branch that ends at E whose upstream is (2); and

 (4) the branch that ends at F whose upstream is (2).

I personally do not do that, though, because you'd need to remember
the order in which these three branches must be rebased (i.e. (2)
must be done first before rebasing (3) and (4) in any order).

