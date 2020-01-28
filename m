Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE91C33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C766120716
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rJ1myVzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgA1S3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:29:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51966 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgA1S3C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:29:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8719BE8FD;
        Tue, 28 Jan 2020 13:29:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pG3ru6EXTYDrRoLmOqNN8HvaMZ4=; b=rJ1myV
        zWqdlqlnFW7rW1M/Zu8NMmP7ohyhjjErFSGjLHUc5fZSOk0ozpfsB6ynumTeiWyE
        QtfMPeP+MJ8Z/v2MEztR6QOjuj52GWXB6tItqM2WTvS6amotngndzdiySz2hr4G/
        R4GRfjMKIdpgGHyuvxAvBQO9k1eKhyEf8VlJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W4laipNOqD3byze79pnlCca6/dtsR+Yb
        jhXB4vCpyZDpkYFqkuM4ARjbV706xtZ+rYEPzJbMwtA0HiB6aY+8fPsA881tn2wU
        BUld+ElUD+IADEE+1BXmqTKdT5YBY/oaDLpSZUFMuQVAeXCWhLx6PzyLEQp5boTV
        NCQQsQq+jHw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1C4ABE8FC;
        Tue, 28 Jan 2020 13:29:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DAF45BE8F8;
        Tue, 28 Jan 2020 13:28:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 15/22] t5515: make test hash independent
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
        <20200125230035.136348-16-sandals@crustytoothpaste.net>
Date:   Tue, 28 Jan 2020 10:28:55 -0800
In-Reply-To: <20200125230035.136348-16-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 25 Jan 2020 23:00:21 +0000")
Message-ID: <xmqqk15b8mfs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C1E6D66-41FC-11EA-A617-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +convert_expected () {
> +	file="$1" &&
> +	for i in one three_file master master2 one_tree three two two2 three2
> +	do
> +		sed -e "s/$(test_oid --hash=sha1 "$i")/$(test_oid "$i")/g" \
> +			"$file" >"$file.tmp" &&
> +		mv "$file.tmp" "$file"
> +	done
> +}

Perhaps we can avoid rewriting the same file that many times, by
feeding the mapping to a single invocation of sed?  E.g.

	sedScript=
	for i in one three_file master master2 one_tree three two two2 three2
	do
		i="s/$(test_oid --hash=sha1 $i/$(test_oid $i)/g"
		sedScript=$sedScript${sedScript:+;}$i"
	done &&
	sed -e "$sedScript" "$file" >"$file.new" &&
	mv "$file.new" "$file"

If somebody's "sed" does not like multiple command concatenated with
";", we can take advantage of the fact that we are just replacing
hexadecimal string without anything funny and go eval, e.g.

	sedCmd="sed"
	for i in one three_file master master2 one_tree three two two2 three2
	do
		sedCmd="$sedCmd -e s/$(test_oid --hash=sha1 $i/$(test_oid $i)/g"
	done &&
	eval "$sedCmd" "$file" >"$file.new" &&
	mv "$file.new" "$file"

