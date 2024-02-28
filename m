Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A151361C4
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160410; cv=none; b=REOjer6teya9dE4Tf5ois9PEVpAjoHap0yVU8YX+fbRhfsUDrAS1Bck/xeBO0xcJxSHXSJcE/P5WWGse9xNE8kkxyWYCS++YMYVgpGkpvCjoca3nJAStREUOmGN5JW/11TSq+jswy4Pk7AEg0YpYc9BWTb5YU9nmCcjGXQ443AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160410; c=relaxed/simple;
	bh=X7SILVlPbtawJRjEJvUP5vLpwdVcHX6tfgTEDVuaY1Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDuS62iyqHOfm5YL+bby8sof+BRO+upfIS4xX48fW5huh4bpC639/3dmCfx8g74+3L67rzmi7McNSFgBtj07RzU3d/qZVjwd7VKzKMLiBOd3OoMR8QIxktK6Exr0AWT9sU6ujZFjk4nsMaVtUNuyjt7QYzO2AvelhlX2v7SbGXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23766 invoked by uid 109); 28 Feb 2024 22:46:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:46:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26944 invoked by uid 111); 28 Feb 2024 22:46:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:46:50 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:46:47 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/4] upload-pack: use repository struct to get config
Message-ID: <20240228224647.GA1158898@coredump.intra.peff.net>
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

Our upload_pack_v2() function gets a repository struct, but we ignore it
totally.  In practice this doesn't cause any problems, as it will never
differ from the_repository. But in the spirit of taking a small step
towards getting rid of the_repository, let's at least starting using it
to grab config. There are probably other spots that could benefit, but
it's a start.

Note that we don't need to pass the repo for protected_config(); the
whole point there is that we are not looking at repo config, so there is
no repo-specific version of the function.

For the v0 version of the protocol, we're not passed a repository
struct, so we'll continue to use the_repository there.

Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 2537affa90..e156c1e472 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1385,9 +1385,10 @@ static int upload_pack_protected_config(const char *var, const char *value,
 	return 0;
 }
 
-static void get_upload_pack_config(struct upload_pack_data *data)
+static void get_upload_pack_config(struct repository *r,
+				   struct upload_pack_data *data)
 {
-	git_config(upload_pack_config, data);
+	repo_config(r, upload_pack_config, data);
 	git_protected_config(upload_pack_protected_config, data);
 }
 
@@ -1398,7 +1399,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 	struct upload_pack_data data;
 
 	upload_pack_data_init(&data);
-	get_upload_pack_config(&data);
+	get_upload_pack_config(the_repository, &data);
 
 	data.stateless_rpc = stateless_rpc;
 	data.timeout = timeout;
@@ -1771,7 +1772,7 @@ enum fetch_state {
 	FETCH_DONE,
 };
 
-int upload_pack_v2(struct repository *r UNUSED, struct packet_reader *request)
+int upload_pack_v2(struct repository *r, struct packet_reader *request)
 {
 	enum fetch_state state = FETCH_PROCESS_ARGS;
 	struct upload_pack_data data;
@@ -1780,7 +1781,7 @@ int upload_pack_v2(struct repository *r UNUSED, struct packet_reader *request)
 
 	upload_pack_data_init(&data);
 	data.use_sideband = LARGE_PACKET_MAX;
-	get_upload_pack_config(&data);
+	get_upload_pack_config(r, &data);
 
 	while (state != FETCH_DONE) {
 		switch (state) {
-- 
2.44.0.rc2.424.gbdbf4d014b

