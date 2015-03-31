From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] remote.c: drop default_remote_name variable
Date: Tue, 31 Mar 2015 13:34:38 -0400
Message-ID: <20150331173437.GA18912@peff.net>
References: <20150331173339.GA17732@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 19:34:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd03q-0003Gb-OW
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 19:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbbCaRem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 13:34:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:40406 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755101AbbCaRek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 13:34:40 -0400
Received: (qmail 16691 invoked by uid 102); 31 Mar 2015 17:34:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 12:34:40 -0500
Received: (qmail 25476 invoked by uid 107); 31 Mar 2015 17:34:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 13:34:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 13:34:38 -0400
Content-Disposition: inline
In-Reply-To: <20150331173339.GA17732@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266533>

When we read the remote config from disk, we update a
default_remote_name variable if we see branch.*.remote
config for the current branch. This isn't wrong, or even all
that complicated, but it is a bit simpler (because it
reduces our overall state) to just lazily compute the
default when we need it.

The ulterior motive here is that the push config uses a
similar structure, and _is_ much more complicated as a
result. That will be simplified in a future patch, and it's
more readable if the logic remotes and push-remotes matches.

Note that we also used default_remote_name as a signal that
the remote config has been loaded; after this patch, we now
use an explicit flag.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/remote.c b/remote.c
index 68901b0..fcd868d 100644
--- a/remote.c
+++ b/remote.c
@@ -39,6 +39,8 @@ struct rewrites {
 	int rewrite_nr;
 };
 
+static int loaded_remotes_config;
+
 static struct remote **remotes;
 static int remotes_alloc;
 static int remotes_nr;
@@ -49,10 +51,8 @@ static int branches_alloc;
 static int branches_nr;
 
 static struct branch *current_branch;
-static const char *default_remote_name;
 static const char *branch_pushremote_name;
 static const char *pushremote_name;
-static int explicit_default_remote_name;
 
 static struct rewrites rewrites;
 static struct rewrites rewrites_push;
@@ -367,12 +367,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 			return 0;
 		branch = make_branch(name, subkey - name);
 		if (!strcmp(subkey, ".remote")) {
-			if (git_config_string(&branch->remote_name, key, value))
-				return -1;
-			if (branch == current_branch) {
-				default_remote_name = branch->remote_name;
-				explicit_default_remote_name = 1;
-			}
+			return git_config_string(&branch->remote_name, key, value);
 		} else if (!strcmp(subkey, ".pushremote")) {
 			if (branch == current_branch)
 				if (git_config_string(&branch_pushremote_name, key, value))
@@ -504,9 +499,11 @@ static void read_config(void)
 	unsigned char sha1[20];
 	const char *head_ref;
 	int flag;
-	if (default_remote_name) /* did this already */
+
+	if (loaded_remotes_config)
 		return;
-	default_remote_name = "origin";
+	loaded_remotes_config = 1;
+
 	current_branch = NULL;
 	head_ref = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
@@ -708,8 +705,11 @@ static struct remote *remote_get_1(const char *name, const char *pushremote_name
 			name = pushremote_name;
 			name_given = 1;
 		} else {
-			name = default_remote_name;
-			name_given = explicit_default_remote_name;
+			if (current_branch && current_branch->remote_name) {
+				name = current_branch->remote_name;
+				name_given = 1;
+			} else
+				name = "origin";
 		}
 	}
 
-- 
2.4.0.rc0.363.gf9f328b
