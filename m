Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689162018A
	for <e@80x24.org>; Fri,  1 Jul 2016 20:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbcGAUkZ (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 16:40:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752501AbcGAUkW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 16:40:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B684927E00;
	Fri,  1 Jul 2016 16:34:08 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lVidQst8Z7KiCAuAM8r6/dj/0EY=; b=mxJlMy
	0+M0J7Cx7o8ljwzePbPr855ZveIPD+iG0rQSrc7ODzR7ssvmYYN6IFoCGbZrDsEC
	nfds4meQWH2y50vvMEVxrDVQXlRh4S59mgGrHvkSI9cyHwXDB70mbcP8uv8egbds
	JL5+a9VaNmjzVZAGx+WgVQd+Y2DioAohO/mPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RH9KoSr3NtrEk30GamuOQ85yOZD/ENRQ
	mSzt5d45Rq5+7f1et8DWAreEATDsKcRj8ZNUnsD0Aptp/RRfkYzKdX8il4xpBUNZ
	ky9cAM0mZqV5T0O8o8/sL5TuXob9bcXjJ1jTC0z4j+SKiBR9QMKdRObADR+mkz5s
	VKCt7kcT/XE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ADB5C27DFE;
	Fri,  1 Jul 2016 16:34:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3387F27DF9;
	Fri,  1 Jul 2016 16:34:08 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Charles Bailey <charles@hashpling.org>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 3/3] grep: fix grepping for "intent to add" files
References: <20160630101348.15665-1-charles@hashpling.org>
	<20160630101348.15665-4-charles@hashpling.org>
Date:	Fri, 01 Jul 2016 13:34:06 -0700
In-Reply-To: <20160630101348.15665-4-charles@hashpling.org> (Charles Bailey's
	message of "Thu, 30 Jun 2016 11:13:48 +0100")
Message-ID: <xmqqpoqxw11d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 291F5222-3FCB-11E6-947E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Charles Bailey <charles@hashpling.org> writes:

> +test_expect_success 'grep can find things only in the work tree' '
> +	: >work-tree-only &&
> +	git add work-tree-only &&
> +	test_when_finished "git rm -f work-tree-only" &&

It is better to have the test_when_finished before "git add", and
possibly before the creation of the test file.

It is not worth a reroll and it is perfectly fine to leave it as a
low-hanging-fruit for later clean-up material, because this test is
not about catchign a "git add" that suddenly starts failing in a
strange way (e.g. adds to the index but exits with non-zero).

Same comment for the use of test_when_finished in the remainder of
the patch.

Thanks.

> +	echo "find in work tree" >work-tree-only &&
> +	git grep --quiet "find in work tree" &&
> +	test_must_fail git grep --quiet --cached "find in work tree" &&
> +	test_must_fail git grep --quiet "find in work tree" HEAD
> +'
> +
> +test_expect_success 'grep can find things only in the work tree (i-t-a)' '
> +	echo "intend to add this" >intend-to-add &&
> +	git add -N intend-to-add &&
> +	test_when_finished "git rm -f intend-to-add" &&
> +	git grep --quiet "intend to add this" &&
> +	test_must_fail git grep --quiet --cached "intend to add this" &&
> +	test_must_fail git grep --quiet "intend to add this" HEAD
> +'
> +
> +test_expect_success 'grep does not search work tree with assume unchanged' '
> +	echo "intend to add this" >intend-to-add &&
> +	git add -N intend-to-add &&
> +	git update-index --assume-unchanged intend-to-add &&
> +	test_when_finished "git rm -f intend-to-add" &&
> +	test_must_fail git grep --quiet "intend to add this" &&
> +	test_must_fail git grep --quiet --cached "intend to add this" &&
> +	test_must_fail git grep --quiet "intend to add this" HEAD
> +'
> +
> +test_expect_success 'grep can find things only in the index' '
> +	echo "only in the index" >cache-this &&
> +	git add cache-this &&
> +	rm cache-this &&
> +	test_when_finished "git rm --cached cache-this" &&
> +	test_must_fail git grep --quiet "only in the index" &&
> +	git grep --quiet --cached "only in the index" &&
> +	test_must_fail git grep --quiet "only in the index" HEAD
> +'
> +
> +test_expect_success 'grep does not report i-t-a with -L --cached' '
> +	echo "intend to add this" >intend-to-add &&
> +	git add -N intend-to-add &&
> +	test_when_finished "git rm -f intend-to-add" &&
> +	git ls-files | grep -v "^intend-to-add\$" >expected &&
> +	git grep -L --cached "nonexistent_string" >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
> +	echo "intend to add this" >intend-to-add-assume-unchanged &&
> +	git add -N intend-to-add-assume-unchanged &&
> +	test_when_finished "git rm -f intend-to-add-assume-unchanged" &&
> +	git update-index --assume-unchanged intend-to-add-assume-unchanged &&
> +	git ls-files | grep -v "^intend-to-add-assume-unchanged\$" >expected &&
> +	git grep -L "nonexistent_string" >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_done
