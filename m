Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B227310C4
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:11:28 -0800 (PST)
Received: (qmail 9837 invoked by uid 109); 7 Dec 2023 07:11:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:11:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 861 invoked by uid 111); 7 Dec 2023 07:11:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:11:32 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:11:27 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: [PATCH 4/7] help: handle NULL value for alias.* config
Message-ID: <20231207071127.GD1276005@coredump.intra.peff.net>
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

When showing all config with "git help --all", we print the list of
defined aliases. But our config callback to do so does not check for a
NULL value, meaning a config block like:

  [alias]
  foo

will cause us to segfault. We should detect and complain about this in
the usual way.

Since this command is purely informational (and we aren't trying to run
the alias), we could perhaps just generate a warning and continue. But
this sort of misconfiguration should be pretty rare, and the error
message we will produce points directly to the line of config that needs
to be fixed. So just generating the usual error should be OK.

Signed-off-by: Jeff King <peff@peff.net>
---
 help.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 6d2ebfbd2a..2dbe57b413 100644
--- a/help.c
+++ b/help.c
@@ -464,8 +464,11 @@ static int get_alias(const char *var, const char *value,
 {
 	struct string_list *list = data;
 
-	if (skip_prefix(var, "alias.", &var))
+	if (skip_prefix(var, "alias.", &var)) {
+		if (!value)
+			return config_error_nonbool(var);
 		string_list_append(list, var)->util = xstrdup(value);
+	}
 
 	return 0;
 }
-- 
2.43.0.664.ga12c899002

