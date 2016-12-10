Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9E4C1FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 18:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbcLJSSe (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 13:18:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61742 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751965AbcLJSSe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 13:18:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C815254747;
        Sat, 10 Dec 2016 13:18:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yPrp4J7A+54HSpYpl7mZsXssFuE=; b=ZT2oa1
        0dehzjG4wQc6xYNqEoAL/Nc+PiacPmf3o9tirICNBwvFmmFkyYxI6spqNG88093+
        nwewiqvBJijX6MLgvtI7mVMANhahSexP1bpbyFgi5EcCqHywZ4K/81tAUSLktb4/
        XfzOb6V40afzuR/CWzbpw8LiBle5bxFQX8vPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gSCcV/hFYEqa7hT55owEKPc/mmjSAdJv
        MNjiy3HP0w1qny9zwibgl3Di2yYS5wO/mPj33qA6oSn8S0pq4TFEtV3o9Ml8iW0j
        Yln+hgDLeLwER1TIHrdKbmBSrX0osbu1p1SxqsPELGItg0LYzkhz/sIugfwBoWmv
        Ouk/fwP5O6c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFBF654746;
        Sat, 10 Dec 2016 13:18:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D6FF54744;
        Sat, 10 Dec 2016 13:18:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 12/16] pathspec: create parse_long_magic function
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
        <1481223550-65277-1-git-send-email-bmwill@google.com>
        <1481223550-65277-13-git-send-email-bmwill@google.com>
        <xmqqwpf8pt0g.fsf@gitster.mtv.corp.google.com>
        <CAGZ79ka0P0rKF8QH3V0jC-O19eT0oaE+fJLGifbfmm3jC_SijA@mail.gmail.com>
Date:   Sat, 10 Dec 2016 10:18:31 -0800
In-Reply-To: <CAGZ79ka0P0rKF8QH3V0jC-O19eT0oaE+fJLGifbfmm3jC_SijA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 9 Dec 2016 15:52:20 -0800")
Message-ID: <xmqqk2b7ps08.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EA2BE34-BF05-11E6-998E-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Jonathan Nieder mentioned off list that he prefers to see that
> series rerolled without mutexes if possible. That is possible by
> creating the questions "struct attr_check" before preloading the
> index and then using the read only questions in the threaded code,
> to obtain answers fast; also no need for a mutex.

I do not see how it would work without further splitting the
attr_stack.  I think you made it per check[], but you would further
split it per <check, thread> before losing the mutex, no?
