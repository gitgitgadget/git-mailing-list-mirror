Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00BDCDB482
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjJKWJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjJKWJx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:09:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8BCBA
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:09:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 566E31CEB4;
        Wed, 11 Oct 2023 18:09:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=0eVK+IjZNicBHFwwvaxkMIJdHnBEcnQvG4V+5R
        v19X8=; b=NHCkvqmThovWo2qhcUA5/78qk0h8Pi7T/QDfcrY2qD94elLhzhoqNJ
        4H/MMLYkhSY57iphSrNWYbGIcpQypwrmkvTpG06HjQy1Li2SuV+7TKM0V5C7eswF
        u/CkvrCXGUwwt4lh1bl4WTW0V3caJBNPxmbBT8Qz8RYcoLic6M29E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EEA41CEB3;
        Wed, 11 Oct 2023 18:09:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 821EC1CEB2;
        Wed, 11 Oct 2023 18:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 0/2] attr: add attr.tree config
In-Reply-To: <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Wed, 11 Oct 2023 17:13:40 +0000")
References: <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com>
        <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
Date:   Wed, 11 Oct 2023 15:09:45 -0700
Message-ID: <xmqqjzrskdzq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E402F318-6882-11EE-97E3-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> 44451a2e5e (attr: teach "--attr-source=" global option to "git", 2023-05-06)
> provided the ability to pass in a treeish as the attr source. When a
> revision does not resolve to a valid tree is passed, Git will die. At
> GitLab, we server repositories as bare repos and would like to always read
> attributes from the default branch, so we'd like to pass in HEAD as the
> treeish to read gitattributes from on every command. In this context we
> would not want Git to die if HEAD is unborn, like in the case of empty
> repositories.
>
> Instead of modifying the default behavior of --attr-source, create a new
> config attr.tree with which an admin can configure a ref for all commands to
> read gitattributes from. Also make the default tree to read from HEAD on
> bare repositories.
>
> Changes since v2:
>
>  * relax the restrictions around attr.tree so that if it does not resolve to
>    a valid treeish, ignore it.
>  * add a commit to default to HEAD in bare repositories
>
> Changes since v1:
>
>  * Added a commit to add attr.tree config

THis is v4 so there must be some changes since v3 that we are missing?

> Range-diff vs v3:
>
>  1:  cef206d47c7 ! 1:  eaa27c47810 attr: read attributes from HEAD when bare repo
>      @@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattr
>       +test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
>       +	test_when_finished rm -rf test bare_with_gitattribute &&
>       +	git init test &&
>      -+	(
>      -+		cd test &&
>      -+		test_commit gitattributes .gitattributes "f/path test=val"
>      -+	) &&
>      ++	test_commit -C test gitattributes .gitattributes "f/path test=val" &&

OK.

>  2:  dadb822da99 ! 2:  749d8a8082e attr: add attr.tree for setting the treeish to read attributes from
>      @@ Documentation/config.txt: other popular tools, and describe them in your documen
>       
>        ## Documentation/config/attr.txt (new) ##
>       @@
>      -+attr.tree:
>      -+	A <tree-ish> to read gitattributes from instead of the worktree. See
>      -+	linkgit:gitattributes[5]. If `attr.tree` does not resolve to a valid tree,
>      -+	treat it as an empty tree. --attr-source and GIT_ATTR_SOURCE take
>      -+	precedence over attr.tree.
>      ++attr.tree::
>      ++	A reference to a tree in the repository from which to read attributes,
>      ++	instead of the `.gitattributes` file in the working tree. In a bare
>      ++	repository, this defaults to `HEAD:.gitattributes`. If the value does
>      ++	not resolve to a valid tree object, an empty tree is used instead.
>      ++	When the `GIT_ATTR_SOURCE` environment variable or `--attr-source`
>      ++	command line option are used, this configuration variable has no effect.

OK.

>      -+	if (!default_attr_source_tree_object_name) {
>      ++	if (!default_attr_source_tree_object_name && git_attr_tree) {
>       +		default_attr_source_tree_object_name = git_attr_tree;
>       +		ignore_bad_attr_tree = 1;
>       +	}

Makes sense.

>      @@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattr
>        
>       +bad_attr_source_err="fatal: bad --attr-source or GIT_ATTR_SOURCE"
>       +
>      ++test_expect_success '--attr-source is bad' '
>      ++	test_when_finished rm -rf empty &&
>      ++	git init empty &&
>      ++	(
>      ++		cd empty &&
>      ++		echo "$bad_attr_source_err" >expect_err &&
>      ++		test_must_fail git --attr-source=HEAD check-attr test -- f/path 2>err &&
>      ++		test_cmp expect_err err
>      ++	)
>      ++'

OK.  We fail when explicitly given a bad attr-source.

>       +test_expect_success 'attr.tree when HEAD is unborn' '
>       +	test_when_finished rm -rf empty &&
>       +	git init empty &&
>       +	(
>       +		cd empty &&
>      -+		echo $bad_attr_source_err >expect_err &&
>       +		echo "f/path: test: unspecified" >expect &&
>       +		git -c attr.tree=HEAD check-attr test -- f/path >actual 2>err &&
>       +		test_must_be_empty err &&

But we silently ignore when given via a configuration variable.

>      @@ t/t0003-attributes.sh: test_expect_success 'bare repository: check that .gitattr
>       +	git init empty &&
>       +	(
>       +		cd empty &&
>      -+		echo $bad_attr_source_err >expect_err &&
>       +		echo "f/path: test: unspecified" >expect &&
>       +		git -c attr.tree=refs/does/not/exist check-attr test -- f/path >actual 2>err &&
>       +		test_must_be_empty err &&

Ditto.  Is this any different from the above?  Both points at an
object that does not exist.  If one were pointing at an object that
does not exist (e.g., HEAD before the initial commit) and the other
were pointing at an object that is not a tree-ish (e.g., a blob),
then having two separate tests may make sense, but otherwise, I am
not sure about the value proposition of the second test.

>      @@ t/t0003-attributes.sh: test_expect_success 'bare repo defaults to reading .gitat
>        	test_cmp expect actual
>        '
>        
>      -+test_expect_success '--attr-source and GIT_ATTR_SOURCE take precedence over attr.tree' '
>      ++test_expect_success 'precedence of --attr-source, GIT_ATTR_SOURCE, then attr.tree' '
>       +	test_when_finished rm -rf empty &&
>       +	git init empty &&
>       +	(
>      @@ t/t0003-attributes.sh: test_expect_success 'bare repo defaults to reading .gitat
>       +		test_commit "val2" .gitattributes "f/path test=val2" &&
>       +		git checkout attr-source &&
>       +		echo "f/path: test: val1" >expect &&
>      -+		git -c attr.tree=attr-tree --attr-source=attr-source check-attr test -- f/path >actual &&
>      ++		GIT_ATTR_SOURCE=attr-source git -c attr.tree=attr-tree --attr-source=attr-source \
>      ++		check-attr test -- f/path >actual &&
>       +		test_cmp expect actual &&
>      -+		GIT_ATTR_SOURCE=attr-source git -c attr.tree=attr-tree check-attr test -- f/path >actual &&
>      ++		GIT_ATTR_SOURCE=attr-source git -c attr.tree=attr-tree \
>      ++		check-attr test -- f/path >actual &&
>       +		test_cmp expect actual
>       +	)
>       +'

Looking good.

Thanks.  Queued.
