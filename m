Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015FB38B
	for <git@vger.kernel.org>; Sun, 12 Jan 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736676151; cv=none; b=I6s0rfzFLUHN07GiRjOmltlv5rysFLYuF5DOHba/ppTyGsjah/oFKoHxb7LoDNo5LwnCh1F4vBt4ygjXhbTohAbIRX4tyHuWFuIwtp4hNZtlJnXE+m7Isx2Za42ZTzC70X/PeNXoBu1VlWNDRQMj0bmWIYHvi3nu93PzbItsA3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736676151; c=relaxed/simple;
	bh=mBSYoJc6h9sG66FYsCweG+VaT2yo60Zeu4ud7o1KhuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Tdbt+wdhqFx685NWt2OScCdi13cvq42PXUFHR/7PE1p4bWPKDAN16omLM7WISdMlI0tDu6udrE7m+tkf+Ff5aQOiukddStDEM/QTHLUKX3ThgviCUvMXYP8tD+HwAoS3gwvEujJNwZ2AGYeIoYURtnZw4lHpjLNVZGAO/I+q+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=A+LScfrx; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="A+LScfrx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1736676133; x=1737280933; i=l.s.r@web.de;
	bh=rWm4/wJ3c0lgKBSRuan7sZxpZXSRxRN82Owi0I9Jhow=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A+LScfrxTc0+Kasn9Z0kbVXcmGj+YHrTNvsdCri7Xc0nDSjII0XkEdBOe50hVpeq
	 ruqpxwyDw6iLmspTmhzKPrJmmzqKCxsl+QSiaWGR5Jh6Z39b5ZcKdpIqUO/zXHzP7
	 J7OmSWjeIdH5LHZOqJ2VbdvJJlnVpuQ6Y9+aEVnwnre3/c4S15VtXrs6bD0USE7V2
	 NUkF/h9OumYAMWzOxoCNrWuxWh1bjqi81leCZdq4W+BhBe+8aA0qiCIOuzyY/qVGP
	 FhGbq/nfOdcPqGopap5tKDCojduRLeam8z6+w8E22NDezkWJDBbTlSS4wL6POI50A
	 c7wODPmvSovfn6mcsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3Euv-1tZx4C2nM5-00583d; Sun, 12
 Jan 2025 11:02:13 +0100
Message-ID: <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
Date: Sun, 12 Jan 2025 11:01:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] ref-filter: share bases and is_base_tips between formatting
 and sorting
To: Ross Goldberg <ross.goldberg@gmail.com>, git@vger.kernel.org
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
Content-Language: en-US
Cc: Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vgewxLrMSdNDbdzTZmjvW2/WWQdxuU14a3syWyveCn9ojN+Ux5y
 tWshZFdgBHswQjJxy1EUJEPoRfJx7XoPaiz4GKLv+hl1TeOqQqe8JYZO2VfCgpdxoQ5Y8uH
 y2iPgFhF0UvMaxlVmtDMWYlCH2W+HLIEl8Mg0Bgn0cRFECJPTk4yGyvvBH1X3DFs3vuv4hv
 2bukxwlIx0niDYzdM9Vwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cn5wTWWVwPA=;LkGRW2NwgzLLPdNdZVrV8NgiK49
 C5GqLUyabNwKgbltBgo4usELqgvd0ioFBn7BAr/H9onjdHRaA/029VjB1Dlt75IU5PmxjGs1+
 dMseFxPKyuTbgoNQkB1LEuHeNy7EgBPvnqSu4QqbJWhiDgJeN0wREZrWRH8ANVmcBUNrRKgK6
 yk2OuPbcTCDyDdPxMlACZ522Rozcxj1NDrT1e6/Pv0Xihas5srBodil/vb4sHWUj9VgXcXJMO
 CENIG7yAchRNWtCQyiJ4itblueVkRgmVWcyLImt1uzLXK2AwLoLl1TTwj9NL8LF3uaNI4sEC4
 B3wyTUfCFGzWg744D9nPurA/Uaehu4AT16IsTK14jWguI+0og0FtajBeXljYhREMalJMcMYtm
 +kUSbFD9S/QetBJg150Q32Gb1WGIL5RUr46ItisBQi0bWXUWmqjBhVMyGt5ZeD/9BkiZYRama
 8mt6qoxcFb00tzzLGJE2dpFOeNKI9+5+4Z8u08JFBx1R9PshxamNF89yQe2bSKHseEzqZ8iEQ
 rqTeqvg97t5hdmWJ9cQvpINZgMPj5dljmufJsj7/XzAIDYtEDMgrPXLJIIjToiLfvsckvKcZN
 ISc0rg9kGAmcBAgVOJHUmgcMxQThzm9yH31Kf/gq1R+neTia861t+o2EZUiA7zbvbqigZwHAa
 G2C8pp7IlJiB9ASrV8lhwqrPKi37iBHHryubg1Tr4OzKEq9U7+bAES6eHhADjNCMxloZy0y82
 RZA6ONpU+BZdWsBDlxfEugcJaiVuVRIod7/gq0bf1JqXeowVO2v7yCcBKmkde49mBJxYheSpI
 b4tXPxGQn+jm9p3eU+q/wFgIny4Nvo+xlOiufeqhN4w3KTgZ+NgUF/c0xsohI+sUTkfT2ZPtV
 hdnMrmYQgQlnkcaUgT3qbyuVWi8VPt6/jOvPQg5NDM9qhZulpDvoj9aXhDwoxTZGwKeOIaNVB
 iSBkJzXDZeAF1tOMKKhQiLILdfVzZMpdSUjOYPhblBvRXGvI1BHT4ZjfTUmyqj3QU7pQe7fA9
 QMHlJlzy0ym4TSa6RQZC8DqN7wEwINQzTzsehmXxFPDXay5mDOoZKUmY+DGaGoec3xyiJFc43
 2T+1WWy3Q=

