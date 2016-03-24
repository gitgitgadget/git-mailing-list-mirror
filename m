From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v9 1/3] parse-options.c: make OPTION__COUNTUP consider negative values
Date: Thu, 24 Mar 2016 11:33:13 +0100
Message-ID: <1458815593-11060-1-git-send-email-szeder@ira.uka.de>
References: <01020153a7ba4e07-f326395b-63df-4f8a-b378-8f387b02d0bd-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 11:33:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj2aE-0007pD-95
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 11:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757200AbcCXKdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 06:33:38 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:53075 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757190AbcCXKdg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 06:33:36 -0400
Received: from x4db26f6f.dyn.telefonica.de ([77.178.111.111] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aj2a4-0007vl-Rk; Thu, 24 Mar 2016 11:33:34 +0100
X-Mailer: git-send-email 2.8.0.rc3.58.gc805582
In-Reply-To: <01020153a7ba4e07-f326395b-63df-4f8a-b378-8f387b02d0bd-000000@eu-west-1.amazonses.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1458815614.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289733>

> The reason to make it consider negative values or more specifically
> "unspecified" values is to give the ability to differentiate between
> once, multiple time or with --no-option.
> 
> Eg. :
> initialize verbose = -1
> `git commit` => verbose = -1
> `git commit -v` => verbose = 1
> `git commit -v -v` => verbose = 2
> `git commit --no-verbose` => verbose = 0
> 
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> 
> ---
> The discussion about this patch:
> [1] : http://thread.gmane.org/gmane.comp.version-control.git/289027
> 
> Previous version of the patch:
> [v1] : http://thread.gmane.org/gmane.comp.version-control.git/289061
> 
> Changes introduced:
> Use a different language in commit message to make the change and its
> utility more clear.

I don't see the mentioned change in the commit message.  In
particular:

  - As Eric pointed out in the previous round, the commit message
    misses the single most important point of justification: to
    determine whether '--option' or '--no-option' was specified at
    all.  Explaining this would also make the examples unnecessary.

  - OPT_COUNTUP is used in several places, mostly indirecty, but the
    commit message doesn't explain that possible side-effects to these
    callers were considered and that they are not harmed by this
    change.

> ---
>  Documentation/technical/api-parse-options.txt | 6 ++++--
>  parse-options.c                               | 8 +++++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)

A couple of new tests to t0040-parse-options.sh would be great to
ensure that starting from a negative value works as advertised, i.e.
at least that '--option' jumps to 1 and '--no-option' resets to 0.

> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> index 5f0757d..a908d8a 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -144,8 +144,10 @@ There are some macros to easily define options:
>  
>  `OPT_COUNTUP(short, long, &int_var, description)`::
>  	Introduce a count-up option.
> -	`int_var` is incremented on each use of `--option`, and
> -	reset to zero with `--no-option`.
> +	If the `int_var` is negative and `--option` is absent,
> +	then it will retain its value. Otherwise it will first set
> +	`int_var` to 0 and then increment it on each use of `--option`,
> +	and reset to zero with `--no-option`.
>  
>  `OPT_BIT(short, long, &int_var, description, mask)`::
>  	Introduce a boolean option.
> diff --git a/parse-options.c b/parse-options.c
> index 47a9192..86d30bd 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -110,7 +110,13 @@ static int get_value(struct parse_opt_ctx_t *p,
>  		return 0;
>  
>  	case OPTION_COUNTUP:
> -		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
> +		if (unset)
> +			*(int *)opt->value = 0;
> +		else {
> +			if (*(int *)opt->value < 0)
> +				*(int *)opt->value = 0;
> +			*(int *)opt->value += 1;
> +		}
>  		return 0;
>  
>  	case OPTION_SET_INT:
> 
> --
> https://github.com/git/git/pull/218
> 
> 
