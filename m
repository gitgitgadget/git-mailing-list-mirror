Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC4910C7
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:11:25 -0800 (PST)
Received: (qmail 9833 invoked by uid 109); 7 Dec 2023 07:11:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:11:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 857 invoked by uid 111); 7 Dec 2023 07:11:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:11:28 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:11:24 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: [PATCH 3/7] trace2: handle NULL values in tr2_sysenv config callback
Message-ID: <20231207071124.GC1276005@coredump.intra.peff.net>
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

If you have config with an implicit bool like:

  [trace2]
  envvars

we'll segfault, as we unconditionally try to xstrdup() the value. We
should instead detect and complain, as a boolean value has no meaning
here. The same is true for every variable in tr2_sysenv_settings (and
this patch covers them all, as we check them in a loop).

Signed-off-by: Jeff King <peff@peff.net>
---
 trace2/tr2_sysenv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index d3ecac2772..048cdd5438 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -68,6 +68,8 @@ static int tr2_sysenv_cb(const char *key, const char *value,
 
 	for (k = 0; k < ARRAY_SIZE(tr2_sysenv_settings); k++) {
 		if (!strcmp(key, tr2_sysenv_settings[k].git_config_name)) {
+			if (!value)
+				return config_error_nonbool(key);
 			free(tr2_sysenv_settings[k].value);
 			tr2_sysenv_settings[k].value = xstrdup(value);
 			return 0;
-- 
2.43.0.664.ga12c899002

