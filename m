Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6F1C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 09:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiKVJ7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 04:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiKVJ7o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 04:59:44 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A1618384
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 01:59:43 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8C9751F910;
        Tue, 22 Nov 2022 09:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1669111183;
        bh=YKhjWzjqWc+wGYYBvKtpLHaZHFB3AeXIQn1PkisqfTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfQLEQDduYGAe2LLi4eoyBrSDU15i60UiSSWDJLbn53pMBiXgM3PXJoHlIC50c8UU
         Y/YgwvYz1CT1iR036CLw+4PC5O46FZ4RdOmLm5JZECsGdU6VxPe11Dxisme+cMBo1V
         Qf8uyKDHrb9LnGLCGWV/EZjc2x0kNE0ACVblZx6E=
Date:   Tue, 22 Nov 2022 09:59:43 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] prune: recursively prune objects directory
Message-ID: <20221122095943.M478967@dcvr>
References: <20221119201213.2398081-1-e@80x24.org>
 <xmqq5yf8yhe0.fsf@gitster.g>
 <20221121104427.M268307@dcvr>
 <xmqqpmdgv4it.fsf@gitster.g>
 <xmqqleo3vraj.fsf@gitster.g>
 <20221122000927.M873500@dcvr>
 <xmqq7cznu69p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7cznu69p.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > I am unsure about duplicating ishex() from name-rev.c, however...
> 
> Yeah, I wonder why name-rev.c does not use isxdigit() in the first
> place.

isxdigit includes uppercase [A-F].  I think being strict is
better, here.  I don't want to open up a can of worms if we
become tolerant of 3rd-party git implementations developed on
case-insensitive FSes.

