From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 08/15] remote: die on config error when setting/adding branches
Date: Tue, 16 Feb 2016 13:56:35 +0100
Message-ID: <1455627402-752-9-git-send-email-ps@pks.im>
References: <1455627402-752-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 13:57:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfBq-0001g8-Rg
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 13:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbcBPM5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 07:57:11 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45301 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932210AbcBPM5C (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 07:57:02 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 1D65420A17
	for <git@vger.kernel.org>; Tue, 16 Feb 2016 07:57:01 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 16 Feb 2016 07:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=V9Yb
	TCP0LI8VzNhgxH37+w2Vraw=; b=dP251QAQjmeGaDEzT5SBvh163yincq0cmDwM
	5LEv3nGlrJBdSkBncgI04VCD4F1uDgz4xOmDD0XFhFu9omrmhwruymBig33sDmCs
	NdknMdD3qabUPdBqEQzYcC96nP+jSxG3p8df971i8czed8KNPNFN5ncjNYhKYDCa
	SrDj8oY=
X-Sasl-enc: jYnWDqtamRP2gvkHdURrxhj5s6GAwX/k672pJPGVMTwd 1455627420
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id B1E9EC00018;
	Tue, 16 Feb 2016 07:57:00 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455627402-752-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286344>

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
2.7.1
