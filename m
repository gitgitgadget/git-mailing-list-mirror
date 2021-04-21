Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C20AC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC2056144D
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245302AbhDUSz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 14:55:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61576 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245284AbhDUSz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 14:55:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B28DC0FC5;
        Wed, 21 Apr 2021 14:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GBGBEoRpR0sy1bOVC26/mGMq/70=; b=XWjupP
        jLTD5BJQeNuQqbRQV+8KkqHr+7uGS1y6VEN261nVFZa2e5eLj9e9KwPkTkTzQ/xO
        KZE1g3rJYXbUZGKONNk4p+AbA8OEvTFiEg3FqlXRaBy/00rtj/D4NgVguDIMqDKW
        62mJddvb0PPz82yKgDK/9kqlhY2ZqbZ1AfzIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ODJphsXiau/67yNmi+ZPM6UmlvOC/+eK
        NFBaCOBQOEQXTP94FrWaN/Y0MszkhO3OQ7qedvDHe6gtfZZWoCKQ2IyHiC7RZMl+
        U0T9WpmO1gang0wDjvWTBWhv7t9k9slSgSTughCo978cvJ6LQwGqhWJ3iaZFMbZx
        stP72xfaojo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62AECC0FC4;
        Wed, 21 Apr 2021 14:54:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8ED9C0FC3;
        Wed, 21 Apr 2021 14:54:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Luke Shumaker <lukeshu@lukeshu.com>,
        Git Mailing List <git@vger.kernel.org>,
        Luke Shumaker <lukeshu@datawire.io>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
References: <20210420190552.822138-1-lukeshu@lukeshu.com>
        <xmqqa6ps4otm.fsf@gitster.g>
        <CABPp-BF-rHnxvz0sAFAujXkiNwSjtpRQA4uvxT=a3z8v_sYbAA@mail.gmail.com>
Date:   Wed, 21 Apr 2021 11:54:52 -0700
In-Reply-To: <CABPp-BF-rHnxvz0sAFAujXkiNwSjtpRQA4uvxT=a3z8v_sYbAA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 21 Apr 2021 11:41:57 -0700")
Message-ID: <xmqqy2dbxybn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E7205EE-A2D3-11EB-85D3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Apr 20, 2021 at 2:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> +The `<refname>` is prefixed with `refs/tags/` when stored
>>  in Git, so importing the CVS branch symbol `RELENG-1_0-FINAL` would
>> -use just `RELENG-1_0-FINAL` for `<name>`, and fast-import will write the
>> +use just `RELENG-1_0-FINAL` for `<refname>`, and fast-import will write the
>>  corresponding ref as `refs/tags/RELENG-1_0-FINAL`.
>
> Going on a slight tangent since you didn't introduce this, but since
> you're modifying this exact documentation...
>
> I hate the assumed "refs/tags/" prefix.  Especially since ...
> ... The special casing reminds me of the ref-updated hook in
> gerrit

Gerrit and fast-import?  What is common is Shawn, perhaps ;-)?

> broken given the fact that the name inside the tag didn't match the
> name of the actual ref.  (To be honest, though, I was never sure why
> the name of the tag was recorded inside the tag itself.)

The name of the tag and the name of the object has to be together
for a signature over it to have any meaning, no?
