Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C68B13A3F6
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049984; cv=none; b=NYAp8s5Vt3YK0KhJmcRV6Xbl8nlcvn8wxjS30944gJouqxCnOlz5POQwI7VMCT22vvXAKIpzNb1ig3p5Q/u8UL/0ZdoS5OdF2h1WcI7jpvrLBMkqSto+KhK8bb3vo74Zo9s1DVYSGiNVBm1jiLSAswaFmxgDpHxQjsKQgZebtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049984; c=relaxed/simple;
	bh=NfEORSqcXcIjnYCUtOuJNhnGU7ovzIlwfmLAN3Ft9r0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IpbYm4viDC8VrpZBSMga7Se71e02c5g9D/mbOOn/R8bdzQo963T72z+rSlIo0Zh01TMiCO9SZ6u30som3zfU4wOo/xFC8VJWywCmTvH2UdOugMSdgRZvMC8+AkGBiEKDBFwBPjNJg5SM+sR081FV5BOpWI0XYVwcEYnGmj2pep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ihP3u6vH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ihP3u6vH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AC9218EB9;
	Wed,  7 Aug 2024 12:59:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NfEORSqcXcIjnYCUtOuJNhnGU7ovzIlwfmLAN3
	Ft9r0=; b=ihP3u6vH7q3TqLfbIRGn6odAcCKS0oQAAsAzh5cUaxL09LzIYosIbg
	J0ISG2eWhzvKSJphMZPjJRZMeecrjR/SDKr36Na2pvCEMEUjzyfqJ+yjG5RHquiX
	iKkrbEHJnp9sSPW0muF20RZPB5ie9q4+0Vh97PIbR5dJDjuimCV2g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2385618EB8;
	Wed,  7 Aug 2024 12:59:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80C5B18EB5;
	Wed,  7 Aug 2024 12:59:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/22] Memory leak fixes (pt.4)
In-Reply-To: <cover.1722933642.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 6 Aug 2024 10:59:32 +0200")
References: <cover.1722933642.git.ps@pks.im>
Date: Wed, 07 Aug 2024 09:59:39 -0700
Message-ID: <xmqqy158nu9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6FB5A6EC-54DE-11EF-A694-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The series is built on top of 406f326d27 (The second batch, 2024-08-01)
> with ps/leakfixes-part-3 at f30bfafcd4 (commit-reach: fix trivial memory
> leak when computing reachability, 2024-08-01) merged into it.

A quick question.  Is it on your radar that transport_get() leaks
the helper name when "foo::bar" is given as a remote?

  https://github.com/git/git/actions/runs/10274435719/job/28431161208#step:5:893

If not, I'll handle it separately, whose fix should look something
like the attached.

Thanks.

 transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git c/transport.c w/transport.c
index 12cc5b4d96..13bf8183b7 100644
--- c/transport.c
+++ w/transport.c
@@ -1115,6 +1115,7 @@ static struct transport_vtable builtin_smart_vtable = {
 struct transport *transport_get(struct remote *remote, const char *url)
 {
 	const char *helper;
+	char *helper_to_free = NULL;
 	const char *p;
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
@@ -1139,10 +1140,11 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	while (is_urlschemechar(p == url, *p))
 		p++;
 	if (starts_with(p, "::"))
-		helper = xstrndup(url, p - url);
+		helper_to_free = helper = xstrndup(url, p - url);
 
 	if (helper) {
 		transport_helper_init(ret, helper);
+		free(helper_to_free);
 	} else if (starts_with(url, "rsync:")) {
 		die(_("git-over-rsync is no longer supported"));
 	} else if (url_is_local_not_ssh(url) && is_file(url) && is_bundle(url, 1)) {

