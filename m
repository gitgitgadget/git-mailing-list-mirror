Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3BB1F93E
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="htCzl74l"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DDDF52D0FE;
	Wed,  3 Jan 2024 18:37:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zXsa9Hja+PyyR3LBOVonAZ4UllR4AMYwx/gxeS
	926JE=; b=htCzl74lkGgBsk4ebREkgfWbNdUrz39zofyne+NfrL7v6k1RO1zzUF
	V5ZEP5i99/Ai2SWYtmUH5jF/PVv8qasLDOTvLpcBqLQ3lE1nmqAW+Ac/vUXZhGHy
	AS67efrKNgubEe4zGTH5Op5MZYkpQ7gCTWy0rX/Rue1zBCEtCxvZA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D65D12D0FD;
	Wed,  3 Jan 2024 18:37:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 952012D0FC;
	Wed,  3 Jan 2024 18:37:51 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sam Delmerico <delmerico@google.com>
Cc: git@vger.kernel.org,  steadmon@google.com
Subject: Re: [PATCH] push: region_leave trace for negotiate_using_fetch
In-Reply-To: <20240103224054.1940209-1-delmerico@google.com> (Sam Delmerico's
	message of "Wed, 3 Jan 2024 14:40:54 -0800")
References: <20240103224054.1940209-1-delmerico@google.com>
Date: Wed, 03 Jan 2024 15:37:50 -0800
Message-ID: <xmqqbka27zu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1C441E1E-AA91-11EE-A3B7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Sam Delmerico <delmerico@google.com> writes:

> There were two region_enter events for negotiate_using_fetch instead of
> one enter and one leave. This commit replaces the second region_enter
> event with a region_leave.
>
> Signed-off-by: Sam Delmerico <delmerico@google.com>
> ---
>  fetch-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks right, after skimming a29263cf (fetch-pack: add tracing for
negotiation rounds, 2022-08-02).  Two questions and a half.

 * How did you find it?  Code inspection?  While writing a script to
   parse the output from around this area, your script noticed the
   ever-increasing nesting level?  Something else?

 * Would it be feasible to write some tests or tools that find
   similar problems (semi-)automatically?

 * Is the breakage (before this patch) something easily demonstrated
   in a new test in t/ somewhere?  And if so, would it be worth
   doing?

Thanks.  Will queue.


>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 31a72d43de..dba6d79944 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -2218,7 +2218,7 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
>  					   the_repository, "%d",
>  					   negotiation_round);
>  	}
> -	trace2_region_enter("fetch-pack", "negotiate_using_fetch", the_repository);
> +	trace2_region_leave("fetch-pack", "negotiate_using_fetch", the_repository);
>  	trace2_data_intmax("negotiate_using_fetch", the_repository,
>  			   "total_rounds", negotiation_round);
>  	clear_common_flag(acked_commits);
>
> base-commit: a26002b62827b89a19b1084bd75d9371d565d03c
