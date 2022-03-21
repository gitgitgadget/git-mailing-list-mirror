Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F3AC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 18:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352199AbiCUSgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 14:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiCUSgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 14:36:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202D175C18
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 11:34:44 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA45217886B;
        Mon, 21 Mar 2022 14:34:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xjL2lGA5yENfCNb68XFZRovj84CLHYBPgg/B1E
        nO4tU=; b=PSLod5Oqy6Q0ErK6qQqXdALmeDGxChgIzL4AqLYttXj6cyWhH3Puob
        GhD/bduHw4jBwxEgBj2gKK6X66ws1V8rtzHov+S36B7cCRPl95uwBw0OwaUq6bAT
        cLw8SSzUPsIxKqKzH3vUbuMFLEwDVfB2V2IOKkCl0EiNsqUjrpvTU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D2D5B17886A;
        Mon, 21 Mar 2022 14:34:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 46EFF178868;
        Mon, 21 Mar 2022 14:34:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        nksingh85@gmail.com, ps@pks.im,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 6/7] core.fsyncmethod: tests for batch mode
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <1937746df47eefecfc343e32eb9bf6c0949fb7b9.1647760561.git.gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 11:34:38 -0700
In-Reply-To: <1937746df47eefecfc343e32eb9bf6c0949fb7b9.1647760561.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Sun, 20 Mar 2022 07:15:59
        +0000")
Message-ID: <xmqqpmmfxigx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 910D5EDA-A945-11EC-9E90-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> Add test cases to exercise batch mode for:
>  * 'git add'

I was wondering why the obviously safe and good candidate 'git add' is
not gaining plug/unplug pair in this series.  It is obviously safe,
unlike 'update-index', that nobody can interact with it, observe its
intermediate output, and expect anything from it.

I think the stupid reason of the lack of new plug/unplug is because
we already had them, which is good ;-).

>  * 'git stash'
>  * 'git update-index'

As I said, I suspect that we'd want to do this safely by adding a
new option to "update-index" and passing it from "stash" which knows
that it does not care about the intermediate state.

> These tests ensure that the added data winds up in the object database.

In other words, "git add $path; git rev-parse :$path" (and its
cousins) would be happy?  Like new object files not left hanging in
a tentative object store etc. _after_ the commands finish.

Good.

> In this change we introduce a new test helper lib-unique-files.sh. The
> goal of this library is to create a tree of files that have different
> oids from any other files that may have been created in the current test
> repo. This helps us avoid missing validation of an object being added due
> to it already being in the repo.

More on this below.

> We aren't actually issuing any fsyncs in these tests, since
> GIT_TEST_FSYNC is 0, but we still exercise all of the tmp_objdir logic
> in bulk-checkin.

Shouldn't we manually override that, if it matters?
Not a suggestion but a question.

> +# Create multiple files with unique contents. Takes the number of
> +# directories, the number of files in each directory, and the base
> +# directory.

This is more honest, compared to the claim made in the proposed log
message, in that the uniqueness guarantee is only among the files
created by this helper.  If we created other test contents without
using this helper, that may crash with the ones created here.

> +# test_create_unique_files 2 3 my_dir -- Creates 2 directories with 3 files
> +#					 each in my_dir, all with unique
> +#					 contents.
> +
> +test_create_unique_files() {

Style.  SP on both sides of ().  I.e.

	test_create_unique_files () {

> +	test "$#" -ne 3 && BUG "3 param"
> +
> +	local dirs=$1
> +	local files=$2
> +	local basedir=$3
> +	local counter=0
> +	test_tick
> +	local basedata=$test_tick

I am not sure if consumption and reliance on tick is a wise thing.
$basedir must be unique across all the other directories in this
test repository (there is no other $basedir)---can't we key
uniqueness off of it?

> +	rm -rf $basedir

Can $basedir have any $IFS character in it?  We should "$quote" it.

> +	for i in $(test_seq $dirs)
> +	do
> +		local dir=$basedir/dir$i
> +
> +		mkdir -p "$dir"
> +		for j in $(test_seq $files)
> +		do
> +			counter=$((counter + 1))
> +			echo "$basedata.$counter"  >"$dir/file$j.txt"

An extra SP before ">"?

> +		done
> +	done
> +}

There is no &&- cascade here, and we expect nothing in this to
fail.  Is that sensible?

> +test_expect_success 'git add: core.fsyncmethod=batch' "
> +	test_create_unique_files 2 4 fsync-files &&
> +	git $BATCH_CONFIGURATION add -- ./fsync-files/ &&
> +	rm -f fsynced_files &&
> +	git ls-files --stage fsync-files/ > fsynced_files &&

Style.  No SP between redirection operator and its target.  I.e.

	git ls-files --stage fsync-files/ >fsynced_files &&

Mixture of names-with-dash and name_with_understore looks somewhat
irritating.

> +	test_line_count = 8 fsynced_files &&

The magic "8" matches "2 4" we saw earlier for create_unique_files?

> +	awk -- '{print \$2}' fsynced_files | xargs -n1 git cat-file -e

A test helper that takes the name of a file that has "ls-files -s" output
may prove to be useful.  I dunno.

> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index a11d61206ad..8e2f73cc68f 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -162,23 +162,25 @@ test_expect_success 'pack-objects with bogus arguments' '
>  
>  check_unpack () {
>  	test_when_finished "rm -rf git2" &&
> -	git init --bare git2 &&
> -	git -C git2 unpack-objects -n <"$1".pack &&
> -	git -C git2 unpack-objects <"$1".pack &&
> -	(cd .git && find objects -type f -print) |
> -	while read path
> -	do
> -		cmp git2/$path .git/$path || {
> -			echo $path differs.
> -			return 1
> -		}
> -	done
> +	git $2 init --bare git2 &&
> +	(
> +		git $2 -C git2 unpack-objects -n <"$1".pack &&
> +		git $2 -C git2 unpack-objects <"$1".pack &&
> +		git $2 -C git2 cat-file --batch-check="%(objectname)"
> +	) <obj-list >current &&
> +	cmp obj-list current
>  }

I think the change from the old "the existence and the contents of
the object files must all match" to the new "cat-file should say
that the objects we expect to exist indeed do" is not a bad thing.

We used to only depend on the contents of the provided packfile but
now we assume that obj-list file gives us the list of objects.  Is
that sensible?  I somehow do not think so.  Don't we have the
corresponding "$1.idx" that we can feed to "git show-index", e.g.

	git show-index <"$1.pack" >expect.full &&
	cut -d" " -f2 >expect <expect.full &&
	... your test in "$2", but feeding expect instead of obj-list ...
	test_cmp expect actual

Also make sure you quote whatever is coming from outside, even if
you happen to call the helper with tokens that do not need quoting
in the current code.  It is a good discipline to help readers.

Thanks.
