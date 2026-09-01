Received: from mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B72C21D8
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251098; cv=none; b=W7GkZvxeBlZSRQYU3EL/blsW2IRF7xdNKWXcvXKDxJvVWyiCIVaWswbMUUo1RuWSf3fdWPxwg2ltbHn3BKRxZ4e9huIE2wJnT3KrAaTaR+DA2/8riBAu82stB1dtuDpDancW4S7QA8fruQb2MqEye+TIYTcJAWEk2+VmlT0kbvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251098; c=relaxed/simple;
	bh=9ESQF6TjnBQ0iRGxaH4C+4yDDk/NWgonDssNnvxxX08=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j3SfvceixINTUdxmeoDsXmQZlywDyQZDVOhqlu2awbF1rGZueiSsNNvrC/LHHaxl24jbw7Ijt9y0YgDp9KlATP5SPEE2+uwdJLbC83vIUKvpXleDH6Z5Bpme10f6jW/c7BSN9Z5KeK98fCX7037U3GhQEv0Hm48qZLPbnbglyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ZmHXV9R2; arc=none smtp.client-ip=95.215.58.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ZmHXV9R2"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9ESQF6TjnBQ0iRGxaH4C+4yDDk/NWgonDssNnvxxX08=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788251091; v=1; x=1788855891;
 b=ZmHXV9R2jeMQyKoM3Wn6AnOdaosYFgIdJsqkwuyB6UGlZHW2uRAxk7Z6GFqFZ1jLvieZ1Bxa
 nhM8eQlaLyfiBjWXKT3jKogyzwCwBLTnF9yzM+JDYE3mubMbNepvZzlQTs4dwQPYLAcYgWFNLHy
 htE68AjTdCMzp/APjPQi3V/o=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id fe9541e92a938a58;
	Tue, 01 Sep 2026 08:24:41 +0000
X-Mizu-Trace-ID: fe9541e92a938a58
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] ci: fix missing Ruby dependency in "documentation" job
In-Reply-To: <20260901-b4-pks-ci-fix-documentation-job-v1-1-a8257ee2a9a4@pks.im>
References: <20260901-b4-pks-ci-fix-documentation-job-v1-1-a8257ee2a9a4@pks.im>
Date: Tue, 01 Sep 2026 10:24:32 +0200
Message-ID: <87pkyxwf9b.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Our "documentation" job has recently stopped working with the following
> error:
>
>   + sudo gem install --version 1.5.8 asciidoctor
>   + gem install --version 1.5.8 asciidoctor
>   ./ci/install-dependencies.sh: 23: gem: not found
>
> The root cause of this is that we never explicitly install Ruby, and
> consequently gem(1) isn't explicitly pulled inus, either. This used to

"inus"?

> work alright because we transitively pulled in Ruby via asciidoc. But
> due to an update it seems that we stopped pulling in the transitive
> dependency, and consequently we don't have gem(1) available anymore.
>
> Fix this by explicitly installing Ruby.

Thanks for this fix, I was just looking at it as well, although I wasn't
sure it started failing recently.


> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> I spotted the failure yesterday. You can see that this fixes the
> pipeline at [1]. Thanks!
>
> Patrick
>
> [1]: https://gitlab.com/gitlab-org/git/-/merge_requests/660
> ---
>  ci/install-dependencies.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 10c3530d1a..502e518077 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -164,7 +164,7 @@ sparse)
>  		libexpat-dev gettext zlib1g-dev sparse
>  	;;
>  Documentation)
> -	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
> +	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make ruby

Good!

>  
>  	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
>  	sudo gem install --version 1.5.8 asciidoctor
>
> ---
> base-commit: 1630431f326e15fcde608827b5ff38422528eb59
> change-id: 20260901-b4-pks-ci-fix-documentation-job-e971e10fbc94

Thanks!

-- 
Laters,
Toon
