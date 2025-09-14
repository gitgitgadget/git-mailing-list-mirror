Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958357C9F
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874798; cv=none; b=Avk1FCf9gTwC1b6YSmsz1gHmeC0bHawAuO0IaxIOG9RRwXztBuJsiCcdklftfDtrSTnoJ9oNuli5H0QfJl+tM7rdXn7Vq4PZb+RPEGHGE8p/2ViI0luNomUzftEFHOtvctQibJRKL1+C9yddRCLYiIzoCFyPLtipBeJ91zMtqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874798; c=relaxed/simple;
	bh=zUzq02YwDqdbGvEMNQw6rBMemBVho4LehDW714uvvF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=RKooZ08KUxGSoJfpvGo1g6N6wqYgLj2y6uPBdzx+AhuiuHNn6okf0VlbleLoA8S/xEspmtmkOAS13KSQExgssPVeJim/S8lw63YunxEue+7ryHiBejWKHdKE5kUNlZtnMlUcy+dVqbajkprhHmYFYLL7XtKM6g3Pt6FQMkZJZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4cPxcM0LtWzRnQP;
	Sun, 14 Sep 2025 20:33:07 +0200 (CEST)
Message-ID: <8cd33841-9959-4cd9-99f2-84cac042ceec@kdbg.org>
Date: Sun, 14 Sep 2025 20:32:14 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: fix error when remote tracking branch is deleted
To: Michael Rappazzo <rappazzo@gmail.com>
References: <20250913113253.74362-1-rappazzo@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20250913113253.74362-1-rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 13.09.25 um 13:31 schrieb Michael Rappazzo:
> When a remote tracking branch is deleted (e.g., via 'git push --delete
> origin branch'), the headids array entry for that branch is removed, but
> upstreamofref may still reference it. This causes gitk to show an error
> and prevents the Tags and Heads view from opening.
> 
> Fix by checking that headids($upstreamofref($n)) exists before accessing
> it in the refill_reflist function.
> 
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>

Thank you, this looks reasonable. Queued.

> ---
> To reproduce the case:
> ```
> mkdir sample-repo-remote &&
> cd sample-repo-remote &&
> git init --bare --initial-branch master && 
> cd .. &&
> git clone sample-repo-remote sample-repo &&
> cd sample-repo &&
> git commit --allow-empty -m "Sample commit" &&
> git push origin master &&
> git push origin master:master2 &&
> git branch master2 origin/master2 &&
> git push --delete origin master2
> ```
> Then run gitk --all then bring up the "Tags and Heads" view.
> 
> 
>  gitk | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/gitk b/gitk
> index 6e4d71d585..3cfc9ef291 100755
> --- a/gitk
> +++ b/gitk
> @@ -10294,7 +10294,9 @@ proc refill_reflist {} {
>          if {![string match "remotes/*" $n] && [string match $reflistfilter $n]} {
>              if {[commitinview $headids($n) $curview]} {
>                  lappend localrefs [list $n H]
> -                if {[info exists upstreamofref($n)] && [commitinview $headids($upstreamofref($n)) $curview]} {
> +                if {[info exists upstreamofref($n)] && \
> +                        [info exists headids($upstreamofref($n))] && \
> +                        [commitinview $headids($upstreamofref($n)) $curview]} {
>                      lappend trackedremoterefs [list $upstreamofref($n) R]
>                  }
>              } else {

