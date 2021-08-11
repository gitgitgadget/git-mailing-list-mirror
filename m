Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33839C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1650460EBD
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 07:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhHKHet (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:34:49 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:41841 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235177AbhHKHes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 03:34:48 -0400
Received: from [192.168.1.103] (089144194204.atnat0003.highway.a1.net [89.144.194.204])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Gl1mJ0njWz5tlL;
        Wed, 11 Aug 2021 09:34:22 +0200 (CEST)
Subject: Re: [PATCH v4] userdiff: improve java hunk header regex
To:     Tassilo Horn <tsdh@gnu.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20210810190937.305765-1-tsdh@gnu.org>
 <d3484278-8413-0d10-e6cd-59a7ff04564b@kdbg.org> <87zgtoh6bm.fsf@gnu.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <95ebb2cf-2e6e-912e-7d80-3947a8e3d9e4@kdbg.org>
Date:   Wed, 11 Aug 2021 09:34:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87zgtoh6bm.fsf@gnu.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.21 um 07:22 schrieb Tassilo Horn:
> Johannes Sixt <j6t@kdbg.org> writes:
>> These new tests are very much appreciated. You do not have to go wild
>> with that many return type tests; IMO, the simple one and the most
>> complicated one should do it. (And btw, s/cart/card/)
> 
> Well, they appeared naturally as a result during development and made it
> easier to spot errors when you know up to which level of complexity it
> still worked.  Is there a stronger reason to remove tests which might
> not be needed, e.g., runtime cost on some CI machines?

I totally understand how the test cases evolved. Having many of them is
not a big deal. It's just the disproportion of tests of this new feature
vs. the existing tests that your patch creates, in particular, when
earlier of the new tests are subsumed by later new tests.

> Another thing I've noticed (with my suggested patch) is that I should
> not try to match constructor signatures.  I think that's impossible
> because they are indistinguishable from method calls, e.g., in
> 
>   public class MyClass {
>       MyClass(String RIGHT) {
>           someMethodCall();
>           someOtherMethod(17)
>               .doThat();
>           // Whatever
>           // ChangeMe
>       }
>   }
> 
> there is no regex way to prefer MyClass(String RIGHT) over
> someOtherMethod().

Good find.

> So all in all, I'd propose this version in the next patch version:
> 
> --8<---------------cut here---------------start------------->8---
> PATTERNS("java",
> 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
>          "^[ \t]*("
>          /* Class, enum, and interface declarations */
>          "(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)"
>          /* Method definitions; note that constructor signatures are not */
>          /* matched because they are indistinguishable from method calls. */
>          "|(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)"
>          ")$",
> 	 /* -- */
> 	 "[a-zA-Z_][a-zA-Z0-9_]*"
> 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
> 	 "|[-+*/<>%&^|=!]="
> 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> --8<---------------cut here---------------end--------------->8---

That looks fine.

One suggestion, though. You do not have to have all positive patterns
("class, enum, interface" and "method definitions") in a single pattern
separated by "|". You can place them on different "lines" (note the "\n"
at the end of the first pattern):

	/* Class, enum, and interface declarations */
	"^[ \t]*(...(class|enum|interface)...)$\n"
	/*
	 * Method definitions; note that constructor signatures are not
	 * matched because they are indistinguishable from method calls.
	 */
	"^[ \t]*(...[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*))$",

I don't think there is a technical difference, but I find this form
easier to understand because fewer open parentheses have to be tracked.

-- Hannes