> > -static void remove_temporary_files(const char *path)
> > +static void remove_temporary_files(const char *path, int recurse)
> >  {
> >  	DIR *dir;
> >  	struct dirent *de;
> >  
> >  	dir = opendir(path);
> >  	if (!dir) {
> > -		fprintf(stderr, "Unable to open directory %s\n", path);
> > +		warning_errno(_("unable to open directory %s"), path);
> >  		return;
> >  	}
> >  	while ((de = readdir(dir)) != NULL)
> > -		if (starts_with(de->d_name, "tmp_"))
> > +		if (starts_with(de->d_name, "tmp_")) {
> >  			prune_tmp_file(mkpath("%s/%s", path, de->d_name));
> > +		} else if (recurse && (strcmp(de->d_name, "packs") == 0 ||
> > +					is_loose_prefix(de->d_name))) {
> 
> OK, the intent is to be careful and deal only with the fan-out
> directories objects/[0-9a-f]{2}/ and objects/pack/ and leave crufts
> in objects/info and any other unknown subdirectories, which makes
> sense.
> 
> Two nits are:
> 
>  - "packs" wants to be "pack".

OK, fixed.  Along with existing test cases, since packs handling
wasn't being tested properly.

>  - "strcmp() == 0" wants to be "!strcmp()".

OK

> > diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> > index 8ae314af58..8c2278035e 100755
> > --- a/t/t5304-prune.sh
> > +++ b/t/t5304-prune.sh
> > @@ -29,6 +29,22 @@ test_expect_success setup '
> >  	git gc
> >  '
> >  
> > +test_expect_success 'prune stale loose objects' '
> > +	mkdir .git/objects/aa &&
> > +	>.git/objects/aa/tmp_foo &&
> > +	test-tool chmtime =-86501 .git/objects/aa/tmp_foo &&
> > +	git prune --expire 1.day &&
> > +	test_path_is_missing .git/objects/aa/tmp_foo
> > +'
> > +
> > +test_expect_success 'bare repo prune is quiet without $GIT_DIR/objects/pack' '
> > +	git clone -q --shared --template= --bare . bare.git &&
> > +	rmdir bare.git/objects/pack &&
> > +	git --git-dir=bare.git prune --no-progress 2>prune.err &&
> > +	test_must_be_empty prune.err &&
> > +	rm -r bare.git prune.err
> > +'
> 
> Is the last "clean-up" step necessary?

Guess not, removed in v2 below.

> > +
> >  test_expect_success 'prune stale packs' '
> >  	orig_pack=$(echo .git/objects/pack/*.pack) &&
> >  	>.git/objects/tmp_1.pack &&
> 
> Other than that, looks like a good idea.

'prune stale packs' was actually insufficient for catching
the extraneous `s' in `pack'.  I've kept existing checks against
objects/tmp_*, but added extra checks for objects/pack/tmp_*

v2 fixes:
* `pack' directory fixed, tests added
* !strcmp
* remove needless cleanup step in test

-----8<-----
Subject: [PATCH] prune: recursively prune objects directory

$GIT_DIR/objects/pack may be removed to save inodes in shared
repositories, so avoid scanning it if it does not exist.  Loose
object directories ($GIT_DIR/objects/??) may have old temporary
files, so we now prune those, too.

Recursion is limited to a single level since git doesn't use
deeper levels.  This avoids the risk of stack overflows via
infinite recursion when pruning untrusted repos.

We'll also emit the system error in case a directory cannot be
opened to help users diagnose permissions problems or resource
constraints.

Signed-off-by: Eric Wong <e@80x24.org>
---
Interdiff:
  diff --git a/builtin/prune.c b/builtin/prune.c
  index 0f6a33690a..a05f1a2704 100644
  --- a/builtin/prune.c
  +++ b/builtin/prune.c
  @@ -143,7 +143,7 @@ static void remove_temporary_files(const char *path, int recurse)
   	while ((de = readdir(dir)) != NULL)
   		if (starts_with(de->d_name, "tmp_")) {
   			prune_tmp_file(mkpath("%s/%s", path, de->d_name));
  -		} else if (recurse && (strcmp(de->d_name, "packs") == 0 ||
  +		} else if (recurse && (!strcmp(de->d_name, "pack") ||
   					is_loose_prefix(de->d_name))) {
   			char *s = mkpathdup("%s/%s", path, de->d_name);
   			remove_temporary_files(s, 0);
  diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
  index 8c2278035e..64d5f4e5b3 100755
  --- a/t/t5304-prune.sh
  +++ b/t/t5304-prune.sh
  @@ -41,19 +41,23 @@ test_expect_success 'bare repo prune is quiet without $GIT_DIR/objects/pack' '
   	git clone -q --shared --template= --bare . bare.git &&
   	rmdir bare.git/objects/pack &&
   	git --git-dir=bare.git prune --no-progress 2>prune.err &&
  -	test_must_be_empty prune.err &&
  -	rm -r bare.git prune.err
  +	test_must_be_empty prune.err
   '
   
   test_expect_success 'prune stale packs' '
   	orig_pack=$(echo .git/objects/pack/*.pack) &&
   	>.git/objects/tmp_1.pack &&
   	>.git/objects/tmp_2.pack &&
  -	test-tool chmtime =-86501 .git/objects/tmp_1.pack &&
  +	>.git/objects/pack/tmp_3.pack &&
  +	>.git/objects/pack/tmp_4.pack &&
  +	test-tool chmtime =-86501 .git/objects/tmp_1.pack \
  +		.git/objects/pack/tmp_3.pack &&
   	git prune --expire 1.day &&
   	test_path_is_file $orig_pack &&
   	test_path_is_file .git/objects/tmp_2.pack &&
  -	test_path_is_missing .git/objects/tmp_1.pack
  +	test_path_is_file .git/objects/pack/tmp_4.pack &&
  +	test_path_is_missing .git/objects/tmp_1.pack &&
  +	test_path_is_missing .git/objects/pack/tmp_3.pack
   '
   
   test_expect_success 'prune --expire' '

 builtin/prune.c  | 28 ++++++++++++++++++++--------
 t/t5304-prune.sh | 24 ++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index df376b2ed1..a05f1a2704 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -114,25 +114,41 @@ static int prune_subdir(unsigned int nr, const char *path, void *data)
 	return 0;
 }
 
+/*
+ * XXX ishex is duplicated in builtin/name-rev.c, perhaps git-compat-util.h
+ * is a better home for it
+ */
+#define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
+static int is_loose_prefix(const char *d_name)
+{
+	return strlen(d_name) == 2 && ishex(d_name[0]) && ishex(d_name[1]);
+}
+
 /*
  * Write errors (particularly out of space) can result in
  * failed temporary packs (and more rarely indexes and other
  * files beginning with "tmp_") accumulating in the object
  * and the pack directories.
  */
-static void remove_temporary_files(const char *path)
+static void remove_temporary_files(const char *path, int recurse)
 {
 	DIR *dir;
 	struct dirent *de;
 
 	dir = opendir(path);
 	if (!dir) {
-		fprintf(stderr, "Unable to open directory %s\n", path);
+		warning_errno(_("unable to open directory %s"), path);
 		return;
 	}
 	while ((de = readdir(dir)) != NULL)
-		if (starts_with(de->d_name, "tmp_"))
+		if (starts_with(de->d_name, "tmp_")) {
 			prune_tmp_file(mkpath("%s/%s", path, de->d_name));
+		} else if (recurse && (!strcmp(de->d_name, "pack") ||
+					is_loose_prefix(de->d_name))) {
+			char *s = mkpathdup("%s/%s", path, de->d_name);
+			remove_temporary_files(s, 0);
+			free(s);
+		}
 	closedir(dir);
 }
 
@@ -150,7 +166,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 			 N_("limit traversal to objects outside promisor packfiles")),
 		OPT_END()
 	};
-	char *s;
 
 	expire = TIME_MAX;
 	save_commit_buffer = 0;
@@ -186,10 +201,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 				      prune_cruft, prune_subdir, &revs);
 
 	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
