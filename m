Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58FDAD5D
	for <git@vger.kernel.org>; Sat, 25 May 2024 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716617181; cv=none; b=aH94TIPEPYXgp/fmp/9sixtxkRktPRe1RU5eMGgYaqOW2BuKFDEqaPjJm2A5N7FIbsiUaC271DIxBZFSqidZEiPLtOi8FPnmOyE9OJ3K+ZFkzmpU6j7BFQyK3wsA7Ig8Os3osq5qH7BfG3khFtjqXA8idkxhyQkK+GO7/CwT3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716617181; c=relaxed/simple;
	bh=H8QWfz7AaDGKB+d7ih/Ih3cnSXcDZKWZGhJrNmQltls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jy1HpBdmD/FK4bMnL+NKid6+Nxyy34ZYyQi8g5ER4nzdm6IEFH34YHCGsHCixllWmtyvxm4AwQL9iQZGJqJ/8MWJIh6DjGhlspi6ocHo9s4c0YBdUqV2yKhlfoCl5rsO6w/6awr3OwjaB0R7nVt+4DX0gPfG5WOOSoIpqFcHUS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jpFf/6C8; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jpFf/6C8"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3AD302ED81;
	Sat, 25 May 2024 02:06:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H8QWfz7AaDGKB+d7ih/Ih3cnSXcDZKWZGhJrNm
	Qltls=; b=jpFf/6C81C+738Oicy7zhAXBWqHd5hju7HBBsdhba2uZPUaG2y9sJw
	OYXeEkSlqVU7IyGghw8jPVB9Md1fJD9cJKGTliFkn5BxBO09K4G7fw/C8MPqYE5T
	tte+sumGrOv/6/aMvWoF1r1sEewdlTk7GZ+rKKkMDpMCfHLLJSMgk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 348752ED80;
	Sat, 25 May 2024 02:06:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 52D7F2ED7F;
	Sat, 25 May 2024 02:06:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] run-command: show prepared command
In-Reply-To: <20240525012207.1415196-3-iwienand@redhat.com> (Ian Wienand's
	message of "Sat, 25 May 2024 11:20:52 +1000")
References: <20240524073411.1355958-1-iwienand@redhat.com>
	<20240525012207.1415196-1-iwienand@redhat.com>
	<20240525012207.1415196-3-iwienand@redhat.com>
Date: Fri, 24 May 2024 23:06:14 -0700
Message-ID: <xmqqed9qifxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E5A006D4-1A5C-11EF-9A3E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ian Wienand <iwienand@redhat.com> writes:

> +test_expect_success 'tracing a shell alias with arguments shows trace of prepared command' '
> +	git config alias.echo "!echo \$*" &&
> +	env GIT_TRACE=1 git echo argument 2>output &&
> +	test_grep "^trace: start_command:.*" output
> +'

This will succeed even if you have two or more instances of this
log, which will not help you avoid the mistake we saw in an earlier
iteration.

How about making sure that the prepared command looks reasonable
enough and we have only one, by doing something like this?

test_expect_success 'tracing a shell alias with arg shows trace of prepared command' '
	cat >expect <<-EOF &&
	trace: prepare_cmd: SHELL -c ${SQ}echo \$* "\$@"${SQ} ${SQ}echo \$*${SQ} arg
	EOF
	git config alias.echo "!echo \$*" &&
	env GIT_TRACE=1 git echo arg 2>output &&
	# redact platform differences
	sed -n -e "s/^\(trace: prepare_cmd:\) .* -c /\1 SHELL -c /p" output >actual &&
	test_cmp expect actual
'

A sample run of CI job with the above change (and others I sent on
the list) can be seen at:

    https://github.com/git/git/actions/runs/9233329671

You can fetch 'seen' and can find commit 05ebf54569, which is the
tip of your topic including a few "fixup" commits I made on top.

  $ git log --decorate --oneline master..05ebf54569
  05ebf54569 (iw/trace-argv-on-alias) fixup! run-command: show prepared command
  11056975bb fixup! run-command: show prepared command
  770dda8f2b run-command: show prepared command
  242b9d4d63 Documentation: alias: add notes on shell expansion
  e4331ad0d4 Documentation: alias: rework notes into points

It hasn't finished running yet, but all the windows tests have
passed, so I'll happily go to bed now ;-)

Thanks.
