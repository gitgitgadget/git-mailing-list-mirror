Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69491AA3C6
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365046; cv=none; b=MMxabph8luTEu7UYIsbVtA173FJ99pfITQQ155YM83ZBLmCxXv8OSQy+NLixEMh/ltsc+7BnUCOJsEpSrJbhVCJTUfQCd4gUb5RAiGMWwjxdqKnnjLCsWnq9KZrkFdeCElJoSpRsHAYtuNEqwT5lI4G2N3NDoakcwU7ssDQgvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365046; c=relaxed/simple;
	bh=KR8xCZOjFnGpXrL8YrhMGJaiRqadfzkJUUqYck7jwn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICCoCc2XLsBNOQBsG4tNIuBDd3Hlb37ZNSJIpRlfYGyQQcIvw+ytCGMkXQyt0g3+z/VdhGiT57Sxy0YlY3TwOmBJX7OtpyAggOM2Cq6w+XeMzXY3p46xpEvyc/JYYBFSm4rKu2wCQiE6vpzHPBmyO9T5xWBKAOxXVX3FFBVs0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gnDRo2Ya; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gnDRo2Ya"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FE221ACBE;
	Tue, 30 Jul 2024 14:43:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=KR8xCZOjFnGpXrL8YrhMGJaiR
	qadfzkJUUqYck7jwn0=; b=gnDRo2Yao91N2Qf7j7W3NaTg3Z+IQHzZB+AacUMXx
	ggq9cKr6vWVhrmYvovve8ThNFIX6WX9QO0GYR+3cXUDIH3ymYrE16qN2EIStQabI
	5RZC66wE9WkUvneiG9uGtqk7LY+nn/ifhytSB3SYzCi02Yjaf9Bc2/16weCMsMEc
	fw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 278721ACBD;
	Tue, 30 Jul 2024 14:43:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A92C81ACBC;
	Tue, 30 Jul 2024 14:43:54 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 0/4] safe.directory clean-up
Date: Tue, 30 Jul 2024 11:43:48 -0700
Message-ID: <20240730184352.2503276-1-gitster@pobox.com>
X-Mailer: git-send-email 2.46.0-77-g633c50689c
In-Reply-To: <20240730011004.4030246-1-gitster@pobox.com>
References: <20240730011004.4030246-1-gitster@pobox.com> <20240723021900.388020-1-gitster@pobox.com> <20240720220915.2933266-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 AC2E254A-4EA3-11EF-A816-9625FCCAB05B-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

    Changes since v3:

     - A preliminary patch to fix overly defensive (mis)uses of the
       result from git_config_pathname() API call has been added.

     - "to_free" variable that did not have the corresponding underlying
       variable that may or may not be allocated has been renamed.

Recently we discussed what we should do when either the path
configured in the safe.directory configuration variable or coming
from the caller of ensure_valid_ownership() function as a result of
repository discovery is not normalized and textual equality check is
not sufficient.  See the thread the contains

  https://lore.kernel.org/git/6d5b75a6-639d-429b-bd37-232fc6f475af@gmail.=
com/

Here are three patches that implement the comparison between
normalized path and configuration value.

