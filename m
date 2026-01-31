Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77236921C
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769888610; cv=none; b=Ml5A7rqDDhpwSybuDs5fo1SDhl6lySJd/gR0X09JUrAD9bXafA7NXBsDsCdFwUUF0JuNiiXmb+LhfaX38d8jvfEaNls8XMm5j5zSxxH5Ja/LSjsL9mGXPJVkkGoaqfwUTK98bsmPa2abON1Ai00trYhwbadqoDV4/Q6uPmWBo6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769888610; c=relaxed/simple;
	bh=fzBS7NO8Tj3v7wwtr8I8enkoQEFMT/XSWaFpr+k8dWM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cLuraHvCYFKeSnUGM4tD41XXS2yVMIzaD+SoFqcEg1HJm7pnMVBqN6cRa5CpX/nqV5RXMOjyEk0xmSbPmrGAHY+1VstWATbcIevoS5J+qwSDPdUzZ2T5/0kFSc6HTjovQo8Ho2x3OwUpgVM0GjEOTb4XmaiUGiHVutf2GWUHbs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=OdpOVuWQ; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="OdpOVuWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1769888606; x=1770147806;
	bh=fzBS7NO8Tj3v7wwtr8I8enkoQEFMT/XSWaFpr+k8dWM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OdpOVuWQo4tg9bIYg8JPem1Gk1KKIgUe+LrC+8pIhWe8kl7PJHRiHLynv2bRZ9VQj
	 8zcqI4dBzq+L9aKdpO8bvQSEmpccDFFPX9EEmc9Voec2/oKauF2ys61ytxloMEr0zD
	 CCqQ4TaqSij/4ZtXhCKN5bfMn+uFkDMyPW580xjvFdcUtYkKFRPQXiF8d+oeY7i1B9
	 1O2XZt0nGbmwPlHy0/d7/o6qHrA1VxCU1K+FhZ1texvla6VSH27AljAUKyEmtKJgUy
	 J+hJsRsE/excrhITbXXkOWnmrfSMeei/5g9piBMa575R9qaOolPpEgdMfHcuejFoqm
	 mSxQv0hWut1/Q==
Date: Sat, 31 Jan 2026 19:43:20 +0000
To: git@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: Bug: git add :!x . exits with error when x is in .gitignore
Message-ID: <20260131194309.601838-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: e419c90a630a7115758cd4fa7735a0d30e133378
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

`git add :!x .`, which is executed as part `git stash :!x`, seems to treat
pathspec with and without exclude magic the same, exiting with error when "=
x"
is in gitignore file. If file "x" isn't present, `git add x` still exits wi=
th
error as expected (although with a different one), but `git add :!x .` succ=
eeds.

Git-add manpage doesn't specify that exclude pathspecs are treated anyhow
differently from normal ones, so I'm not sure if it's really a bug. But it =
does
seem like one. I originally tried to exclude certain files from scripted st=
ashes
using pathspec, but had to switch to reusing core.excludesFile (which is
probably a better fit for my use case).


```sh
$ sh repro.sh
[...]
+ echo x >.gitignore
+ echo x >x
+ git add -- ':!x' .
Saved working directory and index state WIP on main: c8a842d Init
The following paths are ignored by one of your .gitignore files:
x
hint: Use -f if you really want to add them.
hint: Disable this message with "git config set advice.addIgnoredFile false=
"
+ echo exited with code 1
exited with code 1
```


```sh
# repro.sh
rm -rf repro; mkdir repro; cd repro
trap 'echo exited with code $?' EXIT
set -euo pipefail -o xtrace

git init
git commit -m Init --allow-empty

# If we comment out either of the following lines, git add/stash commands b=
elow succeed
echo x >.gitignore
echo x >x

# Git add . is executed as part of git stash, as can be seen using strace -=
ffeexecve
git add -- ":!x" . # fails
# git stash --include-untracked -- ":!x" # fails

echo ok
```

---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index b00821f2..0026bd65 100644
--- a/dir.c
+++ b/dir.c
@@ -2264,7 +2264,7 @@ static int exclude_matches_pathspec(const char *path,=
 int pathlen,
 {
 =09int i;
=20
-=09if (!pathspec || !pathspec->nr)
+=09if (!pathspec || !pathspec->nr || pathspec->magic & PATHSPEC_EXCLUDE)
 =09=09return 0;
=20
 =09GUARD_PATHSPEC(pathspec,
--=20
2.51.2


