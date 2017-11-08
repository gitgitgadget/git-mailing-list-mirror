Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018BE1F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 00:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754896AbdKHA0X (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:26:23 -0500
Received: from avasout04.plus.net ([212.159.14.19]:34641 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752785AbdKHA0W (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2017 19:26:22 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id CECCe1q81zbmWCECDe2RFK; Wed, 08 Nov 2017 00:26:21 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=pGLkceISAAAA:8 a=dIu3SnmMAAAA:8
 a=b7aPGfgOqKja5fhZp_8A:9 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
 a=Ua9G7VpiFza3u12uuhVB:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v16 Part II 2/8] bisect--helper: `bisect_write` shell
 function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a6f8d81e-22de-8dd6-da11-3bda69f8da27@ramsayjones.plus.com>
Date:   Wed, 8 Nov 2017 00:26:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOU7WepT+nt4QpQ/0fi/urohy3vXSAq3oKu4yjUFj7D+h5pZMoEEuRqNX/N1Fx+iBvGvAFbLx7qnzUIdOZwqyPKk2Zc8jCUBalLju37Gv3Ky2oLksR7f
 NTxWdPMmTxhUmcsxN7hl5myt4VTqWzW1KG6V/UWSwaB53wHrwjd8ld5Rm3x8ucrDN35iN43sr5PCDA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/10/17 16:06, Pranit Bauva wrote:
> Reimplement the `bisect_write` shell function in C and add a
> `bisect-write` subcommand to `git bisect--helper` to call it from
> git-bisect.sh
> 
> Using `--bisect-write` subcommand is a temporary measure to port shell
> function in C so as to use the existing test suite. As more functions
> are ported, this subcommand will be retired but its implementation will
> be called by some other methods.
> 
> Note: bisect_write() uses two variables namely TERM_GOOD and TERM_BAD
> from the global shell script thus we need to pass it to the subcommand
> using the arguments. We then store them in a struct bisect_terms and
> pass the memory address around functions.
> 
> Add a log_commit() helper function to write the contents of the commit message
> header to a file which will be re-used in future parts of the code as
> well.
> 
> Also introduce a function free_terms() to free the memory of `struct
> bisect_terms` and set_terms() to set the values of members in `struct
> bisect_terms`.
> 
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  builtin/bisect--helper.c | 107 +++++++++++++++++++++++++++++++++++++++++++++--
>  git-bisect.sh            |  25 ++---------
>  2 files changed, 108 insertions(+), 24 deletions(-)
> 
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 12754448f7b6a..6295f53c850a8 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -12,15 +12,37 @@ static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
>  static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
>  static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
>  static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
> +static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
>  
>  static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --next-all [--no-checkout]"),
>  	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
>  	N_("git bisect--helper --bisect-clean-state"),
>  	N_("git bisect--helper --bisect-reset [<commit>]"),
> +	N_("git bisect--helper --bisect-write <state> <revision> <good_term> <bad_term> [<nolog>]"),
>  	NULL
>  };
>  
> +struct bisect_terms {
> +	const char *term_good;
> +	const char *term_bad;
> +};
> +
> +static void free_terms(struct bisect_terms *terms)
> +{
> +	if (!terms->term_good)
> +		free((void *) terms->term_good);> +	if (!terms->term_bad)
> +		free((void *) terms->term_bad);
You can pass a NULL pointer to free(), so the conditionals here
are not required.

> +}
> +
> +static void set_terms(struct bisect_terms *terms, const char *bad,
> +		      const char *good)
> +{
> +	terms->term_good = xstrdup(good);
> +	terms->term_bad = xstrdup(bad);
> +}
> +
>  /*
>   * Check whether the string `term` belongs to the set of strings
>   * included in the variable arguments.
> @@ -146,6 +168,72 @@ static int bisect_reset(const char *commit)
>  	return bisect_clean_state();
>  }
>  
> +static void log_commit(FILE *fp, char *fmt, const char *state,
> +		       struct commit *commit)
> +{
> +	struct pretty_print_context pp = {0};
> +	struct strbuf commit_msg = STRBUF_INIT;
> +	char *label = xstrfmt(fmt, state);
> +
> +	format_commit_message(commit, "%s", &commit_msg, &pp);
> +
> +	fprintf(fp, "# %s: [%s] %s\n", label, oid_to_hex(&commit->object.oid),
> +		commit_msg.buf);
> +
> +	strbuf_release(&commit_msg);
> +	free(label);
> +}
> +
> +static int bisect_write(const char *state, const char *rev,
> +			const struct bisect_terms *terms, int nolog)
> +{
> +	struct strbuf tag = STRBUF_INIT;
> +	struct object_id oid;
> +	struct commit *commit;
> +	FILE *fp = NULL;
> +	int retval = 0;
> +
> +	if (!strcmp(state, terms->term_bad)) {
> +		strbuf_addf(&tag, "refs/bisect/%s", state);
> +	} else if (one_of(state, terms->term_good, "skip", NULL)) {
> +		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
> +	} else {
> +		error(_("Bad bisect_write argument: %s"), state);
> +		goto fail;
> +	}
> +
> +	if (get_oid(rev, &oid)) {
> +		error(_("couldn't get the oid of the rev '%s'"), rev);
> +		goto fail;
> +	}
> +
> +	if (update_ref(NULL, tag.buf, &oid, NULL, 0,
> +		       UPDATE_REFS_MSG_ON_ERR))
> +		goto fail;
> +
> +	fp = fopen(git_path_bisect_log(), "a");
> +	if (!fp) {
> +		error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
> +		goto fail;
> +	}
> +
> +	commit = lookup_commit_reference(&oid);
> +	log_commit(fp, "%s", state, commit);
> +
> +	if (!nolog)
> +		fprintf(fp, "git bisect %s %s\n", state, rev);
> +
> +	goto finish;
> +
> +fail:
> +	retval = -1;
> +finish:
> +	if (fp)
> +		fclose(fp);
> +	strbuf_release(&tag);
> +	return retval;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -153,9 +241,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		WRITE_TERMS,
>  		BISECT_CLEAN_STATE,
>  		CHECK_EXPECTED_REVS,
> -		BISECT_RESET
> +		BISECT_RESET,
> +		BISECT_WRITE
>  	} cmdmode = 0;
> -	int no_checkout = 0;
> +	int no_checkout = 0, res = 0;
>  	struct option options[] = {
>  		OPT_CMDMODE(0, "next-all", &cmdmode,
>  			 N_("perform 'git bisect next'"), NEXT_ALL),
> @@ -167,10 +256,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
>  		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
>  			 N_("reset the bisection state"), BISECT_RESET),
> +		OPT_CMDMODE(0, "bisect-write", &cmdmode,
> +			 N_("update the refs according to the bisection state and may write it to BISECT_LOG"), BISECT_WRITE),

Is the "... and may write it to" necessary? ;-)
[The original was just: "write out the bisection state in BISECT_LOG"]

ATB,
Ramsay Jones