Imagine that you have a repository at /mnt/disk4/repos/frotz
directory but in order to make it simpler to manage and use, you
have your users use /projects/frotz to access the repository.  A
symlink /projects/frotz pointing at /mnt/disk4/repos/frotz directory
allows you to do so.

 - The first patch normalizes the path to the directory that we
   suspect is a usable repository, before comparing it with the
   safe.directory configuration variable.  The safe.directory may
   say /mnt/disk4/repos/frotz or /mnt/disk4/repos/*, but the path to
   the repository for the users may be /mnt/disk4/repos/frotz or
   /projects/frotz, depending on where they come from and what their
   $PWD makes getcwd() to say.

 - The second patch normalizes the value of the safe.directory
   variable.  This allows safe.directory to say /projects/frotz or
   /projects/* and have them match /mnt/disk4/repos/frotz (which is
   how the first patch normalizes the repository path to).  Note
   that non-absolute paths in safe.directory are ignored, as they
   make little sense, except for ".".

 - The third patch only adds a test to illustrate what happens when
   the safe.directory configuration is set to ".", which was
   advertised as a viable workaround for those who run "git daemon".

Junio C Hamano (4):
  safe.directory: preliminary clean-up
  safe.directory: normalize the checked path
  safe.directory: normalize the configured path
  safe.directory: setting safe.directory=3D"." allows the "current" direc=
tory

 setup.c                   |  58 ++++++++++---
 t/t0033-safe-directory.sh | 178 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 225 insertions(+), 11 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  baed16ada3 safe.directory: preliminary clean-up
1:  7da381eef6 =3D 2:  2ac2407c22 safe.directory: normalize the checked p=
ath
2:  1e872df885 ! 3:  747120dcd7 safe.directory: normalize the configured =
path
    @@ Commit message
    =20
      ## setup.c ##
     @@ setup.c: static int safe_directory_cb(const char *key, const char=
 *value,
    + 		char *allowed =3D NULL;
     =20
      		if (!git_config_pathname(&allowed, key, value)) {
    - 			const char *check =3D allowed ? allowed : value;
    --			if (ends_with(check, "/*")) {
    --				size_t len =3D strlen(check);
    --				if (!fspathncmp(check, data->path, len - 1))
    -+			char *to_free =3D NULL;
    +-			if (ends_with(allowed, "/*")) {
    +-				size_t len =3D strlen(allowed);
    +-				if (!fspathncmp(allowed, data->path, len - 1))
    ++			char *normalized =3D NULL;
     +
     +			/*
     +			 * Setting safe.directory to a non-absolute path
    @@ setup.c: static int safe_directory_cb(const char *key, const char =
*value,
     +			 * level of a repository, then it is OK", which is
     +			 * slightly tighter than "*" that allows discovery.
     +			 */
    -+			if (!is_absolute_path(check) && strcmp(check, ".")) {
    ++			if (!is_absolute_path(allowed) && strcmp(allowed, ".")) {
     +				warning(_("safe.directory '%s' not absolute"),
    -+					check);
    ++					allowed);
     +				goto next;
     +			}
     +
    @@ setup.c: static int safe_directory_cb(const char *key, const char =
*value,
     +			 * worthy event when there is no such path on this
     +			 * machine---the entry may be useful elsewhere.
     +			 */
    -+			to_free =3D real_pathdup(check, 0);
    -+			if (!to_free)
    ++			normalized =3D real_pathdup(allowed, 0);
    ++			if (!normalized)
     +				goto next;
    -+			if (ends_with(to_free, "/*")) {
    -+				size_t len =3D strlen(to_free);
    -+				if (!fspathncmp(to_free, data->path, len - 1))
    ++
    ++			if (ends_with(normalized, "/*")) {
    ++				size_t len =3D strlen(normalized);
    ++				if (!fspathncmp(normalized, data->path, len - 1))
      					data->is_safe =3D 1;
    --			} else if (!fspathcmp(data->path, check)) {
    -+			} else if (!fspathcmp(data->path, to_free)) {
    +-			} else if (!fspathcmp(data->path, allowed)) {
    ++			} else if (!fspathcmp(data->path, normalized)) {
      				data->is_safe =3D 1;
      			}
    -+			free(to_free);
    - 		}
    -+	next:
    - 		if (allowed !=3D value)
    ++		next:
    ++			free(normalized);
      			free(allowed);
    + 		}
      	}
    =20
      ## t/t0033-safe-directory.sh ##
3:  53605f4e20 =3D 4:  5d0cd13e34 safe.directory: setting safe.directory=3D=
"." allows the "current" directory
--=20
2.46.0-77-g633c50689c

