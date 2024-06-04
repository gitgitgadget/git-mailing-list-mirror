Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0111422C2
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538511; cv=none; b=NCuMmnD4pvA8+MHVbOW2BQj4JB6Eyz0QMW+iqHfV+XG9XSkuPIrcASTjcEdRxryPqA14keyw318mrVpHO9JMrZReQF6e2Mog1dsRaELXQ7v10bgGoRgFnncKjfmND70tryvAkF0odDmo0kR/9a2q8p62DOkPsFG6I1fWClxZh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538511; c=relaxed/simple;
	bh=xSh5U8nKeZBCE5gDpH1KjQ3batt7JbE2YKGtOzLfm70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxnGMdLQK2xUZxes/rdMucnvmGKu1wMhiUOywQkxHPAtL13Zfu5/us7pkpOFSiiFjsLfC6GidW2wmMoB4IhlvrBUlnED5H5d4f6o6jGM4W1tF0kVVh1CZ8TmRiyVOmRMiXH2eP1jTNabYEBl9CZngKlAUmm0spJmsLy6/wsqQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ifFyPu/9; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ifFyPu/9"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8095E34259;
	Tue,  4 Jun 2024 18:01:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=xSh5U8nKeZBCE5gDpH1KjQ3ba
	tt7JbE2YKGtOzLfm70=; b=ifFyPu/9r0LBSdE/jp782IKq95uZmTw52hd/ZHwED
	5UxXLrO8ze0lyG+R0jpkkeZXd5IwDZU9NXNoRcF9lfluLYN/aFNQW62OvtNatDGm
	zei876RKZZG6FCfr/QxXp5OTMTawn6tyXD3xKuqn6U+NRAUHWAopMik38o1h4NTW
	zM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7884034258;
	Tue,  4 Jun 2024 18:01:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 94AAF34256;
	Tue,  4 Jun 2024 18:01:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/3] Branches are branches and not heads
Date: Tue,  4 Jun 2024 15:01:42 -0700
Message-ID: <20240604220145.3260714-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-409-g7b0defb391
In-Reply-To: <20240603200539.1473345-1-gitster@pobox.com>
References: <20240603200539.1473345-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 0942204A-22BE-11EF-971A-ACC938F0AE34-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

tl;dr for those who did read v1: v2 does not warn when deprecated
variants are used.
----------------------

Back when Git started, we used the word "head" to mean the tip of
possibly multiple histories, and that is where the name of the
hierarchy .git/refs/heads/ came from.  But these days we call these
entities "branches" in human terms, and "head" is still used to
refer to the tip of the history each of these branches represent.

When asking "git ls-remote" or "git show-ref" to limit their output
to branches (as opposed to showing any ref), we use "--heads" for
historical reasons, but give the option a more human friendly name
"--branches", and demote "--heads" to the status of a deprecated
synonym. =20

We do not plan to remove "--heads" or "-h" yet, but we may want to
do so at the Git 3.0 boundary, in which case we will need to start
advertising upcoming removal with an extra warning when they are
used.  But let's not start annoying users for now.

Junio C Hamano (3):
  refs: call branches branches
  ls-remote: introduce --branches and deprecate --heads
  show-ref: introduce --branches and deprecate --heads

 Documentation/git-ls-remote.txt | 12 +++++++-----
 Documentation/git-show-ref.txt  | 18 ++++++++++--------
 builtin/ls-remote.c             |  9 ++++++---
 builtin/show-ref.c              | 16 +++++++++-------
 connect.c                       |  4 ++--
 remote.h                        |  2 +-
 t/t1403-show-ref.sh             | 24 ++++++++++++++++--------
 t/t5512-ls-remote.sh            | 32 +++++++++++++++++++++++++++-----
 8 files changed, 78 insertions(+), 39 deletions(-)

Range-diff against v1:
1:  2c551ed37b =3D 1:  2c551ed37b refs: call branches branches
2:  f88fe89ff7 ! 2:  5549e98042 ls-remote: introduce --branches and depre=
cate --heads
    @@ Commit message
         limits the output to branches, and deprecate "--heads" option us=
ed
         that way.
    =20
    +    We do not plan to remove "--heads" or "-h" yet; we may want to d=
o so
    +    at Git 3.0, in which case, we may need to start advertising upco=
ming
    +    removal with an extra warning when they are used.
    +
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      ## Documentation/git-ls-remote.txt ##
    @@ builtin/ls-remote.c
      	   "              [-q | --quiet] [--exit-code] [--get-url] [--sort=
