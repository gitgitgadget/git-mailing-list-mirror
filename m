Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD62A20401
	for <e@80x24.org>; Wed, 21 Jun 2017 23:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbdFUXEc (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 19:04:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64068 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750981AbdFUXEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 19:04:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85FE78A993;
        Wed, 21 Jun 2017 19:04:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Yu4gB1Bqrb6/QFHUwC4rH4NuvX0=; b=kxLg6u
        fr/6C8QgAJm5GmlkLyv+q7kNI6rQ0Lt7XZubrv6AA3FmTzoa3+pTBnDEQJqZykOu
        qiU5Eh3sUav49VRLsiTDLlNIxJNUxR77N1ISvaB28Zs4ky2Ct6UsgGRXje5E0W+P
        pN6PiUetynHLRBUKLlgve1VBNPpDpXQ5CLnrA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D9508A992;
        Wed, 21 Jun 2017 19:04:23 -0400 (EDT)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E20568A991;
        Wed, 21 Jun 2017 19:04:22 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
In-Reply-To: <xmqqpodxm2t8.fsf@gitster.mtv.corp.google.com>
References: <20170621213924.wh43i2h7v2zwihq3@genre.crustytoothpaste.net> <xmqqpodxm2t8.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 21 Jun 2017 19:04:22 -0400
Message-ID: <87efud7xjd.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6F5144E-56D5-11E7-AFD0-61520C78B957-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=Yu4gB1Bqrb6/QFHUwC4rH4NuvX0=; b=s4Gi9X8y2trv24N2Nv7HC8/3B49t5jPpNaTV3e22DD9nrcinTwGjrjfSlHUTA9P69AEqr9Vt99NeMO/Dj3gNaxNgmZlPlFt+Bet+PH5s7WJOZo5hvS33b22lT3P/CZzkQ75GCzsNZsBmgbGe3MwvYJmYjOmQPk5U7ZFSInd7/Qg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> I get the following on 2.11.0:
>>
>> 2cbfbd5 HEAD@{0}:
>> 2cbfbd5 HEAD@{1}: checkout: moving from cPanel to master
>> eaf8db2 HEAD@{2}: checkout: moving from master to cPanel
>> 2cbfbd5 HEAD@{3}: clone: from https://bmc@git.crustytoothpaste.net/git/bmc/homedir.git
>>
>> and this on a recent next:
>>
>> 2cbfbd5 HEAD@{0}: Branch: renamed refs/heads/master to refs/heads/new
>>
>> For this test, any repo will work; I just picked this one because it had
>> two branches I could use to generate dummy reflog entries.
>>
>> A colleague reported this to me as a bug.  I don't see anything in the
>> release notes about this as a desired behavior change, and it does seem
>> undesirable to truncate the reflog this way.  If this isn't intentional,
>> I'm happy to work up a patch.
>
> I do not think either behaviour is intentional (old one that gives a
> meaningless empty entry probably is probably not what we want, the
> new one that truncates is not what we want, either).

Eh, sorry about that.  I haven't dug very deeply, but it seems like the
entry is still in .git/logs/HEAD, while "git reflog" is only showing
they latest entry.  (Maybe because we stop consuming the entries when we
hit a null sha1 in the old id field?)

-- 
Kyle
