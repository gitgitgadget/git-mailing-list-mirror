Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2B7C433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 20:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbiDHUNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 16:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiDHUNK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 16:13:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112753542B3
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 13:11:01 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3788D1895EC;
        Fri,  8 Apr 2022 16:11:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XmaVcozFp5tVkPS5YgFtzN8DwFWlpgCziaipXH
        s3+84=; b=HuJaP+fwhmyKfJTJks/YPU0WOCxKo5n+6ZsQtHxDfBb+jZIerc1ea9
        DYKNMBLIX97nTEvNK9x04DUMcKbsME2p3jlXQMxX9sTaxXsQd6/Fh+3wANY8y9ie
        P6rTPTvtJZCZPPTs7q97tl2/yTcmD82JtNMAZT+QGpdRRhOX6gA9w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F8401895EB;
        Fri,  8 Apr 2022 16:11:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 833151895EA;
        Fri,  8 Apr 2022 16:10:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: add a prerequisite to the coverage-report target
References: <20220408105443.192217-1-gitter.spiros@gmail.com>
Date:   Fri, 08 Apr 2022 13:10:57 -0700
In-Reply-To: <20220408105443.192217-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Fri, 8 Apr 2022 10:54:43 +0000")
Message-ID: <xmqqpmlrl4j2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01300330-B778-11EC-B0B5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> @@ -3409,7 +3409,7 @@ coverage-prove: coverage-clean-results coverage-compile
>  		DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="$(GIT_PROVE_OPTS) -j1" \
>  		-j1 test
>  
> -coverage-report:
> +coverage-report: coverage-test
>  	$(QUIET_GCOV)for dir in $(object_dirs); do \
>  		$(GCOV) $(GCOVFLAGS) --object-directory=$$dir $$dir*.c || exit; \
>  	done

I am not sure if this alone makes it a good change.

With the current set-up, you can run coverage-test or coverage-prove
once, view coverage-report, shift your attention to elsewhere to
address issues you saw in the report, and then decide to view the
report again to remind yourself what you saw and what motivated you
to work on your changes.  Most likely this sequence would be
followed by another run of coverage-test followed by coverage-report
to compare what you saw before you made these changes with the
covernage report after your changes.

If this were conditional, i.e. "ah, I see you haven't run any
coverage test yet, so let me run it for you before showing the
result" combined with "ok, I see you did run coverage test, so let
me just show the result without running tests anew", then it would
be a strict improvement from the status quo.

But with the patch as posted, wouldn't we unconditonally wipe the
earlier result out?  If so that may negatively affect established
workflow of some people, I am afraid.

Thanks.
