Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214276EF6
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160653; cv=none; b=G3qoyXrOInZVKNSzlTtP93QzWUA68qOPMoKzNCWQyP0BnLCxUY1lVpi1Io2Hn2VUWrKIZjrzlrGYsG6uG2mPnB6fhLc7D65MKapaSFWmz7TB+gqhJd5dbhgDx5ZrdlBW0FE20wO8L0GQle9A2hEhW+DJg3Lr2gXmjaQlZj+8H2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160653; c=relaxed/simple;
	bh=eRK/QuFG0XBBx8Fe9ak+eYHwo0Eu9HH0y9j38dyhSzg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHlbxrfYNNCH52LIRWMO7o0EWPwIZUjGgUJjnK3wrO/VUIxJhhYk+IZHRrxAdTXGbs0lOKyNgk3/YI5rFcKdbpUNCmtUHF98wLPFub1UWXN1Zw6TriS1fz9Qou0KZFTRdPAghfoxnkWVWBuSmkxbavo809ShrcZX/Ky3L/fjb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23798 invoked by uid 109); 28 Feb 2024 22:50:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:50:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27044 invoked by uid 111); 28 Feb 2024 22:50:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:50:52 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:50:50 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 4/4] upload-pack: only accept packfile-uris if we advertised
 it
Message-ID: <20240228225050.GA1159078@coredump.intra.peff.net>
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

Clients are only supposed to request particular capabilities or features
if the server advertised them. For the "packfile-uris" feature, we only
advertise it if uploadpack.blobpacfileuri is set, but we always accept a
request from the client regardless.

In practice this doesn't really hurt anything, as we'd pass the client's
protocol list on to pack-objects, which ends up ignoring it. But we
should try to follow the protocol spec, and tightening this up may catch
buggy or misbehaving clients more easily.

Thanks to recent refactoring, we can hoist the config check from
upload_pack_advertise() into upload_pack_config(). Note the subtle
handling of a value-less bool (which does not count for triggering an
advertisement).

Signed-off-by: Jeff King <peff@peff.net>
---
I suspect in the long term that we may have other ways to trigger this
feature than the static blobpackfileuri config (e.g., a hook that knows
about site-specific packfiles "somehow"). So we may need to update the
test later for that, but presumably in the vanilla config we'll continue
to skip advertising it.

 t/t5702-protocol-v2.sh | 18 ++++++++++++++++++
 upload-pack.c          | 16 +++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 6ef4971845..902e42c1c0 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -778,6 +778,24 @@ test_expect_success 'archive with custom path does not request v2' '
 	! grep ^GIT_PROTOCOL env.trace
 '
 
+test_expect_success 'reject client packfile-uris if not advertised' '
+	{
+		packetize command=fetch &&
+		printf 0001 &&
+		packetize packfile-uris https &&
+		packetize done &&
+		printf 0000
+	} >input &&
+	test_must_fail env GIT_PROTOCOL=version=2 \
+		git upload-pack client <input &&
+	test_must_fail env GIT_PROTOCOL=version=2 \
+		git -c uploadpack.blobpackfileuri \
+		upload-pack client <input &&
+	GIT_PROTOCOL=version=2 \
+		git -c uploadpack.blobpackfileuri=anything \
+		upload-pack client <input
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
diff --git a/upload-pack.c b/upload-pack.c
index 491ef51daa..66f4de9d87 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -113,6 +113,7 @@ struct upload_pack_data {
 	unsigned done : 1;					/* v2 only */
 	unsigned allow_ref_in_want : 1;				/* v2 only */
 	unsigned allow_sideband_all : 1;			/* v2 only */
+	unsigned allow_packfile_uris : 1;			/* v2 only */
 	unsigned advertise_sid : 1;
 	unsigned sent_capabilities : 1;
 };
@@ -1362,6 +1363,9 @@ static int upload_pack_config(const char *var, const char *value,
 		data->allow_ref_in_want = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
 		data->allow_sideband_all = git_config_bool(var, value);
+	} else if (!strcmp("uploadpack.blobpackfileuri", var)) {
+		if (value)
+			data->allow_packfile_uris = 1;
 	} else if (!strcmp("core.precomposeunicode", var)) {
 		precomposed_unicode = git_config_bool(var, value);
 	} else if (!strcmp("transfer.advertisesid", var)) {
@@ -1647,7 +1651,8 @@ static void process_args(struct packet_reader *request,
 			continue;
 		}
 
-		if (skip_prefix(arg, "packfile-uris ", &p)) {
+		if (data->allow_packfile_uris &&
+		    skip_prefix(arg, "packfile-uris ", &p)) {
 			string_list_split(&data->uri_protocols, p, ',', -1);
 			continue;
 		}
@@ -1847,8 +1852,6 @@ int upload_pack_advertise(struct repository *r,
 	get_upload_pack_config(r, &data);
 
 	if (value) {
-		char *str = NULL;
-
 		strbuf_addstr(value, "shallow wait-for-done");
 
 		if (data.allow_filter)
@@ -1860,13 +1863,8 @@ int upload_pack_advertise(struct repository *r,
 		if (data.allow_sideband_all)
 			strbuf_addstr(value, " sideband-all");
 
-		if (!repo_config_get_string(r,
-					    "uploadpack.blobpackfileuri",
-					    &str) &&
-		    str) {
+		if (data.allow_packfile_uris)
 			strbuf_addstr(value, " packfile-uris");
-			free(str);
-		}
 	}
 
 	upload_pack_data_clear(&data);
-- 
2.44.0.rc2.424.gbdbf4d014b
