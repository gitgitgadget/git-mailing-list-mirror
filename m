Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E092FE09
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OQN9ZVRO"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB5C9E
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 14:51:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 512A01C53AC;
	Fri, 20 Oct 2023 17:51:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EeC3J2eh04dVfTyDOUNt1HflxqamCanhuDmRsG
	89iQ8=; b=OQN9ZVROuuwT2w331vUxPJKVrUS41c6k20PNijs34TUh6esJ6DaYQT
	926bd53/SLI/7yCaJha0HcNTGhaHGRM0CXxMoJpcqTVaFlXzdvWttWZsvBYxQBg9
	6cW6/sBKkyIR7ago/Ml6l/OIAD5rdkfXZY8E2UYnoX+Bp6CsDj4M8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4911A1C53AB;
	Fri, 20 Oct 2023 17:51:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A81861C53AA;
	Fri, 20 Oct 2023 17:51:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/3] rebase: handle --strategy via imply_merge() as well
In-Reply-To: <20231020093654.922890-3-oswald.buddenhagen@gmx.de> (Oswald
	Buddenhagen's message of "Fri, 20 Oct 2023 11:36:53 +0200")
References: <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
	<20231020093654.922890-1-oswald.buddenhagen@gmx.de>
	<20231020093654.922890-3-oswald.buddenhagen@gmx.de>
Date: Fri, 20 Oct 2023 14:51:25 -0700
Message-ID: <xmqqa5sdotcy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D193121E-6F92-11EE-A4BA-25B3960A682E-77302942!pb-smtp2.pobox.com

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> At least after the successive trimming of enum rebase_type mentioned in
> the previous commit, this code did exactly what imply_merge() does, so
> just call it instead.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

Hmph, I do not recall suggesting it, but the resulting code does
make sense.  ;-)

>
> ---
> Cc: Phillip Wood <phillip.wood123@gmail.com>
> ---
>  builtin/rebase.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 44cc1eed12..4a093bb125 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1490,18 +1490,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  
>  	if (options.strategy) {
>  		options.strategy = xstrdup(options.strategy);
> -		switch (options.type) {
> -		case REBASE_APPLY:
> -			die(_("--strategy requires --merge or --interactive"));
> -		case REBASE_MERGE:
> -			/* compatible */
> -			break;
> -		case REBASE_UNSPECIFIED:
> -			options.type = REBASE_MERGE;
> -			break;
> -		default:
> -			BUG("unhandled rebase type (%d)", options.type);
> -		}
> +		imply_merge(&options, "--strategy");
>  	}
>  
>  	if (options.root && !options.onto_name)
