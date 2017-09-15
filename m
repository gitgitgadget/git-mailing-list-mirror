Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8AE820286
	for <e@80x24.org>; Fri, 15 Sep 2017 06:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbdIOGuj (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 02:50:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64427 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751152AbdIOGui (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 02:50:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0E1B8F8CD;
        Fri, 15 Sep 2017 02:50:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/X6YuVqqsOmzkn3qQfTEG3mWIlQ=; b=ikRhaf
        Q4BAfvE04fMwSJ5m+wZs+VBzQjNL+lPr5R71iDPHwTKYH0wdUawhEZ2W8oT0/OLp
        pbS0nHs9sHqKgNAX/k7V5bqN96RUjjaaxmO7KiqGJD6v8sMeAaXWoYt3J438BItY
        D/SYx+2sDNeuNeIMQi/+vpCkV32dwT+0ExYDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s6jjteN827SxjxpOhwBoJ1Fv4ZXZSP65
        NwNqvebSpcEVDIDRmHizq0asjmbNZoWbec42NzOzEctYAd/0YtcaD3fJGROYeUXa
        YsgU7UCjaA+0SbPlRwfwIMhpctE2ZwvjRm6xlKw0luBB9C1h8ifaZyLsFwZc69DX
        QpfMjTnhmNw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A88E28F8CC;
        Fri, 15 Sep 2017 02:50:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B2EF8F8CB;
        Fri, 15 Sep 2017 02:50:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley Smith <wsmith@greatergiving.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Is finalize_object_file in sha1_file.c handling errno from "rename" correctly?
References: <c9b3bc17110048f0b7943704cfbd8f68@APEXC04.auctionpay.com>
Date:   Fri, 15 Sep 2017 15:50:35 +0900
In-Reply-To: <c9b3bc17110048f0b7943704cfbd8f68@APEXC04.auctionpay.com> (Wesley
        Smith's message of "Fri, 15 Sep 2017 06:18:13 +0000")
Message-ID: <xmqq4ls4xxok.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DF25250-99E2-11E7-9706-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wesley Smith <wsmith@greatergiving.com> writes:

> 1) This bug is triggered because "git fetch" is causing a pack
> file to be written when that same pack file already exists.  It
> seems like this is harmless and shouldn't cause a problem.  Is
> that correct?

The final name of the packfile is derived from the entire contents
of the packfile; it should be harmless when we attempt to rename a
new file, which has exactly the same contents as an existing file,
to the existing file and see a failure out of that attempt.

> 2) It seems that finalize_object_file is not accounting for the
> fact that "link" will return EEXIST if the destination file
> already exists but is not writeable, whereas "rename" will return
> EACCESS in this case.  Is that correct?  If so, should
> finalize_object_file be fixed to account for this? Perhaps it
> should check if the newfile exists before calling rename.  Or,
> should the Windows mingw_rename function be modified to return
> EEXIST in this case, even though that's not the standard errno for
> that situation?

The codepath that is triggered by OBJECT_CREATION_USES_RENAMES ought
to behave correctly even on non-Windows platforms, so bending the
error code of rename() only on Windows to fit the existing error
handling would not be a smart thing to do.  Rather, the rename()
emulation should leave a correct errno and the caller should be
updated to be aware of that error that is not EEXIST, which it
currently knows about.

Thanks for spotting a problem and digging to its cause.

This is a #leftoverbits tangent, and should be done separately from
your "OBJECT_CREATION_USES_RENAMES is broken" topic, but I think it
is a bug to use finalize_object_file() directly to "finalize"
anything but an individual loose object file in the first place.

We should create a new shared helper that does what the function
currently does, make finalize_object_file() call that new shared
helper, and make sure finalize_object_file() is called only on a
newly created loose object file.  The codepath that creates a new
packfile and other things and moves them to the final name should
not call finalize_object_file() but the new shared helper instead.

That way, we could later implement the "collision? check" alluded by
the in-code comment in finailize_object_file(), and we won't have to
worry about affecting callers other than the one that creates a
loose object file with such an enhancement.

