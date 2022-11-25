Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FA2C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 17:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiKYRiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 12:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiKYRiM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 12:38:12 -0500
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Nov 2022 09:38:09 PST
Received: from out-21.mta0.migadu.com (out-21.mta0.migadu.com [IPv6:2001:41d0:1004:224b::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBAC29363
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 09:38:09 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyleam.com; s=key1;
        t=1669397511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mh5y9ihvXh1B+zBfbWgkCB8GEkTWsYFlWSDmRuwYK2s=;
        b=ArS2FoEWCXOv66QcO40Iec1m2jLJ5tt2BddA9Eqpqs6263bXc1p89dasbHhNkocs3PLmH+
        pqg8xBVJBZVb3gbTbk5ypj0obzp/hVHOmoo8PGNniR1U1Al+yfuTUur9AeV2dpMsypKthy
        90NdHZKqvocLvYAwIUMyJyfS3L1fR4vMEjlFbxuZh2F8p86QD4JreLOH2kZnFnb1BHYJs0
        CjeDFJ0s0/bdBZf7yL3kqSUgWgDw1gwLP4s51l68QCozlGl2URZRrPd/63eEbYPyal7L9t
        3vNvcSyvMXnX0MT5UhzHJPYTpaiowZN7jeI8u8sWmXkb9LCadMer8geDtHwu6A==
From:   Kyle Meyer <kyle@kyleam.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email: disable option auto-abbreviation
In-Reply-To: <xmqqv8n3cxv9.fsf@gitster.g>
References: <20221124020056.242185-1-kyle@kyleam.com>
 <xmqqv8n3cxv9.fsf@gitster.g>
Date:   Fri, 25 Nov 2022 12:31:48 -0500
Message-ID: <87k03j54aj.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:

> Kyle Meyer <kyle@kyleam.com> writes:
[...]
>>   fatal: ambiguous argument '3': unknown revision or path not in the
>>   working tree.  [...]
>>
>> Disable Getopt's auto-abbreviation feature so that such options are
>> properly relayed to format-patch.  With this change, there is some
>> risk of breaking external scripts that rely on the abbreviation, but
>> that is hopefully unlikely given that Git does not advertise support
>> for auto-abbreviation and most subcommands do not support it.
>
> I personally have no sympathy to those who drive "format-patch" from
> inside "send-email".

I'm not one of those users myself, but I was prompted to look into this
by a report of the above error on another mailing list [*].  I do
sympathize with "skip the explicit format-patch" users that find that
error confusing.

  [*] https://yhetil.org/guix-patches/20221123190710.26517-1-paren@disroot.org

> Many subcommands of "git" do take uniquely abbreviated double-dashed
> option names, but it is true that we do not allow --vanything to be
> given as -v even when there is no other double-dashed option that
> begins with 'v', so "git send-email -v" that stands for "git
> send-email --validate" indeed is an odd thing.

Thanks for the correction. I didn't realize that many subcommands
supported abbreviated options.  I expected it to be, at most, the
remaining ones written in Perl.  When I tried out a couple of commands,
I convinced myself that auto-abbreviation wasn't generally supported:

  $ git log --onelin
  fatal: unrecognized argument: --onelin
  $ git diff --histog
  error: invalid option: --histog

But I didn't look hard enough.  Trying again, I stumbled onto a few
counterexamples (e.g., `git status --shor` works and so does `git
range-diff --le ...`).

And my claim in the commit message that "Git does not advertise support
for auto-abbreviation" is wrong.  I've now found this bit in gitcli(7):

  Abbreviating long options
  ~~~~~~~~~~~~~~~~~~~~~~~~~
  Commands that support the enhanced option parser accepts unique
  prefix of a long option as if it is fully spelled out, but use this
  with a caution.  For example, `git commit --amen` behaves as if you
  typed `git commit --amend`, but that is true only until a later version
  of Git introduces another option that shares the same prefix,
  e.g. `git commit --amenity` option.

> But robbing "git send-email --val" that expands to "--validate" from
> the users is going a bit too far, I am afraid.

Fair enough.  For the reasons above, the last sentence I wrote in the
commit message is invalid and can't justify the change.

> The right solution for allowing "-v 3" given to "format-patch" I think
> is to make send-email understand it and pass that through.  The
> presence of both ("validate" => \$validate) and ("v" =>
> \$reroll_count) in the GetOptions() argument would prevent "-v" to be
> taken as "--validate" while still allowing "--val" to be used as an
> abbrevatiion, no?

I'd think that would work, yes.  I'll look more into going this route.

With that approach, there are other cases of abbreviation intercepting
valid format patch options.  For example, send-email doesn't have the
short option -n while format-patch does, but that doesn't make it
through to format-patch:

  $ git send-email --dry-run -n @{u} | grep Subj
  Subject: [PATCH] send-email: disable option auto-abbreviation

  $ git send-email --dry-run --numbered @{u} | grep Subj
  Subject: [PATCH 1/1] send-email: disable option auto-abbreviation

> By the way, do we advertise support for any and all options to
> format-patch when the feature to drive it from send-email is used?
> Some of the options (e.g. "-o <directory>") do not make any sense in
> the context I would suspect.

Passing an -o to send-email would cause its format-patch call to fail
because send-email uses -o internally:

  $ git send-email --dry-run -o . @{u}
  fatal: two output directories?
  format-patch -o /tmp/W1ZGCr0hwv -o @{u}: command returned error: 128

In any case, here's the only relevant part I spot from
git-send-email(1):

  Patches can be specified as files, directories (which will send all
  files in the directory), or directly as a revision list.  In the last
  case, any format accepted by linkgit:git-format-patch[1] can be passed
  to git send-email, as well as options understood by
  linkgit:git-format-patch[1].

So, there's no mention that some options like -o do not make sense in
the send-email context, but perhaps that's obvious enough (at least in
my view it's much more obvious than '-v 3' and -n not being valid).

Thanks for the review.
