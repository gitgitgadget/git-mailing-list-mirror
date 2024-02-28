Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F736E
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160441; cv=none; b=N87Oa2c8uWJe4T8DbE+/QX5Jcm1TZS1E7HVXsb+rZgdO+LIe15J7q7mgm3V0YKOd8VxAQngcwsINlOq+1ogoqbBkG+xnQNU2LMAV67Y8ZX+1uBnZR8jjmhrf3NeMwVgH8fAV5Oxqw9uQjLjZI9IqyHFqfTWYG2C3W1uXqxROssM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160441; c=relaxed/simple;
	bh=3ocyPhRZqIO858sqJ9tM8iU4ZGoYxJEYC6EpXcwlCW0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdzQNhqEetbR5+L0zygdwBrlfmXdo7zuPmKTgXNkoc14Qr0HnXOVvUYRE0sSj0482z2V5+pRtYKqq5VCHLEOaLyn1RI3hQFqz5jgqwedP+62cgcWU9R+R1DT79HaI+H4VyDzuzW7Jh4zQsRjQ/WOmET731l0PRKibOXFj2BeWJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23771 invoked by uid 109); 28 Feb 2024 22:47:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:47:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26950 invoked by uid 111); 28 Feb 2024 22:47:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:47:21 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:47:18 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/4] upload-pack: centralize setup of sideband-all config
Message-ID: <20240228224718.GB1158898@coredump.intra.peff.net>
References: <20240228224625.GA1158651@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228224625.GA1158651@coredump.intra.peff.net>

We read uploadpack.allowsidebandall to set a matching flag in our
upload_pack_data struct. But for our tests, we also respect
GIT_TEST_SIDEBAND_ALL from the environment, and anybody looking at the
flag in the struct needs to remember to check both. There's only one
such piece of code now, but we're about to add another.

So let's have the config step actually fold the environment value into
the struct, letting the rest of the code use the flag in the obvious
way.

Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index e156c1e472..6bda20754d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1390,6 +1390,8 @@ static void get_upload_pack_config(struct repository *r,
 {
 	repo_config(r, upload_pack_config, data);
 	git_protected_config(upload_pack_protected_config, data);
+
+	data->allow_sideband_all |= git_env_bool("GIT_TEST_SIDEBAND_ALL", 0);
 }
 
 void upload_pack(const int advertise_refs, const int stateless_rpc,
@@ -1639,8 +1641,7 @@ static void process_args(struct packet_reader *request,
 			continue;
 		}
 
-		if ((git_env_bool("GIT_TEST_SIDEBAND_ALL", 0) ||
-		     data->allow_sideband_all) &&
+		if (data->allow_sideband_all &&
 		    !strcmp(arg, "sideband-all")) {
 			data->writer.use_sideband = 1;
 			continue;
-- 
2.44.0.rc2.424.gbdbf4d014b

