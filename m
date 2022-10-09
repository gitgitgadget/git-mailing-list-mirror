Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BC6C433F5
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 22:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiJIWo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 18:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiJIWnT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 18:43:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D091C905
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 15:22:29 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 135061B71B3;
        Sun,  9 Oct 2022 18:13:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cPi9oUXLacRb
        uy7E9JlGgoiUgtJYCUlZxTecEfalUVk=; b=v9LvHaZL+ppcHPBaSym0tLS76Ay5
        TawMrNcPTfaMgSaz6SG2Z1P4NHTEO3bdEONB1Q3J+XGVyHu+u8GcL5ANkKbcwSvR
        ZbJIppErRG9t/yYP5mNzeuc1FgwhzWSVCzZMGPjZSD1ZTvXUflNR/AzQilZDbSF4
        nDg9y+QVE7nd5Ag=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDEDF1B71B2;
        Sun,  9 Oct 2022 18:13:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E5E51B71B1;
        Sun,  9 Oct 2022 18:13:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3] symbolic-ref: teach "--[no-]recurse" option
References: <xmqqleprcn08.fsf@gitster.g> <xmqqsfjzaq78.fsf@gitster.g>
Date:   Sun, 09 Oct 2022 15:13:19 -0700
In-Reply-To: <xmqqsfjzaq78.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        07 Oct 2022 21:34:35 -0700")
Message-ID: <xmqqy1to63y8.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9515172E-481F-11ED-9250-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suppose you are managing many maintenance tracks in your project,
and some of the more recent ones are maint-2.36 and maint-2.37.
Further imagine that your project recently tagged the official 2.38
release, which means you would need to start maint-2.38 track soon,
by doing:

  $ git checkout -b maint-2.38 v2.38.0^0
  $ git branch --list 'maint-2.3[6-9]'
  * maint-2.38
    maint-2.36
    maint-2.37

So far, so good.  But it also is reasonable to want not to have to
worry about which maintenance track is the latest, by pointing a
more generic-sounding 'maint' branch at it, by doing:

  $ git symbolic-ref refs/heads/maint refs/heads/maint-2.38

which would allow you to say "whichever it is, check out the latest
maintenance track", by doing:

  $ git checkout maint
  $ git branch --show-current
  maint-2.38

It is arguably better to say that we are on 'maint-2.38' rather than
on 'maint', and "git merge/pull" would record "into maint-2.38" and
not "into maint", so I think what we have is a good behaviour.

One thing that is slightly irritating, however, is that I do not
think there is a good way (other than "cat .git/HEAD") to learn that
you checked out 'maint' to get into that state.  Just like the output
of "git branch --show-current" shows above, "git symbolic-ref HEAD"
would report 'refs/heads/maint-2.38', bypassing the intermediate
symbolic ref at 'refs/heads/maint' that is pointed at by HEAD.

The internal resolve_ref() API already has the necessary support for
stopping after resolving a single level of a symbolic-ref, and we
can expose it by adding a "--[no-]recurse" option to the command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The third time is the charm?  The only change since v2 is to make
   sure that =C3=86var's "doc SYNOPSIS and cmd -h help must match" topic
   is not upset with the new option.

 Documentation/git-symbolic-ref.txt | 11 ++++++++++-
 builtin/symbolic-ref.c             | 18 +++++++++++-------
 t/t1401-symbolic-ref.sh            | 14 ++++++++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbo=
lic-ref.txt
index ef68ad2b71..102c83eb19 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git symbolic-ref' [-m <reason>] <name> <ref>
-'git symbolic-ref' [-q] [--short] <name>
+'git symbolic-ref' [-q] [--short] [--no-recurse] <name>
 'git symbolic-ref' --delete [-q] <name>
=20
 DESCRIPTION
@@ -46,6 +46,15 @@ OPTIONS
 	When showing the value of <name> as a symbolic ref, try to shorten the
 	value, e.g. from `refs/heads/master` to `master`.
