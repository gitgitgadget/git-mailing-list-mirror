Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEC5D7E
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:11:33 -0800 (PST)
Received: (qmail 9849 invoked by uid 109); 7 Dec 2023 07:11:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:11:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 869 invoked by uid 111); 7 Dec 2023 07:11:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:11:37 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:11:32 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: [PATCH 6/7] trailer: handle NULL value when parsing trailer-specific
 config
Message-ID: <20231207071132.GF1276005@coredump.intra.peff.net>
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

When parsing the "key", "command", and "cmd" trailer config, we just
make a copy of the value string.  If we see an implicit bool like:

  [trailer "foo"]
  key

we'll segfault trying to copy a NULL pointer. We can fix this with the
usual config_error_nonbool() check.

I split this out from the other vanilla cases, because at first glance
it looks like a better fix here would be to move the NULL check out of
the switch statement. But it would change the behavior of other keys
like trailer.*.ifExists, where an implicit bool is interpreted as
EXISTS_DEFAULT.

Signed-off-by: Jeff King <peff@peff.net>
---
 trailer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/trailer.c b/trailer.c
index b0e2ec224a..e4b08ed267 100644
--- a/trailer.c
+++ b/trailer.c
@@ -553,16 +553,22 @@ static int git_trailer_config(const char *conf_key, const char *value,
 	case TRAILER_KEY:
 		if (conf->key)
 			warning(_("more than one %s"), conf_key);
+		if (!value)
+			return config_error_nonbool(conf_key);
 		conf->key = xstrdup(value);
 		break;
 	case TRAILER_COMMAND:
 		if (conf->command)
 			warning(_("more than one %s"), conf_key);
+		if (!value)
+			return config_error_nonbool(conf_key);
 		conf->command = xstrdup(value);
 		break;
 	case TRAILER_CMD:
 		if (conf->cmd)
 			warning(_("more than one %s"), conf_key);
+		if (!value)
+			return config_error_nonbool(conf_key);
 		conf->cmd = xstrdup(value);
 		break;
 	case TRAILER_WHERE:
-- 
2.43.0.664.ga12c899002

