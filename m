Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D15D415B8B
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790419734; cv=none; b=e9q0NBYV+7YtskiF1TOx/5tWEKp1jOHs9OUeLSJoOzMSzCKbTImOP4dnhoOI5nhmYVh0n1V5+FTKvnyD+aS74KbW4V6Nxofc6ChBMbA5+hMNKJmC81mmNwYiBe3fKsjQPWsiO8Y3xYtXMc+RsGrMSzXenQp8RFyVNDzaaDOgHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790419734; c=relaxed/simple;
	bh=ys3EweHuq5g7MsUggRgJHt+u7DefpQ82xdXjl7HtHl4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lVHXipJNECGS/y0NXSKiNU8qhndC5obqok1I0N/lQ0bYEMoysdXkpaDc/OuRd1nAsCPguNf/XKvbqZtdVSmyhzIzR+/kNFrek0PnFZJpO4z0ZC3NfZWllXtfP1WesN6awhd3oxwipADjZroMuS6B5PJZFO2Ghw7/23ZNTBZ/+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=GQd04dvf; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="GQd04dvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1790419710; x=1791024510; i=l.s.r@web.de;
	bh=cd5WHN7jEEGv9t8MUd074xbJETDT2Dq/BCy/OK5icig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GQd04dvfCXsdb2YR4DDLm5OfVHSMtpNEK7XpaZKwNzKR8AdP683JQ/6l8+Idt1IN
	 50voT9rgxDPD24SSDjg6ozFobKnkaqBw/YhW0NzNyh3KMzJl1IgwCGSKZ8KAAU4R8
	 DIu45/hsaGWcdysHFrADsLIp70fhdQ568MXLbQ5CxBnGMJ8doM6dbX94jZfbwqOTY
	 qzxFp+SvjX9vkX4n0v6hCDagUOsQZ+hv0CP8yagnFjlaBU4BWR5oCquGbFgVUOTOg
	 gTLGtu3J3oV+0zfpp0bqc2bVYUW9ZDrK+gHF+D+6nQrCoudqK5RWoDOkQD1vaivjC
	 EnnmZ4bH3NS08AxoSQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgRQD-1wWzC52ItL-00bW01; Sat, 26
 Sep 2026 12:48:30 +0200
Message-ID: <1c6ac703-a5a5-421b-bf0b-640bc1a0932f@web.de>
Date: Sat, 26 Sep 2026 12:48:29 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] dir: skip excluded directory with nested repo on prefix
 match
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: 81625@debbugs.gnu.org, Lester Longley <lester@ieee.org>,
 Sean Whitton <spwhitton@spwhitton.name>, Elijah Newren <newren@gmail.com>,
 =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <87ld94klhf.fsf@athena.silentflame.com>
 <be53c379-b0e1-4242-8504-e96c2c49d294@web.de>
Content-Language: en-US
In-Reply-To: <be53c379-b0e1-4242-8504-e96c2c49d294@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3LetSR4YmRcwSbsnzsiTUx+zmrzkb52zCfmkyVfNxE8oxJKKa5m
 hyFQPr523dIqQPm5bZsgpZM9i+eJFPHPikvupmaBUVKQ4ix7NT+CUoQNpNw6TfHD2Oe/Ams
 eSCqIT6Ty+0mpDc2BAlGi9V8YJqrdFXYJzsWrjJjHQ3ErcJ4CgyiwQ57CDFg85ia6uVvJZ6
 +8d82EbpJ5vQwK3IK0bkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:86RaWGiyjjQ=;+afoh6+YBeKAGSMWM0brQm7yGX5
 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
 1ktG

95c11ecc73 (Fix error-prone fill_directory() API; make it only return
matches, 2020-04-01) optimized away pathspec matching too eagerly and
cada7308ad (dir: check pathspecs before returning `path_excluded`,
2020-07-20) fixed that for files and symlinks.

A corner case remained unaddressed: Ignored directories that contain a
nested repository.  Make sure to run match_pathspec_with_flags() for it
if necessary.

Add a status test to check whether the pathspec is applied correctly as
well as a checkout test to exercise the changed code without a pathspec.

Reported-by: Sean Whitton <spwhitton@spwhitton.name>
Reported-by: Lester Longley <lester@ieee.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 dir.c                         | 27 ++++++++++++++++++++-------
 t/t2021-checkout-overwrite.sh |  7 +++++++
 t/t7061-wtstatus-ignore.sh    |  5 +++++
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index d896e7be4b..ac246ced1d 100644
=2D-- a/dir.c
+++ b/dir.c
@@ -1935,6 +1935,16 @@ static enum exist_status directory_exists_in_index(=
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
@@ -2001,11 +2011,7 @@ static enum path_treatment treat_directory(struct d=
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
@@ -2039,8 +2045,15 @@ static enum path_treatment treat_directory(struct d=
ir_struct *dir,
 		strbuf_release(&sb);
=20
 		if (nested_repo) {
-			if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
-				(matches_how =3D=3D MATCHED_RECURSIVELY_LEADING_PATHSPEC))
+			if (dir->flags & DIR_SKIP_NESTED_GIT)
+				return path_none;
+			if (pathspec && !matches_how) {
+				matches_how =3D dir_match(istate, pathspec,
+							dirname, len);
+				if (!matches_how)
+					return path_none;
+			}
+			if (matches_how =3D=3D MATCHED_RECURSIVELY_LEADING_PATHSPEC)
 				return path_none;
 			return excluded ? path_excluded : path_untracked;
 		}
diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
index 38c41ae373..2b7fff5159 100755
=2D-- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -79,4 +79,11 @@ test_expect_success 'checkout --overwrite-ignore should=
 succeed if only ignored
 	test_path_is_file some_dir
 '
=20
+test_expect_success 'checkout must not overwrite untracked nested repo' '
+	git checkout -f start &&
+	rm -rf some_dir &&
+	git init some_dir &&
+	test_must_fail git checkout df_conflict
+'
+
 test_done
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

Interdiff against v1:
  diff --git a/dir.c b/dir.c
  index aa457f0f4e..ac246ced1d 100644
  --- a/dir.c
  +++ b/dir.c
  @@ -2047,11 +2047,13 @@ static enum path_treatment treat_directory(struc=
t dir_struct *dir,
   		if (nested_repo) {
   			if (dir->flags & DIR_SKIP_NESTED_GIT)
   				return path_none;
  -			if (!matches_how)
  +			if (pathspec && !matches_how) {
   				matches_how =3D dir_match(istate, pathspec,
   							dirname, len);
  -			if (!matches_how ||
  -			    matches_how =3D=3D MATCHED_RECURSIVELY_LEADING_PATHSPEC)
  +				if (!matches_how)
  +					return path_none;
  +			}
  +			if (matches_how =3D=3D MATCHED_RECURSIVELY_LEADING_PATHSPEC)
   				return path_none;
   			return excluded ? path_excluded : path_untracked;
   		}
  diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.=
sh
  index 38c41ae373..2b7fff5159 100755
  --- a/t/t2021-checkout-overwrite.sh
  +++ b/t/t2021-checkout-overwrite.sh
  @@ -79,4 +79,11 @@ test_expect_success 'checkout --overwrite-ignore shou=
ld succeed if only ignored
   	test_path_is_file some_dir
   '
  =20
  +test_expect_success 'checkout must not overwrite untracked nested repo'=
 '
  +	git checkout -f start &&
  +	rm -rf some_dir &&
  +	git init some_dir &&
  +	test_must_fail git checkout df_conflict
  +'
  +
   test_done
=2D-=20
2.55.0
