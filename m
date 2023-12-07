Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F8410CA
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:11:22 -0800 (PST)
Received: (qmail 9825 invoked by uid 109); 7 Dec 2023 07:11:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:11:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 853 invoked by uid 111); 7 Dec 2023 07:11:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:11:26 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:11:21 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: [PATCH 2/7] setup: handle NULL value when parsing extensions
Message-ID: <20231207071121.GB1276005@coredump.intra.peff.net>
References: <20231207071030.GA1275835@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207071030.GA1275835@coredump.intra.peff.net>

The "partialclone" extension config records a string, and hence it is an
error to have an implicit bool like:

  [extensions]
  partialclone

in your config. We should recognize and reject this, rather than
segfaulting (which is the current behavior). Note that it's OK to use
config_error_nonbool() here, even though the return value is an enum. We
explicitly document EXTENSION_ERROR as -1 for compatibility with
error(), etc.

This is the only extension value that has this problem. Most of the
others are bools that interpret this value naturally. The exception is
extensions.objectformat, which does correctly check for NULL.

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/setup.c b/setup.c
index fc592dc6dd..50131be7cc 100644
--- a/setup.c
+++ b/setup.c
@@ -559,6 +559,8 @@ static enum extension_result handle_extension_v0(const char *var,
 			data->precious_objects = git_config_bool(var, value);
 			return EXTENSION_OK;
 		} else if (!strcmp(ext, "partialclone")) {
+			if (!value)
+				return config_error_nonbool(var);
 			data->partial_clone = xstrdup(value);
 			return EXTENSION_OK;
 		} else if (!strcmp(ext, "worktreeconfig")) {
-- 
2.43.0.664.ga12c899002

