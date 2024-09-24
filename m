Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622382488
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214612; cv=none; b=VWcLik++CB2XnvsPVPj27Kqpn6vXy9ZBLEn/AOq/6e4eL0f0oFK+ZpR5Gs6MSSYF0equ3dZuwqIAL3KqKq7BfB5HsZXQuJ+Ne87V3KjoJ37NRlodDA4UrmWvZyPjeIw1eH1wUh8FXtfpgGrPf/GubQUYP3Zf55EjMTI07JCXakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214612; c=relaxed/simple;
	bh=D8W2xKdwMML+BggqQ8ze2mPgDToyp+ebd/jsbzvbYn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rO0PdF+kJ7F4lh+rnxHWF68b7KHb7Fu6q72uIFaGDYkdgae90T0vGPMpvWUpF+ZOqzFjtp+3OJC7uSG+3qNJMnY+WDoqvuOyQXmdRXCcDesWr7G1tXrTpS7CQR6TpFy3BEkFUYakeGZxIFNm2L+S+sD80ZvcNX0tjVcH+mUDfUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15399 invoked by uid 109); 24 Sep 2024 21:50:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:50:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18213 invoked by uid 111); 24 Sep 2024 21:50:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:50:09 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:50:09 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 01/28] http-fetch: clear leaking git-index-pack(1) arguments
Message-ID: <20240924215009.GA1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

From: Patrick Steinhardt <ps@pks.im>

We never clear the arguments that we pass to git-index-pack(1). Create a
common exit path and release them there to plug this leak.

This is leak is exposed by t5702, but plugging the leak does not make
the whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jeff King <peff@peff.net>
---
Obviously I didn't write this or the next two patches, but FWIW, I
reviewed them and they all look good to me.

 http-fetch.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index d460bb1837..02ab80533f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -106,6 +106,7 @@ int cmd_main(int argc, const char **argv)
 	int nongit;
 	struct object_id packfile_hash;
 	struct strvec index_pack_args = STRVEC_INIT;
+	int ret;
 
 	setup_git_directory_gently(&nongit);
 
@@ -157,8 +158,8 @@ int cmd_main(int argc, const char **argv)
 
 		fetch_single_packfile(&packfile_hash, argv[arg],
 				      index_pack_args.v);
-
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	if (index_pack_args.nr)
@@ -170,7 +171,12 @@ int cmd_main(int argc, const char **argv)
 		commit_id = (char **) &argv[arg++];
 		commits = 1;
 	}
-	return fetch_using_walker(argv[arg], get_verbosely, get_recover,
-				  commits, commit_id, write_ref,
-				  commits_on_stdin);
+
+	ret = fetch_using_walker(argv[arg], get_verbosely, get_recover,
+				 commits, commit_id, write_ref,
+				 commits_on_stdin);
+
+out:
+	strvec_clear(&index_pack_args);
+	return ret;
 }
-- 
2.46.2.1011.gf1f9323e02

