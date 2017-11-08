Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814E01F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 00:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758856AbdKHAiB (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:38:01 -0500
Received: from avasout04.plus.net ([212.159.14.19]:35167 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758607AbdKHAiA (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2017 19:38:00 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id CENSe1rCizbmWCENTe2RUp; Wed, 08 Nov 2017 00:37:59 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=dIu3SnmMAAAA:8 a=iV6iKdqZf7FOv1vRbuUA:9
 a=QEXdDO2ut3YA:10 a=Ua9G7VpiFza3u12uuhVB:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v16 Part II 4/8] bisect--helper: `check_and_set_terms`
 shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee273-de8fa1d2-1d59-4990-93f5-d36a6cb3f45a-000000@eu-west-1.amazonses.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <1af55a7a-d58c-6f36-3a2f-25c79cbfb84e@ramsayjones.plus.com>
Date:   Wed, 8 Nov 2017 00:37:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0102015f5e5ee273-de8fa1d2-1d59-4990-93f5-d36a6cb3f45a-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLOpXocB0ZxvAQSy77SeEMh9MzMhVUKADjZjTepvGJoMQqqWDalVv9uxLpift3ZFjOC43iYO63UmVNVbsj3jgrZE90KJIYNIUQr6mGIKCKUvTyvWrg4W
 AjF+tsB3zi3fN30TopooFTJ5bcv+/2NLZ7CbrBcjYLV0uc8NW3izDCrRR1lzuYjRZRfa8InVD7vitw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/10/17 16:06, Pranit Bauva wrote:
> Reimplement the `check_and_set_terms` shell function in C and add
> `check-and-set-terms` subcommand to `git bisect--helper` to call it from
> git-bisect.sh
> 
> Using `--check-and-set-terms` subcommand is a temporary measure to port
> shell function in C so as to use the existing test suite. As more
> functions are ported, this subcommand will be retired but its
> implementation will be called by some other methods.
> 
> check_and_set_terms() sets and receives two global variables namely
> TERM_GOOD and TERM_BAD in the shell script. Luckily the file BISECT_TERMS
> also contains the value of those variables so its appropriate to evoke the
> method get_terms() after calling the subcommand so that it retrieves the
> value of TERM_GOOD and TERM_BAD from the file BISECT_TERMS. The two
> global variables are passed as arguments to the subcommand.
> 
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  builtin/bisect--helper.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  git-bisect.sh            | 36 ++++--------------------------------
>  2 files changed, 44 insertions(+), 33 deletions(-)
> 
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 6295f53c850a8..65abf8a70c6d9 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -20,6 +20,7 @@ static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --bisect-clean-state"),
>  	N_("git bisect--helper --bisect-reset [<commit>]"),
>  	N_("git bisect--helper --bisect-write <state> <revision> <good_term> <bad_term> [<nolog>]"),
> +	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
>  	NULL
>  };
>  
> @@ -234,6 +235,35 @@ static int bisect_write(const char *state, const char *rev,
>  	return retval;
>  }
>  
> +static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
> +{
> +	int has_term_file = !is_empty_or_missing_file(git_path_bisect_terms());
> +
> +	if (one_of(cmd, "skip", "start", "terms", NULL))
> +		return 0;
> +
> +	if (has_term_file && strcmp(cmd, terms->term_bad) &&
> +	    strcmp(cmd, terms->term_good))
> +		return error(_("Invalid command: you're currently in a "
> +				"%s/%s bisect"), terms->term_bad,
> +				terms->term_good);
> +
> +	if (!has_term_file) {
> +		if (one_of(cmd, "bad", "good", NULL)) {
> +			free_terms(terms);
> +			set_terms(terms, "bad", "good");
> +			return write_terms(terms->term_bad, terms->term_good);
> +		}
> +		else if (one_of(cmd, "new", "old", NULL)) {

cuddle the else: '} else if (one_of(....)) {'
OR, simply remove the else.

ATB,
Ramsay Jones

