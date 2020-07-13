Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3D9C433DF
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 18:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54AB920663
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 18:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OKQFiurl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgGMSGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:06:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60920 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgGMSGV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 14:06:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0614CCCDE5;
        Mon, 13 Jul 2020 14:06:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AGKY/lXUuPvFVuaKm36Dcdgmk50=; b=OKQFiu
        rlO/0lQXT5WcPaJkIoZ6bw72IXiwIi1VR/p/7TUjisNNOUu6VjPZxbnPpcOg6uaT
        Zli5By2xLoJm00ZuFQshEXzclkARPTEjDob88VKL9C9Ar91xe3/kR89LhhkBIvOA
        askrCTzjc8CkppHfq7gB7tEUbNxk3wVgWQlao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qxDzv2/5e45ALkVx0YDqsD2gAO6X1sBD
        3w78jhUBngI3hOBT/Jq9ctCgiDc9jzaOa2E3fyvyMbeUfvvJtqgYD1SNMRPCaZCg
        VFvnG/g/nqVOzGmbxMQw+WZTLApqPLRnHmKxe5mBgcG8sBi8ZrJYPewPEdoHM/MD
        0bt88gTeZ1k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1D29CCDE4;
        Mon, 13 Jul 2020 14:06:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EBFA5CCDE3;
        Mon, 13 Jul 2020 14:06:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: [PATCH] fetch: optionally allow disabling FETCH_HEAD update
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
        <xmqqimetrcay.fsf@gitster.c.googlers.com>
        <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
        <xmqqblkkr63u.fsf@gitster.c.googlers.com>
        <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
        <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
        <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org>
        <xmqqk0z7nxs7.fsf@gitster.c.googlers.com>
Date:   Mon, 13 Jul 2020 11:06:09 -0700
In-Reply-To: <xmqqk0z7nxs7.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 13 Jul 2020 10:13:28 -0700")
Message-ID: <xmqqft9vnvce.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8859A3CC-C533-11EA-80A2-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you run fetch but record the result in remote-tracking branches,
and either if you do nothing with the fetched refs (e.g. you are
merely mirroring) or if you always work from the remote-tracking
refs (e.g. you fetch and then merge origin/branchname separately),
you can get away without having FETCH_HEAD at all.

Teach "git fetch" a command line option "--[no-]write-fetch-head"
and "fetch.writeFetchHEAD" configuration variable.  Without either,
the default is to write FETCH_HEAD, and the usual rule that the
command line option defeats configured default applies.

Note that under "--dry-run" mode, FETCH_HEAD is never written;
otherwise you'd see list of objects in the file that you do not
actually have.

Also note that this option is explicitly passed when "git pull"
internally invokes "git fetch", so that those who configured their
"git fetch" not to write FETCH_HEAD would not be able to break the
cooperation between these two commands.  "git pull" must see what
"git fetch" got recorded in FETCH_HEAD to work correctly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    Junio C Hamano <gitster@pobox.com> writes:

    > Johannes Sixt <j6t@kdbg.org> writes:
    >
    >> Nah, really??? It's one of the benefits of git-fetch that it writes
    >> FETCH_HEAD and the primary reason in many cases where I use the command!
    >> So, either I don't care that FETCH_HEAD is written, or I do use it. IMO,
    >> not wanting to write FETCH_HEAD is the odd case and would need a
    >> configuration tweak, not the other way round.
    >
    > Yeah, that's even easier to arrange.  
    >
    > Just the "--[no-]write-fetch-head" command line option and the
    > fetch.writeFetchHEAD configuration variable are introduced and left
    > off by default forever.

    Something like this, perhaps.  Obviously I won't be pushing this
    topic further while in prerelase freeze, but Konstantin or
    anybody else interested can locally apply the patch to their own
    copy of Git to test it out.

    Thanks.

 builtin/fetch.c  | 19 ++++++++++++++++---
 builtin/pull.c   |  3 ++-
 t/t5510-fetch.sh | 39 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 82ac4be8a5..3ccf69753f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -56,6 +56,7 @@ static int prune_tags = -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
 
 static int all, append, dry_run, force, keep, multiple, update_head_ok;
+static int write_fetch_head = 1;
 static int verbosity, deepen_relative, set_upstream;
 static int progress = -1;
 static int enable_auto_gc = 1;
