Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC6C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 23:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbhLMXfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 18:35:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56978 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242230AbhLMXfC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 18:35:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 002F415F168;
        Mon, 13 Dec 2021 18:35:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BE35RYy/dotmMWq0X2BE4EuMJcS8Khc/uf3Yd6
        idKj4=; b=d/1RxFasIzW58eEO7jyIE5741MfgJVUN3E0WdLH3xlxXAY5qg3IKs/
        HVj5bdTgl+DC6wXCtEedzjQN0svpwqycr72H58WY1pFbMB2rGeuhMAVCcX7sSEvy
        /+MI1pXzbUMPvZbIt1ZWeyN3c8NyEI+DopgHyJWXw08T1as2/gbrY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E355415F167;
        Mon, 13 Dec 2021 18:35:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3ABC415F164;
        Mon, 13 Dec 2021 18:34:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH 4/4] git-p4: resolve RCS keywords in binary
References: <20211213225441.1865782-1-jholdsworth@nvidia.com>
        <20211213225441.1865782-5-jholdsworth@nvidia.com>
Date:   Mon, 13 Dec 2021 15:34:56 -0800
In-Reply-To: <20211213225441.1865782-5-jholdsworth@nvidia.com> (Joel
        Holdsworth's message of "Mon, 13 Dec 2021 22:54:41 +0000")
Message-ID: <xmqqzgp484f3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48B3B316-5C6D-11EC-8000-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

> RCS keywords are strings that will are replaced with information from
> Perforce. Examples include $Date$, $Author$, $File$, $Change$ etc.
>
> Perforce resolves these by expanding them with their expanded values
> when files are synced, but Git's data model requires these expanded
> values to be converted back into their unexpanded form.
>
> Previously, git-p4.py would implement this behaviour through the use of
> regular expressions. However, the regular expression substitution was
> applied using decoded strings i.e. the content of incoming commit diffs
> was first decoded from bytes into UTF-8, processed with regular
> expressions, then converted back to bytes.
>
> Not only is this behaviour inefficient, but it is also a cause of a
> common issue caused by text files containing invalid UTF-8 data. For
> files created in Windows, CP1252 Smart Quote Characters (0x93 and 0x94)
> are seen fairly frequently. These codes are invalid in UTF-8, so if the
> script encountered any file containing them, on Python 2 the symbols
> will be corrupted, and on Python 3 the script will fail with an
> exception.

Makes sense, and I am with others who commented on the previous
discussion thread that the right approach to take is to take the
stuff coming from Perforce as byte strings, process them as such and
write them out as byte strings, UNLESS we positively know what the
source and destination encodings are.

And this change we see here, matching with patterns, is perfectly in
line with that direction.  Very nice.

>          try:
> -            with os.fdopen(handle, "w+") as outFile, open(file, "r") as inFile:
> +            with os.fdopen(handle, "wb") as outFile, open(file, "rb") as inFile:

We seem to have lost "w+" and now it is "wb".  I do not see a reason
to make outFile anything but write-only, so the end result looks
good to me, but is it an unrelated "bug"fix that should be explained
as such (e.g. "there is no reason to make outFile read-write, so
instead of using 'w+' just use 'wb' while we make it unencoded
output by adding 'b' to it")?
