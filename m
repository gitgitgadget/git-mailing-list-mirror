Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D31F237D
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464379; cv=none; b=iupipmy1ihOhLpLT7A72+sRyCzkVOrAac5yOcfsem8ETP1ChFh1SYceE3DRdu3KtdkLmVb3//8e2IRznt9IzM/23A0VXEb0ypK44X8a7CkD05INQbR6G76jmMrYOa5B+liyGGzHnkI3hXu8tP1SXyJ2OOqtKLl9xTOvaR8SNlMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464379; c=relaxed/simple;
	bh=2BFvvlX2mIslxHDK8I5bMLFYsV3p83lf8BO8eAzBiMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MCg0BcRCgZXpRQ//3F1gvvNMEIU9zUu/7e/Kp1C2pto9394FLtX+UifcTZda075QQABPdkyeL9JKHULrqwTla3gmSn+rdJBWDi/h5ZAqJuhWn4X9LYanhiDmqVY+tG4dNuB28PrZpdMoXZnDn+PkgwrN7pJK7F+UTCH0dGCcHfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=z9FbxIAg; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="z9FbxIAg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1737464375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fen5xCi/dVIsKOyAxnSvIH6/nyABfyf3U8rtzju4Otk=;
	b=z9FbxIAgWHRktIPqtmDvFf9aDbB45rDZg28G59ClKShKOThrQ/Qwpw1eTrIY1o45uaiapV
	oE9Eb97Ioqz7/H5znpK1ZUuFML1XSVeyyRUlFqC3m5nBSfhoq+nl1YOe4ta3Pa9wKVVOpG
	jtPyk7sMkrSQToSt9IGdbHaxC/NdvE4=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, Eli Schwartz
 <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, M Hickford
 <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2 10/11] ci: raise error when Meson generates warnings
In-Reply-To: <20250114-b4-pks-meson-additions-v2-10-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
 <20250114-b4-pks-meson-additions-v2-10-8d7ec676cfd9@pks.im>
Date: Tue, 21 Jan 2025 13:59:25 +0100
Message-ID: <87msfkiaqa.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Meson prints warnings in several cases, like for example when using a
> feature supported by the current version of Meson, but not yet supported
> by the minimum required version as declared by the project. These
> warnings will not cause the setup to fail by default, which makes it
> quite easy to miss them.
>
> Improve this by passing `--fatal-meson-warnings` to `meson setup` so
> that our CI jobs will fail on warnings.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ci/run-build-and-tests.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 6c828c3b755153dab179f73346e7124bda49c90e..964322055f5db0eae0c794b543664e24ae4249f7 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -52,6 +52,7 @@ esac
>  case "$jobname" in
>  *-meson)
>  	group "Configure" meson setup build . \
> +		--fatal-meson-warnings \
>  		--warnlevel 2 --werror \
>  		--wrap-mode nofallback \
>  		-Dfuzzers=true
>
> -- 
> 2.48.0.257.gd3603152ad.dirty

Cool, this would have caught me trying to use `fs.copyfile`:

    $ meson setup build --fatal-meson-warnings

    # ... [snip] ...

    ../meson.build:1466: WARNING: Project targets '>=0.61.0' but uses feature introduced in '0.64.0': fs.copyfile.

    ../meson.build:1466:3: ERROR: Fatal warnings enabled, aborting


(I missed that warning)

--
Toon

