Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF4E57D
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465390; cv=none; b=akXm/CR0EvKeBO5M0VwPQoONc6f0UIdmILojw3BA/FU+28XN9eOp6NrzgOTkw6tB0b2rk0q6RveNMptR7eia7TfRFcDH6QLNVj1ldl0ptbLd0Ru3aIS2yfn3lqcMVhUrQNR+J1u8rqqa+QDXTDlPAoEpK7tHSBG4QkiGOURsej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465390; c=relaxed/simple;
	bh=JjOpea0Tcuz0gDzRR3KXJszq0cxpFlYTXSXCePKxxGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BPmwYoFpmezpNmxbr6uYPfveBJ0Q42KerbGFNi0vHFW2wPTq3aoZTAAISpwusKcKDnuFqeVIeC8/PnWQg4GwugFSsl9IkFIL+SVgBH/0g4gL74uGaWRvChgca6unYuouKxKLJYiVuqyhBMy3DrSK3LNWu7lJQ4th6awAn6is7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=2ZIpzaBf; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="2ZIpzaBf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1737465385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GB8Q57m0dhpbUk9l8ZWMxQ8wLxDAD1qX9yOd/kWzQHA=;
	b=2ZIpzaBfVVZgv5baXg6HFAO5kt+CSbLYQX7zHAqPXIRmziD+y1U8bcIyzs8RtyyBQwORoN
	ii3qqVThY4dOBHVRwSDmqnucy8UGoX9em1TkuJ5cneFwhwZR5l7tP1STV/ItFtHuCHQeWV
	+eGdzyHzs3nisbtOkVHaFg3qukZAsrc=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, Eli Schwartz
 <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, M Hickford
 <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2 02/11] GIT-VERSION-GEN: allow running without input
 and output files
In-Reply-To: <20250114-b4-pks-meson-additions-v2-2-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
 <20250114-b4-pks-meson-additions-v2-2-8d7ec676cfd9@pks.im>
Date: Tue, 21 Jan 2025 14:16:11 +0100
Message-ID: <87jzaoi9yc.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The GIT-VERSION-GEN script requires an input file containing formatting
> directives to be replaced as well as an output file that will get
> overwritten in case the file contents have changed. When computing the
> project version for Meson we don't want to have either though:
>
>   - We only want to compute the version without anything else, but don't
>     have an input file that would match that exact format. While we
>     could of course introduce a new file just for that usecase, it feels
>     suboptimal to add another file every time we want to have a slightly
>     different format for versioned data.
>
>   - The computed version needs to be read from stdout so that Meson can
>     wire it up for the project.
>
> Extend the script to handle both usecases by recognizing `--format=` as
> alternative to providing an input path and by writing to stdout in case
> no output file was given.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  GIT-VERSION-GEN | 44 +++++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index b8b683b9337e5771e14a2cfb84022a11489bb432..9d201a98fd2766911544225c62159cbfe8dff5fe 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -5,21 +5,29 @@ DEF_VER=v2.48.0
>  LF='
>  '
>  
> -if test "$#" -ne 3
> +if test "$#" -lt 2 || test "$#" -gt 3
>  then
> -    echo >&2 "USAGE: $0 <SOURCE_DIR> <INPUT> <OUTPUT>"
> +    echo >&2 "USAGE: $0 <SOURCE_DIR> (--format=<STRING>|<INPUT>) [<OUTPUT>]"
>      exit 1
>  fi
>  
>  SOURCE_DIR="$1"
> -INPUT="$2"
> -OUTPUT="$3"
>  
> -if ! test -f "$INPUT"
> -then
> -	echo >&2 "Input is not a file: $INPUT"
> -	exit 1
> -fi
> +case "$2" in
> +--format=*)
> +	INPUT="${2#--format=}"
> +	;;
> +*)
> +	if ! test -f "$2"
> +	then
> +		echo >&2 "Input is not a file: $2"
> +		exit 1
> +	fi
> +	INPUT=$(cat "$2")
> +	;;
> +esac
> +
> +OUTPUT="$3"
>  
>  # Protect us from reading Git version information outside of the Git directory
>  # in case it is not a repository itself, but embedded in an unrelated
> @@ -74,19 +82,25 @@ read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trail
>  $(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
>  EOF
>  
> -sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
> +REPLACED=$(printf "%s" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
>  	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
>  	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
>  	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
>  	-e "s|@GIT_PATCH_LEVEL@|$GIT_PATCH_LEVEL|" \
>  	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
>  	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
> -	-e "s|@GIT_DATE@|$GIT_DATE|" \
> -	"$INPUT" >"$OUTPUT".$$+
> +	-e "s|@GIT_DATE@|$GIT_DATE|"
> +)
>  
> -if ! test -f "$OUTPUT" || ! cmp "$OUTPUT".$$+ "$OUTPUT" >/dev/null
> +if test -z "$OUTPUT"
>  then
> -	mv "$OUTPUT".$$+ "$OUTPUT"
> +	printf "%s\n" "$REPLACED"
>  else
> -	rm "$OUTPUT".$$+
> +	printf "%s\n" "$REPLACED" >"$OUTPUT".$$+
> +	if ! test -f "$OUTPUT" || ! cmp "$OUTPUT".$$+ "$OUTPUT" >/dev/null
> +	then
> +		mv "$OUTPUT".$$+ "$OUTPUT"
> +	else
> +		rm "$OUTPUT".$$+
> +	fi
>  fi
>
> -- 
> 2.48.0.257.gd3603152ad.dirty

I was considering to suggest to have GIT-VERSION-GEN accept --stdin for
$INPUT and have it read from stdin instead of passing the format as an
argument, but looking at the following commits I agree with your
approach.

--
Toon
