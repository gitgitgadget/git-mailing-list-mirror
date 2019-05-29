Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE3E1F462
	for <e@80x24.org>; Wed, 29 May 2019 18:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfE2SBm (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 14:01:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60545 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2SBm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 14:01:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC28214D778;
        Wed, 29 May 2019 14:01:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ypoKuy3on2bro9H65rB6DeO1yHg=; b=RXxOZD
        WCcoFAovWLTsVY1NoByhbUQ6Qwzm3Sw1Yl7RbpjU2V4GCFO6kpjmjzte40bs6tmK
        7JvKkmN66nZK0pDqXlnnEmatZy1/bmmLOCwQ0O36Lp6lEtdPzyAZ9KtkD4THlCHv
        2Y9WTT+8SdXIX8aPyX/Q7Qhm7aUEdIs30/Jk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JOCwsCIF0y/ae3K2ra9q8PHToPm6DGOj
        QuIdccgK/8SwgpMX9wYmTPTiw5sg+VPEDbNPQJK7bjdjG6zBUANnoCvwsaKxr6d0
        zfb5iYSiKV+C+j8vcj1jyeJ3yO742+aL+YOoK7Vfb4pDcqhzqs4oHNHAG3Y7jzv6
        IOLoqcRdXx8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4AA914D777;
        Wed, 29 May 2019 14:01:39 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49A8014D775;
        Wed, 29 May 2019 14:01:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     <git@vger.kernel.org>
Subject: Re: Q: git describe --always --tags .. gives "warning: tag 'tag1' is really 'tag2' here"
References: <5CEE38B4020000A1000317C6@gwsmtp.uni-regensburg.de>
Date:   Wed, 29 May 2019 11:01:38 -0700
In-Reply-To: <5CEE38B4020000A1000317C6@gwsmtp.uni-regensburg.de> (Ulrich
        Windl's message of "Wed, 29 May 2019 09:45:56 +0200")
Message-ID: <xmqqd0k1ywal.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEA5902A-823B-11E9-A134-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:

> So I got the response:
> warning: tag 'isredir-0.3.0' is really 'iredir-0.3.0' here
> isredir-0.3.0-3-gaf467c7

I suspect that "git cat-file tag isredir-0.3.0" would begin like

	$ git cat-file tag iredir-0.3.0
	object .....
	type commit
	tag isredir-0.3.0
	tagger ...

Notice that "tag" line records the true name of that tag, which does
not match where you stored that tag in refs/tags/ hierarchy?

While trying to describe af467c7 by following its ancestry and
finding the ancestor three generations ago, the command found
refs/tags/iredir-0.3.0 and then noticed that discrepancy, which is
what the warning is about.

Imagine you have only v1.0.0 (which is with known issues) but
somebody did "cd .git/refs/tags && mv v1.0.0 v1.1.0" in an attempt
to fool you.  The fact that your 'master' is a bit ahead of the
commit that was tagged with the tag object (which is v1.0.0 but
pretending to be v1.1.0) can be seen with "describe", but the
command is careful enough to use the real version number
(i.e. v1.0.0) and not the refname (i.e. v1.1.0).




