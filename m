Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FDB71F461
	for <e@80x24.org>; Wed, 15 May 2019 05:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEOFac (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 01:30:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62730 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfEOFac (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 01:30:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1F47E6A777;
        Wed, 15 May 2019 01:30:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2eOYmt5l8usqe1WNdtuGdndoOOk=; b=YqUz+D
        bHKe/vxMCWiyjS5K/o9foKbdujTGwlbwhkBUOB6Kln8vqz2gTaUIjImLhLbZtj2W
        kE3hfuPK4Y4CI8sIGQi7Z439WYfjhu/Fspcnr07xmhAKSUn5/g8nCxBxvdVrEe/H
        oOdAWLBU1O8uIE78VxF8bT1gHHwHS6EIBPsgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ng7ob4KHW3quxtStS/YdyhCuKTpg8vvK
        UtQpLllKh598HHNl4H7HFsWyPv9A1QAa7g+SwLbgQquqLS3Rh9Ue0sUbV3gDUG7W
        pQT00rVDbS05TG0okg8huquL8dFpHz+RQxyRezsM7fvI7NtgoNarSp4aVQ/fhf/b
        CLvp8UNbv70=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17D096A776;
        Wed, 15 May 2019 01:30:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 467536A775;
        Wed, 15 May 2019 01:30:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric Rannaud" <e@nanocritical.com>,
        Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: [PATCH v3] fast-import: checkpoint: only write out refs and tags if we changed them
References: <ad63393c24c7346c5b606b29579dfacad4d307f3.1557477247.git.e@nanocritical.com>
Date:   Wed, 15 May 2019 14:30:25 +0900
In-Reply-To: <ad63393c24c7346c5b606b29579dfacad4d307f3.1557477247.git.e@nanocritical.com>
        (Eric Rannaud's message of "Fri, 10 May 2019 01:41:15 -0700")
Message-ID: <xmqq8sv8709a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BD97A78-76D2-11E9-BD30-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric Rannaud" <e@nanocritical.com> writes:

> We now keep track of whether branches and tags have been changed by this
> fast-import process since our last checkpoint (or startup). At the next
> checkpoint, only refs and tags that new commands have changed are
> written to disk.

And when we notice that we have been competing with some other
process and the ref that we wanted to update has already been
updated to a different value, what happens?  That should be part of
the description of the new behaviour (aka "fix") written here.

> ---

Missing sign-off.

It sounds like a worthwhile thing to do.

It seems that Elijah has been active in fast-import/export area in
the last 12 months, so let's borrow a second set of eyes from him.

Thanks.

>  fast-import.c          |  14 ++++++
>  t/t9300-fast-import.sh | 106 ++++++++++++++++++++++++++++++++++-------
>  2 files changed, 104 insertions(+), 16 deletions(-)
>
>
> v2 and v1 were sent in Oct 2018. Only difference since is that the new
> test cases in t9300 don't use sleep to implement the asynchronous dance.
>
> Thanks.
>
>
> diff --git a/fast-import.c b/fast-import.c
> index f38d04fa5851..e9c3ea23ae42 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -103,6 +103,7 @@ struct branch {
>  	uintmax_t num_notes;
>  	unsigned active : 1;
>  	unsigned delete : 1;
> +	unsigned changed : 1;
>  	unsigned pack_id : PACK_ID_BITS;
>  	struct object_id oid;
>  };
> @@ -110,6 +111,7 @@ struct branch {
>  struct tag {
>  	struct tag *next_tag;
>  	const char *name;
> +	unsigned changed : 1;
>  	unsigned int pack_id;
>  	struct object_id oid;
>  };
> @@ -581,6 +583,7 @@ static struct branch *new_branch(const char *name)
>  	b->branch_tree.versions[1].mode = S_IFDIR;
>  	b->num_notes = 0;
>  	b->active = 0;
> +	b->changed = 0;
>  	b->pack_id = MAX_PACK_ID;
>  	branch_table[hc] = b;
>  	branch_count++;
> @@ -1571,6 +1574,10 @@ static int update_branch(struct branch *b)
>  	struct object_id old_oid;
>  	struct strbuf err = STRBUF_INIT;
>  
> +	if (!b->changed)
> +		return 0;
> +	b->changed = 0;
> +
>  	if (is_null_oid(&b->oid)) {
>  		if (b->delete)
>  			delete_ref(NULL, b->name, NULL, 0);
> @@ -1636,6 +1643,10 @@ static void dump_tags(void)
>  		goto cleanup;
>  	}
>  	for (t = first_tag; t; t = t->next_tag) {
> +		if (!t->changed)
> +			continue;
> +		t->changed = 0;
> +
>  		strbuf_reset(&ref_name);
>  		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
>  
> @@ -2679,6 +2690,7 @@ static void parse_new_commit(const char *arg)
>  
>  	if (!store_object(OBJ_COMMIT, &new_data, NULL, &b->oid, next_mark))
>  		b->pack_id = pack_id;
> +	b->changed = 1;
>  	b->last_commit = object_count_by_type[OBJ_COMMIT];
>  }
>  
> @@ -2763,6 +2775,7 @@ static void parse_new_tag(const char *arg)
>  		t->pack_id = MAX_PACK_ID;
>  	else
>  		t->pack_id = pack_id;
> +	t->changed = 1;
>  }
>  
>  static void parse_reset_branch(const char *arg)
> @@ -2783,6 +2796,7 @@ static void parse_reset_branch(const char *arg)
>  		b = new_branch(arg);
>  	read_next_command();
>  	parse_from(b);
> +	b->changed = 1;
>  	if (command_buf.len > 0)
>  		unread_command_buf = 1;
>  }
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 3668263c4046..12abaebb22b6 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -3121,14 +3121,23 @@ test_expect_success 'U: validate root delete result' '
>  ### series V (checkpoint)
>  ###
>  
> -# The commands in input_file should not produce any output on the file
> -# descriptor set with --cat-blob-fd (or stdout if unspecified).
> +# Instructions can be sent from $input_file to background_import() loop via the
> +# fast-import progress command.
> +# 
> +# 	progress do: shell
> +# Parse the next progress line and invoke it as a shell command.
> +# 
> +# 	progress do: checkpoint and stop
> +# Send checkpoint and wait for its completion.
> +# 
> +# 	progress do: stop
> +# Internal instruction.
>  #
>  # To make sure you're observing the side effects of checkpoint *before*
>  # fast-import terminates (and thus writes out its state), check that the
>  # fast-import process is still running using background_import_still_running
>  # *after* evaluating the test conditions.
> -background_import_then_checkpoint () {
> +background_import () {
>  	options=$1
>  	input_file=$2
>  
> @@ -3153,22 +3162,30 @@ background_import_then_checkpoint () {
>  	# pipes writing sequence. We want to assume that the write below could
>  	# block, e.g. if fast-import blocks writing its own output to &9
>  	# because there is no reader on &9 yet.
> -	(
> -		cat "$input_file"
> -		echo "checkpoint"
> -		echo "progress checkpoint"
> -	) >&8 &
> +	cat "$input_file" >&8 &
>  
>  	error=1 ;# assume the worst
>  	while read output <&9
>  	do
> -		if test "$output" = "progress checkpoint"
> +		if test "$output" = "progress do: shell"
> +		then
> +			read output <&9
> +			shell_cmd="$(echo $output |sed -e 's/^progress //')"
> +			$shell_cmd
> +		elif test "$output" = "progress do: checkpoint and stop"
> +		then
> +			(
> +				echo "checkpoint"
> +				echo "progress do: stop"
> +			) >&8 &
> +		elif test "$output" = "progress do: stop"
>  		then
>  			error=0
>  			break
> +		else
> +			# otherwise ignore cruft
> +			echo >&2 "cruft: $output"
>  		fi
> -		# otherwise ignore cruft
> -		echo >&2 "cruft: $output"
>  	done
>  
>  	if test $error -eq 1
> @@ -3189,10 +3206,11 @@ test_expect_success PIPE 'V: checkpoint helper does not get stuck with extra out
>  	cat >input <<-INPUT_END &&
>  	progress foo
>  	progress bar
> +	progress do: checkpoint and stop
>  
>  	INPUT_END
>  
> -	background_import_then_checkpoint "" input &&
> +	background_import "" input &&
>  	background_import_still_running
>  '
>  
> @@ -3201,9 +3219,11 @@ test_expect_success PIPE 'V: checkpoint updates refs after reset' '
>  	reset refs/heads/V
>  	from refs/heads/U
>  
> +	progress do: checkpoint and stop
> +
>  	INPUT_END
>  
> -	background_import_then_checkpoint "" input &&
> +	background_import "" input &&
>  	test "$(git rev-parse --verify V)" = "$(git rev-parse --verify U)" &&
>  	background_import_still_running
>  '
> @@ -3216,9 +3236,11 @@ test_expect_success PIPE 'V: checkpoint updates refs and marks after commit' '
>  	data 0
>  	from refs/heads/U
>  
> +	progress do: checkpoint and stop
> +
>  	INPUT_END
>  
> -	background_import_then_checkpoint "--export-marks=marks.actual" input &&
> +	background_import "--export-marks=marks.actual" input &&
>  
>  	echo ":1 $(git rev-parse --verify V)" >marks.expected &&
>  
> @@ -3237,9 +3259,11 @@ test_expect_success PIPE 'V: checkpoint updates refs and marks after commit (no
>  	data 0
>  	from refs/heads/U
>  
> +	progress do: checkpoint and stop
> +
>  	INPUT_END
>  
> -	background_import_then_checkpoint "--export-marks=marks.actual" input &&
> +	background_import "--export-marks=marks.actual" input &&
>  
>  	echo ":2 $(git rev-parse --verify V2)" >marks.expected &&
>  
> @@ -3255,13 +3279,63 @@ test_expect_success PIPE 'V: checkpoint updates tags after tag' '
>  	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
>  	data 0
>  
> +	progress do: checkpoint and stop
> +
>  	INPUT_END
>  
> -	background_import_then_checkpoint "" input &&
> +	background_import "" input &&
>  	git show-ref -d Vtag &&
>  	background_import_still_running
>  '
>  
> +test_expect_success PIPE 'V: checkpoint only resets changed branches' '
> +	cat >input <<-INPUT_END &&
> +	reset refs/heads/V3
> +	from refs/heads/U
> +
> +	checkpoint
> +
> +	progress do: shell
> +	progress git branch -f V3 V
> +
> +	reset refs/heads/V4
> +	from refs/heads/U
> +
> +	progress do: checkpoint and stop
> +
> +	INPUT_END
> +
> +	background_import "--force" input &&
> +	test "$(git rev-parse --verify V3)" = "$(git rev-parse --verify V)" &&
> +	background_import_still_running
> +'
> +
> +test_expect_success PIPE 'V: checkpoint only updates changed tags' '
> +	cat >input <<-INPUT_END &&
> +	tag Vtag2
> +	from refs/heads/U
> +	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +	data 0
> +
> +	checkpoint
> +
> +	progress do: shell
> +	progress git tag -f Vtag2 V
> +
> +	tag Vtag3
> +	from refs/heads/U
> +	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +	data 0
> +
> +	progress do: checkpoint and stop
> +
> +	INPUT_END
> +
> +	background_import "" input &&
> +	test "$(git show-ref -d Vtag2 |tail -1 |awk \{print\ \$1\})" = "$(git rev-parse --verify V)" &&
> +	background_import_still_running
> +'
> +
>  ###
>  ### series W (get-mark and empty orphan commits)
>  ###