=20
+--recurse::
+--no-recurse::
+	When showing the value of <name> as a symbolic ref, if
+	<name> refers to another symbolic ref, follow such a chain
+	of symbolic refs until the result no longer points at a
+	symbolic ref (`--recurse`, which is the default).
+	`--no-recurse` stops after dereferencing only a single level
+	of symbolic ref.
+
 -m::
 	Update the reflog for <name> with <reason>.  This is valid only
 	when creating or updating a symbolic ref.
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index e547a08d6c..d5a70e7bd8 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -6,14 +6,17 @@
=20
 static const char * const git_symbolic_ref_usage[] =3D {
 	N_("git symbolic-ref [<options>] <name> [<ref>]"),
-	N_("git symbolic-ref -d [-q] <name>"),
+	N_("git symbolic-ref -d [-q] [--no-recurse] <name>"),
 	NULL
 };
=20
-static int check_symref(const char *HEAD, int quiet, int shorten, int pr=
int)
+static int check_symref(const char *HEAD, int quiet, int shorten, int re=
curse, int print)
 {
-	int flag;
-	const char *refname =3D resolve_ref_unsafe(HEAD, 0, NULL, &flag);
+	int resolve_flags, flag;
+	const char *refname;
+
+	resolve_flags =3D (recurse ? 0 : RESOLVE_REF_NO_RECURSE);
+	refname =3D resolve_ref_unsafe(HEAD, resolve_flags, NULL, &flag);
=20
 	if (!refname)
 		die("No such ref: %s", HEAD);
@@ -35,13 +38,14 @@ static int check_symref(const char *HEAD, int quiet, =
int shorten, int print)
=20
 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 {
-	int quiet =3D 0, delete =3D 0, shorten =3D 0, ret =3D 0;
+	int quiet =3D 0, delete =3D 0, shorten =3D 0, recurse =3D 1, ret =3D 0;
 	const char *msg =3D NULL;
 	struct option options[] =3D {
 		OPT__QUIET(&quiet,
 			N_("suppress error message for non-symbolic (detached) refs")),
 		OPT_BOOL('d', "delete", &delete, N_("delete symbolic ref")),
 		OPT_BOOL(0, "short", &shorten, N_("shorten ref output")),
+		OPT_BOOL(0, "recurse", &recurse, N_("recursively dereference (default)=
")),
 		OPT_STRING('m', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_END(),
 	};
@@ -55,7 +59,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const=
 char *prefix)
 	if (delete) {
 		if (argc !=3D 1)
 			usage_with_options(git_symbolic_ref_usage, options);
-		ret =3D check_symref(argv[0], 1, 0, 0);
+		ret =3D check_symref(argv[0], 1, 0, 0, 0);
 		if (ret)
 			die("Cannot delete %s, not a symbolic ref", argv[0]);
 		if (!strcmp(argv[0], "HEAD"))
@@ -65,7 +69,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const=
 char *prefix)
=20
 	switch (argc) {
 	case 1:
-		ret =3D check_symref(argv[0], quiet, shorten, 1);
+		ret =3D check_symref(argv[0], quiet, shorten, recurse, 1);
 		break;
 	case 2:
 		if (!strcmp(argv[0], "HEAD") &&
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 132a1b885a..773a6e8e01 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -163,4 +163,18 @@ test_expect_success 'symbolic-ref can resolve d/f na=
me (ENOTDIR)' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'symbolic-ref pointing at another' '
+	git update-ref refs/heads/maint-2.37 HEAD &&
+	git symbolic-ref refs/heads/maint refs/heads/maint-2.37 &&
+	git checkout maint &&
+
+	git symbolic-ref HEAD >actual &&
+	echo refs/heads/maint-2.37 >expect &&
+	test_cmp expect actual &&
+
+	git symbolic-ref --no-recurse HEAD >actual &&
+	echo refs/heads/maint >expect &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.38.0-167-gf9a88ca9e9

