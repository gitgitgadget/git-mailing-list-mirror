Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C11A7202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 05:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbdKUFoH (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 00:44:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59797 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750794AbdKUFoH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 00:44:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B6F4AA10A;
        Tue, 21 Nov 2017 00:44:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F7+TvG7CwpKc7DP4lOVCRUI+j7w=; b=LK9eKi
        UxJpqUkgMLEdHBkhg+PEO4uHBhGFnxK1jGa2T/0Ghtm0+xqpoLLvgWtREUwBmEGo
        gbQGq7tgBNFw2ZpG72C8yX2nAmeoIP1pIgpWjKur53VGX5lK/TrlonzPqlheL/Cd
        Si3BqxNa6Q1f/JoIyu61l9BGZfKDPiw2gXmhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wz4MViz/7UTgDC80Omx0wZiaAibBLsBQ
        DjLbh2U5/epeKMm1nxI3b6AjzJI/vIef2OTtWbWoCE6u+GRPbS5Pv1qj0Ru6prU7
        SLHCsRixxdIPZxrDehN9Byd4ZTZoHzzWXAn5yUyTRxDLI91Nocnr6QjRXoluv30C
        hEniI+iVbk0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64033AA109;
        Tue, 21 Nov 2017 00:44:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8991AA107;
        Tue, 21 Nov 2017 00:44:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vladimir Nikishkin <lockywolf@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: core.safecrlf warning is confusing[improvement suggestion?]
References: <CA+A2iZaLZCMvyb3nbcn=ofVGAPeW2_wRhjOeRRu5q01LuV++Gw@mail.gmail.com>
Date:   Tue, 21 Nov 2017 14:44:04 +0900
In-Reply-To: <CA+A2iZaLZCMvyb3nbcn=ofVGAPeW2_wRhjOeRRu5q01LuV++Gw@mail.gmail.com>
        (Vladimir Nikishkin's message of "Tue, 21 Nov 2017 13:18:30 +0800")
Message-ID: <xmqqo9nwi3tn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCB4F95A-CE7E-11E7-B3DB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vladimir Nikishkin <lockywolf@gmail.com> writes:

> So I put the source in the working directory and tell git to make
>
> git diff --stat
>
> and I see the (ambiguous) warnings:
>
> 'warning: LF will be replaced by CRLF in filename.m.
> The file will have its original line endings in you working directory.'
>
> How I read them: "even though you have core.autocrlf=true, LF will be
> replaced by CRLF and the repository will store CRLF files. However,
> after you checkout them again, the CRLFs will be converted back to
> LF(because the files will have original line endings in the working
> directory.)"
>
>  I feel like it's the opposite of what is actually happening.
>
> So, would it make sense to change the warning message to? :
>
> 'warning: When you next checkout this commit, your code will have CRLF
> line endings. However, right now your files will not be altered.'

I actually think "git diff" should not be triggering the warning
message.  The message may be appropriate when you are doing "git
add", at which point the "will be replaced and that may not be what
you want to see" warning might apply, but "diff" is doing a read-only
thing and will not be replacing anything with any other thing.
