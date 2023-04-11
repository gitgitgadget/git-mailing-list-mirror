Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2805AC77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 17:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDKRN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDKRN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 13:13:27 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7614B49E1
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 10:13:23 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 5ADB8240002;
        Tue, 11 Apr 2023 17:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1681233202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AyT8oFMPWqPet9ffOYQBI6tGgphsJt+0C2pbBj11aHQ=;
        b=RQ3A9bRjlsOJoEJ1QBrFqoermoFlKNBgeBIfgUMsC29sVUbQEUIrF9AxHjS0qK2IpyVqmp
        EBE5ESgFMhiENDXMsYg4omCHlvs+YimLw94y8leRXkktNwpGGfwUYD8eS98uj/ToHW3hx2
        sAVMEb3tbVlXcTgzBWE+Upbpe5fMwtlZfSnItARmuPxpf9Ot8XIHvoiSTWL/cAgxBlYzHk
        /69xgHl5xiPmdzGwrKvt1QByRpfF9jSj6UPv3rnX/D/rdpgM8GRMriIE9QGdifWw13QitW
        z5Cv3o40xJ76EnT2lxdJ/8cXEyV0xZlTqnpo2mH2xzsV7yLvW3+rLPqcFmAyCg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 11 Apr 2023 19:13:19 +0200
Message-Id: <CRU3FHOZIRVM.3N8I4FAZ2RGO5@ringo>
Cc:     <git@vger.kernel.org>,
        =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Michael Strawbridge" <michael.strawbridge@amd.com>
Subject: Re: [PATCH] send-email: export patch counters in validate
 environment
From:   "Robin Jarry" <robin@jarry.cc>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Phillip Wood" <phillip.wood123@gmail.com>
X-Mailer: aerc/0.14.0-154-g68bc51d7fe3d
References: <20230411114723.89029-1-robin@jarry.cc>
 <79a7c59f-6644-1dad-3b85-fe0ca8beb968@gmail.com>
 <xmqqbkjubcyc.fsf@gitster.g>
In-Reply-To: <xmqqbkjubcyc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano, Apr 11, 2023 at 18:28:
> The above mentions "cover letter" and naturally the readers would
> wonder how it is treated.  When we have 5-patch series with a
> separate cover letter, do we get TOTAL=3D6, COUNTER=3D1 for the cover,
> COUNTER=3D2 for [PATCH 1/5], and so on, or do we see TOTAL=3D5,
> COUNTER=3D0 for the cover, counter=3D1 for [PATCH 1/5], and so on?
>
> The latter is certainly richer (with the former, the validator that
> wants to act differently on the cover has to somehow figure out if
> the invocation with COUNTER=3D1 is seeing the cover or the first
> patch).  The usual and recommended workflow being "git format-patch
> -o outdir --cover-letter <range>" followed by "edit outdir/*" to
> proofread and edit the cover and the patches, followed by "git
> send-email outdir/*.patch", git-send-email has to guess before
> invoking the hook.
>
> But it may be better than forcing the hook to guess, I dunno?
>
> Whichever way we choose, we should
>
>  * explain the choice in the proposed log message.  If we choose the
>    "TOTAL is the number of patches and COUNTER=3D0 is used for the
>    optional cover letter" interpretation, we should also explain
>    that we cannot reliably do so and sometimes can guess wrong.  If
>    we choose the "TOTAL is the number of input files and COUNTER
>    just counts, regardless of the payload" interpretation, we should
>    also explain that even though we hinted that a series with cover
>    letter can be validated, it is a slight lie, because the hook has
>    to guess if the series has cover and it can guess wrong.
>
>  * document what TOTAL and COUNTER means.

It is easy enough to differentiate a cover letter from an actual patch
with a simple shell test:

    if grep -q "^diff --git " "$1"; then
        # patch file
    else
        # cover letter
    fi

It is probably best to let git-send-email out of the picture. Since
nothing prevents from sending multiple patch series at once, it may not
be possible to determine the proper ordering of all these files. A dumb
1-based counter will be perfectly suitable.

I will add more details about these two variables, what they mean and
how they should be used.

> This may be sufficient documentation to imply we are not treating
> cover letter any differently, by not saying "patch" or "cover
> letter" but just saying "file".  It may be more helpful to be a bit
> more explicit, though (e.g. "files" -> "input files", perhaps).

It makes sense to use the "files" terminology instead of "patches".
I will update for v2.

> > Do we really need to clear these? Certainly not in each iteration of
> > the loop I would think.
>
> If we set TOTAL outside, we should clear it outside.  We have to set
> COUNTER inside, and we could clear it outside, but it probably is
> easier to see the correspondence of set/clear if it is done inside.

Given the small cost of setting these variables in a perl script, it was
my intention to have a clear correspondence between the set/clear
operations.

> When you have 3 files to send, and if the last one satisfies "-p",
> the hook will be told "You are called for 1/3" and then "2/3", and
> will never hear about "3/3", so in practice it will spool the first
> two and finish without getting a chance to flush what has been
> spooled.  When you have 3 files to send, and if the first one
> satisfies "-p', the hook will be told "You are called for 2/3", but
> it is understandable if anybody is tempted to write a hook this way:
>
> 	if COUNTER=3D=3D1:
> 		initialize the spool area
> 		record TOTAL there
> 	else:
> 		read TOTAL recorded in the spool area
> 		make sure TOTAL matches
>
> 	process [PATCH COUNTER/TOTAL] individually
> 	if COUNTER=3D=3DTOTAL:
> 		process the series as a whole
>
> and for such an invocation of "git send-email", the hook will try to
> process the second file without having its state fully initialzied
> because it never saw the first.
>
> Would these be problems?  I dunno.

I had thought of this. From perl docs:

    -p  File is a named pipe (FIFO), or Filehandle is a pipe.
    https://perldoc.perl.org/functions/-p

While there is very little chance that users will run git send-email on
FIFOs, it is a possibility. Reference commit is:

    300913bd448de ("git-send-email: Accept fifos as well as files")
    https://github.com/git/git/commit/300913bd448de

I can run the loop twice to determine the count of non-FIFOs and adjust
GIT_SENDEMAIL_FILE_TOTAL accordingly.

Thanks for the review.

PS: What would you think if I also added a sendemail-validate.sample
script in the templates folder? Should I add it in the same commit?
