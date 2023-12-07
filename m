Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A9C137
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:24:59 -0800 (PST)
Received: (qmail 10012 invoked by uid 109); 7 Dec 2023 07:24:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:24:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1080 invoked by uid 111); 7 Dec 2023 07:25:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:25:03 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:24:58 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 3/9] imap-send: don't use git_die_config() inside callback
Message-ID: <20231207072458.GC1277973@coredump.intra.peff.net>
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

The point of git_die_config() is to let configset users mention the
file/line info for invalid config, like:

  if (!git_config_get_int("foo.bar", &value)) {
	if (!is_ok(value))
		git_die_config("foo.bar");
  }

Using it from within a config callback is unnecessary, because we can
simply return an error, at which point the config machinery will mention
the file/line of the offending variable. Worse, using git_die_config()
can actually produce the wrong location when the key is found in
multiple spots. For instance, with config like:

  [imap]
  host
  host = foo

we'll report the line number of the "host = foo" line, but the problem
is on the implicit-bool "host" line.

We can fix it by just returning an error code.

Signed-off-by: Jeff King <peff@peff.net>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 996651e4f8..5b0fe4f95a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1346,7 +1346,7 @@ static int git_imap_config(const char *var, const char *val,
 		server.port = git_config_int(var, val, ctx->kvi);
 	else if (!strcmp("imap.host", var)) {
 		if (!val) {
-			git_die_config("imap.host", "Missing value for 'imap.host'");
+			return error("Missing value for 'imap.host'");
 		} else {
 			if (starts_with(val, "imap:"))
 				val += 5;
-- 
2.43.0.664.ga12c899002

