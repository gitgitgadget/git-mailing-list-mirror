Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D91361DAE
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429773; cv=none; b=llwyrh8ydTzWDEAeZsr4hvTw1zFOOYmFDRnkVDpgoIYIOHOjLipsacyDormKnBeVUz9HLujv+7sSHg0HX+zvztg7FVESp8ZFgXPHDyJZQ5yQfttM9ZNGvgFy5jzXW3t3GowIRpFAk0Vhwj2CpZWsNAwXUIu+ZYc6UPFJDVTs8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429773; c=relaxed/simple;
	bh=lyD3pm19LsB75ieBNxUuPrpxotAAwWT86VSw1lt9U64=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ILe3s86XsqdqC+ar569QsetAOAMV6JSfj6TngnfsBx48zdLoxBIJcsz9+xhMbR9p/K/I2SdIvUO7sveY9b1DJF4A/W6WZc22kpjKn70+iV2TywGTV9swi3eS1BZmCZxCPJO9tlKu5qELcePLYv9xt+s9Qvv1xE3PDdXV+Je1tK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=gHCpZ4vy; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="gHCpZ4vy"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hbFX16YmjzMlFX;
	Thu, 03 Sep 2026 12:02:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788429761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7mi5Szwb0Dv3RMHjywbSHxDctUd3lPFMhoKi1+a66I=;
	b=gHCpZ4vyqf6PE4njIPWBlVScgN9yc+sogwB1XwZCwUKJVe90MVJ3Lx7sDW/qHMLf5iqmz5
	gejuC8W7RftIDg8xuIJw8y33XBQsU2sh/JNcVzkRKdck04NCs9jtEiav/c3ZF5PDPbk3d/
	zMcQ+x40F5ZOpm+v1qkFYwTrz3FFzQWLf0uQVaDFyYjuTN/wWZP6jVehhVMVVQp3rsDtd7
	3RL6sWAlerUSpVwAw6YEJdOwJMGqm/Io436q8KiBiAYlnjL12jpYI3zMJkGlc+3Snc8e/Q
	BwSUX9vTJyd5bsTxsoajT2mYLhe6gYA/W50gAzM21m7ATLVjnt+ImSG8h7Cc1Q==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v2 0/2] dir: fix pathspec prefixes with exclusions
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
Date: Thu, 3 Sep 2026 12:02:30 +0200
Cc: Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g>
 <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
To: git@vger.kernel.org

Pathspec prefix optimization must account for exclude items separately.
The prefix is derived from non-exclude items, so applying it while =
matching
an exclude item can compare the wrong portions of the paths. Conversely, =
an
exclude item at the start of the pathspec currently prevents finding a =
common
prefix among the remaining items.

The first patch matches exclude items against the full pathname. The =
second
patch finds the common prefix starting with the first non-exclude item =
and
returns both the prefix length and the string from which it was derived.

Changes since v1:

* Send the changes as a two-patch series in dependency order.
* Return the matched prefix through an output parameter instead of =
returning
  a structure by value.
* Use "non-exclude pathspec item" terminology and consistent variable =
names.

Yannik Tausch (2):
  dir: do not apply prefix to negative pathspecs
  dir: find common prefix among non-exclude pathspec items

 dir.c                       | 39 +++++++++++++++++++++----------------
 t/t6132-pathspec-exclude.sh |  9 +++++++++
 t/unit-tests/u-dir.c        | 28 ++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 17 deletions(-)

Range-diff against v1:
1:  c8a2f1e22e =3D 1:  c8a2f1e22e dir: do not apply prefix to negative =
pathspecs
2:  5a179872c1 ! 2:  d0e08fdb96 dir: find common prefix among positive =
pathspecs
    @@ Metadata
     Author: Yannik Tausch <dev@ytausch.de>
    =20
      ## Commit message ##
    -    dir: find common prefix among positive pathspecs
    +    dir: find common prefix among non-exclude pathspec items
    =20
         common_prefix_len() skips exclude pathspec items, but uses n =3D=3D=
 0 to
         identify the initial item and items[0] as the comparison =
source. When
         an exclude item comes first, the function returns zero even =
when all
    -    positive pathspecs share a directory.
    +    remaining items share a directory.
    =20
    -    Track the first positive item explicitly. Return its match and =
the
    -    common prefix length together so that common_prefix() and
    -    fill_directory() use the correct string. Add a unit test with =
an
    -    unrelated exclude before two positive pathspecs that share a =
directory.
    +    Track the first non-exclude item explicitly. Return its match =
through
    +    an output parameter so that common_prefix() and =
fill_directory() use
    +    the correct string. Add a unit test with an unrelated exclude =
