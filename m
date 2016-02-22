From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 08/15] remote: die on config error when setting/adding branches
Date: Mon, 22 Feb 2016 12:23:29 +0100
Message-ID: <1456140216-24169-9-git-send-email-ps@pks.im>
References: <1456140216-24169-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 12:24:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXobl-0000f0-PW
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 12:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbcBVLYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 06:24:46 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37156 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754492AbcBVLYp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 06:24:45 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 87C9F20C3F
	for <git@vger.kernel.org>; Mon, 22 Feb 2016 06:24:44 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 22 Feb 2016 06:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=V9Yb
	TCP0LI8VzNhgxH37+w2Vraw=; b=SJrrE6Z4+DOjAURmaY5KLW0lYt/HQh0yPJ4/
	7KUZkE1O1zzDz3gvxdPsH3viGSkn3HkAQxpUCuzfFAH5w0440aujNYvvP04leaJr
	bey6U+y0DgSUHiwTAoKLFTPHs0XR1+sACKmUdCb+5S+K1p4xg/NvOJN7zZVi4+OI
	E8WntGo=
X-Sasl-enc: nWyJgLeanOc3wiaavqZvYX50AAMTjLr7MVaQ00REZYXS 1456140284
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 13B116800FE;
	Mon, 22 Feb 2016 06:24:43 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456140216-24169-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286914>

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
