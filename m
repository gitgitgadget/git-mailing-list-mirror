Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8F1C001B0
	for <git@archiver.kernel.org>; Sun, 16 Jul 2023 01:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjGPBIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 21:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGPBIl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 21:08:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0868271E
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 18:08:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0155D21375;
        Sat, 15 Jul 2023 21:08:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tpqERKh4Hzu6HLwuN/h6jKO4WiwPlQ9ui3awP2
        F6mug=; b=OHcW1eprQLpJtLI1Yl0VIR1OW50oHu2iIxasqmYj10HJqpyrrUljJA
        mQQG6d80Z+FnnnDIKtR/oB700sefmib8s3hnESTjDoukrirZ6Eabu6VuCiw/Y2ZZ
        wT4Lw+miG0LJS3Lxn03wDRV8Eq8mcsfOxYSli6bGUcMPe6G/gjzQY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF18B21374;
        Sat, 15 Jul 2023 21:08:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8EBFC21372;
        Sat, 15 Jul 2023 21:08:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH] t2400: Fix test failures when using grep 2.5
References: <20230715025512.7574-1-jacobabel@nullpo.dev>
        <2e22a23f-576f-7a42-ace8-624a5362d9f4@gmail.com>
        <vn5sylull5lqpitsanlyan5fafxj5dhrxgo6k65c462dhqjbno@uwghfyfdixtk>
Date:   Sat, 15 Jul 2023 18:08:33 -0700
In-Reply-To: <vn5sylull5lqpitsanlyan5fafxj5dhrxgo6k65c462dhqjbno@uwghfyfdixtk>
        (Jacob Abel's message of "Sat, 15 Jul 2023 23:15:28 +0000")
Message-ID: <xmqqilakll2m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 497AF3F6-2375-11EE-BF4E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

>> > @@ -998,8 +998,8 @@ test_dwim_orphan () {
>> >   					headpath=$(git $dashc_args rev-parse --sq --path-format=absolute --git-path HEAD) &&
>> 
>> I'm a bit confused by the --sq here - why does it need to be shell
>> quoted when it is always used inside double quotes? 
>
> To be honest I can't remember if this specifically needs to be in
> quotes or not however I had a lot of trouble during the development of
> that patchset with things escaping quotes and causing breakages in the
> tests so if it isn't currently harmful I'd personally prefer to leave
> it as is.

Quoting is sometimes tricky enough that "this happens to work for me
but I do not know why it works" is asking for trouble in somebody
else's environment.  If the form in the patch is correct, but tricky
for others to understand, you'd need to pick it apart and document
how it works (and if you cannot do so, ask for help by somebody who
can, or simplify it enough so that you can explain it yourself).

    headpath=$(git $dashc_args rev-parse --sq --path-format=absolute --git-path HEAD) &&

In this case, "--sq" is a noop that only confuses readers, I think,
and I would drop it if I were you.  "--git-path HEAD" is given by
this call chain:

   builtin/rev-parse.c:cmd_rev_parse() 
   -> builtin/rev-parse.c:print_path()
      -> transform path depending on the path format
         -> puts()

and nowhere in this chain "output_sq" (which is set by "--sq") is
even checked.  The transformations are all about relative, prefix,
etc., and never about quoting.

The original test script t2400 (before your patch) does look crappy
with full of long lines and coding style violations (none of which
is your fault), and it may need to be cleaned up once this patch
settles.

Thanks.
