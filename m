Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD84C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 04:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19852206A4
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 04:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="texaG1qz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgHMEh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 00:37:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59136 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgHMEh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 00:37:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4329A70582;
        Thu, 13 Aug 2020 00:37:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=etQQMDAroKPEoCbu87op8RJtW+g=; b=texaG1
        qzTsrxRFFMFqKT6zCkWZwvX3O+rGjQMMtIfKwS+cyyOvrv+MQVZH/rjvaA8GDtJq
        bDd2OLJ/I2STsJ7IFdlMWHwNfIAUjbPrlsFMtJfQLLASDlphc8duaMoTnB9kNt7a
        z4kWg1kZ07rwXJgBMemmjIiVu8tYKrew5SmeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RZdWqqmsdBp2J5wu1zRTnzIqNnHbz9B9
        FIDajdAltKXBkAMtdg59Xt592B72LxVCf1fStiCUFlT2jYGv74jaBxj0Om4fpXgF
        Lnvhj6JEym2gIlQejxlzxakWW0RWUzU/HhGqcu9Ao6X0TCoL9lb6jLFP0TeTvCHo
        vfan/lm51S0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3253E70581;
        Thu, 13 Aug 2020 00:37:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B183070580;
        Thu, 13 Aug 2020 00:37:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v3] fetch: optionally allow disabling FETCH_HEAD update
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
        <83401c52002716084b9c53a77c9d57b6009f84e2.1596731424.git.gitgitgadget@gmail.com>
        <20200812231021.GG2965447@google.com>
        <xmqqo8nf4dkb.fsf@gitster.c.googlers.com>
Date:   Wed, 12 Aug 2020 21:37:25 -0700
In-Reply-To: <xmqqo8nf4dkb.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 12 Aug 2020 17:03:32 -0700")
Message-ID: <xmqqh7t740vu.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFDC6864-DD1E-11EA-8A04-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you run fetch but record the result in remote-tracking branches,
and either if you do nothing with the fetched refs (e.g. you are
merely mirroring) or if you always work from the remote-tracking
refs (e.g. you fetch and then merge origin/branchname separately),
you can get away with having no FETCH_HEAD at all.

Teach "git fetch" a command line option "--[no-]write-fetch-head".
The default is to write FETCH_HEAD, and the option is primarily
meant to be used with the "--no-" prefix to override this default,
because there is no matching fetch.writeFetchHEAD configuration
variable to flip the default to off (in which case, the positive
form may become necessary to defeat it).

Note that under "--dry-run" mode, FETCH_HEAD is never written;
otherwise you'd see list of objects in the file that you do not
actually have.  Passing `--write-fetch-head` does not force `git
fetch` to write the file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So, it becomes much smaller by punting the whole configuration
   thing, as we do not need the extra code for config parsing and
   there is no need for code to override the user configuration when
   driving "git fetch" from "git pull".

 Documentation/fetch-options.txt |  9 +++++++++
 builtin/fetch.c                 | 15 ++++++++++++---
 t/t5510-fetch.sh                | 15 +++++++++++++--
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 495bc8ab5a..b65a758661 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -64,6 +64,15 @@ documented in linkgit:git-config[1].
 --dry-run::
 	Show what would be done, without making any changes.
 
+ifndef::git-pull[]
+--[no-]write-fetch-head::
+	Write the list of remote refs fetched in the `FETCH_HEAD`
+	file directly under `$GIT_DIR`.  This is the default.
+	Passing `--no-write-fetch-head` from the command line tells
+	Git not to write the file.  Under `--dry-run` option, the
+	file is never written.
+endif::git-pull[]
+
 -f::
 --force::
 	When 'git fetch' is used with `<src>:<dst>` refspec it may
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c8b9366d3c..cb38e6f5ec 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -56,6 +56,7 @@ static int prune_tags = -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
 
 static int all, append, dry_run, force, keep, multiple, update_head_ok;
+static int write_fetch_head = 1;
 static int verbosity, deepen_relative, set_upstream;
 static int progress = -1;
 static int enable_auto_gc = 1;
@@ -162,6 +163,8 @@ static struct option builtin_fetch_options[] = {
 		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 	OPT_BOOL(0, "dry-run", &dry_run,
 		 N_("dry run")),
+	OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
+		 N_("write fetched references to the FETCH_HEAD file")),
 	OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
 	OPT_BOOL('u', "update-head-ok", &update_head_ok,
 		    N_("allow updating of HEAD ref")),
@@ -895,7 +898,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
-	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head(the_repository);
+	const char *filename = (!write_fetch_head
+				? "/dev/null"
+				: git_path_fetch_head(the_repository));
 	int want_status;
 	int summary_width = transport_summary_width(ref_map);
 
@@ -1329,7 +1334,7 @@ static int do_fetch(struct transport *transport,
 	}
 
 	/* if not appending, truncate FETCH_HEAD */
-	if (!append && !dry_run) {
+	if (!append && write_fetch_head) {
 		retcode = truncate_fetch_head();
 		if (retcode)
 			goto cleanup;
@@ -1596,7 +1601,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 	int i, result = 0;
 	struct strvec argv = STRVEC_INIT;
 
-	if (!append && !dry_run) {
+	if (!append && write_fetch_head) {
 		int errcode = truncate_fetch_head();
 		if (errcode)
 			return errcode;
@@ -1797,6 +1802,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
+	/* FETCH_HEAD never gets updated in --dry-run mode */
+	if (dry_run)
+		write_fetch_head = 0;
+
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 9850ecde5d..5bd1f953af 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -539,13 +539,24 @@ test_expect_success 'fetch into the current branch with --update-head-ok' '
 
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
 test_expect_success "should be able to fetch with duplicate refspecs" '
 	mkdir dups &&
 	(
-- 
2.28.0-314-g35e3b9c6bd


