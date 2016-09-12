Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5491207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 21:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbcILVYE (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 17:24:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59608 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751936AbcILVYD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 17:24:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C1303E07B;
        Mon, 12 Sep 2016 17:24:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+mZ7qXASJx7Xsn2GcY51u7Iun0Q=; b=wa1+Hg
        VNNm4kuQRvBaLdHZCalHdl+h4ZXTukIdOPBMdumFux3sWiAc7YprM3kXYdpcbuQl
        HuYIAV+xuxhX09rpEizdaCG1jfG/RW1xLkr2GdAs0Ce9UTPOC+ePWMIZwEsKLHXv
        r7Rm0nyFO0rdA4gL1XUWIjeZLjz7a1l8SXjZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o369Cah7Wm29IqxZiesMwXY+1IE+13e4
        lgxNyLiEYvbOFan/nYuzl6zxK4BgpNA1m9k2Y9NVgKWB4AwHCFvXEQtQ+HRoOJOW
        dbciarSX3ghGTu7hnfhrRGcYAixe/P1tMTuamMb9E4ErRCpLz2P7l+Hh5+e2laQZ
        6MamEkCBjIE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 311493E07A;
        Mon, 12 Sep 2016 17:24:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 166153E078;
        Mon, 12 Sep 2016 17:24:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 19/25] sequencer: remember do_recursive_merge()'s return value
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <44c455710fd9c420a3f759d021c4864f3a83c97a.1473590966.git.johannes.schindelin@gmx.de>
Date:   Mon, 12 Sep 2016 14:23:58 -0700
In-Reply-To: <44c455710fd9c420a3f759d021c4864f3a83c97a.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:55:41 +0200
        (CEST)")
Message-ID: <xmqqh99kzua9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 392DBE5E-792F-11E6-B1B7-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The return value of do_recursive_merge() may be positive (indicating merge
> conflicts), so let's OR later error conditions so as not to overwrite them
> with 0.

Are the untold assumptions as follows?

 - The caller wants to act on positive (not quite an error), zero
   (success) or negative (error);

 - do_recursive_merge() can return positive (success with
   reservation), zero or negative, and the call to it would return
   immediately if it got negative;

 - all other functions that come later may return either zero or negative, and 
   never positive;

 - Hence the caller can be assured that "res" being positive can
   only mean do_recursive_merge() succeeded with reservation and
   everything else succeeded.

This can be extended if the only thing the caller cares about is
positive/zero/negative and it does not care what exact positive
value it gets--in such a case, we can loosen the condition on the
return values from other functions whose return values are OR'ed
together; they may also return positive to signal the same "not
quite an error", i.e. updating the latter two points to

 - all other functions that come later can return positive (success
   with reservation), zero or negative.

 - Hence the caller can be assured that "res" being positive can
   mean nobody failed with negative return, but it is not an
   unconditional success, which is signalled by value "res" being
   0.

I cannot quite tell which is the case, especially what is planned in
the future.  The proposed log message is a good place to explain the
future course this code will take.

> This is not yet a problem, but preparing for the patches to come: we will
> teach the sequencer to do rebase -i's job.

Thanks.
