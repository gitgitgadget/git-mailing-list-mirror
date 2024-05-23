Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B6AA29
	for <git@vger.kernel.org>; Thu, 23 May 2024 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716425819; cv=none; b=nc2sVgxD8EhYP/XU91SIdqqfgUAd98yL820s64yo4qRjLlJYhMW/QJ/wv2NKdW/xiuVlC9M16QTVuFkkk+3eg66pDJiMF9F4FAMp0fpdsC3KiPz/qbm+4BzceCejmT3fvET0fKPZKA2qWOPwQBhC2Sq0jhIVrOljKyuJ5g8aSlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716425819; c=relaxed/simple;
	bh=6Xdqq8fyOKQGc67XwmwlJqMNfzFfVdYbtSrvETdyxAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=US860f4JelCfsE6skNQq/lrwujj7pa7ttxkx+Ru2h7q+AJei6/FDSBWHko7EIg5T2dialKcMvMgyZUNgV9pwCyKBLFJY+ZCD6ippf7bM0HW1bTRc47++M1v1lT64JI/ysW2M/H1ef3pHB2Vi6ZXPvfzTcULpRCGzQtcT5CzsM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sBcESI46; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sBcESI46"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AF38018150;
	Wed, 22 May 2024 20:56:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6Xdqq8fyOKQGc67XwmwlJqMNfzFfVdYbtSrvET
	dyxAI=; b=sBcESI46ybtB4wmuGHrWOFpt7UXoCVSdPpSGTbNo3d9/+9lZIBclfF
	KESjfEO/f0L+gi6ImFoEb6lsVBEPAiA2Pm5Z5hhkYodi8qWGi8tUuRN0RtoEBvBl
	ZS3L9IDfJBDABB8s9QlKLaNUm0jykcN16ttBh1tZQ7PPOuC7/vAnw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A6F941814F;
	Wed, 22 May 2024 20:56:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B201E1814D;
	Wed, 22 May 2024 20:56:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Heghedus Razvan <heghedus.razvan@protonmail.com>
Subject: [rPATCH v2] setup: fix bug with "includeIf.onbranch" when
 initializing dir
In-Reply-To: <xmqqwmnlz7bf.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Wed, 22 May 2024 17:43:32 -0700")
References: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com>
	<cf182bb9ee7d4a7eb46e5dbf4f3ef5deb198d823.1716374321.git.ps@pks.im>
	<xmqqwmnlz7bf.fsf_-_@gitster.g>
Date: Wed, 22 May 2024 17:56:53 -0700
Message-ID: <xmqqjzjlz6p6.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 593737D0-189F-11EF-8CDB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

And this is "git show --remerge-diff" output for the merge that
merges the result of applying the previous patch to v2.44.0 into
v2.45.0-rc0~112 (which removed the 'prev_bare_repository' thing).

The resolution of conflicts in setup.c is trivial.  The change to
t/t0001-init.sh is an evil one.

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 319ed81631..49e9bf77c6 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -584,7 +584,7 @@ test_expect_success 'init with --ref-format=files' '
 	test_cmp expect actual
 '
 
-backends="files"
+backends="files reftable"
 for from_format in $backends
 do
 	test_expect_success "re-init with same format ($from_format)" '
diff --git a/setup.c b/setup.c
remerge CONFLICT (content): Merge conflict in setup.c
index 2f23ab6efa..e01462863b 100644
--- a/setup.c
+++ b/setup.c
@@ -2175,23 +2175,6 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	}
 	startup_info->have_repository = 1;
 
-<<<<<<< 272fd9125a (Merge branch 'gt/core-bare-in-templates')
-	/* Ensure `core.hidedotfiles` is processed */
-	git_config(platform_core_config, NULL);
-
-	safe_create_dir(git_dir, 0);
-
-
-||||||| 3c2a3fdc38
-	/* Ensure `core.hidedotfiles` is processed */
-	git_config(platform_core_config, NULL);
-
-	safe_create_dir(git_dir, 0);
-
-	prev_bare_repository = is_bare_repository();
-
-=======
->>>>>>> 7a998665dd (setup: fix bug with "includeIf.onbranch" when initializing dir)
 	/* Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
 	 * config file, so this will not fail.  What we are catching
@@ -2202,17 +2185,6 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	validate_hash_algorithm(&repo_fmt, hash);
 	validate_ref_storage_format(&repo_fmt, ref_storage_format);
 
-<<<<<<< 272fd9125a (Merge branch 'gt/core-bare-in-templates')
-	reinit = create_default_files(template_dir, original_git_dir,
-				      &repo_fmt, init_shared_repository);
-
-||||||| 3c2a3fdc38
-	reinit = create_default_files(template_dir, original_git_dir,
-				      &repo_fmt, prev_bare_repository,
-				      init_shared_repository);
-
-=======
->>>>>>> 7a998665dd (setup: fix bug with "includeIf.onbranch" when initializing dir)
 	/*
 	 * Now that we have set up both the hash algorithm and the ref storage
 	 * format we can update the repository's settings accordingly.
@@ -2229,11 +2201,8 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	safe_create_dir(git_dir, 0);
 
-	prev_bare_repository = is_bare_repository();
-
 	reinit = create_default_files(template_dir, original_git_dir,
-				      &repo_fmt, prev_bare_repository,
-				      init_shared_repository);
+				      &repo_fmt, init_shared_repository);
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo_fmt.ref_storage_format,
