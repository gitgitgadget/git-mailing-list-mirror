Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1627D42070
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220307; cv=none; b=f/RyRq75zDsjHf8UxeHiP9JKv5jeBL6+Nc8ZQ2EIC0hQ/bnztas/gvNPjy/g81QGeDQxQDkRHRfHZRlbLgOv5R6bUGEGEMg3MxzXQEa4/RW/ODryAjBPpeb0P5sgI3ZIIkfLSkJ5JPUPYF8iTVi8JnuS49z+klaj3OuANf2pfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220307; c=relaxed/simple;
	bh=VeLhdCuPpK0ygLAG13j8RZUUcaBtQgMFW9x1OwP3tq0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M2edRJhN3T9P6Wzue61+rjBQRunx16muHCOrvBQrnci4Jnevj6ObS1DExcJM+MWZfd+qigZxB8kQEGw4k7fphQKSjfEcEixKiHkyPRsawztAlCujegypBcspVVc+Swjq7B5Qr5/7LtmsHfKLVBnS0qTcy9AYbUCsglJ8VTHxqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=EiDclZLP; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="EiDclZLP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737220295; x=1737825095; i=l.s.r@web.de;
	bh=xV2wTaPScE+foUl6PSBiDSj5lYITbjQxkGSDvJywpOU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EiDclZLPlhjxVtEEFBKWuG/k6G98EOYbW4gW0p2eewJCxExFM9yysALlKoVLoMCZ
	 MamuU5l9aPDanWbPRSNZbcRjGk3K+bMMqZmNeFLN5/gf5eE6BT60BEHFXcXxaahhp
	 yb9m8Felrk1IM7nNyNMSd0LEdN0DsT5gImoAQgHDAbfuZhAmyPXEtLKVtu0BJ5Eug
	 229/Zy9ZMXvP9XNvac5pehn4bmALxM6uCuQULa4M/gl5Q11mma6NqUm/fWFflodxl
	 3QSBxLJ6W5yLanS3le3z022ApsVeD653y/Qn81bmfOjgDtTnNv4tqU3dF9xiXolHx
	 Bx24YFQmQgyMWw9jNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.126]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5o3-1thgoh46Xh-00ARTf; Sat, 18
 Jan 2025 18:11:35 +0100
Message-ID: <08fbb64d-8d01-4c24-8072-f6065b4f4ab9@web.de>
Date: Sat, 18 Jan 2025 18:11:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/3] ref-filter: move ahead-behind bases into used_atom
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Ross Goldberg <ross.goldberg@gmail.com>
References: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
 <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
Content-Language: en-US
In-Reply-To: <6b824f05-6f16-4cd9-85b7-3b8b236158b4@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ST6qpDlW3dE5RAfKuBdJUrcYg5wsoHuCmm6z/7PqwHR6KZbNFGU
 tJ2sP81Z7F8LRfjL8WEeHH7KhMPikmbxzGT3uHVC5cJ9CPRI1bHZKmW92rLMgq9RdkxKWO+
 8izy+VCdQrb/6IgKa1xHNZqy3r+uG7FlvPc10LhU45eXNQwolPEmNLfNETOnk6A1iaF7LQM
 6YCKnJRSyg7Zz7b+WuTqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rAFNpCocsj4=;4/ZT2J1q9aYoIpPK19YkmxekpVL
 1j3AedTpb0E6wkqpomIYZnM/DDRLmmXKRf9GbxmG7l4X27ND3KLqS/l+kOLsY4TIBUbwZ67Cm
 mdspz3b70Pjw7Qx53BTIndi5Z0UlkQyxbZuOwgPBEhb7WIVCXV4EIdTi4c7nn4nLl8fGToVIN
 MaSmi9xcxLLlXg7Wyaj2dmyia048wIEJjcDMt1FABwpgZrX3tx+ZDEeiliNQX8tMAxIKAVyhu
 ApuLoHPYp6HcdkOCtfJbLbcFmFUncogJSXanecM4ioq06qhQAG8Aii4AkYNZrj6gY3wZRjw8m
 qkw3IPdgCBVg3R9NT6foYarNdJG7ut35CQMHXNoiyFH5bHFlGgE6QGXhga3Bv/LtmkmWxOgk/
 nNB1DKwd+rE/GDQ+MkODUaBW0pH6wuOsfugZ2zlUp3S36cZ2/H0UGT99QI3fwmeQtOktjgJtN
 OWBFlMY5P8haQicbTiL4k5sZ5i5EczU/Tn1Xffz8eapXQVZrkU0cEqGwZpGNYxvzRbQQL284z
 0AF1euFDAOU22zt9BBuvMfp4vp7tNgjjfj/4QwWmXLpIpXLnN1N8hq6tzMKA5/8lLlgEW+jyo
 c3Lt25R2cZ60P/mIMyeyJb2vzsAM0WA2rQTLdg2Eg3k7aZxsKhobBDehPW5mG7cZLtgS6Catn
 PAEiHLEWP/Q6lG7RptWG09uX3dxfF1ph453PO98tkZPekvZeu3XWe3tE72isFraDlaBzRFWDi
 so4Mtd6/kAf3l/0lSJCFp3kPoV9cYvk81OjhEGAE7r3LSTDs553lySnN6V85CC5U1OhOAKnf4
 gzJIEPRDKymyRcpaiCYRXEPC7bGuZ2cVJyGJjPpMsi3kTC4qcgLodMzFEXvKaWb7LCWITLkJF
 mEYkwEnMsqqgXOYPqNolWH5Ex9WQh/wYxGSGzmTS6NNLU0HOghU8gzn6Ji8dFQW5o8imel/sF
 6ZdhIrOdTQuLef7G+SExQxonH6+jlmnIRD+7EetFu482l3QZpDlmf6sMgDcvf4sH7aqBLoROp
 m1mUZTpK/zhukLgSNwjNJ0d5HkUU0PQo+pwkNt/7MebAVDT9BqW6AfTwRaiwcXR/FUT40vyLL
 xB+sBLHO5lWrz1AGzzad6kIsvqq4rlOtdg29TksfqDgKcncw5sQhww4SPJba1zIDwAZujCbks
 kqMzdAvauono++MC8y+lR/qWJ46SRzRzFsW9RsTT3xA==