item
    +    before two non-exclude items that share a directory.
    =20
         Signed-off-by: Yannik Tausch <dev@ytausch.de>
    =20
    @@ dir.c: static int fnmatch_icase_mem(const char *pattern, int =
patternlen,
      }
     =20
     -static size_t common_prefix_len(const struct pathspec *pathspec)
    -+struct pathspec_prefix {
    -+	const char *match;
    -+	size_t len;
    -+};
    -+
    -+/*
    -+ * Find the common prefix of positive pathspec items. The returned =
match
    -+ * points into the first positive item and is not NUL-terminated =
at len.
    -+ */
    -+static struct pathspec_prefix find_common_prefix(const struct =
pathspec *pathspec)
    ++static size_t common_prefix_len(const struct pathspec *pathspec,
    ++				const char **matched_prefix)
      {
     -	int n;
    -+	struct pathspec_prefix prefix =3D { 0 };
     +	int n, first =3D -1;
      	size_t max =3D 0;
     =20
    @@ dir.c: static size_t common_prefix_len(const struct pathspec =
*pathspec)
      				break;
      		}
      	}
    --	return max;
    -+	prefix.match =3D first < 0 ? NULL : =
pathspec->items[first].match;
    -+	prefix.len =3D max;
    -+	return prefix;
    ++	*matched_prefix =3D first < 0 ? NULL : =
pathspec->items[first].match;
    + 	return max;
      }
     =20
      /*
     - * Returns a copy of the longest leading path common among all
    -+ * Returns a copy of the longest leading path common among all =
positive
    -  * pathspecs.
    +- * pathspecs.
    ++ * Returns a copy of the longest leading path common among all =
pathspec
    ++ * items that are not excluded.
       */
      char *common_prefix(const struct pathspec *pathspec)
      {
     -	unsigned long len =3D common_prefix_len(pathspec);
    -+	struct pathspec_prefix prefix =3D find_common_prefix(pathspec);
    ++	const char *matched_prefix;
    ++	size_t len =3D common_prefix_len(pathspec, &matched_prefix);
     =20
     -	return len ? xmemdupz(pathspec->items[0].match, len) : NULL;
    -+	return prefix.len ? xmemdupz(prefix.match, prefix.len) : NULL;
    ++	return len ? xmemdupz(matched_prefix, len) : NULL;
      }
     =20
      int fill_directory(struct dir_struct *dir,
    @@ dir.c: static size_t common_prefix_len(const struct pathspec =
*pathspec)
      		   const struct pathspec *pathspec)
      {
     -	const char *prefix;
    --	size_t prefix_len;
    -+	struct pathspec_prefix prefix;
    ++	const char *matched_prefix;
    + 	size_t prefix_len;
     =20
      	unsigned exclusive_flags =3D DIR_SHOW_IGNORED | =
DIR_SHOW_IGNORED_TOO;
    - 	if ((dir->flags & exclusive_flags) =3D=3D exclusive_flags)
     @@ dir.c: int fill_directory(struct dir_struct *dir,
      	 * Calculate common prefix for the pathspec, and
      	 * use that to optimize the directory walk
      	 */
     -	prefix_len =3D common_prefix_len(pathspec);
     -	prefix =3D prefix_len ? pathspec->items[0].match : "";
    -+	prefix =3D find_common_prefix(pathspec);
    ++	prefix_len =3D common_prefix_len(pathspec, &matched_prefix);
     =20
      	/* Read the directory and prune it */
     -	read_directory(dir, istate, prefix, prefix_len, pathspec);
    -+	read_directory(dir, istate, prefix.len ? prefix.match : "",
    -+		       prefix.len, pathspec);
    ++	read_directory(dir, istate, prefix_len ? matched_prefix : "",
    ++		       prefix_len, pathspec);
     =20
    --	return prefix_len;
    -+	return prefix.len;
    + 	return prefix_len;
      }
    -=20
    - int within_depth(const char *name, int namelen,
     @@ dir.c: static int match_pathspec_item(struct index_state =
*istate,
     =20
      	/*
      	 * The normal call pattern is:
     -	 * 1. prefix =3D common_prefix_len(ps);
    -+	 * 1. prefix =3D find_common_prefix(ps).len;
    ++	 * 1. prefix =3D common_prefix_len(ps, &matched_prefix);
      	 * 2. prune something, or fill_directory
      	 * 3. match_pathspec()
      	 *
     @@ dir.c: static int match_pathspec_item(struct index_state =
*istate,
    - 	 * prefix part when :(icase) is involved. We do exact
    - 	 * comparison ourselves.
    - 	 *
    --	 * Normally the caller (common_prefix_len() in fact) does
    -+	 * Normally the caller (find_common_prefix() in fact) does
    + 	 * Normally the caller (common_prefix_len() in fact) does
      	 * _exact_ matching on name[-prefix+1..-1] and we do not need
      	 * to check that part. Be defensive and check it anyway, in
     -	 * case common_prefix_len is changed, or a new caller is
     -	 * introduced that does not use common_prefix_len.
    -+	 * case find_common_prefix() is changed, or a new caller is
    -+	 * introduced that does not use find_common_prefix().
    ++	 * case common_prefix_len() is changed, or a new caller is
    ++	 * introduced that does not use common_prefix_len().
      	 *
      	 * If the penalty turns out too high when prefix is really
      	 * long, maybe change it to
    @@ t/unit-tests/u-dir.c: void test_dir__within_depth(void)
     =20
      }
     +
    -+void test_dir__common_prefix_skips_excluded_pathspecs(void)
    ++void test_dir__common_prefix_skips_excluded_pathspec_items(void)
     +{
     +	struct pathspec_item items[] =3D {
     +		{
--=20
2.55.0

