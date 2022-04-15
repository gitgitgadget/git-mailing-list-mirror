Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8BDC433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 20:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbiDOUQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 16:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239141AbiDOUQC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 16:16:02 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CBADD959
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 13:13:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3250A10BAF2;
        Fri, 15 Apr 2022 16:13:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LkdIeiGXExD04sWdyoqNp3IN47eU1gqCQf3Iwt
        Fy2Oc=; b=pD4BlfGXtGbOelDMT8VJuIzmSCVmm+GFb6CS0irMOR1UehEisSd4SV
        L9ArCRG0PVTrLTbjKsXT3KMhjcfJui0a+SUukuNuO3ZqmlzGtPcQBQwsM1G7TZJK
        9v+RitSqtE7ocJxOJpzMBK3OqN65Fj9DVn3i0HNWaoLiWtoR1V8Ow=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2754510BAF1;
        Fri, 15 Apr 2022 16:13:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89ECC10BAEF;
        Fri, 15 Apr 2022 16:13:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>,
        martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Bare repositories in the working tree are a security risk
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqwnfs4kud.fsf@gitster.g>
        <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 15 Apr 2022 13:13:29 -0700
In-Reply-To: <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 14 Apr 2022 09:41:36 -0700")
Message-ID: <xmqqh76ucdg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84B33788-BCF8-11EC-B5FF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Yes, I mean that even the current directory will be ignored when
> discovery is disabled.
>
>>                                                I am not sure that
>> is realistically feasible (I am thinking of cases like "git fetch"
>> going to the remote repository on the local disk that is bare to run
>> "git upload-pack"), but if the fallout is not too bad, it may be a
>> good heuristics.
>
> Good detail - I hadn't considered the impact on our own child processes.
> I suspect this might be a huge undertaking. Unless there is significant
> interest in this option, I probably won't pursue it further.

So, I was doing a bit of experiment.  The change to the set-up
essentially means that working in either a bare repository or in the
.git/ subdirectory of a non-bare repository that you used to be able
to do with

    cd bare.git && git cmd
    cd .git/ && git cmd

is now forbidden, unless you explicitly say which directory you want
to use as the GIT_DIR, i.e.

    cd bare.git && GIT_DIR=. git cmd
    cd .git/ && GIT_DIR=. git cmd

The required change to the code is surprisingly small, but the
fallout is very big.  Partial patches to two tests are attached with
some commentary at the end.

 setup.c          | 9 +++++++--

diff --git c/setup.c w/setup.c
index a7b36f3ffb..52304ae57e 100644
--- c/setup.c
+++ w/setup.c
@@ -1203,12 +1203,15 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	 * Test in the following order (relative to the dir):
 	 * - .git (file containing "gitdir: <path>")
 	 * - .git/
-	 * - ./ (bare)
+	 * - ./ (bare) --- not
 	 * - ../.git
 	 * - ../.git/
-	 * - ../ (bare)
+	 * - ../ (bare) --- not
 	 * - ../../.git
 	 *   etc.
+	 * we used to test the directory itself as a bare one
+	 * after checking if the directory has .git/ that is a repository
+	 * and before moving up the hierarchy, but no longer do so.
 	 */
 	one_filesystem = !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0);
 	if (one_filesystem)
@@ -1238,12 +1241,14 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 			return GIT_DIR_DISCOVERED;
 		}
 
+#if 0
 		if (is_git_directory(dir->buf)) {
 			if (!ensure_valid_ownership(dir->buf))
 				return GIT_DIR_INVALID_OWNERSHIP;
 			strbuf_addstr(gitdir, ".");
 			return GIT_DIR_BARE;
 		}
+#endif
 
 		if (offset <= min_offset)
 			return GIT_DIR_HIT_CEILING;


THe above is all it takes to disable the recognition of a bare
repository during the repositiry discovery.  The code to handle
explicitly specified GIT_DIR is way before the loop being touched
here and works OK as before.

Interestingly, many breakages in tests are not due to "clone"
failing to operate in "the other side".  For example, this one tries
to inspect a bare repository that was created by a clone operation,
and we need to tell "git" where the GIT_DIR is, even after we chdir
to it.  I do not think this is so common but with our popularity,
not-so-common population is still an absolute large number of users
that we do not want to hurt.

diff --git c/t/t5601-clone.sh w/t/t5601-clone.sh
index 4a61f2c901..822ee3164a 100755
--- c/t/t5601-clone.sh
+++ w/t/t5601-clone.sh
@@ -111,9 +111,9 @@ test_expect_success 'clone --mirror' '
 	git clone --mirror src mirror &&
 	test -f mirror/HEAD &&
 	test ! -f mirror/file &&