verify_ref_format() parses a ref-filter format string and stores
recognized items in the static array "used_atom".  For
"ahead-behind:<committish>" it stores the committish part in a
string_list member "bases" of struct ref_format.

ref_sorting_options() also parses bare ref-filter format items and
stores stores recognized ones in "used_atom" as well.  The committish
parts go to a dummy struct ref_format in parse_sorting_atom(), though,
and are leaked and forgotten.

If verify_ref_format() is called before ref_sorting_options(), like in
git for-each-ref, then all works well if the sort key is included in the
format string.  If it isn't then sorting cannot work as the committishes
are missing.

If ref_sorting_options() is called first, like in git branch, then we
have the additional issue that if the sort key is included in the format
string then filter_ahead_behind() can't see its committish, will not
generate any results for it and thus it will be expanded to an empty
string.

Fix those issues by replacing the string_list with a field in used_atom
for storing the committish.  This way it can be shared for handling both
ref-filter format strings and sorting options in the same command.

Reported-by: Ross Goldberg <ross.goldberg@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/branch.c         |  2 +-
 ref-filter.c             | 50 ++++++++++++++++++++++++----------------
 ref-filter.h             |  5 ----
 t/t3203-branch-output.sh | 28 ++++++++++++++++++++++
 4 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6e7b0cfddb..fbb9536282 100644
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
diff --git a/ref-filter.c b/ref-filter.c
index bf5534605e..c3957473e5 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -235,6 +235,9 @@ static struct used_atom {
 			enum { S_BARE, S_GRADE, S_SIGNER, S_KEY,
 			       S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL } option;
 		} signature;
+		struct {
+			struct commit *commit;
+		} base;
 		struct strvec describe_args;
 		struct refname_atom refname;
 		char *head;
@@ -891,18 +894,15 @@ static int rest_atom_parser(struct ref_format *forma=
t UNUSED,
 	return 0;
 }

