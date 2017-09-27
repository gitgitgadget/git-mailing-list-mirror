Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E1E2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 23:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbdI0XTk (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 19:19:40 -0400
Received: from avasout08.plus.net ([212.159.14.20]:52437 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbdI0XTj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 19:19:39 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout08 with smtp
        id EnKc1w0050M91Ur01nKd5G; Thu, 28 Sep 2017 00:19:38 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=EJl26xRC c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=swZap-XzAAAA:8 a=R--0M-u41TAep-aT_5UA:9 a=QEXdDO2ut3YA:10
 a=ckTUcnKWf81qg4j9hmMM:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] fast-import: checkpoint: dump branches/tags/marks even if
 object_count==0
To:     Eric Rannaud <e@nanocritical.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jeremy.serror@gmail.com,
        "Shawn O . Pearce" <spearce@spearce.org>
References: <xmqqefqs7qx8.fsf@gitster.mtv.corp.google.com>
 <cccb06b75df3cad9f013d5a9ab0371f0a2d9c2ce.1506541322.git.e@nanocritical.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2a9cc69b-2e9f-7fe9-3c55-66ffe3060732@ramsayjones.plus.com>
Date:   Thu, 28 Sep 2017 00:19:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <cccb06b75df3cad9f013d5a9ab0371f0a2d9c2ce.1506541322.git.e@nanocritical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/09/17 20:46, Eric Rannaud wrote:
> The checkpoint command cycles packfiles if object_count != 0, a sensible
> test or there would be no pack files to write. Since 820b931012, the
> command also dumps branches, tags and marks, but still conditionally.
> However, it is possible for a command stream to modify refs or create
> marks without creating any new objects.
> 
> For example, reset a branch (and keep fast-import running):
> 
> 	$ git fast-import
> 	reset refs/heads/master
> 	from refs/heads/master^
> 
> 	checkpoint
> 
> but refs/heads/master remains unchanged.
> 
> Other example: a commit command that re-creates an object that already
> exists in the object database.
> 
> The man page also states that checkpoint "updates the refs" and that
> "placing a progress command immediately after a checkpoint will inform
> the reader when the checkpoint has been completed and it can safely
> access the refs that fast-import updated". This wasn't always true
> without this patch.
> 
> This fix unconditionally calls dump_{branches,tags,marks}() for all
> checkpoint commands. dump_branches() and dump_tags() are cheap to call
> in the case of a no-op.
> 
> Add tests to t9300 that observe the (non-packfiles) effects of
> checkpoint.
> 
> Signed-off-by: Eric Rannaud <e@nanocritical.com>
> ---
>  fast-import.c          |   6 +--
>  t/t9300-fast-import.sh | 129 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+), 3 deletions(-)
> 
> 
> Use named pipes instead of the polling approach. Also incorporate your other
> comments.
> 
> 
> diff --git a/fast-import.c b/fast-import.c
> index 35bf671f12c4..d5e4cf0bad41 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -3189,10 +3189,10 @@ static void checkpoint(void)
>  	checkpoint_requested = 0;
>  	if (object_count) {
>  		cycle_packfile();
> -		dump_branches();
> -		dump_tags();
> -		dump_marks();
>  	}
> +	dump_branches();
> +	dump_tags();
> +	dump_marks();
>  }
>  
>  static void parse_checkpoint(void)
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 67b8c50a5ab4..9aa3470d895b 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -3120,4 +3120,133 @@ test_expect_success 'U: validate root delete result' '
>  	compare_diff_raw expect actual
>  '
>  
> +###
> +### series V (checkpoint)
> +###
> +
> +# To make sure you're observing the side effects of checkpoint *before*
> +# fast-import terminates (and thus writes out its state), check that the
> +# fast-import process is still running using background_import_still_running
> +# *after* evaluating the test conditions.
> +background_import_until_checkpoint () {
> +	options=$1
> +	input_file=$2
> +
> +	mkfifo V.input

Since you are using mkfifo here ...

> +	exec 8<>V.input
> +	rm V.input
> +
> +	mkfifo V.output
> +	exec 9<>V.output
> +	rm V.output
> +
> +	cat $input_file >&8
> +	git fast-import $options <&8 >&9 &
> +	echo $! >V.pid
> +	test_when_finished "kill $(cat V.pid) || true"
> +
> +	error=0
> +	if read output <&9
> +	then
> +		if ! test "$output" = "progress checkpoint"
> +		then
> +			echo >&2 "no progress checkpoint received: $output"
> +			error=1
> +		fi
> +	else
> +		echo >&2 "failed to read fast-import output"
> +		error=1
> +	fi
> +
> +	exec 8>&-
> +	exec 9>&-
> +
> +	if test $error -eq 1
> +	then
> +		exit 1
> +	fi
> +}
> +
> +background_import_still_running () {
> +	if ! kill -0 "$(cat V.pid)"
> +	then
> +		echo >&2 "background fast-import terminated too early"
> +		exit 1
> +	fi
> +}
> +

... you need to set the PIPE prerequisite on all of your new tests.

> +test_expect_success 'V: checkpoint updates refs after reset' '
> +	cat >input <<-\INPUT_END &&
> +	reset refs/heads/V
> +	from refs/heads/U
> +
> +	checkpoint
> +	progress checkpoint
> +	INPUT_END
> +
> +	background_import_until_checkpoint "" input &&
> +	test "$(git rev-parse --verify V)" = "$(git rev-parse --verify U)" &&
> +	background_import_still_running
> +'

[snip]

ATB,
Ramsay Jones


