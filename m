From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule helper list: Respect correct path prefix
Date: Wed, 24 Feb 2016 13:21:12 -0800
Message-ID: <xmqqy4a9st2v.fsf@gitster.mtv.corp.google.com>
References: <1456348502-4529-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: cjorden@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 22:21:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYgs5-000887-G3
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 22:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757026AbcBXVVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 16:21:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754406AbcBXVVP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 16:21:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9BCC46AE4;
	Wed, 24 Feb 2016 16:21:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r9uRRhMiLC8dTrY1G1LW/27a7VI=; b=CcxSIZ
	rSa9nIEV7BN8mgubWoy6uRf9jVzU0adI4ooO68rEDUqV9uLGqn1xmT3Rh9sAxJKY
	jRwtJMqvGz7qChgZN3j0r5Vs9anQbEAscB/3L963aj7pQu9iAeVwppA8S1Liif2G
	CWs3ksKLCatVMxdI+7dt+I2X4n5z7hqt4MJFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ScmY8+4d7uCHWejaZBFxsqLQAoY26Yj3
	gXNjPSHEsi5ni2LrJ3XecvRzHGvLq08OUiQZ4xB+0GlunwmWEARTHKGllsayTtP7
	cl9JlLottV7/MpKxh5Qi2157IpJjfjL+UhsTdGiqfA8dURu4Pk44f8hX4EjN/0jj
	MMC46jTC2h0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E02AA46AE3;
	Wed, 24 Feb 2016 16:21:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 63FF246AE1;
	Wed, 24 Feb 2016 16:21:13 -0500 (EST)
In-Reply-To: <1456348502-4529-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 24 Feb 2016 13:15:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8832D30E-DB3C-11E5-8799-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287231>

Stefan Beller <sbeller@google.com> writes:

> This is a regression introduced by 74703a1e4d (submodule: rewrite
> `module_list` shell function in C, 2015-09-02).
>
> Add a test to ensure we list the right submodule when giving a specific
> path spec.
>
> Reported-By: Caleb Jorden <cjorden@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  I developed this on top of current origin/master, though I can backport it
>  to 2.7 as well if desired.
>  
>  I do not remember the cause why we started to ignore a common prefix.

The code you are removing with this patch is probably an
optimization you copied from builtin/ls-files.c.  When the
optimization is used, the original also limits the list of paths to
those that match the prefix by calling prune_cache(), but perhaps
you didn't have a corresponding code in your copy?

>  
>  Thanks,
>  Stefan
>   
>  builtin/submodule--helper.c | 10 ++--------
>  t/t7400-submodule-basic.sh  | 25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f4c3eff..ed764c9 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -22,17 +22,12 @@ static int module_list_compute(int argc, const char **argv,
>  			       struct module_list *list)
>  {
>  	int i, result = 0;
> -	char *max_prefix, *ps_matched = NULL;
> -	int max_prefix_len;
> +	char *ps_matched = NULL;
>  	parse_pathspec(pathspec, 0,
>  		       PATHSPEC_PREFER_FULL |
>  		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
>  		       prefix, argv);
>  
> -	/* Find common prefix for all pathspec's */
> -	max_prefix = common_prefix(pathspec);
> -	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
> -
>  	if (pathspec->nr)
>  		ps_matched = xcalloc(pathspec->nr, 1);
>  
> @@ -44,7 +39,7 @@ static int module_list_compute(int argc, const char **argv,
>  
>  		if (!S_ISGITLINK(ce->ce_mode) ||
>  		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
> -				    max_prefix_len, ps_matched, 1))
> +				    0, ps_matched, 1))
>  			continue;
>  
>  		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
> @@ -57,7 +52,6 @@ static int module_list_compute(int argc, const char **argv,
>  			 */
>  			i++;
>  	}
> -	free(max_prefix);
>  
>  	if (ps_matched && report_path_error(ps_matched, pathspec, prefix))
>  		result = -1;
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 540771c..be82a75 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -999,5 +999,30 @@ test_expect_success 'submodule add clone shallow submodule' '
>  	)
>  '
>  
> +test_expect_success 'submodule helper list is not confused by common prefixes' '
> +	mkdir -p dir1/b &&
> +	(
> +		cd dir1/b &&
> +		git init &&
> +		echo hi >testfile2 &&
> +		git add . &&
> +		git commit -m "test1"
> +	) &&
> +	mkdir -p dir2/b &&
> +	(
> +		cd dir2/b &&
> +		git init &&
> +		echo hello >testfile1 &&
> +		git add .  &&
> +		git commit -m "test2"
> +	) &&
> +	git submodule add /dir1/b dir1/b &&
> +	git submodule add /dir2/b dir2/b &&
> +	git commit -m "first submodule commit" &&
> +	git submodule--helper list dir1/b |cut -c51- >actual &&
> +	echo "dir1/b" >expect &&
> +	test_cmp expect actual
> +'
> +
>  
>  test_done
