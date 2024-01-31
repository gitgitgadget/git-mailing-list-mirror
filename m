Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773812C53B
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722950; cv=none; b=o3XPUYtIDdlI5/iqG/Af87MYeiyIxJWAyaK29Eyn+ILR16EEPtUGcSsRnZ7ofRYab9Fpu7SlmVYt8SK7Kgt+BGpLDlCb6QqneSvdyCX/TTu2xE/9sm4y9OeISz9GU3bXWKG64dnV0h3eEydkkBM3td7jm0EdHpxJELUXQUnlmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722950; c=relaxed/simple;
	bh=Q/5quDyd/nEsBX2VbGJZlmj39FsbvV5fDwOhFVi1y7w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ff45lYLebEdTusZJBJvl4ZarVLaKnxhP6V+eJpqOX+CT5NlGSnk5tHIW1S18gYVemtA+jm8KKe2zC3CfzNEbQdBhP5+rO4dq5K9RMOBpnUPch8GXuoaaBzQW6f7a32F4TE5WQzVCYEj/VOK1TDmVAczAHcNUhkJzLoSlwGY0Xqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tEk0CR1Y; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tEk0CR1Y"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7E041E9A3A;
	Wed, 31 Jan 2024 12:42:25 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=Q/5quDyd/nEsBX2VbGJZlmj39
	FsbvV5fDwOhFVi1y7w=; b=tEk0CR1YxB9TVBYzcd4L5NMNFI9+n0SPTR/B/zMaX
	ks+3ckCu4HAu+MK6ewuHcJ0rUS+6kiq9u1Ak+WyVOO7qyi1yRM5XyxmaNn7any0t
	Kyvwg8SQgY4DIZtS4ZgwomTDaWcv3C2CMhdpeqngdlgpdjwIj0DycqRoHNGJN7Uz
	MU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B07F51E9A39;
	Wed, 31 Jan 2024 12:42:25 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26E701E9A38;
	Wed, 31 Jan 2024 12:42:25 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] Makefile: simplify output of the libpath_template
Date: Wed, 31 Jan 2024 09:42:20 -0800
Message-ID: <20240131174220.4160560-3-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-493-gbc7ee2e5e1
In-Reply-To: <20240131174220.4160560-1-gitster@pobox.com>
References: <20240131174220.4160560-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 18466436-C060-11EE-B3C9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

If a platform lacks the support to specify the dynamic library path,
there is no suitable value to give to the CC_LD_DYNPATH variable.
Allow them to be set to an empty string to signal that they do not
need to add the usual -Wl,-rpath, or -R or whatever option followed
by a directory name.  This way,

    $(call libpath_tempate,$(SOMELIBDIR))

would expand to just a single mention of that directory, i.e.

    -L$(SOMELIBDIR)

when CC_LD_DYNPATH is set to an empty string (or a "-L", which
would have repeated the same "-L$(SOMELIBDIR)" twice without any
ill effect).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This obviously makes it impossible to set CC_LD_DYNPATH to an
   empty string to say "-L /usr/local/lib /usr/local/lib" on the
   linker's command line.  I do not think it would serve any useful
   purpose to be able to have just a directory name on the command
   line of the linker there, so it would not regress anything on
   exotic platforms, I hope ;-).

 shared.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/shared.mak b/shared.mak
index f33cab8a4e..c59cea75a1 100644
--- a/shared.mak
+++ b/shared.mak
@@ -112,5 +112,5 @@ endef
 ## Getting sick of writing -L$(SOMELIBDIR) $(CC_LD_DYNPATH)$(SOMELIBDIR)=
?
 ## Write $(call libpath_template,$(SOMELIBDIR)) instead, perhaps?
 define libpath_template
--L$(1) $(CC_LD_DYNPATH)$(1)
+-L$(1) $(if $(filter-out -L,$(CC_LD_DYNPATH)),$(CC_LD_DYNPATH)$(1))
 endef
--=20
2.43.0-493-gbc7ee2e5e1

