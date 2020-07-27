Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473A2C433DF
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 21:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B7F20729
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 21:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgG0Vl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:41:27 -0400
Received: from 0x63.nu ([109.74.10.199]:48750 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgG0Vl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 17:41:27 -0400
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1k0As0-00085a-Ny; Mon, 27 Jul 2020 23:41:16 +0200
References: <87blk0rjob.fsf@0x63.nu> <xmqqr1swg9lc.fsf@gitster.c.googlers.com> <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Questions about trailer configuration semantics
In-reply-to: <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com>
Date:   Mon, 27 Jul 2020 23:41:16 +0200
Message-ID: <87a6zkr5z7.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Christian Couder writes:

>> > When configuring a value in trailer.<token>.key it causes the trailer to
>> > be normalized to that in "git interpret-trailers --parse".
>
> Yeah, I think that's nice, as it can make sure that the key appears in
> the same way. It's true that it would be better if it would be
> documented.
>
>> > but only if "key" is used, other config options doesn't cause it to be
>> > normalized.
>
> Yeah, in this case we are not sure if "Acked" or "aCKed" is the right
> way to spell it.

Makes sense.

However I guess one alternative implementation would be that if
trailer.X.something is configured but not trailer.X.key it would work as
if there was an implicit "trailer.X.key=X" configured. The name of the
configuration value would specify the correct spelling.


>> > Then there is the replacement by config "trailer.fix.key=Fixes" which
>> > expands "fix" to "Fixes". This happens when using "--trailer 'fix = 123'"
>> > which seems to be expected and useful behavior (albeit a bit unclear in
>> > documentation). But it also happens when parsing incoming trailers, e.g
>> > with that config
>> >  $ printf "\nFix: 1\n" | git interpret-trailers --parse
>> >  will emit: "Fixes: 1"
>
> Yeah, I think it allows for shortcuts and can help with standardizing
> the keys in commit messages.

Maybe what I'm missing is a clear picture of the different cases that
"git interpret-trailers" is being used in. The "--trailer x=10" option
seems clearly designed for human input trying to be as helpful as
possible (e.g always allowing '=' regardless of separators
configured). But when reading a message with trailers, is same
helpfulness useful? Or is it always only reading proper trailers
previously added by --trailer?



The standardization of trailers is interesting. If I want to standardize
"ReviewedBy", "Reviewer", "Code-Reviewer" trailers to "Reviewed-By" I
would add these configs:

trailer.reviewer.key = Reviewed-By
trailer.ReviewedBy.key = Reviewed-By
trailer.Code-Reviewer.key = Reviewed-By

Seems useful (and works out of the box as a msg-filter to
filter-branch). But the configuration seems a bit backwards, it is
configured a 3 different trailer entries, rather that a single trailer
entry with three aliases (or something like that).



>> > (token_from_item prefers order .key, incoming token, .name)
>> >
>> >
>> > The most surprising thing is that it uses prefix matching when finding
>> > they key in configuration. If I have "trailer.reviewed.key=Reviewed-By"
>> > it is possible to just '--trailer r=XYZ' and it will find the
>> > reviewed-by trailer as "r" is a prefix of reviewedby. This also applies
>> > to the "--parse".
>
> Yeah, that's also for shortcuts and standardization.
>
>> > This in makes it impossible to have trailer keys that
>> > are prefix of each other (e.g: "Acked", "Acked-Tests", "Acked-Docs") if
>> > there is multiple matching in configuration it will just pick the one
>> > that happens to come first.
>
> That's a downside of the above. I agree that it might seem strange or
> bad. Perhaps an option could be added to implement a strict matching,
> if people really want it.
>
> Also if you configure trailers in the "Acked", "Acked-Tests",
> "Acked-Docs" order, then any common prefix will pick "Acked" which
> could be considered ok in my opinion.

Yeah, that works. But that dependency on order of configuration is quite
subtle imho.

E.g consider:

$ cat >msg <<EOF

Acked: acked
Acked-Test: test
Acked-Docs: docs
EOF
$ git -c 'trailer.Acked.key=Acked' \
      -c 'trailer.Acked-Tests.key=Acked-Tests' \
      -c 'trailer.Acked-Docs.key=Acked-Docs' \
      interpret-trailers --parse msg
Acked: acked
Acked-Tests: test
Acked-Docs: docs
$ git -c 'trailer.Acked-Docs.key=Acked-Docs' \
      -c 'trailer.Acked-Tests.key=Acked-Tests' \
      -c 'trailer.Acked.key=Acked' \
      interpret-trailers --parse msg
Acked-Docs: acked
Acked-Tests: test
Acked-Docs: docs
$ git -c 'trailer.Acked-Tests.key=Acked-Tests' \
      -c 'trailer.Acked-Docs.key=Acked-Docs' \
      -c 'trailer.Acked.key=Acked' \
      interpret-trailers --parse msg
Acked-Tests: acked
Acked-Tests: test
Acked-Docs: docs





>
>> > (token_matches_item uses strncasecmp with token length)
>> >
>> >
>> > I guess these are the questions for the above observations:
>> >
>> > * Should normalization of spelling happen at all?
>
> Yes, I think it can help.
>
>> > * If so should it only happen when there is a .key config?
>
> Yes, it can help too if that only happens when there is a .key config.
>
>> > * Should replacement to what is in .key happen also in --parse mode, or
>> >   only for "--trailer"
>
> I think it's more consistent if it happens in both --parse and
> --trailer mode. I didn't implement --parse though.


Keep in mind that the machinery used by interpret-trailers is also used
by pretty '%(trailers)' so whatever normalization and shortcuts
happening also shows up there. Is shortcuts useful in that case too?
There the input is commit history, not some user input.

E.g:
$ git -c 'trailer.signed-off-by.key=Attest' \
      show --pretty='format:%(trailers:key=Attest)' --no-patch \
      0172f7834a31ae7cb9873feaaaa63939352fa3ae
Attest: Christian Couder <chriscool@tuxfamily.org>
Attest: Junio C Hamano <gitster@pobox.com>


There is also some inconsistency here. If one use '%(trailers) the
normalization doesn't happen. Only if using '%(trailers:only)' or some
other option.

(because optimization in format_trailer_info:
 /* If we want the whole block untouched, we can take the fast path. */)

I guess the fact that expansion happens also in these cases can get
confusing if I have configured a trailer "Bug-Introduced-In" locally and
the commit message contains "Bug: 123".

'git log --pretty=format:"%h% (trailers:key=Bug-Introduced-In,valueonly,separator=%x20)"'
would pick up data from the wrong trailer just because I added
configuration for Bug-Introduced-In trailer.



>> > * The prefix matching gotta be a bug, right?
>
> No, it's a feature ;-) Seriously I agree that this could be seen as a
> downside, but I think it can be understood that the convenience is
> worth it. And in case someone is really annoyed by this, then adding
> an option for strict matching should not be very difficult.
>
>> > Here is a patch to the tests showing these things.
>
> Thanks for the patch! I would be ok to add such a patch to the test
> suite if it was sent like a regular patch (so with a commit message, a
> Signed-off-by: and so on) to the mailing list. While at it some
> documentation of the related behavior would also be very nice.

Should I keep the "test_expect_failure" tests, or change into expecting
current behavior and switch them over to "test_except_success"?

I'll see if I can do something about documentation.
