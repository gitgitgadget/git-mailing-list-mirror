Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364DAC433EA
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07ED42074F
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YnyRRDl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbgG1QiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:38:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52318 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731443AbgG1QiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:38:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B027576668;
        Tue, 28 Jul 2020 12:38:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1a7p3Y9VBSMEVAklb+nWiZIYltU=; b=YnyRRD
        l08GSrCAVyr5F+knIK/qvzf4SdeP3I0JEgw5N80seuLmk0zd50WeRlzZAlJGGhys
        7mgqLF9c7W1L42flQts07t5swkxCoqxe9Hy0j5DaTLOP3U/vS2C2UNwW8c2S/9/0
        bwh56qwvcLsGb4g5lgs0wp2+xA/JGH6CTPjS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fGou59ZDhoVIPxmD330e/weYLY5UkLte
        aHEpo8aqryt0QWP8E2RGtkFIV7i3cqWzEko994Apu/uBO/wY2q7DHBbNBFeky3+A
        OKUzqBVj0UDzK2hmO/gloNo2l8Dxjl326Q+0ic9H1tsAVmV/0UfsDXsX45Gp7yEo
        mbJF0K90GGo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37D9E76665;
        Tue, 28 Jul 2020 12:38:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 618BB7665F;
        Tue, 28 Jul 2020 12:38:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2] fetch: optionally allow disabling FETCH_HEAD update
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <3165b8916d2d80bf72dac6596a42c871ccd4cbe6.1595527000.git.gitgitgadget@gmail.com>
        <20200725013715.GA2436@danh.dev>
        <xmqqv9icicvd.fsf@gitster.c.googlers.com>
        <421cb856-24fc-6aa0-6ab0-f513d34ddd1a@gmail.com>
        <xmqqy2n5gcls.fsf@gitster.c.googlers.com>
        <5f201690-b090-1716-b175-562801891ee6@gmail.com>
Date:   Tue, 28 Jul 2020 09:37:59 -0700
In-Reply-To: <5f201690-b090-1716-b175-562801891ee6@gmail.com> (Derrick
        Stolee's message of "Mon, 27 Jul 2020 14:27:17 -0400")
Message-ID: <xmqqr1svegt4.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B321974A-D0F0-11EA-9C2A-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 7/27/2020 12:13 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>> 
>>> I'll rebase onto jc/no-update-fetch-head for the next version, since
>>> that branch is based on v2.28.0-rc0, which is recent enough.
>> 
>> I do not think it is wise to base a work on top of unfinished "you
>> could do it this way, perhaps?" demonstration patch the original
>> author does not have much inclination to finish, though.
>> 
>> When I am really bored, I may go back to the topic to finish it, but
>> I wouldn't mind if you took ownership of it at all.
>
> Ah. I didn't understand the status of that branch. I'll pull it in
> to this topic.

So here is with one of the two things that I found missing in the
first iteration of the patch: documentation.

The other thing that I found iffy (and still missing from this
version) was what should be done when "git pull" is explicitly given
the "--no-write-fetch-head" option.

I think (but didn't check the recent code) that 'git pull' would
pass only known-to-make-sense command line options to underlying
'git fetch', so it probably will barf with "unknown option", which
is the best case.  We might want to make it sure with a new test in
5521.  On the other hand, if we get anything other than "no such
option", we may want to think if we want to "fix" it or just leave
it inside "if it hurts, don't do it" territory.

Thanks.  

The patch without doc was Reviewed-by: Taylor Blau <me@ttaylorr.com>
but this round has not been.

-- >8 --

If you run fetch but record the result in remote-tracking branches,
and either if you do nothing with the fetched refs (e.g. you are
merely mirroring) or if you always work from the remote-tracking
refs (e.g. you fetch and then merge origin/branchname separately),
you can get away with having no FETCH_HEAD at all.

Teach "git fetch" a command line option "--[no-]write-fetch-head"
and "fetch.writeFetchHEAD" configuration variable.  Without either,
the default is to write FETCH_HEAD, and the usual rule that the
command line option defeats configured default applies.

Note that under "--dry-run" mode, FETCH_HEAD is never written;
otherwise you'd see list of objects in the file that you do not
actually have.  Passing `--fetch-write-head` does not force `git
fetch` to write the file.

Also note that this option is explicitly passed when "git pull"
internally invokes "git fetch", so that those who configured their
"git fetch" not to write FETCH_HEAD would not be able to break the
cooperation between these two commands.  "git pull" must see what
"git fetch" got recorded in FETCH_HEAD to work correctly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/fetch.txt  |  7 ++++++
 Documentation/fetch-options.txt | 10 +++++++++
 builtin/fetch.c                 | 19 +++++++++++++---
 builtin/pull.c                  |  3 ++-
 t/t5510-fetch.sh                | 39 +++++++++++++++++++++++++++++++--
 5 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index b20394038d..0aaa05e8c0 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -91,3 +91,10 @@ fetch.writeCommitGraph::
 	merge and the write may take longer. Having an updated commit-graph
 	file helps performance of many Git commands, including `git merge-base`,
 	`git push -f`, and `git log --graph`. Defaults to false.
+
+fetch.writeFetchHEAD::
+	Setting it to false tells `git fetch` not to write the list
+	of remote refs fetched in the `FETCH_HEAD` file directly
+	under `$GIT_DIR`.  Can be countermanded from the command
+	line with the `--[no-]write-fetch-head` option.  Defaults to
+	true.
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 6e2a160a47..6775e8499f 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -64,6 +64,16 @@ documented in linkgit:git-config[1].
 --dry-run::
 	Show what would be done, without making any changes.
 
+ifndef::git-pull[]
+--[no-]write-fetch-head::
+	Write the list of remote refs fetched in the `FETCH_HEAD`
+	file directly under `$GIT_DIR`.  This is the default unless
+	the configuration variable `fetch.writeFetchHEAD` is set to
+	false.  Passing `--no-write-fetch-head` from the command
+	line tells Git not to write the file.  Under `--dry-run`
+	option, the file is never written.
+endif::git-pull[]
+
 -f::
 --force::
 	When 'git fetch' is used with `<src>:<dst>` refspec it may
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
2.28.0