@@ -118,6 +119,10 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.writefetchhead")) {
+		write_fetch_head = git_config_bool(k, v);
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -162,6 +167,8 @@ static struct option builtin_fetch_options[] = {
 		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 	OPT_BOOL(0, "dry-run", &dry_run,
 		 N_("dry run")),
+	OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
+		 N_("write fetched references to the FETCH_HEAD file")),
 	OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
 	OPT_BOOL('u', "update-head-ok", &update_head_ok,
 		    N_("allow updating of HEAD ref")),
@@ -893,7 +900,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
-	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head(the_repository);
+	const char *filename = (!write_fetch_head
+				? "/dev/null"
+				: git_path_fetch_head(the_repository));
 	int want_status;
 	int summary_width = transport_summary_width(ref_map);
 
@@ -1327,7 +1336,7 @@ static int do_fetch(struct transport *transport,
 	}
 
 	/* if not appending, truncate FETCH_HEAD */
-	if (!append && !dry_run) {
+	if (!append && write_fetch_head) {
 		retcode = truncate_fetch_head();
 		if (retcode)
 			goto cleanup;
@@ -1594,7 +1603,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 	int i, result = 0;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
-	if (!append && !dry_run) {
+	if (!append && write_fetch_head) {
 		int errcode = truncate_fetch_head();
 		if (errcode)
 			return errcode;
@@ -1795,6 +1804,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
+	/* FETCH_HEAD never gets updated in --dry-run mode */
+	if (dry_run)
+		write_fetch_head = 0;
+
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
diff --git a/builtin/pull.c b/builtin/pull.c
index 8159c5d7c9..e988d92b53 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -527,7 +527,8 @@ static int run_fetch(const char *repo, const char **refspecs)
 	struct argv_array args = ARGV_ARRAY_INIT;
 	int ret;
 
-	argv_array_pushl(&args, "fetch", "--update-head-ok", NULL);
+	argv_array_pushl(&args, "fetch", "--update-head-ok",
+			 "--write-fetch-head", NULL);
 
 	/* Shared options */
 	argv_push_verbosity(&args);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a66dbe0bde..3052c2d8d5 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -539,13 +539,48 @@ test_expect_success 'fetch into the current branch with --update-head-ok' '
 
 '
 
-test_expect_success 'fetch --dry-run' '
-
+test_expect_success 'fetch --dry-run does not touch FETCH_HEAD' '
 	rm -f .git/FETCH_HEAD &&
 	git fetch --dry-run . &&
 	! test -f .git/FETCH_HEAD
 '
 
+test_expect_success '--no-write-fetch-head does not touch FETCH_HEAD' '
+	rm -f .git/FETCH_HEAD &&
+	git fetch --no-write-fetch-head . &&
+	! test -f .git/FETCH_HEAD
+'
+
+test_expect_success '--write-fetch-head gets defeated by --dry-run' '
+	rm -f .git/FETCH_HEAD &&
+	git fetch --dry-run --write-fetch-head . &&
+	! test -f .git/FETCH_HEAD
+'
+
+test_expect_success 'fetch.writeFetchHEAD and FETCH_HEAD' '
+	rm -f .git/FETCH_HEAD &&
+	git -c fetch.writeFetchHEAD=no fetch . &&
+	! test -f .git/FETCH_HEAD
+'
+
+test_expect_success 'fetch.writeFetchHEAD gets defeated by --dry-run' '
+	rm -f .git/FETCH_HEAD &&
+	git -c fetch.writeFetchHEAD=yes fetch --dry-run . &&
+	! test -f .git/FETCH_HEAD
+'
+
+test_expect_success 'fetch.writeFetchHEAD and --no-write-fetch-head' '
+	rm -f .git/FETCH_HEAD &&
+	git -c fetch.writeFetchHEAD=yes fetch --no-write-fetch-head . &&
+	! test -f .git/FETCH_HEAD
+'
+
+test_expect_success 'fetch.writeFetchHEAD and --write-fetch-head' '
+	rm -f .git/FETCH_HEAD &&
+	git -c fetch.writeFetchHEAD=no fetch --write-fetch-head . &&
+	test -f .git/FETCH_HEAD
+'
+
 test_expect_success "should be able to fetch with duplicate refspecs" '
 	mkdir dups &&
 	(
-- 
2.28.0-rc0