=3D<key>]\n"
      	   "              [--symref] [<repository> [<patterns>...]]"),
      	NULL
    -@@ builtin/ls-remote.c: static int tail_match(const char **pattern, =
const char *path)
    - 	return 0;
    - }
    -=20
    -+static int heads_callback(const struct option *opt, const char *arg=
, int unset)
    -+{
    -+	unsigned *flags =3D opt->value;
    -+
    -+	if (unset) {
    -+		warning(_("'--no-heads' is deprecated; use '--no-branches' instea=
d"));
    -+		*flags &=3D ~REF_BRANCHES;
    -+	} else {
    -+		warning(_("'--heads' is deprecated; use '--branches' instead"));
    -+		*flags |=3D REF_BRANCHES;
    -+	}
    -+	return 0;
    -+}
    -+
    - int cmd_ls_remote(int argc, const char **argv, const char *prefix)
    - {
    - 	const char *dest =3D NULL;
     @@ builtin/ls-remote.c: int cmd_ls_remote(int argc, const char **arg=
v, const char *prefix)
      			   N_("path of git-upload-pack on the remote host"),
      			   PARSE_OPT_HIDDEN },
      		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
     -		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_BRANCHES)=
,
     +		OPT_BIT('b', "branches", &flags, N_("limit to branches"), REF_BRA=
NCHES),
    -+		OPT_CALLBACK_F('h', "heads", &flags,
    -+			       NULL,
    -+			       N_("deprecated synonym for --branches"),
    -+			       PARSE_OPT_NOARG|PARSE_OPT_HIDDEN,
    -+			       &heads_callback),
    ++		OPT_BIT_F('h', "heads", &flags,
    ++			  N_("deprecated synonym for --branches"), REF_BRANCHES,
    ++			  PARSE_OPT_HIDDEN),
      		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NOR=
MAL),
      		OPT_BOOL(0, "get-url", &get_url,
      			 N_("take url.<base>.insteadOf into account")),
    @@ t/t5512-ls-remote.sh: test_expect_success 'ls-remote self' '
     +	test_cmp expected.branches actual
     +'
     +
    -+test_expect_success 'ls-remote -h is deprecated' '
    ++test_expect_success 'ls-remote -h is deprecated w/o warning' '
     +	git ls-remote -h self >actual 2>warning &&
     +	test_cmp expected.branches actual &&
    -+	test_grep deprecated warning
    ++	test_grep ! deprecated warning
     +'
     +
    -+test_expect_success 'ls-remote --heads is deprecated' '
    ++test_expect_success 'ls-remote --heads is deprecated and hidden w/o=
 warning' '
    ++	test_expect_code 129 git ls-remote -h >short-help &&
    ++	test_grep ! -e --head short-help &&
     +	git ls-remote --heads self >actual 2>warning &&
     +	test_cmp expected.branches actual &&
    -+	test_grep deprecated warning
    ++	test_grep ! deprecated warning
     +'
     +
      test_expect_success 'ls-remote --sort=3D"version:refname" --tags se=
lf' '
3:  295554edfc ! 3:  9022743a32 show-ref: introduce --branches and deprec=
ate --heads
    @@ Commit message
         limits the output to branches, and deprecate "--heads" option us=
ed
         that way.
    =20
    +    We do not plan to remove "--heads" or "-h" yet; we may want to d=
o so
    +    at Git 3.0, in which case, we may need to start advertising upco=
ming
    +    removal with an extra warning when they are used.
    +
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      ## Documentation/git-show-ref.txt ##
    @@ builtin/show-ref.c: static int cmd_show_ref__patterns(const struct=
 patterns_opti
      			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
      		if (opts->tags_only)
      			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
    -@@ builtin/show-ref.c: static int exclude_existing_callback(const st=
ruct option *opt, const char *arg,
    - 	return 0;
    - }
    -=20
    -+static int heads_callback(const struct option *opt, const char *arg=
, int unset)
    -+{
    -+	int *branches_only =3D opt->value;
    -+
    -+	if (unset) {
    -+		warning(_("'--no-heads' is deprecated; use '--no-branches' instea=
d"));
    -+		*branches_only =3D 0;
    -+	} else {
    -+		warning(_("'--heads' is deprecated; use '--branches' instead"));
    -+		*branches_only =3D 1;
    -+	}
    -+	return 0;
    -+}
    -+
    - int cmd_show_ref(int argc, const char **argv, const char *prefix)
    - {
    - 	struct exclude_existing_options exclude_existing_opts =3D {0};
     @@ builtin/show-ref.c: int cmd_show_ref(int argc, const char **argv,=
 const char *prefix)
      	struct show_one_options show_one_opts =3D {0};
      	int verify =3D 0, exists =3D 0;
    @@ builtin/show-ref.c: int cmd_show_ref(int argc, const char **argv, =
const char *pr
     -		OPT_BOOL(0, "heads", &patterns_opts.heads_only, N_("only show hea=
ds (can be combined with tags)")),
     +		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags =
(can be combined with branches)")),
     +		OPT_BOOL(0, "branches", &patterns_opts.branches_only, N_("only sh=
ow branches (can be combined with tags)")),
    -+		OPT_CALLBACK_F(0, "heads", &patterns_opts.branches_only,
    -+			       NULL,
    -+			       N_("deprecated synonym for --branches)"),
    -+			       PARSE_OPT_NOARG|PARSE_OPT_HIDDEN,
    -+			       &heads_callback),
    ++		OPT_HIDDEN_BOOL(0, "heads", &patterns_opts.branches_only,
    ++				N_("deprecated synonym for --branches")),
      		OPT_BOOL(0, "exists", &exists, N_("check for reference existence =
without resolving")),
      		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
      			    "requires exact ref path")),
    @@ t/t1403-show-ref.sh: test_expect_success 'show-ref --heads, --tags=
, --head, patt
      	test_cmp expect actual
      '
     =20
    -+test_expect_success 'show-ref --heads is deprecated' '
    ++test_expect_success 'show-ref --heads is deprecated and hidden' '
    ++	test_expect_code 129 git show-ref -h >short-help &&
    ++	test_grep ! -e --heads short-help &&
     +	git show-ref --heads >actual 2>warning &&
    -+	test_grep deprecated warning &&
    ++	test_grep ! deprecated warning &&
     +	test_cmp expect.branches actual
     +'
     +
--=20
2.45.2-409-g7b0defb391