verify_ref_format() parses a ref-filter format string and stores
recognized items in the static array "used_atom".  For
"ahead-behind:<committish>" and "is-base:<committish>" it stores the
committish part in string_lists that are part of struct ref_format.

ref_sorting_options() also parses bare ref-filter format items and also
stores recognized ones in "used_atom".  The committish parts go to a
dummy struct ref_format in parse_sorting_atom(), though, and are leaked
and forgotten.

If verify_ref_format() is called before ref_sorting_options(), like in
git for-each-ref, then all works well if the sort key is included in the
format string.  If it isn't then sorting cannot work as the committishes
are missing.

If ref_sorting_options() is called first, like in git branch, then we
have the additional issue that if the sort key is included in the format
string then filter_ahead_behind() and filter_is_base() can't see their
committishes, will not generate any results for them and thus they will
for expanded to empty strings.

Fix those issues by making the string_lists static, like their sibling
"used_atom".  This way they can all be shared for handling both
ref-filter format strings and sorting options in the same command.
And since struct ref_format no longer contains any allocated members,
remove the now unnecessary ref_format_init() and ref_format_clear().

Reported-by: Ross Goldberg <ross.goldberg@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/branch.c         |  3 +-
 builtin/for-each-ref.c   |  1 -
 builtin/tag.c            |  1 -
 builtin/verify-tag.c     |  1 -
 ref-filter.c             | 70 ++++++++++++++++++----------------------
 ref-filter.h             | 13 --------
 t/t3203-branch-output.sh | 28 ++++++++++++++++
 t/t6600-test-reach.sh    | 29 +++++++++++++++++
 8 files changed, 89 insertions(+), 57 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6e7b0cfddb..9a29de5bf1 100644
