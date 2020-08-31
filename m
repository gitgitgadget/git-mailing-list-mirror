Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598AEC433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296CA2054F
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pzJGcmSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgHaRJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:09:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50899 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgHaRJP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 13:09:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9889580B45;
        Mon, 31 Aug 2020 13:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xYzw0eja1E0Kq/CbfSwee4tbRHo=; b=pzJGcm
        Su9N2i0E+jkvZLHmkb0MTshyj3kXUAyi3/ST+CwzW3Bf5VHp+DCYGv3JOg+fC8SO
        2bP3eChvH47iAS65fDY9BtIW+61K/FMe7HfZmNdqoXh6PVU3BYUjfRz8/JYP0khI
        ARyF1Y9Wyo+de0IKupjQpOp27Lh79Jl1HyBYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e9JGv8+uxrme+l0+RZWfQtKP9S08fv1B
        9UspqhXjdEhtOS0MT61jyODIRFNe8RQkBy11t+Xadb4zfA6rw+lBvNwElkV8urY4
        hm3g7yDNKiMeoMrCyapwGQFXkvUH8DOROXXgX+8ZMfjIzbN2lkeZPEwm+05ueKCh
        pLuClbUwX28=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FBA580B44;
        Mon, 31 Aug 2020 13:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18E8880B43;
        Mon, 31 Aug 2020 13:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Miriam R." <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v6 06/13] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
References: <20200828124617.60618-1-mirucam@gmail.com>
        <20200828124617.60618-7-mirucam@gmail.com>
        <xmqq8sdxi70a.fsf@gitster.c.googlers.com>
        <CAN7CjDBd=41PQ5qfqazdtx4uoRcfcc6cUWf5u0cNiooSo24ENg@mail.gmail.com>
Date:   Mon, 31 Aug 2020 10:09:12 -0700
In-Reply-To: <CAN7CjDBd=41PQ5qfqazdtx4uoRcfcc6cUWf5u0cNiooSo24ENg@mail.gmail.com>
        (Miriam R.'s message of "Mon, 31 Aug 2020 12:50:33 +0200")
Message-ID: <xmqq8sduhhdz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B162C498-EBAC-11EA-B3AC-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Miriam R." <mirucam@gmail.com> writes:

> I don't know if it is something related to my compiler but my -Werror
> build does not break.

FWIW, here is a full compilation command line from "make V=1" for
the file:

cc -o builtin/bisect--helper.o -c -MF builtin/.depend/bisect--helper.o.d -MQ builtin/bisect--helper.o -MMD -MP -Werror -Wall -Wdeclaration-after-statement -Wformat-security -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-prototypes -Wunused -Wvla -Wextra -Wmissing-prototypes -Wno-empty-body -Wno-missing-field-initializers -Wno-sign-compare -Wno-unused-parameter  -g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU="\"x86_64\"" -DHAVE_ALLOCA_H  -DUSE_CURL_FOR_IMAP_SEND -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH="/proc/self/exe"'  -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"' -DPAGER_ENV='"LESS=FRX LV=-c"'  builtin/bisect--helper.c
builtin/bisect--helper.c: In function 'bisect_next':
builtin/bisect--helper.c:570:6: error: variable 'no_checkout' set but not used [-Werror=unused-but-set-variable]
  570 |  int no_checkout;
      |      ^~~~~~~~~~~
cc1: all warnings being treated as errors
