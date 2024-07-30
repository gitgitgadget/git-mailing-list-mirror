Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE71A76C9
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362169; cv=none; b=Q9ZzL+LPr0+ecLJG3MYSnl4tpdiMJ1RXOgMmOj4LJMhKnrWtQ8oBzxLKKWiKFWhj0l2u8r5BLXJhx6xaeisA+SKww2OPMPb7av4aPmMZkfN9asbCXJ/0OSVlRJanYqxPf2ELUabK98393qtYfk51Dh2MnyWUeXZdvntTo9FqCxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362169; c=relaxed/simple;
	bh=xiWH9udoVhPPLYYrMi1vNOs2V+/QXb21S0sXVq3FXMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R2wFAvhcBnAAo+k9dm4/jV5BKy/cu3Ty0hOt+8p4ZY/fFYTfiCU6EqlS9f4EWq/YDX4gdFIbBl3GQnt5fVg979XlwYS1VWNRSwouSF3UZVrL/sfbluizp+9lSvSeN8+/oiu1K7n2V1hB2/gWAOeMRTjFGOtWCFuYutfmerkMV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NziggpjC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NziggpjC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D191334908;
	Tue, 30 Jul 2024 13:56:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xiWH9udoVhPPLYYrMi1vNOs2V+/QXb21S0sXVq
	3FXMI=; b=NziggpjCSj+9Hj3XtdyjcdqAheal8hq7zMHSACG2Kqdiy6rutpEF7C
	GcvJZsosRgBZQxhtu/QdzWclMdpVAt643H9NMF9tHYqq2t95s1EEwTl5TOPuaPzU
	lNXtWfwxhvAXDmfCTEfCFDNl8p0GIArxv60hd+i4XYf6comCzN/Yc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C890534906;
	Tue, 30 Jul 2024 13:56:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1215834904;
	Tue, 30 Jul 2024 13:56:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: safe.directory: preliminary clean-up
In-Reply-To: <xmqqv80metou.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	30 Jul 2024 09:22:09 -0700")
References: <20240723021900.388020-1-gitster@pobox.com>
	<20240720220915.2933266-1-gitster@pobox.com>
	<20240730011004.4030246-1-gitster@pobox.com>
	<20240730011004.4030246-3-gitster@pobox.com>
	<20240730074307.GB562212@coredump.intra.peff.net>
	<xmqqv80metou.fsf@gitster.g>
Date: Tue, 30 Jul 2024 10:56:04 -0700
Message-ID: <xmqq5xsmdarv.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FE5A8E64-4E9C-11EF-8530-34EEED2EC81B-77302942!pb-smtp1.pobox.com

The paths given in the safe.directory configuration variable are
allowed to contain "~user" (which interpolates to user's home
directory) and "%(prefix)" (which interpolates to the installation
location in RUNTIME_PREFIX-enabled builds, and a call to the
git_config_pathname() function is tasked to obtain a copy of the
path with these constructs interpolated.

The function, when it succeeds, always yields an allocated string in
the location given as the out-parameter; even when there is nothing
to interpolate in the original, a literal copy is made.  The code
path that contains this caller somehow made two contradicting and
incorrect assumptions of the behaviour when there is no need for
interpolation, and was written with extra defensiveness against
two phantom risks that do not exist.

One wrong assumption was that the function might yield NULL when
there is no interpolation.  This led to the use of an extra "check"
variable, conditionally holding either the interpolated or the
original string.  The assumption was with us since 8959555c
(setup_git_directory(): add an owner check for the top-level
directory, 2022-03-02) originally introduced the safe.directory
feature.

Another wrong assumption was that the function might yield the same
pointer as the input when there is no interpolation.  This led to a
conditional free'ing of the interpolated copy, that the conditional
never skipped, as we always received an allocated string.

Simplify the code by removing the extra defensiveness.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git c/setup.c w/setup.c
index d458edcc02..3177d010d1 100644
--- c/setup.c
+++ w/setup.c
@@ -1235,17 +1235,15 @@ static int safe_directory_cb(const char *key, const char *value,
 		char *allowed = NULL;
 
 		if (!git_config_pathname(&allowed, key, value)) {
-			const char *check = allowed ? allowed : value;
-			if (ends_with(check, "/*")) {
-				size_t len = strlen(check);
-				if (!fspathncmp(check, data->path, len - 1))
+			if (ends_with(allowed, "/*")) {
+				size_t len = strlen(allowed);
+				if (!fspathncmp(allowed, data->path, len - 1))
 					data->is_safe = 1;
-			} else if (!fspathcmp(data->path, check)) {
+			} else if (!fspathcmp(data->path, allowed)) {
 				data->is_safe = 1;
 			}
-		}
-		if (allowed != value)
 			free(allowed);
+		}
 	}
 
 	return 0;
