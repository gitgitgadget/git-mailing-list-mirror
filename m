Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F278C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 16:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbiEIQMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 12:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiEIQMn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 12:12:43 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B666274A35
        for <git@vger.kernel.org>; Mon,  9 May 2022 09:08:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76ED61338AD;
        Mon,  9 May 2022 12:08:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tgJmJwERIrzzsrsebb19mnJrqhvh5iNPqKG+uV
        yFQss=; b=cIBwZkOG0LnwyoHFNF1+shmGTfIygw63jNp4Eoo1yKeh1BrUlnGsar
        p8btIxU2wzXCaq/qss5GKOEnuNrK4oMMSnS89h8TNiNrBDTKXG8dTdDufQy1aTc7
        20oRbdvpFKwqxdNHqId+9WzZqKeV1Sk7f3XNuHts6CECMJwt+rSv0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CEC31338AC;
        Mon,  9 May 2022 12:08:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D64CE1338AB;
        Mon,  9 May 2022 12:08:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Chris Down <chris@chrisdown.name>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] bisect: output bisect setup status in bisect log
References: <cover.1651796862.git.chris@chrisdown.name>
        <acab8859d02c95750fdbc691ac672c17d5be0291.1651796862.git.chris@chrisdown.name>
        <xmqqh762le32.fsf@gitster.g> <Ynk2q1XVGsLPvALn@nand.local>
Date:   Mon, 09 May 2022 09:08:46 -0700
In-Reply-To: <Ynk2q1XVGsLPvALn@nand.local> (Taylor Blau's message of "Mon, 9
        May 2022 11:43:39 -0400")
Message-ID: <xmqqv8ueelip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F0BC2A4-CFB2-11EC-AD51-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, May 06, 2022 at 11:18:25AM -0700, Junio C Hamano wrote:
>> Chris Down <chris@chrisdown.name> writes:
>>
>> > +__attribute__((format (printf, 1, 2)))
>> > +static void bisect_log_printf(const char *fmt, ...)
>> > +{
>> > +	va_list ap;
>> > +	char buf[1024];
>> > +
>> > +	va_start(ap, fmt);
>> > +	if (vsnprintf(buf, sizeof(buf), fmt, ap) < 0)
>> > +		*buf = '\0';
>> > +	va_end(ap);
>>
>> We should just do
>>
>> 	struct strbuf buf = STRBUF_INIT;
>>
>> 	va_start(ap, fmt);
>> 	strbuf_vaddf(&buf, fmt, ap);
>> 	va_end(ap);
>>
>> > +	printf("%s", buf);
>> > +	append_to_file(git_path_bisect_log(), "# %s", buf);
>>
>> and free the resource with
>>
>> 	strbuf_release(&buf);
>>
>> I think.
>
> I don't think so. bisect_log_printf() has only one caller, which is
> bisect_print_status(). Couldn't the latter manage its own strbuf without
> the need to introduce a new varargs function?

I actually was hoping that other existing informational messages
prefixed with "Bisecting:" (i.e. those that tells you how many steps
are remaining) can go as similar comments to the log file; they are
currently written with plain-vanilla printf(3), and could use this
one instead.
