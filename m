Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBAA18C004
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220636; cv=none; b=doJq9KJrJp1/FP7KJkW1Q5VAm63+Tr7qCWHS0lZ7qSrZi11QXgZCFLAVSRAaHWCR9QVet3pGny1HVGw/ixHSBY3d5I7IYuKDXNsZryS6+gDf7UHWevjJ2eOEr12ArVf2LveDCNpllv3rJUv3e+r+rDd9NCRjK/LUgs+Btn6JhsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220636; c=relaxed/simple;
	bh=JaK1jCzAi35DfBtOahgio2LknmBDNxQXHM8Sv/17Lbo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MW99+LhWbW1HxycMLNHj9Kzx6G2IrqDX4Zdzg+mNK+BxTiSZ95J8Rize/BpRYRTOTqIwpNTUmbiAdTkW11ssCo+gCBXDjjVTrgHxXGHZRlhC3eWBYaCKygUajpoV4QQOyV130AdP/LN11J5iYj3yKvK3CFf2jJbQ9RKCGyxnzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=lkIh9nnP; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="lkIh9nnP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737220631; x=1737825431; i=l.s.r@web.de;
	bh=j88aHa3Qc9GJiLD5lmneR3eDwJkQiuwRsOsBF9ScS+I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lkIh9nnP2LUfbUQdPq/C9qMccHYlaY7DHfDv+gT4hSvxX2Xws9UF4fuzqK0wrKjE
	 uGJcNzOffPvh3LpaY4cdjbXT2jfjtp3NUFQQPSXBX33F/SjCu6buzEleiCd8V4qWU
	 3LPqpympPa5cUMcT9MxGlRkoObMidlpn2yl9HLL1uLYwM3+GZ68QgOwiKZnNcLeJ7
	 F/HTT2YdW9gCj8KYZ9SyG05cC2dvfDg0QbIY5LEoHo02tfCwRvwdy+af4oKr1pKLG
	 cbNouEnvoxvJBmjpSrwTtL4IYKcJqExxr14yGjEZmswSNCP4WBx2YY8Ybb7XaN6SM
	 HHaoJSNJXl4WupDyeA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.126]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPdr-1tus4f02Px-00NWaG; Sat, 18
 Jan 2025 18:11:52 +0100
Message-ID: <37f98b6b-b49b-4c17-b157-e15e14dbc91d@web.de>
Date: Sat, 18 Jan 2025 18:11:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/3] ref-filter: move is-base tip to used_atom
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
X-Provags-ID: V03:K1:pL5N1JlyVBCzcvgVbvyuHTlfYfS4B+EkikHfnt+r+gcEdC9X8I2
 AO/wim1j9vWPreCBwOJfhmiBidTOKRAaEXytzrw815WUE5ZY2EW/JeJfA2l+6YyzmEgMaRh
 VndSnXN72dibug7thRfCVYBsjFSlUQzw14QbBahO1ciwyokfjSX5Kmuoo8e4upMoaAUwlCR
 vruN8IwQksnSfmbzf+DwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a+Le0o+YBzk=;WH5lXQB5fR3y5Mr43truXvL669O
 nOor9BmqTiijrtm3Ew5ndSAlZ63SacODneztAmizoY9FU86MkSvsnk9ljt5EUZlu3ojgaGc48
 q7Qp62okJp6bcjyG760+0/+bebxj7Z8r1gcx2Y8CHgN7TEfIL4FG6Dh0UVCWIpNlN/WHQRijE
 eKTHM3653kHyhW4EGlITLHIp1KfixKbk09FGUVqxiDZ2hPr7dp/x9YPxChcHcyuPlZpgf66yl
 gj7TcCsS7m11T32dVErWqE4TW+zZCF2dzddQrovGLck1Hdbi5Zhy0qJaplyMXsOy2X/PFGGZY
 HOJCV8hqlL/MucDfhBLBo4xg+5cERO3WT5L9XiC4Gt2Zoa6/865KSxn/3oibpKmJZ6B2tryDX
 upn0lbIZWB8Jyhu2DBszZ+CNCLHAfd4MvHXVcpDELlAtaE2vLYDBT5rwP7oNi1x2C7unMoIWr
 MyCJiU9NdCPaChGd72/13FnS2QNHPgjft+/HefOn2KsrDOkLaHQKp/NBbiDkNA+Zao9M8cicX
 d6wjrXCGLvtIOsEnnhukkwZeaiK6DrD2qMBXs2tfCum4rY1fyeSzeCcWEsbr/W7ah7Nexbyi7
 HC/rZccdj8gQ74fTjlV2EcIHEaQhT+vXpfMC9qZyZEHM190n9Jp6lQq7RS44jVnwPy/mBGKSw
 IGpiEM/XcEW0XRBf44XzaK88pbatiebfw6CdH62Zgtl6DO83QQ9sV4Uh6/LAG/pN50ojhu5n4
 kNBWZdLtLZyhpd0oI3kL97wJmnMDJv0JGVkCRFdkpoh1QZzSZcTWhUIyvXjm99pg3ryKgTFFN
 JvwaG1Fq3IZJ4+6f8ZPoSoa+8uFBkmLdduR/5kO9Re9own+eGabM7UezkuFb+XCEvwGf7m7H+
 +tr5B0dSU0mjMzB0C3TXnBZHieHQdaxFpU6X8Ul6VIwJ+tXRJanI4J1muGjDnpDkiaQIAONKf
 ylSJTOI3WqKPDY6PtGD2MvOr8J8f6lJ+XAHJzI/XgZvuktLSQ+BYXz4UIhF/MReTmQfROrZ1j
 MAUya1fhIsOjZVvaKKztRBcxxR92v5+7XSDSaXj3lavsNYH3ZcXHrk9mQqboKCpx97coKJTsx
 Ovb730EHIMz8e6hb9P+3OcvrpTtH+s+oVAheuF1uMw+aX0DObXe9MpzF4/XCFmEWZSaZwsHIC
 1Uk+rqxOupTQqgRPaJbxiVawHKFNEclwjPSWau2lLlA==

