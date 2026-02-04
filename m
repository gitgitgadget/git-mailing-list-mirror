Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ADD194A60
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211853; cv=none; b=iELqivpT33eeUg76sbAONcD0HQBN5j9khg4cgCMBTStOleB12sUu72nkgSyBRUTOkwEfDo68UzrrJgkljUomKPV+GMPE1ty4a61S6hUJA/TdMpJLq0Ro8RlvxcJxH6zMdSMAwsEvMHXHfhOZRPqcUhSQ6cn4T0bE5kQbiD5mQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211853; c=relaxed/simple;
	bh=XibJnJHQom3yfJ4qtt2FZLbEalLeDZ/USoprr9bC9+8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fD//HKJc5mVOx6KNDT01tLOZEtUWUEDzCUwz4xw07KEEhH3ZFRpNAPqbCbpU+inR7I6WF9a5eC0OrdYHNB/429as/meyt2zGgICp2A6Vsc6uJNv/JKp1qIguj8SB/kshqQtxPut+hh4AWmVL+67i484E50XIkfM0epLZGTG5xmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=x5gsLGhM; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="x5gsLGhM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1770211842; x=1770471042;
	bh=4OFX4/ooBjUTjxb2L/gUGAFln3+l/X6WethLRa3WwBE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=x5gsLGhMXU5uqNbzjQj+1TLJwboDImIk/YU7lAngx6moyD5KIQ2BiFricEUbCUy36
	 CTaHBTTJ/ZEcoBsbQAtoDW2AUnyx1Kij5igXBdEKQoxbL6rwGrlfs1rHW60cI+fUdf
	 Y6jDi5ZwlBE0D0qlhZDnOOZEwptCdzsJEC8cG/ZNAkLJfIfcQau/uj4ziAeeYr5SkH
	 dZk5C/XoVoZlCrYECAqDWlBlzFNMZMbABScI6m5bI99r4bmElHjKv1fn0B4Ppy0Q5W
	 5gxyv8prpzs/W9NoinO6Z4BWRflYbXMOSOBViZCmdb0m+bpfvv18mgqQBWEbYmt1nB
	 OgluJOWTYb0rw==
Date: Wed, 04 Feb 2026 13:30:38 +0000
To: git@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Tian Yuchen <a3205153416@gmail.com>, "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH] fix git add :!x exiting with error when x is in .gitignore
Message-ID: <20260204132747.1564157-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: f381e2d63d5b1120947d939e8fe99338544164e0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

`git add :!x .`, which is also executed as part of `git stash :!x`,
seems to treat pathspec with and without exclude magic the same, exiting
with error when "x" exists and is in gitignore.

Git-add manpage doesn't specify that exclude pathspecs should be treated
anyhow differently from normal ones, which seems like a bug. Two
inconsistencies I noticed: `git add :!ignored .` succeeds when "ignored"
file doesn't exist, and `git add :!ignored/x .` succeeds even when
"ignored/x" file exists.

This commit makes makes `git add :!x` not error on x being excluded path.


| $ sh repro.sh
| [...]
| + echo x >.gitignore
| + echo x >x
| + git stash --include-untracked -- ':!x'
| Saved working directory and index state WIP on main: c8a842d Init
| The following paths are ignored by one of your .gitignore files:
| x
| hint: Use -f if you really want to add them.
| hint: Disable this message with "git config set advice.addIgnoredFile fal=
se"
| + echo exited with code 1
| exited with code 1


| # repro.sh
| rm -rf repro; mkdir repro; cd repro
| trap 'echo exited with code $?' EXIT
| set -euo pipefail -o xtrace
|
| git init
| git commit -m Init --allow-empty
|
| # Commenting out either of the following lines makes git add/stash below =
succeed
| echo x >.gitignore
| echo x >x
|
| # Git add . is executed as part of git stash, as can be seen using strace=
 -ffeexecve:
| git add -- ":!x" . # fails
| # git stash --include-untracked -- ":!x" # fails

---
I'm not sure who else to cc, last commit touching this code is 2ec87741
from 10 year ago, being a mere refactoring. I think this bug was simply
overlooked when introducing PATHSPEC_EXCLUDE.

Thanks to Tian Yuchen for looking at my earlier submission (and noticing
an awkwardly stupid bug there).
---
 dir.c                              |  3 +++
 t/t2204-add-ignored.sh             | 14 ++++++++++++++
 t/t3905-stash-include-untracked.sh | 23 +++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/dir.c b/dir.c
index b00821f294..ed6b99e337 100644
--- a/dir.c
+++ b/dir.c
@@ -2280,6 +2280,9 @@ static int exclude_matches_pathspec(const char *path,=
 int pathlen,
 =09=09const struct pathspec_item *item =3D &pathspec->items[i];
 =09=09int len =3D item->nowildcard_len;
=20
+=09=09if (item->magic & PATHSPEC_EXCLUDE)
+=09=09=09continue;
+
 =09=09if (len =3D=3D pathlen &&
 =09=09    !ps_strncmp(item, item->match, path, pathlen))
 =09=09=09return 1;
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index 31eb233df5..76c53fbfde 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -47,6 +47,20 @@ do
 =09test_expect_success "complaints for ignored $i with unignored file outp=
ut" '
 =09=09test_grep -e "Use -f if" err
 =09'
+
+=09test_expect_success "no complaints for unignored file with ignored :!$i=
" '
+=09=09rm -f .git/index &&
+=09=09git add file ":!$i" &&
+=09=09git ls-files file "$i" >out &&
+=09=09test -s out
+=09'
+
+=09test_expect_success "complaints for ignored $i with ignored :!ign" '
+=09=09rm -f .git/index &&
+=09=09test_must_fail git add "$i" :!ign 2>err &&
+=09=09git ls-files "$i" ign >out &&
+=09=09test_must_be_empty out
+=09'
 done
=20
 for i in sub sub/*
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-unt=
racked.sh
index 7704709054..028ff3efc0 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -206,6 +206,29 @@ test_expect_success 'stash push --include-untracked wi=
th pathspec' '
 =09test_path_is_file foo
 '
=20
+test_expect_success 'stash push --include-untracked with :!pathspec' '
+=09>foo &&
+=09>bar &&
+=09git stash push --include-untracked -- :!bar &&
+=09test_path_is_file bar &&
+=09test_path_is_missing foo &&
+=09git stash pop &&
+=09test_path_is_file bar &&
+=09test_path_is_file foo
+'
+
+test_expect_success 'stash push --include-untracked with :!pathspec in .gi=
tignore' '
+=09echo ignored > .gitignore &&
+=09>foo &&
+=09>ignored &&
+=09git stash push --include-untracked -- :!ignored &&
+=09test_path_is_file ignored &&
+=09test_path_is_missing foo &&
+=09git stash pop &&
+=09test_path_is_file ignored &&
+=09test_path_is_file foo
+'
+
 test_expect_success 'stash push with $IFS character' '
 =09>"foo bar" &&
 =09>foo &&
--=20
2.51.2


