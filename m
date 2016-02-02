From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 08/15] remote: die on config error when setting/adding branches
Date: Tue,  2 Feb 2016 12:51:49 +0100
Message-ID: <1454413916-31984-9-git-send-email-ps@pks.im>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 12:53:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQZWK-0007Sf-Lp
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 12:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbcBBLxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 06:53:17 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38130 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754854AbcBBLxQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 06:53:16 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id BA96D20615
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 06:53:15 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 02 Feb 2016 06:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=qgpu
	/KuhAI/N1j1X01Eltu0qi7I=; b=mEm3NtxGbgqHbA9Prp87netWojZ5uCs/5Skn
	BGGZ+3nWoOBeEAoh64dYlVCs/aUKUBY2JWn3XWfubwyxjR4sfnGKJmu4i74VBltm
	UQEp7CXUMrTQVuqwtORK/Fl0MauyP0WRLHn9y2d7YOd+8rktShFTzgSOStR/dt3c
	RAIlz6A=
X-Sasl-enc: 8Xdlj/DRzSZccR38BfuK629yuIridZ2oJEQX3HNrCARd 1454413995
Received: from localhost (f052008117.adsl.alicedsl.de [78.52.8.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id 22352C0001A;
	Tue,  2 Feb 2016 06:53:15 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454413916-31984-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285257>

When we add or set new branches (e.g. by `git remote add -f` or
`git remote set-branches`) we do not check for error codes when
writing the branches to the configuration file. When persisting
the configuration failed we are left with a remote that has none
or not all of the branches that should have been set without
notifying the user.

Fix this issue by dying early on configuration error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 8b78c3d..eeb6d2e 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -108,8 +108,8 @@ enum {
 #define MIRROR_PUSH 2
 #define MIRROR_BOTH (MIRROR_FETCH|MIRROR_PUSH)
 
-static int add_branch(const char *key, const char *branchname,
-		const char *remotename, int mirror, struct strbuf *tmp)
+static void add_branch(const char *key, const char *branchname,
+		       const char *remotename, int mirror, struct strbuf *tmp)
 {
 	strbuf_reset(tmp);
 	strbuf_addch(tmp, '+');
@@ -119,7 +119,7 @@ static int add_branch(const char *key, const char *branchname,
 	else
 		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
 				branchname, remotename, branchname);
-	return git_config_set_multivar(key, tmp->buf, "^$", 0);
+	git_config_set_multivar_or_die(key, tmp->buf, "^$", 0);
 }
 
 static const char mirror_advice[] =
@@ -206,9 +206,8 @@ static int add(int argc, const char **argv)
 		if (track.nr == 0)
 			string_list_append(&track, "*");
 		for (i = 0; i < track.nr; i++) {
-			if (add_branch(buf.buf, track.items[i].string,
-				       name, mirror, &buf2))
-				return 1;
+			add_branch(buf.buf, track.items[i].string,
+				   name, mirror, &buf2);
 		}
 	}
 
@@ -1416,21 +1415,17 @@ static int remove_all_fetch_refspecs(const char *remote, const char *key)
 	return git_config_set_multivar(key, NULL, NULL, 1);
 }
 
-static int add_branches(struct remote *remote, const char **branches,
-			const char *key)
+static void add_branches(struct remote *remote, const char **branches,
+			 const char *key)
 {
 	const char *remotename = remote->name;
 	int mirror = remote->mirror;
 	struct strbuf refspec = STRBUF_INIT;
 
 	for (; *branches; branches++)
-		if (add_branch(key, *branches, remotename, mirror, &refspec)) {
-			strbuf_release(&refspec);
-			return 1;
-		}
+		add_branch(key, *branches, remotename, mirror, &refspec);
 
 	strbuf_release(&refspec);
-	return 0;
 }
 
 static int set_remote_branches(const char *remotename, const char **branches,
@@ -1449,10 +1444,7 @@ static int set_remote_branches(const char *remotename, const char **branches,
 		strbuf_release(&key);
 		return 1;
 	}
-	if (add_branches(remote, branches, key.buf)) {
-		strbuf_release(&key);
-		return 1;
-	}
+	add_branches(remote, branches, key.buf);
 
 	strbuf_release(&key);
 	return 0;
-- 
2.7.0
