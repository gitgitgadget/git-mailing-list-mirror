Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648531FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 18:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbcFPSMT (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 14:12:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751397AbcFPSMS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 14:12:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B368922646;
	Thu, 16 Jun 2016 14:12:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t9+Iz9zKaMW6ZmpsNNsOG1FouV4=; b=oXHwY8
	8BfZDW9SVr6Xy9vLVSDwl34T3M0osQWa2HXkeDAR318ShJsy2FXJVRbPx3yjT7y2
	3bA1eTnV3Gz9ffPclPC5m0gaMrI0oGa6+VtHWOLFgXaXl4YjRAeeXuZFZ9qelhMN
	LyrqI7t9NghiGUDdf3Xni/A/ONuw6gpytyFPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=homJwkQ6lPL9EF4RoKaZx3FEJWJDzwVd
	Yg06OHLgtrmLq0ygJn8IY61WH+rK0oEbSyFlwCMLwJaRiPDLTMGlVi1Ttxx6P9ap
	J5ifx++kmaz2P7eqOaciIPQ3l1QA0jYUluBMzzTawv67HEI4Mgzaq4abxsBwQGHu
	7i64oBVVB0o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AC1BF22645;
	Thu, 16 Jun 2016 14:12:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 31CFD22644;
	Thu, 16 Jun 2016 14:12:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Charles Bailey <charles@hashpling.org>
Cc:	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] grep: fix grepping for "intent to add" files
References: <20160616065324.GA14967@hashpling.org>
Date:	Thu, 16 Jun 2016 11:12:15 -0700
In-Reply-To: <20160616065324.GA14967@hashpling.org> (Charles Bailey's message
	of "Thu, 16 Jun 2016 07:53:24 +0100")
Message-ID: <xmqq7fdp57gg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBF8CBA6-33ED-11E6-A9C7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Charles Bailey <charles@hashpling.org> writes:

> http://thread.gmane.org/gmane.comp.version-control.git/272363/focus=276358
>
> http://thread.gmane.org/gmane.comp.version-control.git/283001/focus=283002
>
> Unless I've misunderstood the conversation and commit message, the
> referenced commit was supposed to be a "code as a comment" commit with
> no change in observable behavior

Thanks for a pointer; 276358 claims that ce->ce_mode would be zero
for path added with "git add -N path", but I do not think it is
correct.

The updated behaviour is more understandable.  With "add -N", the
user said "Just keep an eye on this path, I cannot decide what the
contents for this path in the index should be at this moment".
grep_cache() that checks the contents in the index cannot say what
is in the index, because the contents is not yet there.
