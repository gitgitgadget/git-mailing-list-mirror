Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B4A14A619
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537305; cv=none; b=byBLq4gJQyaFr6ACAfHzbDaU6i1Fl9acp2NTnUe1QqKX4cjNAJSqH4KctdsQ3VVykJgYA05smal+VOK58xM8MPxAJIP9GSysR59GLU93XUxTULy/5KsPVZ4LdTivWxLBJewO960+d4X1sLXD1XRG8Os+K0zrJMOiIRzOkajj9is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537305; c=relaxed/simple;
	bh=PiXVQLq24jSLcKBueDp04XZciIx7xDvQrlx8gT/9/AQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pR98XaZ3u+PltnfP119X4wKnfE8V+yGDzAUYEW74TtOOkjPyAhCKAOHSwjfwws3g5ipmxRrrAIwUEeiG9cky08BQCkBuVt4AMVIb64NAxp94gjCbWid9QNAlwsh2c9caq8CrthRdOCifHtURPVnrd+Ziprxvpc0aY0EKe+bp82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OPwP0wr3; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OPwP0wr3"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB8DC2B7E6;
	Thu,  1 Aug 2024 14:35:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PiXVQLq24jSLcKBueDp04XZciIx7xDvQrlx8gT
	/9/AQ=; b=OPwP0wr3rsZ6SPh4OaNyCgkRGIL9upCpPdo7Ch71UKAoCXspHWWiM/
	fCIKfb21CGtUFxdeRfhf5uZDJK7qQibCW1JAjuCv5ML3VIRTjk9EecJZfjQPhV6K
	wUjSurgjSz9KD4zEvIJvly9gy9JQyNudhHwScX4d0mGVktlhsyHdE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68B352B7E4;
	Thu,  1 Aug 2024 14:35:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D7922B7E3;
	Thu,  1 Aug 2024 14:35:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [Bug] Temp file use in t0018.6
In-Reply-To: <02d401dae43e$c076b000$41641000$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Thu, 1 Aug 2024 14:15:07 -0400")
References: <02d401dae43e$c076b000$41641000$@nexbridge.com>
Date: Thu, 01 Aug 2024 11:34:59 -0700
Message-ID: <xmqqbk2cum5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C2748456-5034-11EF-9AAF-34EEED2EC81B-77302942!pb-smtp1.pobox.com

<rsbecker@nexbridge.com> writes:

> In the 2.46.0 test suite on NonStop I'm getting the following surprise
> error:
>
> expecting success of 0018.6 'advice should be printed when GIT_ADVICE is set
> to true':
>         q_to_tab >expect <<-\EOF &&
>         On branch trunk
>
>         No commits yet
>
>         Untracked files:
>           (use "git add <file>..." to include in what will be committed)
>         QREADME
>
>         nothing added to commit but untracked files present (use "git add"
> to track)
>         EOF
>
>         test_when_finished "rm -fr advice-test" &&
>         git init advice-test &&
>         (
>                 cd advice-test &&
>                 >README &&
>                 GIT_ADVICE=true git status
>         ) >actual &&
>         cat actual > /tmp/actual &&
>         test_cmp expect actual

Sheesh.

We should *not* be assuming what is in /tmp.  Our TMPDIR may not
even be set to point at /tmp.  Anybody can create directory 'actual'
there and break this test.

I thought this was a left-over debugging copy while reviewing the
patch, and I thought I had pointed it out to the author and/or I
removed it while queuing it.  The copy to /tmp/actual with cat
should be removed.

Thanks for noticing.  Are there other reference to /tmp in our test
suite I have to wonder...

