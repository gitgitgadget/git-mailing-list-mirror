Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B74E1F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 00:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758453AbdKHAHN (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:07:13 -0500
Received: from avasout04.plus.net ([212.159.14.19]:33812 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751566AbdKHAHN (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2017 19:07:13 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id CDtee1o0CzbmWCDtfe2QgO; Wed, 08 Nov 2017 00:07:11 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=dIu3SnmMAAAA:8 a=UsysoTnl0L_OJJCZmwgA:9
 a=QEXdDO2ut3YA:10 a=Ua9G7VpiFza3u12uuhVB:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v16 Part II 1/8] bisect--helper: `bisect_reset` shell
 function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <272aaa88-99c2-83a8-7343-c65797566a14@ramsayjones.plus.com>
Date:   Wed, 8 Nov 2017 00:07:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLkKVNqEYD3wDeOeCZ6r4NaHJnd4lDgeJrso+b9joVJsIna18cx3hD5gdmmKj9V1CDStyehC8ueokQlo45keoJrtY7gQH3Hz/s/u5Syirikk/CbtBLj8
 p1+TAqgcFadt8bV5SznM94NneojGZIDY8IU+N6uhj2ioNh2DsN1dumwtCmM837MdXGYT+SMjDE89ZA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/10/17 16:06, Pranit Bauva wrote:
> Reimplement `bisect_reset` shell function in C and add a `--bisect-reset`
> subcommand to `git bisect--helper` to call it from git-bisect.sh .
> 
> Using `bisect_reset` subcommand is a temporary measure to port shell
> functions to C so as to use the existing test suite. As more functions
> are ported, this subcommand would be retired but its implementation will
> be called by some other method.
> 
> Note: --bisect-clean-state subcommand has not been retired as there are
> still a function namely `bisect_start()` which still uses this
> subcommand.
> 
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> 
> ---
[snip]

Sorry for not responding sooner, I've been a bit busy.

Unfortunately, I have only had time to skim the patches, but
I haven't noticed anything too serious.

>  builtin/bisect--helper.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++-
>  git-bisect.sh            | 28 ++-------------------------
>  2 files changed, 50 insertions(+), 27 deletions(-)
> 
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 35d2105f941c6..12754448f7b6a 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -3,15 +3,21 @@
>  #include "parse-options.h"
>  #include "bisect.h"
>  #include "refs.h"
> +#include "dir.h"
> +#include "argv-array.h"
> +#include "run-command.h"
>  
>  static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
>  static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
>  static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
> +static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
> +static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
>  
>  static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --next-all [--no-checkout]"),
>  	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
>  	N_("git bisect--helper --bisect-clean-state"),
> +	N_("git bisect--helper --bisect-reset [<commit>]"),
>  	NULL
>  };
>  
> @@ -106,13 +112,48 @@ static void check_expected_revs(const char **revs, int rev_nr)
>  	}
>  }
>  
> +static int bisect_reset(const char *commit)
> +{
> +	struct strbuf branch = STRBUF_INIT;
> +
> +	if (!commit) {
> +		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1)
> +			return !printf(_("We are not bisecting.\n"));

I've no idea what this is about! If printf encounters an error, then
this will be equivalent to !-1. If printf does not encounter an error,
then this will be !<length of output> (whatever that may be, given that
the string is marked for translation).

I would suggest that you don't want to do that. ;-)

ATB,
Ramsay Jones

