Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2199C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 20:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJMUNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 16:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJMUNG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 16:13:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEF97C763
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 13:13:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DC611BD9C1;
        Thu, 13 Oct 2022 16:13:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tHcDFqyptsWY
        mpzUkq1Jqbi++2lSZwdE2tjUhPwcS9s=; b=FEEW6/UCqjfOlKIeLb/usxjKTVLv
        j9/jrsVPTgen6OT5I/bAePJ5qDRJNvn0MVq9HpRc0x1w1hvvtaUyZGBtJifT4din
        jALx/a4bDWXMMBhUaW4DuUmb0SCpp+iccBPjXArZMa4O0GBVQDhsZruuFeqP7HEf
        mCGlbhZnJ5lq/DE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 865401BD9BF;
        Thu, 13 Oct 2022 16:13:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7DA31BD9BC;
        Thu, 13 Oct 2022 16:13:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 3/8] rebase: be stricter when reading state files
 containing oids
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
        <1fd58520253420fbe870a8528540dbc9e2178e3f.1665650564.git.gitgitgadget@gmail.com>
        <221013.86fsfrleqi.gmgdl@evledraar.gmail.com>
Date:   Thu, 13 Oct 2022 13:13:01 -0700
In-Reply-To: <221013.86fsfrleqi.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 13 Oct 2022 21:10:53 +0200")
Message-ID: <xmqqa65zfpo2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 70E31722-4B33-11ED-B42A-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Oct 13 2022, Phillip Wood via GitGitGadget wrote:
>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The state files for 'onto' and 'orig_head' should contain a full hex
>> oid, change the reading functions from get_oid() to get_oid_hex() to
>> reflect this.
> ...
>> @@ -431,7 +431,7 @@ static int read_basic_state(struct rebase_options =
*opts)
>>  	opts->head_name =3D starts_with(head_name.buf, "refs/") ?
>>  		xstrdup(head_name.buf) : NULL;
>>  	strbuf_release(&head_name);
>> -	if (get_oid(buf.buf, &oid))
>> +	if (get_oid_hex(buf.buf, &oid))
>
> The change looks sensible, maybe a commit message update + assuring
> ourselves that we don't care about anyone manually manipulating these
> files (e.g. a script with OID abbreviation that would "echo" to these.

"should contain" sufficiently conveys that already, but I do not
mind being extra clear, either.

You do not want 6c1221c99975ad3216d82de51ed980fbf327d7f8 to be
interpreted as a branch whose name is the 40-hex that points at a
wrong commit, when it appears on the state file and I think that the
proposed log message gives a reasonable explanation why we do not
want to use get_oid() and instead use get_oid_hex().  If the code
made sure that 40-hex is followed by end-of-line, that would even be
better, but it is not required.
