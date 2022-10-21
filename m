Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD276C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 14:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJUO6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJUO6K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 10:58:10 -0400
Received: from mail.hostpark.net (mail.hostpark.net [212.243.197.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7B029814
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 07:58:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.hostpark.net (Postfix) with ESMTP id CA67D16591;
        Fri, 21 Oct 2022 16:58:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bernoul.li; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:references:in-reply-to:subject:subject
        :from:from:received:received; s=sel2011a; t=1666364285; bh=R8iq+
        VFtJ3UfEXbEGG5xuyVyhp4k9l3xImMmmNf2/+Y=; b=phdlGum0v/brghK53xuO7
        OUOB4p+XNC5hoFxroKXhKOz1uAErITsrhNMh9zrULw/aTNaO5AyFOpW+9RLmUYie
        knalbMTbObTXslUUuES3dL52cOC2nh1k65QaZFtsCMZkjoMrx4nI5glA0O1WOkof
        1PcjAv/3JckXPCQ7Jb1tX4=
X-Virus-Scanned: by Hostpark/NetZone Mailprotection at hostpark.net
Received: from mail.hostpark.net ([127.0.0.1])
        by localhost (mail0.hostpark.net [127.0.0.1]) (amavisd-new, port 10224)
        with ESMTP id bnN_nnN2gaU3; Fri, 21 Oct 2022 16:58:05 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.hostpark.net (Postfix) with ESMTPSA id 95B9016572;
        Fri, 21 Oct 2022 16:58:05 +0200 (CEST)
From:   Jonas Bernoulli <jonas@bernoul.li>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "submodule foreach" much slower than removed "submodule--helper
 --list"
In-Reply-To: <221017.86h702jsiq.gmgdl@evledraar.gmail.com>
References: <87czatrpyb.fsf@bernoul.li> <87a65xrnwz.fsf@bernoul.li>
 <221017.86h702jsiq.gmgdl@evledraar.gmail.com>
Date:   Fri, 21 Oct 2022 16:58:05 +0200
Message-ID: <87k04tfcle.fsf@bernoul.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for going silent right after bringing this up.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I can't reproduce anything like the 8ms v.s. ~600ms difference you note
> here, but for me migrating it to a built-in is around 10% slower with
> "foreach" than the old "list". I wonder what results you get?

The repository, in which I observed this slowdown, has one hundred
modules.

> I sent in a topic to migrate it since you sent this report. I was going
> to do it in this development cycle, but this prompted me to do it
> earlier:

Thanks!

A lot more is happening here than I can quickly understand, but the last
commit mentions that the slowdown is now just 0.1, which would be good
enough for me, I think.

> On Sat, Oct 15 2022, Jonas Bernoulli wrote:
>
>> I just noticed that "submodule--helper name" was also removed, which I
>> also found useful in scripts.  Please tell me if I am missing something,
>> but it seems I now have to do something like this instead:
>>
>>   git config -f .gitmodules --list |
>>       sed -n "s|^submodule.\([^.]*\).path=3D$path\$|\1|p"
>>
>> The old way was nicer:
>>
>>   git submodule--helper name $path
>>
>> I realize submodule--helper is for internal use and using it anyway
>> comes with the risk of such removals and other changes, but again,
>> please consider restoring that or providing something similar in the
>> public interface.
>
> This however is another case, I removed "name" along with "list" and
> other leftover code we weren't using anymore for the internal-only
> "submodule--helper" (which is at turns out, was not as internal-only as
> we'd hoped).
>
> For "list" it's clear how to use "foreach" instead, but for "name" then
> AFAICT the "best" replacement is to do a:
>
> 	git submodule foreach 'echo $displaypath $name'
>
> And pipe that into grep/sed. If that's fast enough would it satisfy your
> use-case, or would a "name" equivalent be handy?
>
> I think the best way to prove that would be e.g.:
>
> 	git submodule foreach-format '%{name}' -- <pathspec>
>
> Which, due to the "foreach" taking N number of arguments isn't easy to
> add to "foreach" without the interface becoming somewhat tortured (we
> could add a [---pathspec=3D<pathspec>]...), but "-- <pathspec>" with a
> different subcommand name seems better.

I agree, that adding support for "-- <pathspec>" to an existing or new
subcommand, would make it unnecessary to bring back a "name" subcommand.

Will "foreach"/"foreach-format" continue to be limited to active
modules?  Sometimes it would be nice to list all modules, including
those that are inactive.  As mentioned earlier "git ls-files -s | grep
^160000" is enough to get a list of the module paths, but sometimes we
want more information, e.g., "git submodule list --include-inactive
--format '$name $is_active submodule.$name.url' -- <pathspec>".

     Jonas
