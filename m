Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DFC433B4
	for <git@archiver.kernel.org>; Sun, 16 May 2021 14:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D7B61182
	for <git@archiver.kernel.org>; Sun, 16 May 2021 14:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhEPOd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 10:33:28 -0400
Received: from coleridge.oriole.systems ([89.238.76.34]:42390 "EHLO
        coleridge.oriole.systems" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbhEPOd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 10:33:27 -0400
Date:   Sun, 16 May 2021 16:31:56 +0200
From:   Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] rev-parse: fix segfault with missing --path-format
 argument
Message-ID: <20210516143156.mauc2ukryx5j2e2r@nabokov.fritz.box>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20210516120449.661636-1-wolf@oriole.systems>
 <xmqqsg2m6dsi.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsg2m6dsi.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-16 21:53, Junio C Hamano wrote:

> As die() is end-user facing, you'd probably want
> 
> 	die(_("--path-format requires an argument"));
> 
> We do have untranslated die() nearby for the same option, which may
> want to be cleaned up either in a preliminary patch, or in this same
> patch as an unrelated fix "while we are at it".

I would not mind preparing a preliminary patch that cleans up all
untranslated user-facing calls to die(). My editor finds 15 of those in
rev-parse.c, and I think they all qualify.

If you'd rather not touch unrelated code paths I'll instead include it
in v2 as an unrelated fix in the same commit.

> The above is certainly worth testing for, but if we ever upgrade the
> command line parser of "rev-parse" to be compatible with the parser
> based on the parse-options API to allow both "--opt=val" and "--opt
> val", it will start to fail for an entirely different reason, namely
> "--show-toplevel" will be taken as the argument to "--path-format",
> and we'd get "unknown argument to --path-format".  So it might be
> prudent to test both, i.e.
> 
> 	test_must_fail git rev-parse --path-format --show-toplevel &&
> 	test_must_fail git rev-parse --show-toplevel --path-format

I think I initially went for "--path-format --show-toplevel" because I
was under the assumption that --path-format needs another option it can
modify. It seems that this is not the case, so wouldn't it be simpler
here to do the following instead:

	test_must_fail git rev-parse --path-format

That way we do not have to worry about subsequent changes to other,
unrelated, options.

-- 
Wolfgang
