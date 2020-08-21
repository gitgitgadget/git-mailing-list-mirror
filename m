Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7623CC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC8F206DA
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mr3qgITB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgHUQrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:47:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55779 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgHUQq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 12:46:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B4C98508E;
        Fri, 21 Aug 2020 12:46:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xbUhXa6+1c+CZHI1y5dKTq6qE8I=; b=Mr3qgI
        TBG+L0UKXZC+bGvhpSjfaI4tpnV5DvpKcoMbvkhctAwHzgEJ5IqmGf4s0aGeorrO
        lq7JZjHEMy1lK1CWv1+uBG5U4c3vRUv8S1svkMkSCUJhIQoBTjft7GXgy2SVULoC
        vLYysjgK3t1vxSXyVuKlV1lFhqp4kZzAyAXFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SQbiZrLmpp/C3FeF+tVFo5Szn7On2U0h
        SCfyWrQS8aBaevkH/+f9NmoR1DwyOoY9T0wSOEYbWRdSM9dXKkVGbSRwaMHXikYq
        O5VZtBNSRiy+srGe7P3LT7xhDQkEvI9FSRru5v5+NZA/KS4bBIYV8rIUo7Mhyml8
        IXlpY4Yz2rI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 740DB8508D;
        Fri, 21 Aug 2020 12:46:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00C338508C;
        Fri, 21 Aug 2020 12:46:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     voxspox <voxspox@gmx.net>
Cc:     git@vger.kernel.org
Subject: Re: gitignore does not ignore wildcard directory if it is a link
References: <0179b688-576b-7423-8824-9b57fe8f92fc@gmx.net>
Date:   Fri, 21 Aug 2020 09:46:55 -0700
In-Reply-To: <0179b688-576b-7423-8824-9b57fe8f92fc@gmx.net> (voxspox@gmx.net's
        message of "Fri, 21 Aug 2020 15:37:15 +0200")
Message-ID: <xmqqa6yo9cao.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC487738-E3CD-11EA-9A0C-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

voxspox <voxspox@gmx.net> writes:

> /somefile1
> /test/dir1  (directory)
> /test/dir2  (link to directory)
> /test/dir3  (link to directory)
> /test/file1
>
> I want to ignore all subfolders in "test", thus I modified my .gitignore to:
>
> /test/*/
>
>
>> git status
>
> Untracked files:
>   test/dir2
>   test/dir3
>
>
> Putting "/test/dir3" into .gitignore will work fine.
>
>
> -> It seems that directories are not ignored by a wildcard pattern if
> the directory is a link

This is working as designed, intended and expected, I would think.
Git does track symbolic links as the first-class citizen, and dir2
and dir3 in the above example are *not* directories.
