Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A3B71F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 00:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbdKHA7D (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:59:03 -0500
Received: from avasout04.plus.net ([212.159.14.19]:35974 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752539AbdKHA7C (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2017 19:59:02 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id CEhoe1tOKzbmWCEhpe2S7X; Wed, 08 Nov 2017 00:59:01 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=dIu3SnmMAAAA:8 a=DibueHh8FKHO1FA6kHAA:9
 a=QEXdDO2ut3YA:10 a=Ua9G7VpiFza3u12uuhVB:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v16 Part II 6/8] bisect--helper: `get_terms` &
 `bisect_terms` shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee303-449f1b76-ff53-433c-8973-8b4850466810-000000@eu-west-1.amazonses.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <aacc7970-6952-206e-5ef0-10e0cf3d7373@ramsayjones.plus.com>
Date:   Wed, 8 Nov 2017 00:59:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0102015f5e5ee303-449f1b76-ff53-433c-8973-8b4850466810-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKor+XuZyVJaW10xY4DyCyWTs/fNEFuUbzy6pLvXPBZiFLZ/yylg1W/bdIUHZDx/tpbhbHSHyvnKQft1PjBe8xGaUSThMpvfQIpRgzbe2wWfz9grPlDg
 462MEmPEXqw/DUL36l9UChtrTJW/SyJqbnpB2aL7HJhpsJgqucqY9vlLy2WP7ahTA7BLmQIOFvC3Tg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/10/17 16:06, Pranit Bauva wrote:
> Reimplement the `get_terms` and `bisect_terms` shell function in C and
> add `bisect-terms` subcommand to `git bisect--helper` to call it from
> git-bisect.sh .
> 
> Using `--bisect-terms` subcommand is a temporary measure to port shell
> function in C so as to use the existing test suite. As more functions
> are ported, this subcommand will be retired but its implementation will
> be called by some other methods.
> 
> Also use error() to report "no terms defined" and accordingly change the
> test in t6030.
> 
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  builtin/bisect--helper.c    | 69 +++++++++++++++++++++++++++++++++++++++++++--
>  git-bisect.sh               | 35 ++---------------------
>  t/t6030-bisect-porcelain.sh |  2 +-
>  3 files changed, 70 insertions(+), 36 deletions(-)
> 
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 0f9c3e63821b8..ab0580ce0089a 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -23,6 +23,7 @@ static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --bisect-write <state> <revision> <good_term> <bad_term> [<nolog>]"),
>  	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
>  	N_("git bisect--helper --bisect-next-check [<term>] <good_term> <bad_term>"),
> +	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
>  	NULL
>  };
>  
> @@ -344,6 +345,62 @@ static int bisect_next_check(const struct bisect_terms *terms,
>  	return retval;
>  }
>  
> +static int get_terms(struct bisect_terms *terms)
> +{
> +	struct strbuf str = STRBUF_INIT;
> +	FILE *fp = NULL;
> +	int res = 0;
> +
> +	fp = fopen(git_path_bisect_terms(), "r");
> +	if (!fp)
> +		goto fail;
> +
> +	free_terms(terms);
> +	strbuf_getline_lf(&str, fp);
> +	terms->term_bad = strbuf_detach(&str, NULL);
> +	strbuf_getline_lf(&str, fp);
> +	terms->term_good = strbuf_detach(&str, NULL);
> +	goto finish;
> +
> +fail:
> +	res = -1;
> +finish:
> +	if (fp)
> +		fclose(fp);
> +	strbuf_release(&str);
> +	return res;
> +}
> +
> +static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
> +{
> +	int i;
> +
> +	if (get_terms(terms))
> +		return error(_("no terms defined"));
> +
> +	if (argc > 1)
> +		return error(_("--bisect-term requires exactly one argument"));
> +
> +	if (argc == 0)
> +		return !printf(_("Your current terms are %s for the old state\n"
> +				 "and %s for the new state.\n"),
> +				 terms->term_good, terms->term_bad);

Again, I don't think you want to do this. :-D

> +
> +	for (i = 0; i < argc; i++) {
> +		if (!strcmp(argv[i], "--term-good"))> +			printf(_("%s\n"), terms->term_good);
> +		else if (!strcmp(argv[i], "--term-bad"))
> +			printf(_("%s\n"), terms->term_bad);
> +		else

Here, you want to check for the pairs "--term-{good,old}" and
"--term-{bad,new}", so maybe this instead:

+		if (one_of(argv[i], "--term-good", "--term-old", NULL))
+			printf("%s\n", terms->term_good);
+		else if (one_of(argv[i], "--term-bad", "--term-new", NULL))
+			printf("%s\n", terms->term_bad);
+		else

> +			error(_("BUG: invalid argument %s for 'git bisect terms'.\n"
> +				  "Supported options are: "
> +				  "--term-good|--term-old and "
> +				  "--term-bad|--term-new."), argv[i]);
> +	}
> +
> +	return 0;
> +}
> +

ATB,
Ramsay Jones


