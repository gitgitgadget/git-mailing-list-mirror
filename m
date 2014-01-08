From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] branch_get: provide per-branch pushremote pointers
Date: Wed, 8 Jan 2014 04:35:31 -0500
Message-ID: <20140108093531.GD15720@sigill.intra.peff.net>
References: <20140108093338.GA15659@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 10:35:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0pY2-0007zz-O0
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 10:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493AbaAHJfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 04:35:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:57097 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753919AbaAHJfd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 04:35:33 -0500
Received: (qmail 29696 invoked by uid 102); 8 Jan 2014 09:35:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jan 2014 03:35:33 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jan 2014 04:35:31 -0500
Content-Disposition: inline
In-Reply-To: <20140108093338.GA15659@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240202>

When a caller uses branch_get to retrieve a "struct branch",
they get the per-branch remote name and a pointer to the
remote struct. However, they have no way of knowing about
the per-branch pushremote from this interface.

Let's expose that information via fields similar to
"remote" and "remote_name".

We have to do a little refactoring around the configuration
reading here. Instead of pushremote_name being its own
allocated string, it instead becomes a pointer to one of:

  1. The pushremote_name of the current branch, if
     configured.

  2. The globally configured remote.pushdefault, which we
     store separately as pushremote_config_default.

We can then set the branch's "pushremote" field by doing the
normal sequence of config fallback.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 23 +++++++++++++++++++----
 remote.h |  2 ++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index a773004..53e40e0 100644
--- a/remote.c
+++ b/remote.c
@@ -50,6 +50,7 @@ static int branches_nr;
 static struct branch *current_branch;
 static const char *default_remote_name;
 static const char *pushremote_name;
+static const char *pushremote_config_default;
 static int explicit_default_remote_name;
 
 static struct rewrites rewrites;
@@ -351,9 +352,10 @@ static int handle_config(const char *key, const char *value, void *cb)
 				explicit_default_remote_name = 1;
 			}
 		} else if (!strcmp(subkey, ".pushremote")) {
+			if (git_config_string(&branch->pushremote_name, key, value))
+				return -1;
 			if (branch == current_branch)
-				if (git_config_string(&pushremote_name, key, value))
-					return -1;
+				pushremote_name = branch->pushremote_name;
 		} else if (!strcmp(subkey, ".merge")) {
 			if (!value)
 				return config_error_nonbool(key);
@@ -385,8 +387,11 @@ static int handle_config(const char *key, const char *value, void *cb)
 	name = key + 7;
 
 	/* Handle remote.* variables */
-	if (!strcmp(name, "pushdefault"))
-		return git_config_string(&pushremote_name, key, value);
+	if (!strcmp(name, "pushdefault")) {
+		if (git_config_string(&pushremote_config_default, key, value) < 0)
+			return -1;
+		pushremote_name = pushremote_config_default;
+	}
 
 	/* Handle remote.<name>.* variables */
 	if (*name == '/') {
@@ -1560,6 +1565,16 @@ struct branch *branch_get(const char *name)
 			}
 		}
 	}
+
+	if (ret->pushremote_name)
+		ret->pushremote = remote_get(ret->pushremote_name);
+	else if (pushremote_config_default)
+		ret->pushremote = remote_get(pushremote_config_default);
+	else if (ret->remote_name)
+		ret->pushremote = remote_get(ret->remote_name);
+	else
+		ret->pushremote = remote_get("origin");
+
 	return ret;
 }
 
diff --git a/remote.h b/remote.h
index 00c6a76..e5beb30 100644
--- a/remote.h
+++ b/remote.h
@@ -200,6 +200,8 @@ struct branch {
 
 	const char *remote_name;
 	struct remote *remote;
+	const char *pushremote_name;
+	struct remote *pushremote;
 
 	const char **merge_name;
 	struct refspec **merge;
-- 
1.8.5.2.500.g8060133
