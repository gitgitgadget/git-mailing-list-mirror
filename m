From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] free ref string returned by dwim_ref
Date: Thu, 24 Jul 2014 00:41:11 -0400
Message-ID: <20140724044111.GB32355@peff.net>
References: <20140724043940.GA31282@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 06:41:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAAqJ-0002fA-AS
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 06:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934076AbaGXElT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 00:41:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:39356 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934043AbaGXElT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 00:41:19 -0400
Received: (qmail 20565 invoked by uid 102); 24 Jul 2014 04:41:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jul 2014 23:41:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jul 2014 00:41:11 -0400
Content-Disposition: inline
In-Reply-To: <20140724043940.GA31282@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254145>

A call to "dwim_ref(name, len, flags, &ref)" will allocate a
new string in "ref" to return the exact ref we found. We do
not consistently free it in all code paths, leading to small
leaks. The worst is in get_sha1_basic, which may be called
many times (e.g., by "cat-file --batch"), though it is
relatively unlikely, as it only triggers on a bogus reflog
specification.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-parse.c   | 1 +
 builtin/show-branch.c | 1 +
 sha1_name.c           | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8102aaa..d85e08c 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -151,6 +151,7 @@ static void show_rev(int type, const unsigned char *sha1, const char *name)
 				error("refname '%s' is ambiguous", name);
 				break;
 			}
+			free(full);
 		} else {
 			show_with_type(type, name);
 		}
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 5fd4e4e..298c95e 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -777,6 +777,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			sprintf(nth_desc, "%s@{%d}", *av, base+i);
 			append_ref(nth_desc, sha1, 1);
 		}
+		free(ref);
 	}
 	else if (all_heads + all_remotes)
 		snarf_refs(all_heads, all_remotes);
diff --git a/sha1_name.c b/sha1_name.c
index 6ccd3a5..63ee66f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -540,8 +540,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 			char *tmp = xstrndup(str + at + 2, reflog_len);
 			at_time = approxidate_careful(tmp, &errors);
 			free(tmp);
-			if (errors)
+			if (errors) {
+				free(real_ref);
 				return -1;
+			}
 		}
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
-- 
2.0.0.566.gfe3e6b2