The string_list "is_base_tips" in struct ref_format stores the
committish part of "is-base:<committish>".  It has the same problems
that its sibling string_list "bases" had.  Fix them the same way as the
previous commit did for the latter, by replacing the string_list with
fields in "used_atom".

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 ref-filter.c          | 56 +++++++++++++++++++++++++------------------
 ref-filter.h          |  5 ----
 t/t6600-test-reach.sh | 29 ++++++++++++++++++++++
 3 files changed, 62 insertions(+), 28 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index c3957473e5..9a4b2d4cea 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -236,6 +236,7 @@ static struct used_atom {
 			       S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL } option;
 		} signature;
 		struct {
+			char *name;
 			struct commit *commit;
 		} base;
 		struct strvec describe_args;
@@ -908,18 +909,16 @@ static int ahead_behind_atom_parser(struct ref_forma=
t *format UNUSED,
 	return 0;
 }

-static int is_base_atom_parser(struct ref_format *format,
-			       struct used_atom *atom UNUSED,
+static int is_base_atom_parser(struct ref_format *format UNUSED,
+			       struct used_atom *atom,
 			       const char *arg, struct strbuf *err)
 {
-	struct string_list_item *item;
-
 	if (!arg)
 		return strbuf_addf_ret(err, -1, _("expected format: %%(is-base:<committ=
ish>)"));

-	item =3D string_list_append(&format->is_base_tips, arg);
-	item->util =3D lookup_commit_reference_by_name(arg);
-	if (!item->util)
+	atom->u.base.name =3D xstrdup(arg);
+	atom->u.base.commit =3D lookup_commit_reference_by_name(arg);
+	if (!atom->u.base.commit)
 		die("failed to find '%s'", arg);

 	return 0;
@@ -3009,6 +3008,8 @@ void ref_array_clear(struct ref_array *array)
 			free(atom->u.head);
 		else if (atom->atom_type =3D=3D ATOM_DESCRIBE)
 			strvec_clear(&atom->u.describe_args);
+		else if (atom->atom_type =3D=3D ATOM_ISBASE)
+			free(atom->u.base.name);
 		else if (atom->atom_type =3D=3D ATOM_TRAILERS ||
 			 (atom->atom_type =3D=3D ATOM_CONTENTS &&
 			  atom->u.contents.option =3D=3D C_TRAILERS)) {
@@ -3133,14 +3134,20 @@ void filter_ahead_behind(struct repository *r,
 }

 void filter_is_base(struct repository *r,
-		    struct ref_format *format,
 		    struct ref_array *array)
 {
 	struct commit **bases;
-	size_t bases_nr =3D 0;
+	size_t bases_nr =3D 0, is_base_nr;
 	struct ref_array_item **back_index;

-	if (!format->is_base_tips.nr || !array->nr)
+	if (!array->nr)
+		return;
+
+	for (size_t i =3D is_base_nr =3D 0; i < used_atom_cnt; i++) {
+		if (used_atom[i].atom_type =3D=3D ATOM_ISBASE)
+			is_base_nr++;
+	}
+	if (!is_base_nr)
 		return;

 	CALLOC_ARRAY(back_index, array->nr);
@@ -3150,7 +3157,7 @@ void filter_is_base(struct repository *r,
 		const char *name =3D array->items[i]->refname;
 		struct commit *c =3D lookup_commit_reference_by_name_gently(name, 1);

-		CALLOC_ARRAY(array->items[i]->is_base, format->is_base_tips.nr);
+		CALLOC_ARRAY(array->items[i]->is_base, is_base_nr);

 		if (!c)
 			continue;
@@ -3160,15 +3167,20 @@ void filter_is_base(struct repository *r,
 		bases_nr++;
 	}

-	for (size_t i =3D 0; i < format->is_base_tips.nr; i++) {
-		struct commit *tip =3D format->is_base_tips.items[i].util;
-		int base_index =3D get_branch_base_for_tip(r, tip, bases, bases_nr);
+	for (size_t i =3D 0, j =3D 0; i < used_atom_cnt; i++) {
+		struct commit *tip;
+		int base_index;
+
+		if (used_atom[i].atom_type !=3D ATOM_ISBASE)
+			continue;

+		tip =3D used_atom[i].u.base.commit;
+		base_index =3D get_branch_base_for_tip(r, tip, bases, bases_nr);
 		if (base_index < 0)
 			continue;

 		/* Store the string for use in output later. */
-		back_index[base_index]->is_base[i] =3D xstrdup(format->is_base_tips.ite=
ms[i].string);
+		back_index[base_index]->is_base[j++] =3D xstrdup(used_atom[i].u.base.na=
me);
 	}

 	free(back_index);
@@ -3260,8 +3272,7 @@ struct ref_sorting {
 };

 static inline int can_do_iterative_format(struct ref_filter *filter,
-					  struct ref_sorting *sorting,
-					  struct ref_format *format)
+					  struct ref_sorting *sorting)
 {
 	/*
 	 * Reference backends sort patterns lexicographically by refname, so if
@@ -3288,17 +3299,17 @@ static inline int can_do_iterative_format(struct r=
ef_filter *filter,
 	for (size_t i =3D 0; i < used_atom_cnt; i++) {
 		if (used_atom[i].atom_type =3D=3D ATOM_AHEADBEHIND)
 			return 0;
+		if (used_atom[i].atom_type =3D=3D ATOM_ISBASE)
+			return 0;
 	}
-	return !(filter->reachable_from ||
-		 filter->unreachable_from ||
-		 format->is_base_tips.nr);
+	return !(filter->reachable_from || filter->unreachable_from);
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
@@ -3315,7 +3326,7 @@ void filter_and_format_refs(struct ref_filter *filte=
r, unsigned int type,
 		struct ref_array array =3D { 0 };
 		filter_refs(&array, filter, type);
 		filter_ahead_behind(the_repository, &array);
-		filter_is_base(the_repository, format, &array);
+		filter_is_base(the_repository, &array);
 		ref_array_sort(sorting, &array);
 		print_formatted_ref_array(&array, format);
 		ref_array_clear(&array);
@@ -3658,6 +3669,5 @@ void ref_format_init(struct ref_format *format)

 void ref_format_clear(struct ref_format *format)
 {
-	string_list_clear(&format->is_base_tips, 0);
 	ref_format_init(format);
 }
diff --git a/ref-filter.h b/ref-filter.h
index 5f3dd6c931..0ba94df651 100644
=2D-- a/ref-filter.h
+++ b/ref-filter.h
@@ -99,9 +99,6 @@ struct ref_format {
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;

-	/* List of bases for is-base indicators. */
-	struct string_list is_base_tips;
-
 	struct {
 		int max_count;
 		int omit_empty;
@@ -114,7 +111,6 @@ struct ref_format {
 }
 #define REF_FORMAT_INIT {             \
 	.use_color =3D -1,              \
-	.is_base_tips =3D STRING_LIST_INIT_DUP, \
 }

 /*  Macros for checking --merged and --no-merged options */
@@ -210,7 +206,6 @@ void filter_ahead_behind(struct repository *r,
  * If this is not called, then any is-base atoms will be blank.
  */
 void filter_is_base(struct repository *r,
-		    struct ref_format *format,
 		    struct ref_array *array);

 void ref_filter_init(struct ref_filter *filter);
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
2.48.1
