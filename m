Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D36C20A40
	for <e@80x24.org>; Sun,  3 Dec 2017 06:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbdLCGFg (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 01:05:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56865 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750718AbdLCGFf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 01:05:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD037BB08C;
        Sun,  3 Dec 2017 01:05:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eyX7i6BLBbEtpdugMpVyONvl/90=; b=sTHRe5
        llQwyYdUdN1coml0W/duJj9vl/w8YkNRyFeJTAijjQjijd+Bmi5phQb8lm/H0IlQ
        hs8eCCVb0YSGIjfpW0BK3Y2qJGSpyPAaY97iz26sabrYzXFBbhrhe++VjRotuL4w
        bOAZCmByUPiO390g0y9mxrb2eCucKl/84SV60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=igKF2Sa3MOMpJofoCsobqh3qD2PSF9eG
        JNIhm/9wwvrySMGb1B1r02M0F8qG5WOABvZaBYx4sLyRA+GyijXQgnEXvqopH5hL
        kG4RaPVAPf5AHk2ESf1ZWiV44jKsKKGxwKW0qPOTlg83+BdclEOJCFhbtqCn6CHT
        687wUDd3t6I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B584ABB08B;
        Sun,  3 Dec 2017 01:05:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2DD97BB08A;
        Sun,  3 Dec 2017 01:05:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Shikher Verma <root@shikherverma.com>, git@vger.kernel.org,
        santiago@nyu.edu, sbeller@google.com
Subject: Re: [PATCH] Add a sample hook which saves push certs as notes
References: <xmqqtvzzqt5u.fsf@gitster.mtv.corp.google.com>
        <20171202091248.6037-1-root@shikherverma.com>
        <20171203004543.GO3693@zaya.teonanacatl.net>
Date:   Sat, 02 Dec 2017 22:05:32 -0800
In-Reply-To: <20171203004543.GO3693@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Sat, 2 Dec 2017 19:45:43 -0500")
Message-ID: <xmqq609ojqhf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F98D9442-D7EF-11E7-92A9-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> (I also noticed the tests which use $GIT_PUSH_CERT, like t5534, use
> 'cat-file blob ...' rather than 'cat-file -p ...'.  I don't know if
> that's much safer/better than letting cat-file guess the object type
> in the hook.

The '-p' option is meant for human consumption and we promise that
the output from it _will_ change if it makes sense at the UI level.

In a script like this, you do care about the exact byte sequence.
So that is a more important reason why you should say "blob" not
"-p".

>> +	# Verify that the ref update matches that in push certificate.
>> +	if [[ $push_cert == *$oval" "$nval" "$ref* ]]; then

I am not sure what this expression is trying to do in the first
place.  The contents of the push certificate blob may contain these
three values, but has a lot more than that.

A post-receive is run after all the receive processing is done, so
its failing cannot abort the transfer.  I wonder how an almost
simultaneous push to a same ref, that would not fail normally
without this new hook script, would behave.  One receive updates the
tip from A to B and then starts running this script, while the other
receive updates the tip from B to C and then starts running another
copy of the script.  They both wants to update the notes database
but there can be only one winner in the race for its tip.  

What happens then?  Don't we need to be running a script like this
from a hook mechanism that runs under a lock or something?
