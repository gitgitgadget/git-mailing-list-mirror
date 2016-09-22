Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9457A1F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 17:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbcIVR1h (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 13:27:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55306 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752022AbcIVR1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 13:27:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 292193E842;
        Thu, 22 Sep 2016 13:27:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TA5oJ3iICoJnY26taaq73xdMXgY=; b=RZT/gl
        f6gLGdz45bOoyWCPJcBDa4OiQJaC0ZIkmGtOHK/+/E7ea/I+ng6Zw27D8JzeoEP9
        rW2u2EhPdYvqmTbEiKLQuyTU3/5SwIxevvWpw95uW4cCFc6n/7aH8hGEIAmGXIAB
        ypXvafm6I4moy5xpbTQgEvaWrL/fwqeAbzMEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=viDZyZN3xCOEU86iOBzptS5gy/nZ+EBV
        L802ywOD02oze2B80fxwdZhb5VWEk0KFBuku1gD3Nx62qTntPT+OpkszJd4P1HUb
        aZhh92tiTuGtXws0p6MX2nX3ew817XfogpHduGP3RCPFGxTWTc5pMQO3KyGos3Ha
        44vI2PYT4+M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 202B53E841;
        Thu, 22 Sep 2016 13:27:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 91E2B3E840;
        Thu, 22 Sep 2016 13:27:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Max Nordlund <max.nordlund@sqore.com>
Subject: Re: [PATCH v2 2/3] init: do not set core.worktree more often than necessary
References: <20160908134719.27955-1-pclouds@gmail.com>
        <20160921112939.3444-1-pclouds@gmail.com>
        <20160921112939.3444-3-pclouds@gmail.com>
        <xmqqd1jx854z.fsf@gitster.mtv.corp.google.com>
        <CACsJy8BQvo_XSXZ3m8=A=0tik3qPd8k9cyC4G408JK+AhtYStQ@mail.gmail.com>
Date:   Thu, 22 Sep 2016 10:27:32 -0700
In-Reply-To: <CACsJy8BQvo_XSXZ3m8=A=0tik3qPd8k9cyC4G408JK+AhtYStQ@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 22 Sep 2016 17:06:11 +0700")
Message-ID: <xmqqbmzf6e0r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D989F84C-80E9-11E6-8C7B-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> Perhaps a comment before init_db() to tell callers to always call
>> the other one is the least thing necessary?
>
> Good thinking. We could go a step further, baking it as assert() to
> catch new/incorrect call sequences automatically.
>
> Or we could combine the two functions init_db() and set_git_dir_init()
> into one. I prefer this one, but having problem with finding a good
> name for it ...

It probably is a reasonable way forward to name the combined
function that takes the parameters that are taken by both functions
in their current incarnation init_db().  After all, initializing the
Git repository database involves telling the function where the .git
directory is, among other things like where to take the template for
a newly created repository is.

