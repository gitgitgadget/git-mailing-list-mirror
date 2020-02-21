Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB282C11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F404206DB
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="crz/bjDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgBUA0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:26:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51182 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgBUA0G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 19:26:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F26CBAFD83;
        Thu, 20 Feb 2020 19:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xd2FigPx5Hb4Rj33I2uGmhwTTYY=; b=crz/bj
        DXQ1TeQrWACOfqA6q3F3O6HTbaBmMeQC2fVL3CIngUeFB2i8e+i7AAUIHm0kC+xN
        uJdK9x/N85kBuNN74gZG7/st8R0LKHTPddeQe950yz1gr+Ru8aErt1YonSjlv4r6
        skSIfhe/FrfS2VuoM46FuB/K4AJcy5KNOSYI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z8y8z4TIRppESERqNRFw/V6dydwz7jWP
        mWf9WReM09McA3nD5K5tA6sjgfMbQKwfAKmeINj06IqWSYOJBmH87y7T7F/P1FSy
        8AN6epYAuCkLOowVHE6nc3mY4GUEUNjbrV631sdOHanhsRLmQqPXDB8mJL45nABd
        SMDR9RdsZ24=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EAEC0AFD81;
        Thu, 20 Feb 2020 19:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 50A25AFD7F;
        Thu, 20 Feb 2020 19:26:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 06/15] bugreport: add compiler info
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-7-emilyshaffer@google.com>
Date:   Thu, 20 Feb 2020 16:26:00 -0800
In-Reply-To: <20200220015858.181086-7-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 19 Feb 2020 17:58:49 -0800")
Message-ID: <xmqq7e0g946f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE2CBC28-5440-11EA-AFEC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +	strbuf_addstr(sys_info, "compiler info: ");
> +	get_compiler_info(sys_info);
> +	strbuf_complete_line(sys_info);

Continuing the response to 04/15 review, I do not think this is a
good use of complete_line(), either.  On an exotic platform you
haven't seen, get_compiler_info() might stuff nothing in the output
buffer, in which case we are left with an incomplete line that just
says "compiler info: ", and it might be better not to leave that
incomplete line hanging around by calling complete_line(), but an
even better solution would be to make sure get_compiler_info()
explicitly say it encountered a system totally new to it.  And at
that point, as long as everybody in get_compiler_info() ends its
output with a complete line, there is no need for complete_line()
on the caller's side.

Of course, you can make it a convention that all case arms or ifdef
blocks in get_compiler_info() uniformly end what they have to say
with an incomplete line and make it a responsibility of the caller
to terminate the incomplete line.  But in that case, you'd not be
using complete_line(), but strbuf_addch('\n').

