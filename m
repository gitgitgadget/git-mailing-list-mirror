Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8B16BE00
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615578; cv=none; b=lL14t2ejv9tZXXeXH8juDvSn4HNZhW8S8m0k1QUT0Kp/H/thmxJ7CIYtwrKe5J26uURizrA3LGBh4cjvZUGsVCi4B61MgQuU7p2+VWOABEaLxZntgTAnuir6aybWkxuoihYhV3xVF2L2DphiftvTEsQ3Eeu4slABisMZtf0IUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615578; c=relaxed/simple;
	bh=Iso9LpRGfbtIdgb26RK7r/T31At9eobxPMGfvRjgKOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oDjzYXATHgEmsJd8lPzs8/sv0WONuQazdaXIgCQDyY4xuiGoW3UV1uDY8Nu3tm0YRZWhFry9+OqHnJZIXOSAZwtcBpBmJFhc3f9+s8mgzS+CXbEFV5Omg2UrVvNDq4dLReLw/KQeahWrFWbb+SwEMrkg15akYzAx91YYTFDlMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oyzou1mM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oyzou1mM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D39A349A2;
	Fri,  2 Aug 2024 12:19:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Iso9LpRGfbtIdgb26RK7r/T31At9eobxPMGfvR
	jgKOA=; b=Oyzou1mMPVvTay6I/3t9SPIKkOjOT9onJoV3i3Jy/VmZL5iBgH2Ueq
	W1CNzz8wIIb1xVplhfeBpUDkVRdkQov2qsdxVrWawE6sbmd4f4Fa2Ds1DJUlyJVV
	DUaDc4G0OquP9Da9whdm0BLYnfkIb/0PLnNZDG9YWBEl47hMG5Yps=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 45444349A1;
	Fri,  2 Aug 2024 12:19:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3FE7B349A0;
	Fri,  2 Aug 2024 12:19:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: the.tester@mac.com
Cc: git@vger.kernel.org
Subject: Re: Date and time processing issue
In-Reply-To: <B896574C-A150-45AE-A636-ADA9ADF3255A@mac.com> (the tester's
	message of "Fri, 2 Aug 2024 11:46:30 +0200")
References: <B896574C-A150-45AE-A636-ADA9ADF3255A@mac.com>
Date: Fri, 02 Aug 2024 09:19:23 -0700
Message-ID: <xmqqplqqew38.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FC08D04E-50EA-11EF-BDE9-92D9AF168FA5-77302942!pb-smtp20.pobox.com

the.tester@mac.com writes:

> To me, the error message is at least misleading. 

Correct.  The error message is prepared for the most common case
where people ask for an invalid format, but does not pay attention
to the fact that some timestamps are not out of range in the Git
timescale and such an out of range timestamp can be fed to the
program.

Something along the following line may be a good first step to fix
it.

 builtin/commit.c | 2 +-
 ident.c          | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git c/builtin/commit.c w/builtin/commit.c
index 66427ba82d..24de55ae86 100644
--- c/builtin/commit.c
+++ w/builtin/commit.c
@@ -657,7 +657,7 @@ static void determine_author_info(struct strbuf *author_ident)
 	if (force_date) {
 		struct strbuf date_buf = STRBUF_INIT;
 		if (parse_force_date(force_date, &date_buf))
-			die(_("invalid date format: %s"), force_date);
+			die(_("invalid format or date out of range: %s"), force_date);
 		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
 	}
 
diff --git c/ident.c w/ident.c
index caf41fb2a9..d18773554d 100644
--- c/ident.c
+++ w/ident.c
@@ -528,7 +528,8 @@ const char *fmt_ident(const char *name, const char *email,
 		strbuf_addch(ident, ' ');
 		if (date_str && date_str[0]) {
 			if (parse_date(date_str, ident) < 0)
-				die(_("invalid date format: %s"), date_str);
+				die(_("invalid format or date out of range: %s"),
+				    date_str);
 		}
 		else
 			strbuf_addstr(ident, ident_default_date());

