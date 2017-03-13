Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B80B202C1
	for <e@80x24.org>; Mon, 13 Mar 2017 00:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755893AbdCMAgz (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 20:36:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50351 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755840AbdCMAgs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 20:36:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C80146EE12;
        Sun, 12 Mar 2017 20:36:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lJ4YxvzKp2PYHp56BfmoYB4y9WI=; b=nortiq
        Efe0hkuULO+LdKTYFK4/4YApo5ZFFDupZksCkGla0MV5qcdUYTpdNd+32Yi7Yq2Q
        R/7X6S6zNFG1Pdku5U4KhCIze/chGz6XNFTKdFqy0qnn5SyH9X30SyBnHVOdMNVE
        qVXOD0U7FhvZWVZNxM1KNLWTzhLl9qiBFmxdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UL+JgWSjoBJZKiNLlYQCIOFUDULPDiWg
        l79pR/yoVjY9vHUQ4Z8drM+72G/jDvNyKFX4OigT6OyrL3rJWYoPAAF8asYiopCL
        3ViAoPQa6pvdwEjO0LNj48fh7LuXghS71jR/1eEExaGjtfNI1FCd0t1n47vleB6V
        yeZBqqb4tpM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF0116EE11;
        Sun, 12 Mar 2017 20:36:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20B716EE10;
        Sun, 12 Mar 2017 20:36:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nikhil Benesch <nikhil.benesch@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH 1/1] archive: learn to include submodules in output archive
References: <20170312075404.23951-1-nikhil.benesch@gmail.com>
        <20170312075404.23951-2-nikhil.benesch@gmail.com>
Date:   Sun, 12 Mar 2017 17:36:39 -0700
In-Reply-To: <20170312075404.23951-2-nikhil.benesch@gmail.com> (Nikhil
        Benesch's message of "Sun, 12 Mar 2017 03:54:04 -0400")
Message-ID: <xmqqtw6yt3l4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20441598-0785-11E7-8758-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nikhil Benesch <nikhil.benesch@gmail.com> writes:

> This commit is a revival of Lars Hjemli's 2009 patch to provide an
> option to include submodules in the output of `git archive`.
>
> The `--recurse-submodules` option (named consistently with fetch, clone,
> and ls-files) will recursively traverse submodules in the repository and
> consider their contents for inclusion in the output archive, subject to
> any pathspec filters. Like other commands that have learned
> `--recurse-submodules`, submodules that have not been checked out will
> not be traversed.
>
> Signed-off-by: Nikhil Benesch <nikhil.benesch@gmail.com>
> ---

I'll let others comment on the proposed log message.

> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> index cfa1e4ebe..f223f9e05 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -11,8 +11,8 @@ SYNOPSIS
>  [verse]
>  'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
>  	      [-o <file> | --output=<file>] [--worktree-attributes]
> -	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
> -	      [<path>...]
> +	      [--recurse-submodules] [--remote=<repo> [--exec=<git-upload-archive>]]
> +	      <tree-ish> [<path>...]

With the reflowing of lines it was not immediately obvious, but the
only change is to addd [--recurse-submodules] in front of the
existing [--remote=<repo>] option.  It would have probably made more
sense to add new things at the end, just because these options can
be given in any order.

> +--recurse-submodules::
> +	Recursively include the contents of any checked-out submodules in
> +	the archive.

OK.  

A question to the submodule folks: Is "checked-out" the right terminology
in this context?  I am wondering if we have reached more official set
of words to express submodule states discussed in [*1*].

> -	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
> -		if (args->verbose)
> -			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
> -		err = write_entry(args, sha1, path.buf, path.len, mode);
> -		if (err)
> -			return err;
> -		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
> -	}
> -
>  	if (args->verbose)
>  		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
> -	return write_entry(args, sha1, path.buf, path.len, mode);
> +	err = write_entry(args, sha1, path.buf, path.len, mode);
> +	if (err)
> +		return err;
> +	if (S_ISDIR(mode) || (S_ISGITLINK(mode) && args->recurse_submodules &&
> +			      !add_submodule_odb(path_without_prefix)))
> +		return READ_TREE_RECURSIVE;
> +	return 0;

So, we used to (and without the option we still) stop recursing when
we see a gitlink after asking write_entry() to write the path itself
out, but with the option, we keep going.

How does pathspec limiting work with this codepath?  If you have a
superproject with a regular file "sub/README" that belongs to the
superproject itself, and a submodule at "sub/module/", what makes
sure that this command

    $ git archive --recurse-submodules HEAD -- 'sub/R*' 'sub/module/lib/'

looks only in 'lib/' part of the submodule?

> diff --git a/t/t5005-archive-submodules.sh b/t/t5005-archive-submodules.sh
> new file mode 100755
> index 000000000..747e38627
> --- /dev/null
> +++ b/t/t5005-archive-submodules.sh
> @@ -0,0 +1,112 @@
> +#!/bin/sh
> +
> +test_description='git archive can include submodule content'
> +
> +. ./test-lib.sh
> +
> +add_file()
> +{

Style.  A shell function begins like so (see Documentation/CodingGuidelines):

	add_file () {

> +	git add $1 &&

Put dq around "$1" to make it easier to reuse, even if you know you
only happen to use pathnames without any $IFS whitespace characters.

I think all of these comments apply to the other shell function you
added to this file..

> +test_expect_success 'by default, submodules are not included' '
> +	echo "File 1" >1 &&
> +	add_file 1 &&
> +	add_submodule 2 3 &&
> +	add_submodule 4 5 &&
> +	cat <<EOF >expected &&
> +1
> +2/
> +4/
> +EOF

Use <<-EOF to allow you to indent your here-doc data.  Also when
your here-doc data does not need any $variable_interpolation, quote
the end marker to help reduce reviewer's mental burden, i.e.

	cat <<-\EOF >expected &&
	1
	2/
	4/
	EOF

The same comment applies to other tests (I won't even repeat this).

> +	git archive HEAD >normal.tar &&
> +	tar -tf normal.tar >actual &&

Lose "-" from "-tf"; that's the canonical and the most portable way
to spell the option to "tar".

> +test_expect_success 'packed submodules are supported' '
> +	msg=$(cd 2 && git repack -ad && git count-objects) &&
> +	test "$msg" = "0 objects, 0 kilobytes" &&
> +	git archive --recurse-submodules HEAD >packed.tar &&
> +	tar -tf packed.tar >actual &&
> +	test_cmp expected actual
> +'

I am not sure how packing would be expected to break anything, but
an extra test may not hurt.

I notice that you only test the case where the submodule's ".git" 
is embedded in its working tree (as opposed to ".git" being a
"gitdir:" file that points at the real location of the repository,
somewhere inside ".git/modules/" of the superproject).  You probably
want to make sure that also works, too.

I also notice that you do not use any pathspec in your "git archive"
invocation.  You'd want to make sure that works as expected.

Thanks.


[Reference]

*1* <20170209020855.23486-1-sbeller@google.com>
