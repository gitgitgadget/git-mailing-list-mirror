Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2424E06E7
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729472; cv=none; b=lNvx1fvCz3rPwfv9LNoh3ZkNCHLIDqyXrcRRR2AxMTjK5H4679TV3hogwmfswDBhSaECSitRMZ7+4LzrggFjETcO+5oqUrztHviRvKEk6hkL9O3uJXyab2esUWY2ctpYww/GcpOW3ISpHRrf0XH52LPQqmzOb5Y/hUkkUg4SQoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729472; c=relaxed/simple;
	bh=IJgib8gp9JPx1+Q0pJ3+s+RUN6vx47LHoXnsGHgQfYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCv8gMMUIymoIDQyxqlumd8xt6ihs3ueLyJ+UfkeOdE0YAcynhojlYfgLcRVuz6GOl3vlh84hpz8zX5lWkEgNvTXpUaaa2/hUZ0AmJxt7p443jvOPiFsrbu4N0XHvp24HJxgNjOLb7ICmI4VgCuOj8PNCvax31lh4Dyi60s+3wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=eZFKCWg2; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="eZFKCWg2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1789729447; x=1790334247; i=l.s.r@web.de;
	bh=r/w8SUApG1Srh46l5uj2qbbU2El/cN2dQ9E++NeSvMY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eZFKCWg2PRF8QDzTgnyhpVfBIal3XQZdidqPEl1y1Tnchs3D5I7Z6yceFFbf0WtA
	 otJvmmVtOfY1rSIOxYY6Rvt3kLNmJfwX5/1AFyfP5QM+Iu0MArz5QItxTmc161KnN
	 z1RP2ot7qtJ0nvG0UCcjvv1DTIZ+R/b+Uyc9rWyl/uniGz8it7Gy2UUEFkeXXHgyA
	 4n1pbCnp2ioEH2fkAK2PLDlaNesprz4UcN2CH0Z+GkJs+9d13+J7aI27hG7dnMP0A
	 i0OBBJrTZQ8NZXFmfbXQJrNufDfkcYlzJH4NZ6s17UqkHSHcERyiC/AHaVgxSDK9w
	 n1BGUCgt19AwY619Vw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBB86-1ww03V31DS-000qbK; Fri, 18
 Sep 2026 13:04:07 +0200
Message-ID: <be53c379-b0e1-4242-8504-e96c2c49d294@web.de>
Date: Fri, 18 Sep 2026 13:04:06 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] dir: skip excluded directory with nested repo on prefix match
To: git@vger.kernel.org
Cc: 81625@debbugs.gnu.org, Lester Longley <lester@ieee.org>,
 Sean Whitton <spwhitton@spwhitton.name>, Elijah Newren <newren@gmail.com>,
 =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <87ld94klhf.fsf@athena.silentflame.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <87ld94klhf.fsf@athena.silentflame.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JcwQmr2r/7mUvd+ibG038jn9+dtRAYcd6Khkdwhy6Are8Vb4U7k
 OzdDIpMLbZzKlamE0UoKwyiNd47/73fkvPd4BU8D+kusPpcBBxEHOWWlEJnyAt7d3uTz7Xp
 3r5WHz/uPhthnz2Ujoi2jA3ryU6EM6v63zBWkAncuZm+VSWzuR0ZphSPyD34vyE61lV/HYo
 y9HOqP6HQQcrLgW41i0hA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DKts2+EnuD0=;ucEeqB/Xy7THfFXdr2117UPvkwM
 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
 4=

95c11ecc73 (Fix error-prone fill_directory() API; make it only return
matches, 2020-04-01) optimized away pathspec matching too eagerly and
cada7308ad (dir: check pathspecs before returning `path_excluded`,
2020-07-20) fixed that for files and symlinks.

A corner case remained unaddressed: Ignored directories that contain a
nested repository.  Make sure to run match_pathspec_with_flags() for it
if necessary.

Reported-by: Sean Whitton <spwhitton@spwhitton.name>
Reported-by: Lester Longley <lester@ieee.org>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 dir.c                      | 25 ++++++++++++++++++-------
 t/t7061-wtstatus-ignore.sh |  5 +++++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index 95d8a1cce9..0557a59d5e 100644
=2D-- a/dir.c
+++ b/dir.c
@@ -1930,6 +1930,16 @@ static enum exist_status directory_exists_in_index(=
struct index_state *istate,
 	return index_nonexistent;
 }
=20
+static int dir_match(struct index_state *istate,
+		     const struct pathspec *pathspec,
+		     const char *dirname, int len)
+{
+	return match_pathspec_with_flags(istate, pathspec, dirname, len,
+					 0 /* prefix */,
+					 NULL /* seen */,
+					 DO_MATCH_LEADING_PATHSPEC);
+}
+
 /*
  * When we find a directory when traversing the filesystem, we
  * have three distinct cases:
@@ -1996,11 +2006,7 @@ static enum path_treatment treat_directory(struct d=
ir_struct *dir,
 	 * for matching patterns.
 	 */
 	if (pathspec && !excluded) {
-		matches_how =3D match_pathspec_with_flags(istate, pathspec,
-							dirname, len,
-							0 /* prefix */,
-							NULL /* seen */,
-							DO_MATCH_LEADING_PATHSPEC);
+		matches_how =3D dir_match(istate, pathspec, dirname, len);
 		if (!matches_how)
 			return path_none;
 	}
@@ -2034,8 +2040,13 @@ static enum path_treatment treat_directory(struct d=
ir_struct *dir,
 		strbuf_release(&sb);
=20
 		if (nested_repo) {
-			if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
-				(matches_how =3D=3D MATCHED_RECURSIVELY_LEADING_PATHSPEC))
+			if (dir->flags & DIR_SKIP_NESTED_GIT)
+				return path_none;
+			if (!matches_how)
+				matches_how =3D dir_match(istate, pathspec,
+							dirname, len);
+			if (!matches_how ||
+			    matches_how =3D=3D MATCHED_RECURSIVELY_LEADING_PATHSPEC)
 				return path_none;
 			return excluded ? path_excluded : path_untracked;
 		}
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 14ddaba2f3..182933471f 100755
=2D-- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -340,4 +340,9 @@ test_expect_success 'status ignores submodule in exclu=
ded directory' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'status omits excluded directory with submodule on pr=
efix match' '
+	git status --porcelain --ignored -u tracke >actual &&
+	test_must_be_empty actual
+'
+
 test_done
=2D-=20
2.55.0