-	remove_temporary_files(get_object_directory());
-	s = mkpathdup("%s/pack", get_object_directory());
-	remove_temporary_files(s);
-	free(s);
+	remove_temporary_files(get_object_directory(), 1);
 
 	if (is_repository_shallow(the_repository)) {
 		perform_reachability_traversal(&revs);
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 8ae314af58..64d5f4e5b3 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -29,15 +29,35 @@ test_expect_success setup '
 	git gc
 '
 
+test_expect_success 'prune stale loose objects' '
+	mkdir .git/objects/aa &&
+	>.git/objects/aa/tmp_foo &&
+	test-tool chmtime =-86501 .git/objects/aa/tmp_foo &&
+	git prune --expire 1.day &&
+	test_path_is_missing .git/objects/aa/tmp_foo
+'
+
+test_expect_success 'bare repo prune is quiet without $GIT_DIR/objects/pack' '
+	git clone -q --shared --template= --bare . bare.git &&
+	rmdir bare.git/objects/pack &&
+	git --git-dir=bare.git prune --no-progress 2>prune.err &&
+	test_must_be_empty prune.err
+'
+
 test_expect_success 'prune stale packs' '
 	orig_pack=$(echo .git/objects/pack/*.pack) &&
 	>.git/objects/tmp_1.pack &&
 	>.git/objects/tmp_2.pack &&
-	test-tool chmtime =-86501 .git/objects/tmp_1.pack &&
+	>.git/objects/pack/tmp_3.pack &&
+	>.git/objects/pack/tmp_4.pack &&
+	test-tool chmtime =-86501 .git/objects/tmp_1.pack \
+		.git/objects/pack/tmp_3.pack &&
 	git prune --expire 1.day &&
 	test_path_is_file $orig_pack &&
 	test_path_is_file .git/objects/tmp_2.pack &&
-	test_path_is_missing .git/objects/tmp_1.pack
+	test_path_is_file .git/objects/pack/tmp_4.pack &&
+	test_path_is_missing .git/objects/tmp_1.pack &&
+	test_path_is_missing .git/objects/pack/tmp_3.pack
 '
 
 test_expect_success 'prune --expire' '
