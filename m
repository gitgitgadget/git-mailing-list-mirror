Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF27137
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:24:06 -0800 (PST)
Received: (qmail 10000 invoked by uid 109); 7 Dec 2023 07:24:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:24:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1039 invoked by uid 111); 7 Dec 2023 07:24:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:24:09 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:24:04 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/9] config: reject bogus values for core.checkstat
Message-ID: <20231207072404.GA1277973@coredump.intra.peff.net>
References: <20231207072338.GA1277727@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207072338.GA1277727@coredump.intra.peff.net>

If you feed nonsense config like:

  git -c core.checkstat=foobar status

we'll silently ignore the unknown value, rather than reporting an error.
This goes all the way back to c08e4d5b5c (Enable minimal stat checking,
2013-01-22).

Detecting and complaining now is technically a backwards-incompatible
change, but I don't think anybody has any reason to use an invalid value
here. There are no historical values we'd want to allow for backwards
compatibility or anything like that. We are better off loudly telling
the user that their config may not be doing what they expect.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.c b/config.c
index 18085c7e38..d997c55e33 100644
--- a/config.c
+++ b/config.c
@@ -1392,6 +1392,9 @@ static int git_default_core_config(const char *var, const char *value,
 			check_stat = 1;
 		else if (!strcasecmp(value, "minimal"))
 			check_stat = 0;
+		else
+			return error(_("invalid value for '%s': '%s'"),
+				     var, value);
 	}
 
 	if (!strcmp(var, "core.quotepath")) {
-- 
2.43.0.664.ga12c899002

