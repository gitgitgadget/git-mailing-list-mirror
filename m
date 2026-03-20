Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447A337472F
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010101; cv=none; b=f6Ems1Pa24PfSaG50Llhh2oGp3ULO0QMmKtbrlTGn4w922NTlWYyyKQNXxMyR8+rGt2ToDwxHDn0sXp95OFch5ks7IaJNVU4d32yWCh6YmR6iDjk1RQB3yWspuN59ZFAUvFXbG1/vMs2sC5eJIU9LOmJJTgrMAQT6E8dlU7Qb10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010101; c=relaxed/simple;
	bh=4HtPxN8UbOp0So4VuypQlUMUwsPzcqLkN3vAREQ88ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gdZA+ym8wxRCVoxEmjVdWUtumMwKF5pb+QYG/kMHrIRoWCBN5/XYlZZB0ZJfRTD6BZWAmisQ6rqNUSDAZ53n8FkR0Ji/sKHuwtc/HuoxjoDQyhMHIamqNwl0blygRt/DpjG4ftpBO82teMlGz4WzcP5kuRbzirBwptkvforDDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=z03b5NZB; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="z03b5NZB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774010096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NlDjPcjYsa8NSCnpbxbCh5YByXN8Lf5V++RTeajN9wg=;
	b=z03b5NZBjEqxB3nbpZ8DXakSpLf4HM4djx+e0PMmuF7h5U9lAJkIrNLv5lS1K0uhu7/3/T
	NUDV2ntq0ZfDhEreQbvf3Zf+xNZAM0913OnSfhlNl1tF59a3cTRZ7uISer4LoF5X7IcArp
	LBCS8B9QUH3TXXYET5v0MEeF7G3EqvU=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>, Junio C Hamano
 <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 6/8] git-compat-util.h: move warning infra to prepare
 for PCHs
In-Reply-To: <20260319-b4-pks-build-infra-improvements-v3-6-82f5fb3edc3f@pks.im>
References: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
 <20260319-b4-pks-build-infra-improvements-v3-6-82f5fb3edc3f@pks.im>
Date: Fri, 20 Mar 2026 13:34:50 +0100
Message-ID: <87y0jm1xxx.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The "git-compat-util.h" header is supposed to be the first header
> included by every code compilation unit. As such, a subsequent commit
> will start to precompile this header to speed up compilation of Git.
>
> This will cause an issue though with the way that we have set up the
> "-Wsign-compare" warnings. It is expected that any compilation unit that
> fails with that compiler warning sets `DISABLE_SIGN_COMPARE_WARNINGS`
> before including "git-compat-util.h". If so, we'll disable the warning
> right away via a compiler pragma.
>
> But with precompiled headers we do not know ahead of time whether the
> code unit wants to disable those warnings, and thus we'll have to
> precompile the header without defining `DISABLE_SIGN_COMPARE_WARNINGS`.
> But as the pragma statement is wrapped by our include guards, the second
> include of that file will not have the desired effect of disabling the
> warnings anymore.
>
> We could fix this issue by declaring a new macro that compilation units
> are expected to invoke after having included the file. In retrospect,
> that would have been the better way to handle this as it allows for
> more flexibility: we could for example toggle the warning for specific
> code blocks, only. But changing this now would require a bunch of
> changes, and the churn feels excessive for what we gain.
>
> Instead, prepare for the precompiled headers by moving the code outside
> of the include guards.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  git-compat-util.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index bebcf9f698..4b4ea2498f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -34,10 +34,6 @@ struct strbuf;
>  #  define DISABLE_WARNING(warning)
>  #endif
>  
> -#ifdef DISABLE_SIGN_COMPARE_WARNINGS
> -DISABLE_WARNING(-Wsign-compare)
> -#endif
> -
>  #undef FLEX_ARRAY
>  #define FLEX_ARRAY /* empty - weather balloon to require C99 FAM */
>  
> @@ -1099,3 +1095,7 @@ extern int not_supposed_to_survive;
>  #endif /* CHECK_ASSERTION_SIDE_EFFECTS */
>  
>  #endif
> +
> +#ifdef DISABLE_SIGN_COMPARE_WARNINGS
> +DISABLE_WARNING(-Wsign-compare)
> +#endif

Okay, so with all patches applied, when a .c file is compiled,
tools/precompiled.h is included as the first one. That one includes
git-compat-util.h and processes everything inside the include guards.
Then it starts processing the contents of that files and that file might
#define DISABLE_SIGN_COMPARE_WARNINGS. Usually git-compat-util.h is then
included again, but thanks to the include guards, most of it is ignored,
except for this last bit.

Okay, makes sense.

-- 
Cheers,
Toon
