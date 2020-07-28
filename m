Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D3DC433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 00:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB13620729
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 00:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgG1ABW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 20:01:22 -0400
Received: from 0x63.nu ([109.74.10.199]:48996 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG1ABW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 20:01:22 -0400
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1k0D3U-0008Qt-2Y; Tue, 28 Jul 2020 02:01:16 +0200
References: <87blk0rjob.fsf@0x63.nu> <xmqqr1swg9lc.fsf@gitster.c.googlers.com> <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com> <xmqqk0yog1lg.fsf@gitster.c.googlers.com> <878sf4r4au.fsf@0x63.nu> <xmqq5za8ftih.fsf@gitster.c.googlers.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Questions about trailer configuration semantics
Message-ID: <871rkwqzi3.fsf@0x63.nu>
In-reply-to: <xmqq5za8ftih.fsf@gitster.c.googlers.com>
Date:   Tue, 28 Jul 2020 02:01:15 +0200
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano writes:

> Anders Waldenborg <anders@0x63.nu> writes:
>
>> From what I can understand it tries to match *both* on the second level
>> AND the value of .key (trailers.c:token_matches_item)
>
> Yuck, I do not know what were we thinking to design the behaviour
> like *that*.  Or it may be simply buggy.
>
>> $ printf '\na: 1\nb: 2\nc: 3\n' | \
>>   git -c 'trailer.A.key=B' interpret-trailers
>> B: 1
>> B: 2
>> c: 3
>
> I can understand the first one (i.e. "trailer.$name.$var" try to
> match $name as case insensitively) but not the second one.  There is
> not an single rule for "b" trailer, and we should be getting the
> same behaviour as the third line, i.e. the key not involved in
> rewriting is passed as-is.

I'm not so sure about that. Matching sometimes needs to happen on .key
too. If this configuration is supposed to be useful (and as "shortcuts"
has been mentioned before and is what tests does, I think it should be):

trailer.rb.key=Reviewed-By
trailer.rb.ifexists=addifdifferent

then matching must look at key, not name. As the value of .key is what
would have been written previously into the message.

E.g:
$ printf "\nReviewed-By: hi\n" | \
  git -c "trailer.rb.key=Reviewed-By" \
      -c "trailer.rb.ifexists=addifdifferent" \
      interpret-trailers --trailer "rb=hi"
Reviewed-By: hi



The opposite case, matching on name in input message I'm not sure where
it is useful.

 $ printf "\nrb: hi\n" | \
   git -c "trailer.rb.key=Reviewed-By" \
       -c "trailer.rb.ifexists=addifdifferent" \
       interpret-trailers --trailer "rb=hi"
Reviewed-By: hi



The way I have understood it ".key" can be used for some different
things:

 * Freeing up name to be used as a shortcut alias.
 * Defining the canonical capitalization when passing through trailers
 * Allowing specifying non default separator for that key.

I wonder if those uses could be split up.

So instead of this configuration:

 [trailer "rb"]
     key="Reviewed-By> "

that does all three of those. The configuration would be:

 [trailer "Reviewed-By"]
     separator="> "
     canonicalize=true
     alias=rb

that way the "name" part of the config always is the correct spelling
and capitalization. "alias" could easily be a list of multiple alias if
that is wanted. "alias" could be split into "inputalias" (matched
against when reading trailers from stdin or a commit/tag message) and
"optalias" (matched against when reading --trailer cmdline option, and
%(trailers:key))
