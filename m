Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897023D2A4
	for <git@vger.kernel.org>; Tue, 12 May 2026 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583309; cv=none; b=qz2kqo7lJSCCQvcmwXxMoh5wvlq3mq92w5+nU3MdWBhZDF3Ezsei7Vo6h5K9HA9yvnjqGwVXobwltOxWtOJO8FnA6xsW3mv80kZdFEi31HcAc02+6DLxawtHY7WlQbFIHJmCHH0VzwQoBmdog03LicZbnhQfb459VLKaxzqw/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583309; c=relaxed/simple;
	bh=Eoqx/Kg81DEcuFKasH7HEpY8H234sPgTLdRTbJaEIOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=liZVpySftlq69Vp65SSfzG5lp4X5Jfy/19tV791tg5xcqXPznkvblSK5zg1ub6IZhkZL6c91vjPF5Nma7r9FKeSfLrvuWo5vnkD+XMc/2TATceQRbdbfr66HSR3KnhmSrsEgr7pmT6tbXPq+3CfoWI/5OvM3Ojz8X+XAiv9XvPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=QsJEm5iq; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="QsJEm5iq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1778583303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=crmJkDRWLbvkNI5/DQIfvdwgrYynpToOVpu2N+K3TZI=;
	b=QsJEm5iqTQsjeRmNvev1Ln6c7nfs5YjiCpHJor1w/rb9v0GURgqJjNSQT4RXwBE55OkFdn
	n6csE49F/yAehqnhqy9oj0+CPXYd5nrciG4H/fIKDo3QROOf9j/GZN2pESqQ5dQgiwsIuR
	6el7nQijwmuhDg6DP+byB2f3lpyJYYI=
From: Toon Claes <toon@iotcl.com>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Johannes Schindelin <johannes.schindelin@gmx.de>, Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC 4/5] test-tool: add a "historian" subcommand for
 building merge fixtures
In-Reply-To: <72c486312cde9a9fd2dedb60bc43c5c3e40a0d64.1778107405.git.gitgitgadget@gmail.com>
References: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
 <72c486312cde9a9fd2dedb60bc43c5c3e40a0d64.1778107405.git.gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 12:54:50 +0200
