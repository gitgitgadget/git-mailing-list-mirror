Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4D13F43B
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727214942; cv=none; b=N6uhPyd9nVJ9em3KC7YOk4ksAvje2Nm60CF6DkuMhR4zJqO3Mj7+yUinjoAyARUM1Jzb+jrtcmycqJjjUuhz3qqKu3/O8IgbMfelnW1SbUbUycZpWtI1yuW9LBnQXZce63ZJTsK6OyLY74v31wjzoE1UlXH1/KtjPOGRDkL7aKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727214942; c=relaxed/simple;
	bh=fdZcMDnrqsd0Ewj6CRx6vePAO0z9kRDfbf3yanMdyEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV5wU1alqxiZTTCG3OmOcYk4OHnW58Gmx8HKB6MUAgeZLz4X+DLIwpatQFUwpL9eO7rpigzR0vAbupu2L6P7muA9Qq9LiyZwPS4Ogd559LkPPCgLBEl4nu0Vyg7KxiOjfaiEcyecBoRrzd0XDYuZeKokPp3PYuoq3IE2hNid1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15452 invoked by uid 109); 24 Sep 2024 21:55:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:55:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18577 invoked by uid 111); 24 Sep 2024 21:55:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:55:39 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:55:39 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 08/28] send-pack: free cas options before exit
Message-ID: <20240924215539.GH1143820@coredump.intra.peff.net>
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

The send-pack --force-with-lease option populates a push_cas_option
struct with allocated strings. Exiting without cleaning this up will
cause leak-checkers to complain.

We can fix this by calling clear_cas_option(), after making it publicly
available. Previously it was used only for resetting the list when we
saw --no-force-with-lease.

The git-push command has the same "leak", though in this case it won't
trigger a leak-checker since it stores the push_cas_option struct as a
global rather than on the stack (and is thus reachable even after main()
exits). I've added cleanup for it here anyway, though, as
future-proofing.

The leak is triggered by t5541 (it tests --force-with-lease over http,
which requires a separate send-pack process under the hood), but we
can't mark it as leak-free yet.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/push.c      | 1 +
 builtin/send-pack.c | 1 +
 remote.c            | 2 +-
 remote.h            | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index e6f48969b8..59d4485603 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -669,6 +669,7 @@ int cmd_push(int argc,
 	rc = do_push(flags, push_options, remote);
 	string_list_clear(&push_options_cmdline, 0);
 	string_list_clear(&push_options_config, 0);
+	clear_cas_option(&cas);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index c49fe6c53c..8b1d46e79a 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -344,5 +344,6 @@ int cmd_send_pack(int argc,
 	free_refs(local_refs);
 	refspec_clear(&rs);
 	oid_array_clear(&shallow);
+	clear_cas_option(&cas);
 	return ret;
 }
diff --git a/remote.c b/remote.c
index 390a03c264..e291e8ff5c 100644
--- a/remote.c
+++ b/remote.c
@@ -2544,7 +2544,7 @@ struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map)
 /*
  * Compare-and-swap
  */
-static void clear_cas_option(struct push_cas_option *cas)
+void clear_cas_option(struct push_cas_option *cas)
 {
 	int i;
 
diff --git a/remote.h b/remote.h
index a58713f20a..ad4513f639 100644
--- a/remote.h
+++ b/remote.h
@@ -409,6 +409,7 @@ struct push_cas_option {
 };
 
 int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
+void clear_cas_option(struct push_cas_option *);
 
 int is_empty_cas(const struct push_cas_option *);
 void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
-- 
2.46.2.1011.gf1f9323e02

