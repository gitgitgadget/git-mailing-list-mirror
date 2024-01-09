Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470373C461
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qTmYE0Ij"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F26751C91AC;
	Tue,  9 Jan 2024 13:19:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1YbXF62Fz1LU
	mEwfIbCC67DQbRXa3qW4C/8mOzTqNgg=; b=qTmYE0Ij14rAy0P3QcqAJizYH7JY
	OyBC3gHyAdUL8NwcTyLwKalt0jL7lR8mhtjG3gXSnQ5scpoBIdHNbSPQB7mDrIoQ
	pTz7XW32T5WG9op8iLO7lt+bEz0jwTsw3TjGHx2UEBqa9qHAzcjqCZDei8/dBfSN
	G//qKl9EfjWfYqE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EA1ED1C91AB;
	Tue,  9 Jan 2024 13:19:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61CC11C91AA;
	Tue,  9 Jan 2024 13:19:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] t/test-tool: handle -c <name>=<value> arguments
In-Reply-To: <6a4d6a56-ab6f-4557-a5a3-1713f57cbfc9@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 9 Jan 2024 16:29:57 +0100")
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
	<6a4d6a56-ab6f-4557-a5a3-1713f57cbfc9@gmail.com>
Date: Tue, 09 Jan 2024 10:19:29 -0800
Message-ID: <xmqqttnmgyj2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A1897F0E-AF1B-11EE-AF73-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Soon we're going to need to pass configuration values to a command in
> test-tool.
>
> Let's teach test-tool to take config values via command line arguments.
>
> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  t/helper/test-tool.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Nice.

>
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index d9f57c20db..7eba4ec9ab 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -3,9 +3,10 @@
>  #include "test-tool-utils.h"
>  #include "trace2.h"
>  #include "parse-options.h"
> +#include "config.h"
> =20
>  static const char * const test_tool_usage[] =3D {
> -	"test-tool [-C <directory>] <command> [<arguments>...]]",
> +	"test-tool [-C <directory>] [-c <name>=3D<value>] <command> [<argumen=
ts>...]",
>  	NULL
>  };
> =20
> @@ -106,6 +107,13 @@ static NORETURN void die_usage(void)
>  	exit(128);
>  }
> =20
> +static int parse_config_option(const struct option *opt, const char *a=
rg,
> +			       int unset)
> +{
> +	git_config_push_parameter(arg);
> +	return 0;
> +}
> +
>  int cmd_main(int argc, const char **argv)
>  {
>  	int i;
> @@ -113,6 +121,9 @@ int cmd_main(int argc, const char **argv)
>  	struct option options[] =3D {
>  		OPT_STRING('C', NULL, &working_directory, "directory",
>  			   "change the working directory"),
> +		OPT_CALLBACK('c', NULL, NULL, "<name>=3D<value>",
> +			   "pass a configuration parameter to the command",
> +			   parse_config_option),
>  		OPT_END()
>  	};
