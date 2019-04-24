Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 398361F453
	for <e@80x24.org>; Wed, 24 Apr 2019 10:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfDXKgn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 06:36:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63427 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfDXKgl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 06:36:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFD54576C0;
        Wed, 24 Apr 2019 06:36:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QU4im/xCPobO
        OOLsyU3iiNPRWmQ=; b=AVVX6kmrNbSKCLt3SVu0PQmPzAnXtjfWh688FhNfuTRq
        zm89UzaTcowmHyqcwgyvgJebi2/JllGX8VaUUX+4XEdwWHVRhiS2/HLHlaJL9BiB
        a50v4QTZ9LflUWwt2sBHgNwcmQ4w7ye1N7EgleZtSH1HAaiRrrRLYzRBAUjV0pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xOISJy
        g8Q+37VRYkzwlgLm9d9ixeAyOOo7OcvZDsyMf1FJo2nKONJAptC+TbJ3zkfAC1Ka
        cxHhh84hCJYLw/DXw9/GLa8PYgf2IjfdqBvtE/UmWlJv/Ms1mDw/Mqk7Spww+OWz
        PKga42CJlGFx8au5nMzcKD8w8RtF4/6q06w9g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E2E6576BF;
        Wed, 24 Apr 2019 06:36:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BEE23576BE;
        Wed, 24 Apr 2019 06:36:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     a@xkqr.org (Christoffer =?utf-8?Q?Stjernl=C3=B6f?=)
Cc:     git@vger.kernel.org
Subject: Re: Bug: git branch returns EXIT_SUCCESS when no branches found
References: <875zr3iucd.fsf@xkqr.org>
Date:   Wed, 24 Apr 2019 19:36:34 +0900
In-Reply-To: <875zr3iucd.fsf@xkqr.org> ("Christoffer =?utf-8?Q?Stjernl?=
 =?utf-8?Q?=C3=B6f=22's?= message of
        "Wed, 24 Apr 2019 10:13:54 +0000")
Message-ID: <xmqqmukf1yh9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D63F468A-667C-11E9-A9F9-D01F9763A999-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

a@xkqr.org (Christoffer Stjernl=C3=B6f) writes:

> A common use case of git branch =E2=80=93 for me =E2=80=93 is to use it=
 to test whether
> a particular branch satisfies some conditions. A recent example is this=
:
>
>     if ! git branch "$DEV_BRANCH" --contains master; then

This invocation is not in line with how "git branch" subcommand is
designed to work.

The subcommand operates in various modes (like creating a new one,
renaming an existing one, deleting existing one(s)), among which
there is a mode to "list existing ones".  Without an explicit option
on the command line to tell what mode the user wants (e.g. "-d" for
deleting), it defaults to the listing mode, "git branch --list".

The list mode can limit what is listed via different criteria, one
of which is with a pattern that the shown branches must match, e.g.

	$ git branch --list "cs/*"

which shows only the branches whose names begin with "cs/".  It can
also limit the branches whose tip commits can reach a named commit
with the "--contains".

	$ DEV_BRANCH=3Dcs/topic
	$ git branch --contains master "$DEV_BRANCH"

asks the subcommand to show only the branches that can reach the
commit at the tip of 'master', *AND* whose name match cs/topic.  So
it may show the cs/topic branch (and nothing else, even there are
cs/topic1 or cs/topic/2 branches) if and only if that branch
can reach the tip of 'master'.

If you want to ask "does the tip of $DEV_BRANCH reach commit
'master'?", the right way would probably be to ask

	if git merge-base --is-ancestor master "$DEV_BRANCH"
	then
		echo "master is an ancestor of $DEV_BRANCH"
	else
		echo "master has commits not in $DEV_BRANCH"
		git --no-pager log "master..$DEV_BRANCH" --
	fi