Message-ID: <87lddooq2t.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The merge-replay tests added in a follow-up commit need a way to set
> up specific topologies with full control over blob contents, parent
> order, and per-side trees. Sequencing plumbing commands or driving
> plain `git fast-import` from shell quickly becomes unreadable for
> the kinds of scenarios that exercise non-trivial merge resolution
> (textual conflicts, semantic edits outside the conflict region,
> intentional limitations such as new content on one side).
>
> Add a small `test-tool historian` subcommand that reads a tight,
> shell-quoted, one-line-per-object DSL and feeds an equivalent stream
> to a `git fast-import` child process. Each blob and commit is given
> a logical name; the helper allocates fast-import marks on first use
> and emits a lightweight tag for every commit so tests can refer to
> the resulting object via `refs/tags/<name>`.
>
> The DSL has just two directives:
>
>   blob NAME LINE...
>   commit NAME BRANCH SUBJECT [from=NAME] [merge=NAME]... [PATH=BLOB]...
>
> A blob's content is the listed lines joined with `\n` (and a final
> `\n`); a commit's tree is exactly the listed PATH=BLOB pairs (the
> helper emits a `deleteall` so nothing leaks in from the implicit
> parent). Token splitting is delegated to `split_cmdline()` so quoted
> arguments work as in shell. Marks for parent references and file
> contents go through the same `strintmap`-backed name resolver, which
> keeps the helper itself trivially small: blob writing, tree
> construction, commit creation and merge-base computation are all
> handled by `git fast-import`.
>
> Note that the DSL reserves the names `from` and `merge` (with a
> trailing `=`) for parent specification; a tree path called `from` or
> `merge` cannot be expressed via this helper. That is acceptable here
> because every input is a tightly controlled test fixture and the
> filenames are chosen by the test author.
>
> The helper trusts its caller: malformed input results in a
> fast-import error rather than a friendly diagnostic.
>
> Wire the new subcommand into the Makefile and meson build, register
> it in `t/helper/test-tool.{c,h}`.
>
> Assisted-by: Claude Opus 4.7
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Makefile                  |   1 +
>  t/helper/meson.build      |   1 +
>  t/helper/test-historian.c | 189 ++++++++++++++++++++++++++++++++++++++
>  t/helper/test-tool.c      |   1 +
>  t/helper/test-tool.h      |   1 +
>  5 files changed, 193 insertions(+)
>  create mode 100644 t/helper/test-historian.c
>
> diff --git a/Makefile b/Makefile
> index cedc234173..b38678b484 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -832,6 +832,7 @@ TEST_BUILTINS_OBJS += test-hash-speed.o
>  TEST_BUILTINS_OBJS += test-hash.o
>  TEST_BUILTINS_OBJS += test-hashmap.o
>  TEST_BUILTINS_OBJS += test-hexdump.o
> +TEST_BUILTINS_OBJS += test-historian.o
>  TEST_BUILTINS_OBJS += test-json-writer.o
>  TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
>  TEST_BUILTINS_OBJS += test-match-trees.o
> diff --git a/t/helper/meson.build b/t/helper/meson.build
> index 675e64c010..704edd1e1f 100644
> --- a/t/helper/meson.build
> +++ b/t/helper/meson.build
> @@ -29,6 +29,7 @@ test_tool_sources = [
>    'test-hash.c',
>    'test-hashmap.c',
>    'test-hexdump.c',
> +  'test-historian.c',
>    'test-json-writer.c',
>    'test-lazy-init-name-hash.c',
>    'test-match-trees.c',
> diff --git a/t/helper/test-historian.c b/t/helper/test-historian.c
> new file mode 100644
> index 0000000000..2250d420c0
> --- /dev/null
> +++ b/t/helper/test-historian.c
> @@ -0,0 +1,189 @@
> +/*
> + * Build a small history out of a tiny declarative input. Used by tests
> + * that need specific merge topologies without long sequences of
> + * plumbing commands or fragile shell helpers.
> + *
> + * The historian reads stdin line by line and emits an equivalent
> + * stream to a `git fast-import` child process. It also allocates marks
> + * for named objects so tests can refer to commits and blobs by name.

Really appreciate you're introducing this command. I'm actually
surprised no else did before.

> + *
> + * Input directives (one per line, shell-style quoting):
> + *
> + *	blob NAME LINE1 LINE2 ...
> + *	    Each LINE becomes a content line in the blob; lines are
> + *	    joined with '\n' and the blob ends with a final '\n'. With
> + *	    no LINEs, the blob is empty.
> + *
> + *	commit NAME BRANCH SUBJECT [from=PARENT] [merge=PARENT]... [PATH=BLOB]...

I'm not sure how I feel about mixing named arguments (like `from=PARENT`) with
the `PATH=BLOB` arguments? Obviously this tool isn't made for anything
that's even close to production, but still feels strange. How about
putting a double dash (`--`) before the paths, or using the `PATH:BLOB`
syntax instead?

> + *	    Creates a commit on refs/heads/BRANCH using the listed
> + *	    file=blob mappings as the entire tree (no inheritance from
> + *	    parents). Up to one `from=` and any number of `merge=`
> + *	    parents may be given. `from=` defaults to the current branch
> + *	    tip; if BRANCH has no tip yet, the commit becomes a root.

At GitLab in our Gitaly suite we have a similar tool as what you're
introducing here, but there you have to specify the parent(s) for each
commit and if you want to assign a ref to a commit, you have to be
explicit about it. So I would replace `from=` and `merge=` with
`parent=` and allow that to be occur zero or more times (this would also
allow creating unrelated histories). And remove the mandatory argument
BRANCH, and instead allow the command to accept a `branch=` argument.

If we'd take an example from the follow-up commit:

        # Setup:
        #       A (a) --- C (a, h) ----+--- M (a, g, h)
        #        \                    /
        #         +-- B (a, g) ------+
        #
        # Topic touches `g` only; main touches `h` only. The auto-merge
        # at M is clean.
        blob a "shared content"
        blob g guarded
        blob h host
        commit A main "A" a=a
        commit B topic "B (introduces g)" from=A a=a g=g
        commit C main "C (introduces h)" a=a h=h
        commit M main "Merge topic" merge=B a=a g=g h=h

I would suggest to rewrite that to:

        blob a "shared content"
        blob g guarded
        blob h host
        commit A "A" a:a
        commit B "B (introduces g)" parent=A branch=topic a:a g:g
        commit C "C (introduces h)" parent=A a:a h:h
        commit M "Merge topic" parent=A parent=B ref=main a:a g:g h:h

I realize this is less alike to git-fast-import(1), so I'd understand if
you'd reject this idea.


-- 
Cheers,
Toon