-	FETCH="$(cd mirror && git config remote.origin.fetch)" &&
+	FETCH="$(cd mirror && GIT_DIR=. git config remote.origin.fetch)" &&
 	test "+refs/*:refs/*" = "$FETCH" &&
-	MIRROR="$(cd mirror && git config --bool remote.origin.mirror)" &&
+	MIRROR="$(cd mirror && GIT_DIR=. git config --bool remote.origin.mirror)" &&
 	test "$MIRROR" = true
 
 '
@@ -151,7 +151,7 @@ test_expect_success 'clone --mirror does not repeat tags' '
 	 git tag some-tag HEAD) &&
 	git clone --mirror src mirror2 &&
 	(cd mirror2 &&
-	 git show-ref 2> clone.err > clone.out) &&
+	 GIT_DIR=. git show-ref 2>clone.err >clone.out) &&
 	! grep Duplicate mirror2/clone.err &&
 	grep some-tag mirror2/clone.out
 


The next example is "init" test, which seems to reveal that refusing
to discover a bare repository is not exactly an approach that is
workable.

The first two hunks just show the same pattern as above.  The
check_config helper is given a directory, under which 'config' and
'refs' should exist (in other words, the first part of the helper
emulates setup.c::is_git_directory()).  Then it tries to read from
the configuration file found in that directory.  Be it a bare
repository or .git/ subdirectory of a non-bare repository the caller
has given us, we need to do the same GIT_DIR=. dance as the above.

The last hunk does not really fix.  The scenario is this:

    * A bare repository bare-ancestor-aliased.git is prepared

    * Its config file says "[alias] aliasedinit=init" in it

    * In that bare repository (next to 'refs', 'config'), we create
      a subdirectory 'plain-nested'.

    * We go to that bare-ancestor-aliased.git/plain-nested/
      directory and say "git aliasedinit".

This wants to be able to create a subdirectory in this bare
repository and make that subdirectory an independent repository (it
happens to be a non-bare repository, but a bare repository should
also work---think of .git/modules/name/ bare repository that is
designed to be pointed at with gitfile: link from a submodule
working tree).

Now, in order for the last step to be able to even _use_ the alias,
it has to treat the bare-ancestor-aliased.git directory as a bare
repository and read its configuration.  But by explicitly setting
GIT_DIR to that location, the behaviour of "git init" itself is
changed.  It no longer initializes the current directory,
i.e. plain-nested subdirectory of the bare-ancestor-aliased.git;
GIT_DIR tells us to (re)initialize it instead.

This fundamentally does not work.

It is a separate matter if it makes sense to allow creating a new
repository inside a bare repository (it does---that is what the
modern submodule layout uses), or to allow an alias to help doing so
defined in the top-level bare repository (it probably does---the
end-user may want to have a handy way to customize how submodules
are configured).  But it seems to tell us that with today's external
interface we have for "git init", we cannot take configuration from
a shallower level and use it to drive "git init" to create a new
repository at a deeper level.

diff --git c/t/t0001-init.sh w/t/t0001-init.sh
index d479303efa..57f2eedac0 100755
--- c/t/t0001-init.sh
+++ w/t/t0001-init.sh
@@ -6,6 +6,7 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_config () {
+	# NEEDSWORK: refs could be a file in post reftable world.
 	if test_path_is_dir "$1" &&
 	   test_path_is_file "$1/config" && test_path_is_dir "$1/refs"
 	then
@@ -21,8 +22,8 @@ check_config () {
 		return 1
 	fi
 
-	bare=$(cd "$1" && git config --bool core.bare)
-	worktree=$(cd "$1" && git config core.worktree) ||
+	bare=$(cd "$1" && GIT_DIR=. git config --bool core.bare)
+	worktree=$(cd "$1" && GIT_DIR=. git config core.worktree) ||
 	worktree=unset
 
 	test "$bare" = "$2" && test "$worktree" = "$3" || {
@@ -84,7 +85,7 @@ test_expect_success 'plain nested in bare through aliased command' '
 		echo "[alias] aliasedinit = init" >>config &&
 		mkdir plain-nested &&
 		cd plain-nested &&
-		git aliasedinit
+		GIT_DIR=.. git aliasedinit ;# does not work
 	) &&
 	check_config bare-ancestor-aliased.git/plain-nested/.git false unset
 '
