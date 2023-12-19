Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC9A38F87
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OU3nUxi4"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2701026D8A;
	Tue, 19 Dec 2023 14:26:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=R
	Vya5hw166L5wNXjr6fv4II9AJdEYufcWBfjpk9fuGc=; b=OU3nUxi4yNuGEb6xq
	+2HhktiiWrgU036daS0qXOnO0HIkSkDSO1FxVdFkQEIZ7tMOA+lvLeYwzySnsY8Q
	F5HuRsaRra5mShmrQYBZMS5wXUNJL4Dzk0/fKERM5XsLE8d/dhhMvpsAQPEFvVZY
	wR+F5a2HqRHCqzGejPFSRE/TWA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F79F26D89;
	Tue, 19 Dec 2023 14:26:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BDB7526D88;
	Tue, 19 Dec 2023 14:26:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] remote.h: retire CAS_OPT_NAME
Date: Tue, 19 Dec 2023 11:26:25 -0800
Message-ID: <xmqq5y0uc7tq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 80CE4A6A-9EA4-11EE-A6BD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

When the "--force-with-lease" option was introduced in 28f5d176
(remote.c: add command line option parser for "--force-with-lease",
2013-07-08), the design discussion revolved around the concept of
"compare-and-swap", and it can still be seen in the name used for
variables and helper functions.  The end-user facing option name
ended up to be a bit different, so during the development iteration
of the feature, we used this C preprocessor macro to make it easier
to rename it later.

All of that happened more than 10 years ago, and the flexibility
afforded by the CAS_OPT_NAME macro outlived its usefulness.  Inline
the constant string for the option name, like all other option names
in the code.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c      | 4 ++--
 builtin/send-pack.c | 2 +-
 remote.h            | 2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index dbdf609daf..e740dd93e3 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -393,7 +393,7 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 	if (!is_empty_cas(&cas)) {
 		if (!transport->smart_options)
 			die("underlying transport does not support --%s option",
-			    CAS_OPT_NAME);
+			    "force-with-lease");
 		transport->smart_options->cas = &cas;
 	}
 
@@ -604,7 +604,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT('n' , "dry-run", &flags, N_("dry run"), TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
-		OPT_CALLBACK_F(0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
+		OPT_CALLBACK_F(0, "force-with-lease", &cas, N_("<refname>:<expect>"),
 			       N_("require old value of ref to be at this value"),
 			       PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option),
 		OPT_BIT(0, TRANS_OPT_FORCE_IF_INCLUDES, &flags,
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4784143004..87e5269e9f 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -207,7 +207,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "stateless-rpc", &stateless_rpc, N_("use stateless RPC protocol")),
 		OPT_BOOL(0, "stdin", &from_stdin, N_("read refs from stdin")),
 		OPT_BOOL(0, "helper-status", &helper_status, N_("print status from remote helper")),
-		OPT_CALLBACK_F(0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
+		OPT_CALLBACK_F(0, "force-with-lease", &cas, N_("<refname>:<expect>"),
 		  N_("require old value of ref to be at this value"),
 		  PARSE_OPT_OPTARG, parseopt_push_cas_option),
 		OPT_BOOL(0, TRANS_OPT_FORCE_IF_INCLUDES, &force_if_includes,
diff --git a/remote.h b/remote.h
index 73638cefeb..9ba7f7d3e2 100644
--- a/remote.h
+++ b/remote.h
@@ -398,8 +398,6 @@ struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map);
 /*
  * Compare-and-swap
  */
-#define CAS_OPT_NAME "force-with-lease"
-
 struct push_cas_option {
 	unsigned use_tracking_for_rest:1;
 	unsigned use_force_if_includes:1;
-- 
2.43.0-121-g624eb90fa8

