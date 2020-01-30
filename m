Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C30FC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 21:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A659420661
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 21:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XpOukl8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgA3V0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:26:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50370 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgA3V0G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 16:26:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABC194ABE7;
        Thu, 30 Jan 2020 16:26:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Un+s2B6CoSnez5rgs7H0OyCRsgE=; b=XpOukl
        8nspnJUN56taphgzW0DbBkQCEsmm8CtijxfZvu0GoZueletoBaEf7prMZ3K6xhIn
        8StStNhCKEQ3wtcgm5OEbZ9GPzAPBI9LCYpd9AvGJKbB1vZy10FG7SUpIgW2ttPy
        Qc4fOV0dGXN6EEUT25tsGu2LEq1gExXbi+ULc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GNOCiTvRjupG399WEnr5fJ9DeFf1cCyy
        ozGOzHQrY779vkkoKZjC5SdVvB0Xpgn5P8QvZH2xU+08hCuHf292Q5dfXNF3mpZx
        7hZEdQRE8bEAtacPWJyYAop9niegFOopaSEKWG/LJEyZp3741b4dPTCqleXqfv34
        1wFaNUHgeV4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A32EF4ABE6;
        Thu, 30 Jan 2020 16:26:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EAFCA4ABE5;
        Thu, 30 Jan 2020 16:26:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] fix inconsistent uses of the_repo in parse_object()'s call chain
References: <cover.1580413221.git.matheus.bernardino@usp.br>
Date:   Thu, 30 Jan 2020 13:26:02 -0800
In-Reply-To: <cover.1580413221.git.matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Thu, 30 Jan 2020 17:32:16 -0300")
Message-ID: <xmqqmua4bpqt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E934D7A-43A7-11EA-9AA4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> Note: I also tried to replace some uses of the_hash_algo with the struct
> git_hash_algo from the received repository, for consitency. (In
> practice, I'm not sure if this is very useful right now, but maybe it
> will be relevant for the change to SHA256?) Still, many functions in
> parse_object()'s call chain call oid_to_hex(), which uses the_hash_algo.
> Since changing this would require a much bigger operation, I decided to
> leave it as is, for now.

Passing a repo instance throughout the callchain and redusing the
use of the_repo would be a worthwhile longer term clean-up.  

Moving off of the_hash_algo to repo->hash_algo is, too, and it is
very much relevant to the "newhash" work Brian (CCed) has been
working on.  You two do not want to step on each other's toes.
Please coordinate.

Thanks.
