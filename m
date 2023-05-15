Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E83C7EE25
	for <git@archiver.kernel.org>; Mon, 15 May 2023 18:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245092AbjEOSRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 14:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245207AbjEOSQu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 14:16:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C188C18865
        for <git@vger.kernel.org>; Mon, 15 May 2023 11:15:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 333AA1F607D;
        Mon, 15 May 2023 14:15:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WfPho6xUNGxTu1zNSRfplGsrOB0qmlOlCMBbJy
        VHMgA=; b=dTalAABvVhHdC2NEFfUYXhUPxVpdg8AZdJ3zeMy1JvKGTw+eBA9qsG
        PGwgeeJm9yLZfdxFBRqtDwBShHzRJNoTbiEwLp1aoomYW6VW9OZXxk9f/Zp/6eTd
        83ongyi03S3Grtvtyl3COO6F/CUuNBWPGGgrgzJGPJd8KkEstYISg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B47D1F607A;
        Mon, 15 May 2023 14:15:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CEFF71F6076;
        Mon, 15 May 2023 14:14:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] credential/libsecret: support password_expiry_utc
References: <pull.1469.v2.git.git.1679729764851.gitgitgadget@gmail.com>
        <pull.1469.v3.git.git.1683270298313.gitgitgadget@gmail.com>
        <CAGJzqskMwOJkriH6serqdwAVYi+fftEL8ohJd-suP6v+OxB_bg@mail.gmail.com>
Date:   Mon, 15 May 2023 11:14:55 -0700
In-Reply-To: <CAGJzqskMwOJkriH6serqdwAVYi+fftEL8ohJd-suP6v+OxB_bg@mail.gmail.com>
        (M. Hickford's message of "Mon, 15 May 2023 11:50:01 +0100")
Message-ID: <xmqq353xa2cg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65C22C4A-F34C-11ED-BB59-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

M Hickford <mirth.hickford@gmail.com> writes:

>> +static const SecretSchema schema = {
>> +       "org.git.Password",
>> +       /* Ignore schema name for backwards compatibility with previous versions */
>> +       SECRET_SCHEMA_DONT_MATCH_NAME,
>> +       {
>> +               {  "user", SECRET_SCHEMA_ATTRIBUTE_STRING },
>> +               {  "object", SECRET_SCHEMA_ATTRIBUTE_STRING },
>> +               {  "protocol", SECRET_SCHEMA_ATTRIBUTE_STRING },
>> +               {  "port", SECRET_SCHEMA_ATTRIBUTE_INTEGER },
>> +               {  "server", SECRET_SCHEMA_ATTRIBUTE_STRING },
>> +               {  "password_expiry_utc", SECRET_SCHEMA_ATTRIBUTE_INTEGER },
>
> I've been testing this patch with credential-generating helper
> git-credential-helper. It works, but because libsecret overwrites
> items if and only if the attributes match exactly, you end up with
> many items in the secret store that differ only by expiry date. This
> is inelegant, and confusing to users. Please hold this patch, don't
> merge to master. A solution might be to store the expiry date as the
> secret of a separate item (even though the value is not confidential)

Thanks for stopping me.  I'll mark the topic as "on hold".

It does sound problematic, but if we think about what is used as
keys and what is used as values, it does make a lot more sense to
store the expiry as part of a value.  After all, we are not even
asking "give me the password that will expire in the most distant
future" or anything like that.  We consult the database with "who
wants to access what server over which protocol at what port" as the
key and expect we find the suitable authentication material to use.
It would be best if we can treat the expiry date as an additional
attribute of that authentication material.  

Do the methods to store and retrieve a password from the keyring
allow us to add such an extra attribute to the password?  I have no
idea how the Gnome keyring API works, but is there a way to mark
each entry in the SecretSchemaAttributes as "this is used as a key"
vs "this is used as a value---do not match"?  Would thinking along
such a line help?

Another possibility would be to store encoded concatenation of the
real password and expiration timestamp and decode them into two upon
retrieval.  If we were the only user of the keystore, that may work,
but if we are sharing the keystore with other applications, it would
be a non-starter.

What do other application do, when using the keyring to store
expirable passwords with services that do let you know the
expiration time of the password?  If they just ask the users again
only after finding out that the password did not work, perhaps we
should do the same, without being proactive and notice the expiry
ourselves?  That is, instead of failing the access to the server
immediately upon seeing an auth failure, if the authentication
material is know to have expiration time, can we let the application
layer to ask the end-user to provide an refreshed password and try
again?  For such a scheme, we do not have to store ever-changing
"password_expiry_utc" and contaminate the keyring with crufts whose
expiry dates are the only difference.  Instead we can just have a
Boolean "does this site expire a valid password?" and use it to
behave differently, if desired, from sites for which the passwords
do not expire, perhaps?

