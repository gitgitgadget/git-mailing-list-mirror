Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDC8F51
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 00:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z5M/MVHQ"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFDAD4E
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 16:38:49 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D1A0333156;
	Mon, 13 Nov 2023 19:38:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cIkmQFDgydCABj6FkzbSbfd+PCgaAEGfJN/fJl
	vVpqo=; b=Z5M/MVHQ0tl+vhXLE7ICAthXEUXcX0KJTs0uN2JflGXdGFl+6gXaHN
	ttMYr1OcMgtgSNgqSUf0GjYaXUS6bSxWd8GNTOWhPc/gMAJZfvXbomDc1j5LAG0H
	O9s1PuM3Y/4S746UTFYth+iQVvhuh2cLwRYKYFHxjLJU7AXFLFCM8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CA46633155;
	Mon, 13 Nov 2023 19:38:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6902F33116;
	Mon, 13 Nov 2023 19:38:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH 03/13] spaces and errors fix Handled git pipeline errors
In-Reply-To: <e31be0d764f47c21519016729259f8d74a53e21f.1699871056.git.gitgitgadget@gmail.com>
	(Haritha D. via GitGitGadget's message of "Mon, 13 Nov 2023 10:24:05
	+0000")
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
	<e31be0d764f47c21519016729259f8d74a53e21f.1699871056.git.gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 09:38:41 +0900
Message-ID: <xmqqpm0d2mpa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 29DA1728-8286-11EE-A767-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Haritha D via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH 03/13] spaces and errors fix Handled git pipeline errors

-ECANNOTPARSE.  Perhaps Documentation/CodingGuidelines and
 Documentation/SubmittingPatches may help?

> From: Haritha D <harithamma.d@ibm.com>
>
> This PR has fixes to enable build on z/OS

This is way under-explained.  Your proposed log message should be
able to answer when somebody asks "Is anything broken in the
existing codebase to cause your build to fail, or is it your
compiler toolchain that is broken?" but the above does not help
understanding what and why you needed to fix at all.

> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index b33b32ff977..9129658a37c 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -62,8 +62,8 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
>  #  include <stdio.h>
>  #  include <stdlib.h>
>  
> -   int setbinaryfd(int fd)
> -   {
> +int setbinaryfd(int fd)
> +{
>       attrib_t attr;
>       int rc;
>  
> @@ -74,7 +74,7 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
>  
>       rc = __fchattr(fd, &attr, sizeof(attr));
>       return rc;
> -   }
> +}
>  #  endif
>  #endif

No such function in our codebase.  Are you fixing somebody else's
forked version of Git and we shouldn't even be looking at this
patch, perhaps?

> diff --git a/convert.c b/convert.c
> index 4f14ff6f1ed..17cc849efed 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -1315,15 +1315,28 @@ static struct attr_check *check;
>  
>  static const char* get_platform() {
>  	struct utsname uname_info;
> +	char *result;
> +	if(!uname_info.sysname)
> +	{
> +		result = (char *)malloc(strlen(uname_info.sysname)+1);
> +		int index=0;
> +		while(index <= strlen(uname_info.sysname))
> +		{
> +			*result = uname_info.sysname[index];
> +			++result;
> +			++index;
> +		}
> +	}

No such function in our codebase.  I doubt these patches have much
relevance to this project?

I'll stop here.
