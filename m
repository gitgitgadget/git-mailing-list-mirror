Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788C0C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 18:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiDKSbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 14:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243082AbiDKSba (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 14:31:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4244515733
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 11:29:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FF6A115BC9;
        Mon, 11 Apr 2022 14:29:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yO0SSaAI4H60
        5uSkrwOysWygHv30duiod1NnIU8hfe0=; b=trvqz/FTjz+J0Kmh3JO9apnrbzRh
        hu9c6XxPqoAU2X4H8h7tS9irCIvmvrKlip/D+BwWjb4JP9WqzFh7V05blLUbSir2
        LDIcF2l+NhkcuksC6w8Baps5qDeyCIXwGTJy4iPXdbk9MWnmNIRASSbfJy6RynUL
        TS3o9YsKKFspXRg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96B7C115BC8;
        Mon, 11 Apr 2022 14:29:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BB37115BC7;
        Mon, 11 Apr 2022 14:29:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Makefile: add a prerequisite to the
 coverage-report target
References: <20220409043033.1288946-1-gitter.spiros@gmail.com>
Date:   Mon, 11 Apr 2022 11:29:09 -0700
In-Reply-To: <20220409043033.1288946-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Sat, 9 Apr 2022 04:30:33 +0000")
Message-ID: <xmqqv8vfiidm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 48146EE0-B9C5-11EC-B492-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> Directly invoking make coverage-report as a target results in an error =
because
> its prerequisites are missing,
>
> This patch adds the compile-test prerequisite, which is run only once e=
ach time
> the compile-report target is invoked. In practice, the developer may de=
cide to
> review the coverage-report results without necessarily rerunning for th=
is
> coverage-test, if it has already been run.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is the second version of the patch.
>
> With respect to the first version, we tried to eliminate the inefficien=
t
> coverage-test invocation if the target is coverage-report, introducing =
a more
> useful invocation order

Thanks.

I do not see why you want to make the name of coverage-test.file
customizable.  In our makefiles, it seems that these "stamp" files
are named with the ".made" suffix

   $ git grep -e '\.made'

so using hardcoded "coverage-test.made" (with something that removes
*.made when "make clean" is run) may make it in line with the rest
of the build procedure.

=C3=86var, I had an impression that you had many Makefile patches either
unsubmitted or work-in-progress in the dependency-tightening area,
and am wondering if you find the dependencies (or the lack thereof)
for coverage-report target annoying.  Any good ideas?



>  Makefile | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index e8aba291d7..eacdffd748 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3378,6 +3378,8 @@ check-builtins::
>  .PHONY: coverage-untested-functions cover_db cover_db_html
>  .PHONY: coverage-clean-results
> =20
> +coverage-test.file?=3Dcoverage-test.file
> +
>  coverage:
>  	$(MAKE) coverage-test
>  	$(MAKE) coverage-untested-functions
> @@ -3389,6 +3391,7 @@ coverage-clean-results:
>  	$(RM) coverage-untested-functions
>  	$(RM) -r cover_db/
>  	$(RM) -r cover_db_html/
> +	$(RM) -f $(coverage-test.file)
> =20
>  coverage-clean: coverage-clean-results
>  	$(RM) $(addsuffix *.gcno,$(object_dirs))
> @@ -3404,12 +3407,16 @@ coverage-test: coverage-clean-results coverage-=
compile
>  	$(MAKE) CFLAGS=3D"$(COVERAGE_CFLAGS)" LDFLAGS=3D"$(COVERAGE_LDFLAGS)"=
 \
>  		DEFAULT_TEST_TARGET=3Dtest -j1 test
> =20
> +$(coverage-test.file):
> +	@make coverage-test
> +	touch $(coverage-test.file)
> +
>  coverage-prove: coverage-clean-results coverage-compile
>  	$(MAKE) CFLAGS=3D"$(COVERAGE_CFLAGS)" LDFLAGS=3D"$(COVERAGE_LDFLAGS)"=
 \
>  		DEFAULT_TEST_TARGET=3Dprove GIT_PROVE_OPTS=3D"$(GIT_PROVE_OPTS) -j1"=
 \
>  		-j1 test
> =20
> -coverage-report:
> +coverage-report: $(coverage-test.file)
>  	$(QUIET_GCOV)for dir in $(object_dirs); do \
>  		$(GCOV) $(GCOVFLAGS) --object-directory=3D$$dir $$dir*.c || exit; \
>  	done
