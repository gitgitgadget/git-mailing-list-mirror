Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA36D57
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:11:31 -0800 (PST)
Received: (qmail 9843 invoked by uid 109); 7 Dec 2023 07:11:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 07:11:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 865 invoked by uid 111); 7 Dec 2023 07:11:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 02:11:34 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 02:11:29 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: [PATCH 5/7] submodule: handle NULL value when parsing
 submodule.*.branch
Message-ID: <20231207071129.GE1276005@coredump.intra.peff.net>
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

We record the submodule branch config value as a string, so config that
uses an implicit bool like:

  [submodule "foo"]
  branch

will cause us to segfault. Note that unlike most other config-parsing
bugs of this class, this can be triggered by parsing a bogus .gitmodules
file (which we might do after cloning a malicious repository).

I don't think the security implications are important, though. It's
always a strict NULL dereference, not an out-of-bounds read or write. So
we should reliably kill the process. That may be annoying, but the
impact is limited to the attacker preventing the victim from
successfully using "git clone --recurse-submodules", etc, on the
malicious repo.

The "branch" entry is the only one with this problem; other strings like
"path" and "url" already check for NULL.

Signed-off-by: Jeff King <peff@peff.net>
---
 submodule-config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/submodule-config.c b/submodule-config.c
index 6a48fd12f6..f4dd482abc 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -516,7 +516,9 @@ static int parse_config(const char *var, const char *value,
 			submodule->recommend_shallow =
 				git_config_bool(var, value);
 	} else if (!strcmp(item.buf, "branch")) {
-		if (!me->overwrite && submodule->branch)
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite && submodule->branch)
 			warn_multiple_config(me->treeish_name, submodule->name,
 					     "branch");
 		else {
-- 
2.43.0.664.ga12c899002

