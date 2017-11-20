Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742B1202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 17:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbdKTR0n (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 12:26:43 -0500
Received: from e1i183.smtp2go.com ([103.36.108.183]:43332 "EHLO
        e1i183.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdKTR0m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 12:26:42 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Nov 2017 12:26:42 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=m1fbw0.a1-4.dyn; x=1511199702; h=Feedback-ID:
        X-Smtpcorp-Track:Date:Subject:To:From:Reply-To:Message-ID:Sender:
        List-Unsubscribe; bh=Gsvh4Btw/TSIGL1+pLvcsd8PnQ3DDrPtFCBQgGeMlks=; b=P0/Wf/d9
        lGj16VFgCX7AejnuvIR0Q62BroopAAPeGZrI4co+yzvmFAxPby+jwxMsyawY8Nl7cMDgf3f5n+KhP
        rhBm/diLDC3k+3JM/S459R1PLtD80pXa7vF5RSyu6shNNGHpoTSmPmtbn6pe60hANp9JENFCtZexF
        b8UDXPgeCCDBo/PLrqTjm4FkObDw0mLAFPIbnVSAWzsaxDSXOl97iK/jfOVrHwtZ5/xKqH/maKXa1
        sUFi33YfnpXZZpTDovHLFNTCGXQO6GcnmO1uomraCUGj7aM9RQP8S8vJgh6dGthZiItmJupXqUOUy
        lQO+ek65c9YC6jCKPew/fuNq0g==;
Message-ID: <B03A23EA75104E99BADBB420B6BEA614@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Stefan Beller" <sbeller@google.com>, <git@vger.kernel.org>
Cc:     <gitster@pobox.com>, <jonathantanmy@google.com>,
        "Stefan Beller" <sbeller@google.com>
References: <20171116020039.17810-1-sbeller@google.com> <20171116020039.17810-8-sbeller@google.com>
Subject: Re: [PATCHv5 7/7] builtin/describe.c: describe a blob
Date:   Mon, 20 Nov 2017 15:10:53 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1-GpMv9EFLrbOH.Ey7J_L0YL
Feedback-ID: 66524m:66524aMf6O2Y:66524s9IEG9PWyh:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse-contact@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Stefan Beller" <sbeller@google.com>
Sent: Thursday, November 16, 2017 2:00 AM

[in catch up mode..]

> Sometimes users are given a hash of an object and they want to
> identify it further (ex.: Use verify-pack to find the largest blobs,
> but what are these? or [1])
>
> When describing commits, we try to anchor them to tags or refs, as these
> are conceptually on a higher level than the commit. And if there is no ref
> or tag that matches exactly, we're out of luck.  So we employ a heuristic
> to make up a name for the commit. These names are ambiguous, there might
> be different tags or refs to anchor to, and there might be different
> path in the DAG to travel to arrive at the commit precisely.
>
> When describing a blob, we want to describe the blob from a higher layer
> as well, which is a tuple of (commit, deep/path) as the tree objects
> involved are rather uninteresting.  The same blob can be referenced by
> multiple commits, so how we decide which commit to use?  This patch
> implements a rather naive approach on this: As there are no back pointers
> from blobs to commits in which the blob occurs, we'll start walking from
> any tips available, listing the blobs in-order of the commit and once we
> found the blob, we'll take the first commit that listed the blob. For
> example
>
>  git describe --tags v0.99:Makefile
>  conversion-901-g7672db20c2:Makefile
>
> tells us the Makefile as it was in v0.99 was introduced in commit 
> 7672db20.
>
> The walking is performed in reverse order to show the introduction of a
> blob rather than its last occurrence.
>
> [1] https://stackoverflow.com/questions/223678/which-commit-has-this-blob
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> Documentation/git-describe.txt | 18 ++++++++++--
> builtin/describe.c             | 62 
> ++++++++++++++++++++++++++++++++++++++----
> t/t6120-describe.sh            | 34 +++++++++++++++++++++++
> 3 files changed, 107 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-describe.txt 
> b/Documentation/git-describe.txt
> index c924c945ba..e027fb8c4b 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -3,14 +3,14 @@ git-describe(1)
>
> NAME
> ----
> -git-describe - Describe a commit using the most recent tag reachable from 
> it
> -
> +git-describe - Give an object a human readable name based on an available 
> ref
>
> SYNOPSIS
> --------
> [verse]
> 'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] 
> [<commit-ish>...]
> 'git describe' [--all] [--tags] [--contains] 
> [--abbrev=<n>] --dirty[=<mark>]
> +'git describe' <blob>
>
> DESCRIPTION
> -----------
> @@ -24,6 +24,12 @@ By default (without --all or --tags) `git describe` 
> only shows
> annotated tags.  For more information about creating annotated tags
> see the -a and -s options to linkgit:git-tag[1].
>
> +If the given object refers to a blob, it will be described
> +as `<commit-ish>:<path>`, such that the blob can be found
> +at `<path>` in the `<commit-ish>`, which itself describes the
> +first commit in which this blob occurs in a reverse revision walk
> +from HEAD.
> +
> OPTIONS
> -------
> <commit-ish>...::
> @@ -186,6 +192,14 @@ selected and output.  Here fewest commits different 
> is defined as
> the number of commits which would be shown by `git log tag..input`
> will be the smallest number of commits possible.
>
> +BUGS
> +----
> +
> +Tree objects as well as tag objects not pointing at commits, cannot be 
> described.

Is this true? Is it stand alone from the describing of a blob? If so should 
it be its own patchlet. - I thought I'd read that within the series there is 
now a tree / tag (of blob/trees) description capability.

I'd prefer that we don't start with the "can't" view (relative to the 
subsequent sentences of the paragraph). It puts off the reader - we are 
about to say what can be described but in a limited way - the limitation 
being the bug. Maybe just swap the line to form a second paragraph.

> +When describing blobs, the lightweight tags pointing at blobs are 
> ignored,
> +but the blob is still described as <committ-ish>:<path> despite the 
> lightweight
> +tag being favorable.
> +
--
Philip

> GIT
> ---
> Part of the linkgit:git[1] suite
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 9e9a5ed5d4..5b4bfaba3f 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -3,6 +3,7 @@
> #include "lockfile.h"
> #include "commit.h"
> #include "tag.h"
> +#include "blob.h"
> #include "refs.h"
> #include "builtin.h"
> #include "exec_cmd.h"
> @@ -11,8 +12,9 @@
> #include "hashmap.h"
> #include "argv-array.h"
> #include "run-command.h"
> +#include "revision.h"
> +#include "list-objects.h"
>
> -#define SEEN (1u << 0)
> #define MAX_TAGS (FLAG_BITS - 1)
>
> static const char * const describe_usage[] = {
> @@ -434,6 +436,53 @@ static void describe_commit(struct object_id *oid, 
> struct strbuf *dst)
>  strbuf_addstr(dst, suffix);
> }
>
> +struct process_commit_data {
> + struct object_id current_commit;
> + struct object_id looking_for;
> + struct strbuf *dst;
> + struct rev_info *revs;
> +};
> +
> +static void process_commit(struct commit *commit, void *data)
> +{
> + struct process_commit_data *pcd = data;
> + pcd->current_commit = commit->object.oid;
> +}
> +
> +static void process_object(struct object *obj, const char *path, void 
> *data)
> +{
> + struct process_commit_data *pcd = data;
> +
> + if (!oidcmp(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
> + reset_revision_walk();
> + describe_commit(&pcd->current_commit, pcd->dst);
> + strbuf_addf(pcd->dst, ":%s", path);
> + free_commit_list(pcd->revs->commits);
> + pcd->revs->commits = NULL;
> + }
> +}
> +
> +static void describe_blob(struct object_id oid, struct strbuf *dst)
> +{
> + struct rev_info revs;
> + struct argv_array args = ARGV_ARRAY_INIT;
> + struct process_commit_data pcd = { null_oid, oid, dst, &revs};
> +
> + argv_array_pushl(&args, "internal: The first arg is not parsed",
> + "--objects", "--in-commit-order", "--reverse", "HEAD",
> + NULL);
> +
> + init_revisions(&revs, NULL);
> + if (setup_revisions(args.argc, args.argv, &revs, NULL) > 1)
> + BUG("setup_revisions could not handle all args?");
> +
> + if (prepare_revision_walk(&revs))
> + die("revision walk setup failed");
> +
> + traverse_commit_list(&revs, process_commit, process_object, &pcd);
> + reset_revision_walk();
> +}
> +
> static void describe(const char *arg, int last_one)
> {
>  struct object_id oid;
> @@ -445,11 +494,14 @@ static void describe(const char *arg, int last_one)
>
>  if (get_oid(arg, &oid))
>  die(_("Not a valid object name %s"), arg);
> - cmit = lookup_commit_reference(&oid);
> - if (!cmit)
> - die(_("%s is not a valid '%s' object"), arg, commit_type);
> + cmit = lookup_commit_reference_gently(&oid, 1);
>
> - describe_commit(&oid, &sb);
> + if (cmit)
> + describe_commit(&oid, &sb);
> + else if (lookup_blob(&oid))
> + describe_blob(oid, &sb);
> + else
> + die(_("%s is neither a commit nor blob"), arg);
>
>  puts(sb.buf);
>
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index c8b7ed82d9..4668f0058e 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -310,6 +310,40 @@ test_expect_success 'describe ignoring a broken 
> submodule' '
>  grep broken out
> '
>
> +test_expect_success 'describe a blob at a directly tagged commit' '
> + echo "make it a unique blob" >file &&
> + git add file && git commit -m "content in file" &&
> + git tag -a -m "latest annotated tag" unique-file &&
> + git describe HEAD:file >actual &&
> + echo "unique-file:file" >expect &&
> + test_cmp expect actual
> +'
> +
> +test_expect_success 'describe a blob with its first introduction' '
> + git commit --allow-empty -m "empty commit" &&
> + git rm file &&
> + git commit -m "delete blob" &&
> + git revert HEAD &&
> + git commit --allow-empty -m "empty commit" &&
> + git describe HEAD:file >actual &&
> + echo "unique-file:file" >expect &&
> + test_cmp expect actual
> +'
> +
> +test_expect_success 'describe directly tagged blob' '
> + git tag test-blob unique-file:file &&
> + git describe test-blob >actual &&
> + echo "unique-file:file" >expect &&
> + # suboptimal: we rather want to see "test-blob"
> + test_cmp expect actual
> +'
> +
> +test_expect_success 'describe tag object' '
> + git tag test-blob-1 -a -m msg unique-file:file &&
> + test_must_fail git describe test-blob-1 2>actual &&
> + grep "fatal: test-blob-1 is neither a commit nor blob" actual
> +'
> +
> test_expect_failure ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
>  i=1 &&
>  while test $i -lt 8000
> -- 
> 2.15.0.128.gcadd42da22
> 

