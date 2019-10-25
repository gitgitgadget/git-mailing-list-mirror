Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765BB1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390571AbfJYCqD (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:46:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52262 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfJYCqD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:46:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4898797123;
        Thu, 24 Oct 2019 22:46:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4V14ncbU7JBg
        gEOLzhCzMvWBYEc=; b=rKRGjeG+WHu42MEyxsiPWDpcF8udRjm5O+EtGaRkXXaT
        32K7/5IXB98EH5RAZdbhfNcn7pc/YHRE/feHLL59bBq4XlgHBxqlNHeznG5LC85Z
        4DbaLCTeRKYAIo5yCMKACy6NbNW6iLF2F+W3Y3XQYvkvrDVTtsDZIVNsu+zeESU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LZi6o6
        BrH8Ewo5LYWcN8NNulMZthc8JpflQcoZEuZZB803IKkc//Eu2KhsyZDQ50i4dFyn
        hXaWyIlkUjwevHt3WEV75fipM1JSuFu7HavWYv9EDYPg9l7cgobhZh7jrSnH8+Cq
        u67Oi2vjFQqvWQ4ridpMCEBRhCRdpXwOgyYGk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41B0897122;
        Thu, 24 Oct 2019 22:46:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 718EC97120;
        Thu, 24 Oct 2019 22:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and `is_directory()`
References: <20191024092745.97035-1-mirucam@gmail.com>
        <20191024114148.GK4348@szeder.dev>
Date:   Fri, 25 Oct 2019 11:45:56 +0900
In-Reply-To: <20191024114148.GK4348@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Thu, 24 Oct 2019 13:41:48 +0200")
Message-ID: <xmqqmudpee57.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 92E86282-F6D1-11E9-B4A2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> The first callsite is:
>
>     dest_exists =3D dir_exists(dir);
>     if (dest_exists && !is_empty_dir(dir))
>             die(_("destination path '%s' already exists and is not "
>                     "an empty directory."), dir);

Yup.  The primary/original reason why the helper exists is to see if
we can create directory there, so the function is asking "is this
path taken?"  It might have been cleaner to do all of these without
using such a helper function and instead take the safer approach to
"try mkdir, and if we fail, complian", which is race-free.  But the
above is what we have now X-<.

