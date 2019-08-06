Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5021F731
	for <e@80x24.org>; Tue,  6 Aug 2019 16:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbfHFQsF (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 12:48:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51186 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732788AbfHFQsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 12:48:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9749157D99;
        Tue,  6 Aug 2019 12:48:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dhqbxQ+iiilY
        dBfEzW/oVi9Yu2M=; b=dy48qa6jsQtLakh2t/E1cVxppfxXqNKhNMuJJ9u3T652
        oNiojWLQg99L3V72J395IOZC3nYznvv5sZuCvMkBb1S7OZkZS/d//MGD86FSkMyX
        LPQTkAIcaT9AMOhWyCDdKxsjl0qmC7La9KMuuw429ruXWh/xAqlidI/JTLgB1Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LCRILd
        qKF49Pj2oU42a/JmdEUfADfi8BAWDG8o3TB3jHiuGLt81CKI2dChQHwOEWFtZXqT
        HgJ58fn62tViZJKiSO/oUMqovLAyi1RbgBfP7rHUijh66m3Pvd1xK7KZmrM8gxxb
        2pEDnT8QP57ZQtUcMiBaO6yrvmAgaosKpihjk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD530157D98;
        Tue,  6 Aug 2019 12:48:02 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05576157D95;
        Tue,  6 Aug 2019 12:48:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, l.s.r@web.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
Subject: Re: [RFC PATCH v3 0/3] grep: no leaks or crashes (windows testing needed)
References: <20190806085014.47776-1-carenas@gmail.com>
        <20190806163658.66932-1-carenas@gmail.com>
Date:   Tue, 06 Aug 2019 09:48:00 -0700
In-Reply-To: <20190806163658.66932-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 6 Aug 2019 09:36:55 -0700")
Message-ID: <xmqq5znakzpb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F43FD886-B869-11E9-8CCF-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Junio, could you comment in my assumption that the use of grep in
> revision.c doesn't require initializing a PCRE2 global context and
> therefore not doing the cleanup?

Many callers of setup_revisions() do so only to run two-thing diffs
(e.g. run_diff_files() that compares the index and the working tree),
but some do so to traverse the history with the grep_filter
(e.g. "git log --grep=3D<pattern>").  "git log -P" may affect how that
pattern is used to match the contents of the log messages, no?
