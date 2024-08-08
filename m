Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76064A1E
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079474; cv=none; b=fnpkFsBmL1a1tm9Joh87MWXdPob0mdSBnCocNj1qU3YIYmj3w0kzKAHaQbFtC2ecRHJo4kciAx5y+9NrbPYAHfKq1rouMzJdjUuU31wUmGDnX8eK8kZb7slBAGsJdvyPlWilM8pMOl/jPxsYgmaU4sPPTmv8V63u58lx0b3cJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079474; c=relaxed/simple;
	bh=WyhqmrN/oXg3Kkqh78ambt8x5Nb5Newm1cIufBcs14A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S4peVLflbxP5LOxz7+pWXs4JUV/WiYpqLcAY4iszbe9RIjrwSuiva7VUQ2DYwp5Bj6UsMtwDMnikxsz3/OuUPme5SWnzW4xYv9pF6vgyEildz6zBt6kwg8G4yh6EAXEpMoNVzqpvxXp2YS8yNwBhZ9jmPHxYbhiMgSirpA/GaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PoADecOA; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PoADecOA"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F0B4729083;
	Wed,  7 Aug 2024 21:11:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=W
	yhqmrN/oXg3Kkqh78ambt8x5Nb5Newm1cIufBcs14A=; b=PoADecOAPj5empGSz
	HQ+p+qza2vSqpBSyxj1tzM800TKDALIgn29ikYxYfSkQOj9S3HYte/ok/cJLS4Xn
	x5/diNXpTMbNgg5Ei8p6Ne1tkvntJ+71dkWDYa7zH3CwKFtMmzJAHPY5y2lIHryR
	1xN3YlIkz0FeBlGi/Uw77/xVrc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E96F629082;
	Wed,  7 Aug 2024 21:11:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C5C329081;
	Wed,  7 Aug 2024 21:11:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] transport: fix leak with transport helper URLs
Date: Wed, 07 Aug 2024 18:11:10 -0700
Message-ID: <xmqq34nfn7ip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1982555A-5523-11EF-AC27-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Transport URLs can be prefixed with "foo::", which would tell us that
the transport uses a remote helper called "foo". We extract the helper
name by `xstrndup()`ing the prefix before the double-colons, but never
free that string.

Fix this leak by assigning the result to a separate local variable that
we can then free upon returning.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * It turns out that Patrick planned to have an almost identical
   patch, I am queuing this "independently invented" one now,
   because a recent update to ls-remote and its tests started
   breaking the CI.

 transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index 12cc5b4d96..7c4af9f56f 100644
--- a/transport.c
+++ b/transport.c
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
+		helper = helper_to_free = xstrndup(url, p - url);
 
 	if (helper) {
 		transport_helper_init(ret, helper);
+		free(helper_to_free);
 	} else if (starts_with(url, "rsync:")) {
 		die(_("git-over-rsync is no longer supported"));
 	} else if (url_is_local_not_ssh(url) && is_file(url) && is_bundle(url, 1)) {
-- 
2.46.0-313-g2d45963c97

