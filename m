From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Require a struct remote in transport_get()
Date: Tue, 3 Nov 2009 21:38:51 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911032133540.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 03:38:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Vly-0004dU-Bd
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 03:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbZKDCir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 21:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbZKDCir
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 21:38:47 -0500
Received: from iabervon.org ([66.92.72.58]:41170 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943AbZKDCiq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 21:38:46 -0500
Received: (qmail 22382 invoked by uid 1000); 4 Nov 2009 02:38:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2009 02:38:51 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132024>

cmd_ls_remote() was calling transport_get() with a NULL remote and a
non-NULL url in the case where it was run outside a git
repository. This involved a bunch of ill-tested special
cases. Instead, simply get the struct remote for the URL with
remote_get(), which works fine outside a git repository, and can also
take global options into account.

This fixes a tiny and obscure bug where "git ls-remote" without a repo
didn't support global url.*.insteadOf, even though "git clone" and
"git ls-remote" in any repo did.

Also, enforce that all callers provide a struct remote to transport_get().

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
This is sufficient to stop the segfault when tring "git ls-remote 
http://..." outside of a repo, but not to make it work, which requires 
either something simple but not ideal or something complex.

 builtin-ls-remote.c |    6 +++---
 transport.c         |    7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 78a88f7..b5bad0c 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -86,10 +86,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			pattern[j - i] = p;
 		}
 	}
-	remote = nongit ? NULL : remote_get(dest);
-	if (remote && !remote->url_nr)
+	remote = remote_get(dest);
+	if (!remote->url_nr)
 		die("remote %s has no configured URL", dest);
-	transport = transport_get(remote, remote ? remote->url[0] : dest);
+	transport = transport_get(remote, remote->url[0]);
 	if (uploadpack != NULL)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 
diff --git a/transport.c b/transport.c
index 644a30a..298dc46 100644
--- a/transport.c
+++ b/transport.c
@@ -812,6 +812,9 @@ struct transport *transport_get(struct remote *remote, const char *url)
 {
 	struct transport *ret = xcalloc(1, sizeof(*ret));
 
+	if (!remote)
+		die("No remote provided to transport_get()");
+
 	ret->remote = remote;
 	ret->url = url;
 
@@ -849,10 +852,10 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		data->thin = 1;
 		data->conn = NULL;
 		data->uploadpack = "git-upload-pack";
-		if (remote && remote->uploadpack)
+		if (remote->uploadpack)
 			data->uploadpack = remote->uploadpack;
 		data->receivepack = "git-receive-pack";
-		if (remote && remote->receivepack)
+		if (remote->receivepack)
 			data->receivepack = remote->receivepack;
 	}
 
-- 
1.6.5.2.142.g063c5.dirty
