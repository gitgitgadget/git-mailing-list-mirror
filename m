Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE43F1F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbcHFUAT (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:00:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751223AbcHFUAR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:00:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C1612F85A;
	Sat,  6 Aug 2016 13:02:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JuXfWesvzDsJLqGZA53CA82bqWY=; b=RRblSw
	gJWEVtzWpO/O8DNyMg48W0mJB9/CqbxWF6NL+X2cZfjpx/vBm7VnyV7kvOZ4gPpX
	+06Chq+vd2IvH8S3v1LHJ0KraU3+xAsCmaJPMOVycRq+hpp6MYD1Qg5W3whZZz/S
	ORQ2gpEM/Nqj2X/J6okxLlJmeSyfa34yE7Hpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ODb3HOIbkAsvYT7iDBzFxu21T2hZw8Rt
	8sZdLaai/R2cmbtTZr5+xWpEWAQVefRM6lZDkeyKBCheGgAH1u97Bf6MkGzyCyz7
	/xklvTltTrAI2sYaHfz6ot9QNwZAfqUOlkHxqaKF1DH5YtWM/qHhMmGGO5i6Xs6z
	vU65/Htsgtw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 74A632F854;
	Sat,  6 Aug 2016 13:02:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0E132F853;
	Sat,  6 Aug 2016 13:02:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Jens.Lehmann@web.de, git@vger.kernel.org, mst@redhat.com
Subject: Re: [PATCHv2 2/6] t7408: merge short tests, factor out testing method
References: <20160806012318.17968-1-sbeller@google.com>
	<20160806012318.17968-3-sbeller@google.com>
Date:	Sat, 06 Aug 2016 10:02:53 -0700
In-Reply-To: <20160806012318.17968-3-sbeller@google.com> (Stefan Beller's
	message of "Fri, 5 Aug 2016 18:23:14 -0700")
Message-ID: <xmqqshuhj0ea.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EC2D880-5BF7-11E6-A9B8-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +test_alternate_usage() {

According to Documentation/CodingGuidelines, this should be:

    test_alternate_usage () {

Somehow the helper name sounds as if it is testing if an alternate
is used correctly (i.e. the machinery may attempt to use alternate
but not in a correct way), not testing if an alternate is correctly
used (i.e. the machinery incorrectly forgets to use an alternate at
all), but maybe it is just me.

> +test_expect_success 'updating superproject keeps alternates' '
> +	test_when_finished "rm -rf super-clone" &&

This one is new; we do not remove A, B or super.  According to the
previous round of review, this is a deliberate design, that needs to
be spelled out by having a comment block before this test so that
other people who add more tests can understand why they need to
clean when they follow suit.  Perhaps something like:

    ###############################################################
    # The tests up to this point, and repositories created by them
    # (A, B, super and super/sub), are about setting up the stage
    # forsubsequent tests and meant to be kept throughout the
    # remainder of the test.
    # Tests from here on, if they create their own test repository,
    # are expected to clean after themselves.

    test_expect_success 'updating superproject keeps alternates' '
            test_when_finished "rm -rf super-clone" &&

