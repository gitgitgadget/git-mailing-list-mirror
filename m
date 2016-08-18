Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01542203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 00:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbcHSAuS (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 20:50:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60658 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754139AbcHSAuR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:50:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F09136CDF;
        Thu, 18 Aug 2016 17:53:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E81H3advxFA75KZNJUs+CVd4t8I=; b=aUosIb
        YBbVeielUUlCYWLEM2E+GB3+1oTjabpD891smGCLEDdnnxI2DaG3bi5K2jetubDC
        CwtMi7nf2dHPF9KTgrwdSBBuaWYedU+J14Ja8q/TRM6LL7nS7r/zIW4uqawb2AIS
        +by0WRmvJOZMRoundh/R78hf0pxnHkddddhOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=opgzYT2momU4ijzDoKhQE8vcbHWzsmWQ
        1MLmE+ebAKm2HVf4VI6a/FxQQZLVy/J3Nntu7rBrenF2azcJWMv4W3O8tFjkAvfr
        jjrddB/i4ABm64mWwy0y9IYswj9A3z82a/XHJdNrMGslX4xQnaST+5rPdRYbsFZf
        X5ykiJDGaMk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7779B36CDE;
        Thu, 18 Aug 2016 17:53:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F35CD36CDD;
        Thu, 18 Aug 2016 17:53:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Ben Wijen <ben@wijen.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/2] mingw: ensure temporary file handles are not inherited by child processes
References: <cover.1471437637.git.johannes.schindelin@gmx.de>
        <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de>
        <20160818173555.GA29253@starla>
Date:   Thu, 18 Aug 2016 14:53:03 -0700
In-Reply-To: <20160818173555.GA29253@starla> (Eric Wong's message of "Thu, 18
        Aug 2016 17:35:55 +0000")
Message-ID: <xmqqshu14udc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24556ED2-658E-11E6-A0B2-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> O_CLOEXEC only exists since Linux 2.6.23 and there are likely
> still LTS (CentOS 5.x?) and non-Linux systems which do not have
> it, as well as machines with could have it defined in userspace
> headers but not have it in the kernel.
>
> So I suggest something like the following: (untested)
>
> #define GIT_O_TMP (O_RDWR | O_CREAT | O_EXCL)
>
> #ifndef O_CLOEXEC
> #  define O_CLOEXEC 0
> #endif
> 	/* state: -1=unknown; 0=broken; 1=working */
> 	static int cloexec_state = O_CLOEXEC == 0 ? 0 : -1;
> 	static int GIT_O_ETMP = (GIT_O_TMP | O_CLOEXEC)
>
> 	int fd = open(filename, GIT_O_ETMP, 0666);
> ...
> 	/*
> 	 * This is racy in the presence of threads,
> 	 * but the best we can do for old *nix:
> 	 */
> #if defined(F_GETFD) && defined(F_SETFD) && defined(FD_CLOEXEC)
> 	if (fd >= 0 && cloexec_state != 1) {
> 		int flags = fcntl(fd, F_GETFD);
>
> 		if (flags == -1)
> 			die_errno("F_GETFD failed");
> 		if (flags & O_CLOEXEC)
> 			cloexec_state = 1;
> 		else {
> 			flags = fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
> 			if (flags == -1)
> 				die_errno("F_SETFD failed");
> 			cloexec_state = 0;
>
> 		}
> 	}
> #endif
> 	...

Our codepaths themselves generally do not care about O_CLOEXEC, so
giving a racy emulation of it is not worth the effort, making the
later half of the above an overkill.  Perhaps the three lines to
define O_CLOEXEC to 0 on older UNIX might be sufficient.
