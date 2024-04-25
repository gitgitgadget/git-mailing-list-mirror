Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA3614D70C
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064989; cv=none; b=OypEOsWNrN4boj6PjEwsoYlOgfrLb/CPDdeX8laEnN50oSGZenC+L8ahZTRNBOO8HZ2jbjNRD4WD9Yb28EizwVnUcmUl6S+AfqqCLxUlDEB6mj/YFfu3kTIBYQDFVqHuGdPJ5VQqFLcvVRZzP/WTM/tyAfx70AZVV3KI3vB5TB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064989; c=relaxed/simple;
	bh=jjaU4/U1LOxbDQdDAV7j+KVoM48fbOCNGMf6iVjXxQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nkbozoLR53oHuTd4va7SOl+adDxuHrQGm7xeOvTG3EHiFIwlHepG2rN4I6eGM6uCgf7IenmHhI94mGJ3mVq56ICB1i7OcbTdiWOiT1u2sHqJsb8mZIcP/RlQuRWAX0xndaOrqVRqzRbaUltBQ0v8qjrZdehcFuQR8PVluogi47E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vVOe4EkU; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vVOe4EkU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C8AE2402B;
	Thu, 25 Apr 2024 13:09:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jjaU4/U1LOxbDQdDAV7j+KVoM48fbOCNGMf6iV
	jXxQ0=; b=vVOe4EkUn1Ph1gXYcWhI2V23KkB6ccMexODpVd+qtV7xGkivy8FdUq
	/6M4Vdjm4qxr9TUX/k8Uc2E85mzaBI7sHtxSxA/9nXbffluAk8w3exjHg/Nv++rn
	O4F32Bh7SX8JNpZFv2JmjZe1JZ5qT1TmHOK8OUilHn+kWPuDA4JXA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7307A2402A;
	Thu, 25 Apr 2024 13:09:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DBD2C24029;
	Thu, 25 Apr 2024 13:09:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 0/8] refs: add symref support to 'git-update-ref'
In-Reply-To: <20240423212818.574123-1-knayak@gitlab.com> (Karthik Nayak's
	message of "Tue, 23 Apr 2024 23:28:10 +0200")
References: <20240412095908.1134387-1-knayak@gitlab.com>
	<20240423212818.574123-1-knayak@gitlab.com>
Date: Thu, 25 Apr 2024 10:09:45 -0700
Message-ID: <xmqq8r11gyhy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9E2DC1E4-0326-11EF-9FF7-25B3960A682E-77302942!pb-smtp2.pobox.com

You'd want something like this squashed into an appropriate step to
avoid breaking "make sparse".

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 175579148f..1cdafc33f3 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -228,7 +228,7 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	have_old = !parse_next_arg(&next, end, &old_oid,
 				   &old_target, "update", refname,
 				   PARSE_SHA1_OLD | PARSE_REFNAME_TARGETS);
-	have_old = have_old & !old_target.len;
+	have_old = have_old && !old_target.len;
 
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