=2D-- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -473,7 +473,7 @@ static void print_ref_list(struct ref_filter *filter, =
struct ref_sorting *sortin
 	if (verify_ref_format(format))
 		die(_("unable to parse format string"));

-	filter_ahead_behind(the_repository, format, &array);
+	filter_ahead_behind(the_repository, &array);
 	ref_array_sort(sorting, &array);

 	if (column_active(colopts)) {
@@ -884,7 +884,6 @@ int cmd_branch(int argc,
 		string_list_clear(&output, 0);
 		ref_sorting_release(sorting);
 		ref_filter_clear(&filter);
-		ref_format_clear(&format);

 		ret =3D 0;
 		goto out;
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 715745a262..8085ebd8fe 100644
=2D-- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -108,7 +108,6 @@ int cmd_for_each_ref(int argc,
 	filter_and_format_refs(&filter, flags, sorting, &format);

 	ref_filter_clear(&filter);
-	ref_format_clear(&format);
 	ref_sorting_release(sorting);
 	strvec_clear(&vec);
 	return 0;
diff --git a/builtin/tag.c b/builtin/tag.c
index c4bd145831..e8a344b926 100644
=2D-- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -698,7 +698,6 @@ int cmd_tag(int argc,
 cleanup:
 	ref_sorting_release(sorting);
 	ref_filter_clear(&filter);
-	ref_format_clear(&format);
 	strbuf_release(&buf);
 	strbuf_release(&ref);
 	strbuf_release(&reflog_msg);
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index a7f20618ff..f6b97048a5 100644
=2D-- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -69,6 +69,5 @@ int cmd_verify_tag(int argc,
 		if (format.format)
 			pretty_print_ref(name, &oid, &format);
 	}
-	ref_format_clear(&format);
 	return had_error;
 }
diff --git a/ref-filter.c b/ref-filter.c
index 23054694c2..aef142e105 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -242,6 +242,12 @@ static struct used_atom {
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;

+/* List of bases for ahead-behind counts. */
+static struct string_list bases =3D STRING_LIST_INIT_DUP;
+
+/* List of bases for is-base indicators. */
+static struct string_list is_base_tips =3D STRING_LIST_INIT_DUP;
+
 /*
  * Expand string, append it to strbuf *sb, then return error code ret.
  * Allow to save few lines of code.
@@ -891,7 +897,7 @@ static int rest_atom_parser(struct ref_format *format =
UNUSED,
 	return 0;
 }

-static int ahead_behind_atom_parser(struct ref_format *format,
+static int ahead_behind_atom_parser(struct ref_format *format UNUSED,
 				    struct used_atom *atom UNUSED,
 				    const char *arg, struct strbuf *err)
 {
@@ -900,7 +906,7 @@ static int ahead_behind_atom_parser(struct ref_format =
*format,
 	if (!arg)
 		return strbuf_addf_ret(err, -1, _("expected format: %%(ahead-behind:<co=
mmittish>)"));

-	item =3D string_list_append(&format->bases, arg);
+	item =3D string_list_append(&bases, arg);
 	item->util =3D lookup_commit_reference_by_name(arg);
 	if (!item->util)
 		die("failed to find '%s'", arg);
@@ -908,7 +914,7 @@ static int ahead_behind_atom_parser(struct ref_format =
*format,
 	return 0;
 }

-static int is_base_atom_parser(struct ref_format *format,
+static int is_base_atom_parser(struct ref_format *format UNUSED,
 			       struct used_atom *atom UNUSED,
 			       const char *arg, struct strbuf *err)
 {
@@ -917,7 +923,7 @@ static int is_base_atom_parser(struct ref_format *form=
at,
 	if (!arg)
 		return strbuf_addf_ret(err, -1, _("expected format: %%(is-base:<committ=
ish>)"));

-	item =3D string_list_append(&format->is_base_tips, arg);
+	item =3D string_list_append(&is_base_tips, arg);
 	item->util =3D lookup_commit_reference_by_name(arg);
 	if (!item->util)
 		die("failed to find '%s'", arg);
@@ -3024,6 +3030,8 @@ void ref_array_clear(struct ref_array *array)
 	}
 	FREE_AND_NULL(used_atom);
 	used_atom_cnt =3D 0;
+	string_list_clear(&bases, 0);
+	string_list_clear(&is_base_tips, 0);

 	if (ref_to_worktree_map.worktrees) {
 		hashmap_clear_and_free(&(ref_to_worktree_map.map),
@@ -3084,22 +3092,21 @@ static void reach_filter(struct ref_array *array,
 }

 void filter_ahead_behind(struct repository *r,
-			 struct ref_format *format,
 			 struct ref_array *array)
 {
 	struct commit **commits;
-	size_t commits_nr =3D format->bases.nr + array->nr;
+	size_t commits_nr =3D bases.nr + array->nr;

-	if (!format->bases.nr || !array->nr)
+	if (!bases.nr || !array->nr)
 		return;

 	ALLOC_ARRAY(commits, commits_nr);
-	for (size_t i =3D 0; i < format->bases.nr; i++)
-		commits[i] =3D format->bases.items[i].util;
+	for (size_t i =3D 0; i < bases.nr; i++)
+		commits[i] =3D bases.items[i].util;

-	ALLOC_ARRAY(array->counts, st_mult(format->bases.nr, array->nr));
+	ALLOC_ARRAY(array->counts, st_mult(bases.nr, array->nr));

-	commits_nr =3D format->bases.nr;
+	commits_nr =3D bases.nr;
 	array->counts_nr =3D 0;
 	for (size_t i =3D 0; i < array->nr; i++) {
 		const char *name =3D array->items[i]->refname;
@@ -3108,8 +3115,8 @@ void filter_ahead_behind(struct repository *r,
 		if (!commits[commits_nr])
 			continue;

-		CALLOC_ARRAY(array->items[i]->counts, format->bases.nr);
-		for (size_t j =3D 0; j < format->bases.nr; j++) {
+		CALLOC_ARRAY(array->items[i]->counts, bases.nr);
+		for (size_t j =3D 0; j < bases.nr; j++) {
 			struct ahead_behind_count *count;
 			count =3D &array->counts[array->counts_nr++];
 			count->tip_index =3D commits_nr;
@@ -3125,14 +3132,13 @@ void filter_ahead_behind(struct repository *r,
 }

 void filter_is_base(struct repository *r,
-		    struct ref_format *format,
 		    struct ref_array *array)
 {
 	struct commit **bases;
 	size_t bases_nr =3D 0;
 	struct ref_array_item **back_index;

-	if (!format->is_base_tips.nr || !array->nr)
+	if (!is_base_tips.nr || !array->nr)
 		return;

 	CALLOC_ARRAY(back_index, array->nr);
@@ -3142,7 +3148,7 @@ void filter_is_base(struct repository *r,
 		const char *name =3D array->items[i]->refname;
 		struct commit *c =3D lookup_commit_reference_by_name_gently(name, 1);

-		CALLOC_ARRAY(array->items[i]->is_base, format->is_base_tips.nr);
+		CALLOC_ARRAY(array->items[i]->is_base, is_base_tips.nr);

 		if (!c)
 			continue;
@@ -3152,15 +3158,15 @@ void filter_is_base(struct repository *r,
 		bases_nr++;
 	}

-	for (size_t i =3D 0; i < format->is_base_tips.nr; i++) {
-		struct commit *tip =3D format->is_base_tips.items[i].util;
+	for (size_t i =3D 0; i < is_base_tips.nr; i++) {
+		struct commit *tip =3D is_base_tips.items[i].util;
 		int base_index =3D get_branch_base_for_tip(r, tip, bases, bases_nr);

 		if (base_index < 0)
 			continue;

 		/* Store the string for use in output later. */
-		back_index[base_index]->is_base[i] =3D xstrdup(format->is_base_tips.ite=
ms[i].string);
+		back_index[base_index]->is_base[i] =3D xstrdup(is_base_tips.items[i].st=
ring);
 	}

 	free(back_index);
@@ -3252,8 +3258,7 @@ struct ref_sorting {
 };

 static inline int can_do_iterative_format(struct ref_filter *filter,
-					  struct ref_sorting *sorting,
-					  struct ref_format *format)
+					  struct ref_sorting *sorting)
 {
 	/*
 	 * Reference backends sort patterns lexicographically by refname, so if
@@ -3279,15 +3284,15 @@ static inline int can_do_iterative_format(struct r=
ef_filter *filter,
 	 */
 	return !(filter->reachable_from ||
 		 filter->unreachable_from ||
-		 format->bases.nr ||
-		 format->is_base_tips.nr);
+		 bases.nr ||
+		 is_base_tips.nr);
 }

 void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
 			    struct ref_sorting *sorting,
 			    struct ref_format *format)
 {
-	if (can_do_iterative_format(filter, sorting, format)) {
+	if (can_do_iterative_format(filter, sorting)) {
 		int save_commit_buffer_orig;
 		struct ref_filter_and_format_cbdata ref_cbdata =3D {
 			.filter =3D filter,
@@ -3303,8 +3308,8 @@ void filter_and_format_refs(struct ref_filter *filte=
r, unsigned int type,
 	} else {
 		struct ref_array array =3D { 0 };
 		filter_refs(&array, filter, type);
-		filter_ahead_behind(the_repository, format, &array);
-		filter_is_base(the_repository, format, &array);
+		filter_ahead_behind(the_repository, &array);
+		filter_is_base(the_repository, &array);
 		ref_array_sort(sorting, &array);
 		print_formatted_ref_array(&array, format);
 		ref_array_clear(&array);
@@ -3638,16 +3643,3 @@ void ref_filter_clear(struct ref_filter *filter)
 	free_commit_list(filter->unreachable_from);
 	ref_filter_init(filter);
 }
-
-void ref_format_init(struct ref_format *format)
-{
-	struct ref_format blank =3D REF_FORMAT_INIT;
-	memcpy(format, &blank, sizeof(blank));
-}
-
-void ref_format_clear(struct ref_format *format)
-{
-	string_list_clear(&format->bases, 0);
-	string_list_clear(&format->is_base_tips, 0);
-	ref_format_init(format);
-}
diff --git a/ref-filter.h b/ref-filter.h
index 754038ab07..013d4cfa64 100644
=2D-- a/ref-filter.h
+++ b/ref-filter.h
@@ -99,12 +99,6 @@ struct ref_format {
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;

-	/* List of bases for ahead-behind counts. */
-	struct string_list bases;
-
-	/* List of bases for is-base indicators. */
-	struct string_list is_base_tips;
-
 	struct {
 		int max_count;
 		int omit_empty;
@@ -117,8 +111,6 @@ struct ref_format {
 }
 #define REF_FORMAT_INIT {             \
 	.use_color =3D -1,              \
-	.bases =3D STRING_LIST_INIT_DUP, \
-	.is_base_tips =3D STRING_LIST_INIT_DUP, \
 }

 /*  Macros for checking --merged and --no-merged options */
@@ -205,7 +197,6 @@ struct ref_array_item *ref_array_push(struct ref_array=
 *array,
  * If this is not called, then any ahead-behind atoms will be blank.
  */
 void filter_ahead_behind(struct repository *r,
-			 struct ref_format *format,
 			 struct ref_array *array);

 /*
@@ -215,13 +206,9 @@ void filter_ahead_behind(struct repository *r,
  * If this is not called, then any is-base atoms will be blank.
  */
 void filter_is_base(struct repository *r,
-		    struct ref_format *format,
 		    struct ref_array *array);

 void ref_filter_init(struct ref_filter *filter);
 void ref_filter_clear(struct ref_filter *filter);

-void ref_format_init(struct ref_format *format);
-void ref_format_clear(struct ref_format *format);
-
 #endif /*  REF_FILTER_H  */
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 500c9d0e72..a6bd88a58d 100755
=2D-- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -368,6 +368,34 @@ test_expect_success 'git branch --format with ahead-b=
ehind' '
 	test_cmp expect actual
 '

+test_expect_success 'git branch `--sort=3D[-]ahead-behind` option' '
+	cat >expect <<-\EOF &&
+	(HEAD detached from fromtag) 0 0
+	refs/heads/ambiguous 0 0
+	refs/heads/branch-two 0 0
+	refs/heads/branch-one 1 0
+	refs/heads/main 1 0
+	refs/heads/ref-to-branch 1 0
+	refs/heads/ref-to-remote 1 0
+	EOF
+	git branch --format=3D"%(refname) %(ahead-behind:HEAD)" \
+		--sort=3Drefname --sort=3Dahead-behind:HEAD >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	(HEAD detached from fromtag) 0 0
+	refs/heads/branch-one 1 0
+	refs/heads/main 1 0
+	refs/heads/ref-to-branch 1 0
+	refs/heads/ref-to-remote 1 0
+	refs/heads/ambiguous 0 0
+	refs/heads/branch-two 0 0
+	EOF
+	git branch --format=3D"%(refname) %(ahead-behind:HEAD)" \
+		--sort=3Drefname --sort=3D-ahead-behind:HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git branch with --format=3D%(rest) must fail' '
 	test_must_fail git branch --format=3D"%(rest)" >actual
 '
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 2591f8b8b3..6638d1aa1d 100755
=2D-- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -733,4 +733,33 @@ test_expect_success 'for-each-ref is-base:multiple' '
 		--format=3D"%(refname)[%(is-base:commit-2-3)-%(is-base:commit-6-5)]" --=
stdin
 '

+test_expect_success 'for-each-ref is-base: --sort' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-4-2
+	refs/heads/commit-4-4
+	refs/heads/commit-8-4
+	EOF
+
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-4-4
+	refs/heads/commit-8-4
+	refs/heads/commit-4-2
+	EOF
+	run_all_modes git for-each-ref \
+		--format=3D"%(refname)" --stdin \
+		--sort=3Drefname --sort=3Dis-base:commit-2-3 &&
+
+	cat >expect <<-\EOF &&
+	refs/heads/commit-4-2
+	refs/heads/commit-1-1
+	refs/heads/commit-4-4
+	refs/heads/commit-8-4
+	EOF
+	run_all_modes git for-each-ref \
+		--format=3D"%(refname)" --stdin \
+		--sort=3Drefname --sort=3D-is-base:commit-2-3
+'
+
 test_done
=2D-
2.48.0