-static int ahead_behind_atom_parser(struct ref_format *format,
-				    struct used_atom *atom UNUSED,
+static int ahead_behind_atom_parser(struct ref_format *format UNUSED,
+				    struct used_atom *atom,
 				    const char *arg, struct strbuf *err)
 {
-	struct string_list_item *item;
-
 	if (!arg)
 		return strbuf_addf_ret(err, -1, _("expected format: %%(ahead-behind:<co=
mmittish>)"));

-	item =3D string_list_append(&format->bases, arg);
-	item->util =3D lookup_commit_reference_by_name(arg);
-	if (!item->util)
+	atom->u.base.commit =3D lookup_commit_reference_by_name(arg);
+	if (!atom->u.base.commit)
 		die("failed to find '%s'", arg);

 	return 0;
@@ -3084,22 +3084,30 @@ static void reach_filter(struct ref_array *array,
 }

 void filter_ahead_behind(struct repository *r,
-			 struct ref_format *format,
 			 struct ref_array *array)
 {
 	struct commit **commits;
-	size_t commits_nr =3D format->bases.nr + array->nr;
+	size_t bases_nr, commits_nr;

-	if (!format->bases.nr || !array->nr)
+	if (!array->nr)
 		return;

-	ALLOC_ARRAY(commits, commits_nr);
-	for (size_t i =3D 0; i < format->bases.nr; i++)
-		commits[i] =3D format->bases.items[i].util;
+	for (size_t i =3D bases_nr =3D 0; i < used_atom_cnt; i++) {
+		if (used_atom[i].atom_type =3D=3D ATOM_AHEADBEHIND)
+			bases_nr++;
+	}
+	if (!bases_nr)
+		return;

-	ALLOC_ARRAY(array->counts, st_mult(format->bases.nr, array->nr));
+	ALLOC_ARRAY(commits, st_add(bases_nr, array->nr));
+	for (size_t i =3D 0, j =3D 0; i < used_atom_cnt; i++) {
+		if (used_atom[i].atom_type =3D=3D ATOM_AHEADBEHIND)
+			commits[j++] =3D used_atom[i].u.base.commit;
+	}

-	commits_nr =3D format->bases.nr;
+	ALLOC_ARRAY(array->counts, st_mult(bases_nr, array->nr));
+
+	commits_nr =3D bases_nr;
 	array->counts_nr =3D 0;
 	for (size_t i =3D 0; i < array->nr; i++) {
 		const char *name =3D array->items[i]->refname;
@@ -3108,8 +3116,8 @@ void filter_ahead_behind(struct repository *r,
 		if (!commits[commits_nr])
 			continue;

-		CALLOC_ARRAY(array->items[i]->counts, format->bases.nr);
-		for (size_t j =3D 0; j < format->bases.nr; j++) {
+		CALLOC_ARRAY(array->items[i]->counts, bases_nr);
+		for (size_t j =3D 0; j < bases_nr; j++) {
 			struct ahead_behind_count *count;
 			count =3D &array->counts[array->counts_nr++];
 			count->tip_index =3D commits_nr;
@@ -3277,9 +3285,12 @@ static inline int can_do_iterative_format(struct re=
f_filter *filter,
 	 * - filtering on reachability
 	 * - including ahead-behind information in the formatted output
 	 */
+	for (size_t i =3D 0; i < used_atom_cnt; i++) {
+		if (used_atom[i].atom_type =3D=3D ATOM_AHEADBEHIND)
+			return 0;
+	}
 	return !(filter->reachable_from ||
 		 filter->unreachable_from ||
-		 format->bases.nr ||
 		 format->is_base_tips.nr);
 }

@@ -3303,7 +3314,7 @@ void filter_and_format_refs(struct ref_filter *filte=
r, unsigned int type,
 	} else {
 		struct ref_array array =3D { 0 };
 		filter_refs(&array, filter, type);
-		filter_ahead_behind(the_repository, format, &array);
+		filter_ahead_behind(the_repository, &array);
 		filter_is_base(the_repository, format, &array);
 		ref_array_sort(sorting, &array);
 		print_formatted_ref_array(&array, format);
@@ -3647,7 +3658,6 @@ void ref_format_init(struct ref_format *format)

 void ref_format_clear(struct ref_format *format)
 {
-	string_list_clear(&format->bases, 0);
 	string_list_clear(&format->is_base_tips, 0);
 	ref_format_init(format);
 }
diff --git a/ref-filter.h b/ref-filter.h
index 754038ab07..5f3dd6c931 100644
=2D-- a/ref-filter.h
+++ b/ref-filter.h
@@ -99,9 +99,6 @@ struct ref_format {
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;

-	/* List of bases for ahead-behind counts. */
-	struct string_list bases;
-
 	/* List of bases for is-base indicators. */
 	struct string_list is_base_tips;

@@ -117,7 +114,6 @@ struct ref_format {
 }
 #define REF_FORMAT_INIT {             \
 	.use_color =3D -1,              \
-	.bases =3D STRING_LIST_INIT_DUP, \
 	.is_base_tips =3D STRING_LIST_INIT_DUP, \
 }

@@ -205,7 +201,6 @@ struct ref_array_item *ref_array_push(struct ref_array=
 *array,
  * If this is not called, then any ahead-behind atoms will be blank.
  */
 void filter_ahead_behind(struct repository *r,
-			 struct ref_format *format,
 			 struct ref_array *array);

 /*
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
=2D-
2.48.1
