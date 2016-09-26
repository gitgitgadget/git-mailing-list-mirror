Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAC8E207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 18:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162156AbcIZSK7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 14:10:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51377 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1161770AbcIZSK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 14:10:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEEC44161F;
        Mon, 26 Sep 2016 14:10:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=btf8f5jbhhC8HxY+zi8TcAcBW9c=; b=eOfRxv
        WgQ3b+OzgT54FFMU24gUUZB0rRZmVCV6Uz0dRtlKIqkwioE1XpkHGH47X8GKCnFy
        4MX0Yesj4a42RRbjuuq6zpwCZhC/QnkNROnFpfGUTSGgr6g06g6YnlISpoVXmy68
        S5EqU7kmFEsaBB2eUMlocWuIoLuubZlauLE+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lmHPodce6LybUVYVJGwXcQrRpjC78a73
        IvfMtEFOB9IiQb4GefC+wQJWMvcltU9uPWwf/WQy8JtfjqgUlgGSdEolxUQDbmr7
        2zwvEmz35dFU04YCujfZ1y/Rz7Z/X/MmcLoZERlyKRsbvadrDRdZMpuiWDpgd1tf
        FQgWg7hidOU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D67404161E;
        Mon, 26 Sep 2016 14:10:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 513CE4161C;
        Mon, 26 Sep 2016 14:10:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gustavo Grieco <gustavo.grieco@imag.fr>
Cc:     git@vger.kernel.org
Subject: Re: Stack read out-of-bounds in parse_sha1_header_extended using git 2.10.0
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
        <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
        <790613313.8353074.1474912139102.JavaMail.zimbra@imag.fr>
        <xmqq37kmtukf.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Sep 2016 11:10:54 -0700
In-Reply-To: <xmqq37kmtukf.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 26 Sep 2016 10:55:12 -0700")
Message-ID: <xmqqtwd2sf9t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91E7679E-8414-11E6-BD48-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am inclined to say that it has no security implications.  You have
> to be able to write a bogus loose object in an object store you
> already have write access to in the first place, in order to cause
> this ...

Note that you could social-engineer others to fetch from you and
feed a small enough update that results in loose objects created in
their repositories, without you having a direct write access to the
repository.

The codepath under discussion in this thread however cannot be used
as an attack vector via that route, because the "fetch from
elsewhere" codepath runs verification of the incoming data stream
before storing the results (either in loose object files, or in a
packfile) on disk.

