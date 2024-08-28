Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F031AC443
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880535; cv=none; b=SFdkK3PNiqxFcnCxVQhf3fPjr/yebhTvMPiMGpqzPPG+HyDeCdZqLEwGDi2njLYb+WmJT/kdb5DAoRBVZxmQ6RoC6lnt4lxMt5XVFAkafq/hCHogA646zHPK9xsjyz7tKVz89dSP3+H/8Agw2myNorFp3MB4+gXR7PBzwWApOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880535; c=relaxed/simple;
	bh=EgReY3OwBUNImp74kZG4s6lLu9Myi/Xn7hwgwqgnTIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z12Gi72cYFVFGKAF5Gzpfw0vMU76jod6C9PVkzCGhRDMtTOky1FlOju/Hz/V7WQHJMbhe2CfK4o4pi6hE5fb2e8oxJ7MeVfvJUcJ43xHIf5bm5ASIAaMt0qBehBi3MyKDoaiiwhfRJkbAQ5FZb+8/6StsxvHV68TMBrY30RII7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IsAhhuzx; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IsAhhuzx"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BC7A3358F;
	Wed, 28 Aug 2024 17:28:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EgReY3OwBUNImp74kZG4s6lLu9Myi/Xn7hwgwq
	gnTIw=; b=IsAhhuzx8ImF6MXFUFjr3zas4y9sHzvo8jpn4DZzJBTUUR61zNCLKe
	dXBTKvtdZJ9B5YYbRU7w5D7OnBwetJoAz0ztxc0617W7HBafYsNAgZXPG8NcgBX6
	VpEmmu7gChoSYfI5hFAquiPSiwCW3gRp0pTNs5YxA0TkeRuROLxv4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 94AD53358E;
	Wed, 28 Aug 2024 17:28:53 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5D923358D;
	Wed, 28 Aug 2024 17:28:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/4] add ref content check for files backend
In-Reply-To: <Zs348uXMBdCuwF-2@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 28 Aug 2024 00:04:02 +0800")
References: <ZsIMc6cJ-kzMzW_8@ArchLinux> <Zs348uXMBdCuwF-2@ArchLinux>
Date: Wed, 28 Aug 2024 14:28:47 -0700
Message-ID: <xmqqbk1cz69c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 837895AC-6584-11EF-AA61-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Here is another one.

By the way, Peff, do we have MAYBE_UNUSED that can be used in a case
like this one?  Platforms without symbolic links supported may well
define NO_SYMLINK_HEAD, which makes the incoming parameters unused.

static int create_ref_symlink(struct ref_lock *lock, const char *target)
{
	int ret = -1;
#ifndef NO_SYMLINK_HEAD
	char *ref_path = get_locked_file_path(&lock->lk);
	unlink(ref_path);
	ret = symlink(target, ref_path);
	free(ref_path);

	if (ret)
		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
#endif
	return ret;
}

We can of course do the attached, which I'll let shejialuo to squash
into an appropriate patch in the series.

Thanks.


 refs/files-backend.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git c/refs/files-backend.c w/refs/files-backend.c
index 69dd283c9d..110af32788 100644
--- c/refs/files-backend.c
+++ w/refs/files-backend.c
@@ -1951,10 +1951,13 @@ static int commit_ref_update(struct files_ref_store *refs,
 	return 0;
 }
 
+#ifdef NO_SYMLINK_HEAD
+#define create_ref_symlink(lock, referent) (-1)
+#else
 static int create_ref_symlink(struct ref_lock *lock, const char *target)
 {
 	int ret = -1;
-#ifndef NO_SYMLINK_HEAD
+
 	char *ref_path = get_locked_file_path(&lock->lk);
 	unlink(ref_path);
 	ret = symlink(target, ref_path);
@@ -1962,9 +1965,9 @@ static int create_ref_symlink(struct ref_lock *lock, const char *target)
 
 	if (ret)
 		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
-#endif
 	return ret;
 }
+#endif
 
 static int create_symref_lock(struct ref_lock *lock, const char *target,
 			      struct strbuf *err)
