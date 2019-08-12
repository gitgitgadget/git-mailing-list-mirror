Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8931F45C
	for <e@80x24.org>; Mon, 12 Aug 2019 15:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfHLPyk (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 11:54:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56945 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfHLPyj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 11:54:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA443166857;
        Mon, 12 Aug 2019 11:54:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GNw9o1DaSIyAgvwoPYlcVVXTUOc=; b=G1SEhX
        c1C231TyMX7TCsVTQdsqPvCwCnCX4Pwqi4DFMV0tN5lsDRrutCIarArIcn3MURYO
        e4NzO2L4DHcvBLmyUojnUUDWVEn6TJLsd90OOksUz28tGE3fJVqCiNE2g9QH+U90
        Exu2OnvaLvMJOpuGPb13E37MSchlSJCUgF9oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p/uQ16Cl6mTAjXXCftlQNPDUQ49R4yjG
        518DlRuGn4YP0h8o8g7f9cd3LF1+z7giyAR2J15TrfI/VR9jLdF0q9SOXEIz8Uxh
        ucspmTck9OG1IJQwCJ6/isB1Y0+KjMxSQZmX7/wLQ7+tfXzPWq0LGL9D6qutwSuq
        dL3Q7WHDe70=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D71C166856;
        Mon, 12 Aug 2019 11:54:37 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5271166855;
        Mon, 12 Aug 2019 11:54:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Gregory Szorc'" <gregory.szorc@gmail.com>, <git@vger.kernel.org>
Subject: Re: Non-robust lock files in containers can lead to repo corruption
References: <qimq0i$49gn$1@blaine.gmane.org>
        <003901d55114$9428df40$bc7a9dc0$@nexbridge.com>
Date:   Mon, 12 Aug 2019 08:54:35 -0700
In-Reply-To: <003901d55114$9428df40$bc7a9dc0$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 12 Aug 2019 09:48:04 -0400")
Message-ID: <xmqqk1bibcqs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C4F3056-BD19-11E9-9FE1-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>> The lock design of gc.pid stores the current hostname and PID of the locking
>> process in the file. If another process comes along and its hostname matches
>> the stored hostname, it checks to see if the listed PID exists. If the PID is
>> missing, it assumes the lock is stale and releases the lock.

The assumption that <hostname, pid> pair can be used to identify
running process (until the pid wraps around and gets reused) does
not sound particularly limited Git.  Don't container folks solve it
without touching individual applications?  For example, is it a
viable option to isolate UTS namespaces (CLONE_NEWUTS) in addition
to PID namespaces (CLONE_NEWPID)?
