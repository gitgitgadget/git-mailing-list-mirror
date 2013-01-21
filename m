From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] Update :/abc ambiguity check
Date: Mon, 21 Jan 2013 20:00:48 +0700
Message-ID: <1358773249-24384-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 14:00:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxGzZ-0004H4-Og
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 14:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab3AUNA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 08:00:29 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:41890 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab3AUNA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 08:00:28 -0500
Received: by mail-da0-f49.google.com with SMTP id v40so2695456dad.8
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 05:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=lLgmNJZ5e2E0at6r7hi6L4UKdr9VEr+Q/QkoBizauiA=;
        b=V/sVOhdZP19c4QFpjtUZ4l3r9F4qEQKgTsypoYsVPboS9x5nQ77YDaj7rcjDg4YNLR
         Z5ikwMbeW4HQFeWM1zoj3OwftwA1QlRIQXNMf9NNJGGlPzX0b8uTCMVvq3HzJjsO+Q5l
         4oaE+jCQtRjsBuN3GqM/HTwzj58KlZWG2srUO64RECBJn0QqGzeI/sm8EW2TR9d6UAu2
         jndLt8kZlPZiM+bYlWCZslNBxRP65z9Q9vJlhtOMMN8dwSAjzKxwFAqrfXZx5Iune6I3
         FRae4Gb+hHTocyR+2H6pwAdzZbovid3/NQKMNskFZRGPoQ5EEcghN7Mex8M2FFwGPBiB
         xxow==
X-Received: by 10.68.130.226 with SMTP id oh2mr48169183pbb.157.1358773227914;
        Mon, 21 Jan 2013 05:00:27 -0800 (PST)
Received: from lanh ([115.74.55.178])
        by mx.google.com with ESMTPS id ou3sm8667971pbb.46.2013.01.21.05.00.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 05:00:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 21 Jan 2013 20:00:51 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214115>

:/abc may mean two things:

- as a revision, it means the revision that has "abc" in commit
  message.

- as a pathpec, it means "abc" from root.

Currently we see ":/abc" as a rev (most of the time), but never see it
as a pathspec even if "abc" exists and "git log :/abc" will gladly
take ":/abc" as rev even it's ambiguous. This patch makes it:

- ambiguous when "abc" exists on worktree
- a rev if abc does not exist on worktree
- a path if abc is not found in any commits (although better use
  "--" to avoid ambiguation because searching through commit DAG is
  expensive)

A plus from this patch is, because ":/" never matches anything as a
rev, it is never considered a valid rev and because root directory
always exists, ":/" is always unambiguously seen as a pathspec.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This makes "git grep foo :/" work. For such an often used command,
 the less I type the better.

 The ".. is expensive" thing is not cool. But it hopefully does not
 happen often. I expect people rely on shell's tab completion more
 than :/typing-path-to-somewhere-manually. Copy/paste happens more
 often. I usually type ":" then copy a path from diff --git line.

 We should probably kill ":/abc as a rev" and replace it with @{/abc}
 or something less ambiguous.

 setup.c                       |  9 ++++++++-
 t/t4208-log-magic-pathspec.sh | 17 +++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index f108c4b..47acc11 100644
--- a/setup.c
+++ b/setup.c
@@ -66,7 +66,14 @@ int check_filename(const char *prefix, const char *a=
rg)
 	const char *name;
 	struct stat st;
=20
-	name =3D prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
+	if (!prefixcmp(arg, ":/")) {
+		if (arg[2] =3D=3D '\0') /* ":/" is root dir, always exists */
+			return 1;
+		name =3D arg + 2;
+	} else if (prefix)
+		name =3D prefix_filename(prefix, strlen(prefix), arg);
+	else
+		name =3D arg;
 	if (!lstat(name, &st))
 		return 1; /* file exists */
 	if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR)
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec=
=2Esh
index 2c482b6..72300b5 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -11,11 +11,24 @@ test_expect_success 'setup' '
 	mkdir sub
 '
=20
-test_expect_success '"git log :/" should be ambiguous' '
-	test_must_fail git log :/ 2>error &&
+test_expect_success '"git log :/" should not be ambiguous' '
+	git log :/
+'
+
+test_expect_success '"git log :/a" should be ambiguous (applied both r=
ev and worktree)' '
+	: >a &&
+	test_must_fail git log :/a 2>error &&
 	grep ambiguous error
 '
=20
+test_expect_success '"git log :/a -- " should not be ambiguous' '
+	git log :/a --
+'
+
+test_expect_success '"git log -- :/a" should not be ambiguous' '
+	git log -- :/a
+'
+
 test_expect_success '"git log :" should be ambiguous' '
 	test_must_fail git log : 2>error &&
 	grep ambiguous error
--=20
1.8.0.rc2.23.g1fb49df
