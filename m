Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E960D1F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 00:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758979AbdKHAtB (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:49:01 -0500
Received: from avasout04.plus.net ([212.159.14.19]:35623 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752720AbdKHAs7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2017 19:48:59 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id CEY5e1sE7zbmWCEY6e2Rix; Wed, 08 Nov 2017 00:48:58 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=VVlED5B4AAAA:8 a=pGLkceISAAAA:8 a=dIu3SnmMAAAA:8
 a=1GEu0c_66gakO7CShGgA:9 a=QEXdDO2ut3YA:10 a=Ua9G7VpiFza3u12uuhVB:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v16 Part II 5/8] bisect--helper: `bisect_next_check` shell
 function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee2ca-bf824205-86e6-4259-b7d7-a68e2fbb087d-000000@eu-west-1.amazonses.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <8d59ede3-043d-6a48-b290-bf4d49e650f1@ramsayjones.plus.com>
Date:   Wed, 8 Nov 2017 00:48:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0102015f5e5ee2ca-bf824205-86e6-4259-b7d7-a68e2fbb087d-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfM0m4/aJiOjeXYL+jfnm/Hs7XW8Z6KDM8QuppOoDa6N0fUd5nWQXBhwazRWf/qYUCQm84/tUaLqGkh+qTZ9zalRXq1dM7RmIPsmzhu7oay+GOxArt8GT
 89ERxEslt0rbtBtMyKjk6cGDKLevgRm0BBf6zIE0KZYloiD9R7N7JboeWzRu/rmp6HQvs2yIuOIQgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/10/17 16:06, Pranit Bauva wrote:
> Reimplement `bisect_next_check` shell function in C and add
> `bisect-next-check` subcommand to `git bisect--helper` to call it from
> git-bisect.sh .
> 
> `bisect_voc` shell function is no longer useful now and is replaced by
> using a char *[] of "new|bad" and "good|old" values.
> 
> Using `--bisect-next-check` is a temporary measure to port shell
> function to C so as to use the existing test suite. As more functions
> are ported, this subcommand will be retired but its implementation will
> be called by some other methods.
> 
> Helped-by: Stephan Beyer <s-beyer@gmx.net>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  builtin/bisect--helper.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++-
>  git-bisect.sh            | 60 +++----------------------------
>  2 files changed, 94 insertions(+), 57 deletions(-)
> 
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 65abf8a70c6d9..0f9c3e63821b8 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -6,6 +6,7 @@
>  #include "dir.h"
>  #include "argv-array.h"
>  #include "run-command.h"
> +#include "prompt.h"
>  
>  static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
>  static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
> @@ -21,6 +22,7 @@ static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --bisect-reset [<commit>]"),
>  	N_("git bisect--helper --bisect-write <state> <revision> <good_term> <bad_term> [<nolog>]"),
>  	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
> +	N_("git bisect--helper --bisect-next-check [<term>] <good_term> <bad_term>"),
>  	NULL
>  };
>  
> @@ -44,6 +46,11 @@ static void set_terms(struct bisect_terms *terms, const char *bad,
>  	terms->term_bad = xstrdup(bad);
>  }
>  
> +static const char *voc[] = {
> +	"bad|new",
> +	"good|old"
> +};
> +
In my version I had this instead:

+static const char *vocab_bad = "bad|new";
+static const char *vocab_good = "good|old";
+

which I prefer, because ...

>  /*
>   * Check whether the string `term` belongs to the set of strings
>   * included in the variable arguments.
> @@ -264,6 +271,79 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
>  	return 0;
>  }
>  
> +static int mark_good(const char *refname, const struct object_id *oid,
> +		     int flag, void *cb_data)
> +{
> +	int *m_good = (int *)cb_data;
> +	*m_good = 0;
> +	return 1;
> +}
> +
> +static int bisect_next_check(const struct bisect_terms *terms,
> +			     const char *current_term)
> +{
> +	int missing_good = 1, missing_bad = 1, retval = 0;
> +	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
> +	const char *good_glob = xstrfmt("%s-*", terms->term_good);
> +
> +	if (ref_exists(bad_ref))
> +		missing_bad = 0;
> +
> +	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
> +			     (void *) &missing_good);
> +
> +	if (!missing_good && !missing_bad)
> +		goto finish;
> +
> +	if (!current_term)
> +		goto fail;
> +
> +	if (missing_good && !missing_bad && current_term &&
> +	    !strcmp(current_term, terms->term_good)) {
> +		char *yesno;
> +		/*
> +		 * have bad (or new) but not good (or old). We could bisect
> +		 * although this is less optimum.
> +		 */
> +		fprintf(stderr, _("Warning: bisecting only with a %s commit\n"),
> +			terms->term_bad);
> +		if (!isatty(0))
> +			goto finish;
> +		/*
> +		 * TRANSLATORS: Make sure to include [Y] and [n] in your
> +		 * translation. The program will only accept English input
> +		 * at this point.
> +		 */
> +		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
> +		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
> +			goto fail;
> +
> +		goto finish;
> +	}
> +	if (!is_empty_or_missing_file(git_path_bisect_start())) {
> +		error(_("You need to give me at least one %s and "
> +			"%s revision. You can use \"git bisect %s\" "
> +			"and \"git bisect %s\" for that.\n"),
> +			voc[0], voc[1], voc[0], voc[1]);

... this is (arguably) easier to read:
+			vocab_bad, vocab_good, vocab_bad, vocab_good);

> +		goto fail;
> +	} else {
> +		error(_("You need to start by \"git bisect start\". You "
> +			"then need to give me at least one %s and %s "
> +			"revision. You can use \"git bisect %s\" and "
> +			"\"git bisect %s\" for that.\n"),
> +			voc[1], voc[0], voc[1], voc[0]);

ditto

ATB,
Ramsay Jones

