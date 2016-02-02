From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 09/15] remote: die on config error when manipulating remotes
Date: Tue,  2 Feb 2016 12:51:50 +0100
Message-ID: <1454413916-31984-10-git-send-email-ps@pks.im>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 12:53:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQZWP-0007Yq-Ac
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 12:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972AbcBBLxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 06:53:21 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55186 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754854AbcBBLxR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 06:53:17 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 10D8220629
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 06:53:17 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 02 Feb 2016 06:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=+oeu
	Ux6Cvge0Rqn9KZXNnRO+Mvg=; b=h1U8t+KPJ5RFFgC0qdFmtJnOwOyK78VnJKRC
	0spSbSf/Qp0KZGfMF9Wo/tZAmj40G2C7gy76y38OGLIdeHnAzfLl+UMY+Dg6xb/g
	klcp6+OvpUWJGQAPO1m12SYpL4XAoW+Cp4QbA93SgcDCWB93/F4aWOis++lTVmcV
	mGpd730=
X-Sasl-enc: vXpveNZCut6F/0Zz2UPvTluKO3TT9ltwvg618CoB0uHM 1454413996
Received: from localhost (f052008117.adsl.alicedsl.de [78.52.8.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id 90A3D680173;
	Tue,  2 Feb 2016 06:53:16 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454413916-31984-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285259>

When manipulating remotes we try to set various configuration
values without checking if the values were persisted correctly,
possibly leaving the remote in an inconsistent state.

Fix this issue by dying early and notifying the user about the
error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index eeb6d2e..fe57f77 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -197,8 +197,7 @@ static int add(int argc, const char **argv)
 		die(_("'%s' is not a valid remote name"), name);
 
 	strbuf_addf(&buf, "remote.%s.url", name);
-	if (git_config_set(buf.buf, url))
-		return 1;
+	git_config_set_or_die(buf.buf, url);
 
 	if (!mirror || mirror & MIRROR_FETCH) {
 		strbuf_reset(&buf);
@@ -214,16 +213,14 @@ static int add(int argc, const char **argv)
 	if (mirror & MIRROR_PUSH) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.mirror", name);
-		if (git_config_set(buf.buf, "true"))
-			return 1;
+		git_config_set_or_die(buf.buf, "true");
 	}
 
 	if (fetch_tags != TAGS_DEFAULT) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.tagopt", name);
-		if (git_config_set(buf.buf,
-			fetch_tags == TAGS_SET ? "--tags" : "--no-tags"))
-			return 1;
+		git_config_set_or_die(buf.buf,
+				      fetch_tags == TAGS_SET ? "--tags" : "--no-tags");
 	}
 
 	if (fetch && fetch_remote(name))
@@ -591,25 +588,20 @@ static int migrate_file(struct remote *remote)
 
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
 	for (i = 0; i < remote->url_nr; i++)
-		if (git_config_set_multivar(buf.buf, remote->url[i], "^$", 0))
-			return error(_("Could not append '%s' to '%s'"),
-					remote->url[i], buf.buf);
+		git_config_set_multivar_or_die(buf.buf, remote->url[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
 	for (i = 0; i < remote->push_refspec_nr; i++)
-		if (git_config_set_multivar(buf.buf, remote->push_refspec[i], "^$", 0))
-			return error(_("Could not append '%s' to '%s'"),
-					remote->push_refspec[i], buf.buf);
+		git_config_set_multivar_or_die(buf.buf, remote->push_refspec[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
 	for (i = 0; i < remote->fetch_refspec_nr; i++)
-		if (git_config_set_multivar(buf.buf, remote->fetch_refspec[i], "^$", 0))
-			return error(_("Could not append '%s' to '%s'"),
-					remote->fetch_refspec[i], buf.buf);
+		git_config_set_multivar_or_die(buf.buf, remote->fetch_refspec[i], "^$", 0);
 	if (remote->origin == REMOTE_REMOTES)
 		unlink_or_warn(git_path("remotes/%s", remote->name));
 	else if (remote->origin == REMOTE_BRANCHES)
 		unlink_or_warn(git_path("branches/%s", remote->name));
+
 	return 0;
 }
 
@@ -656,8 +648,7 @@ static int mv(int argc, const char **argv)
 
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
-	if (git_config_set_multivar(buf.buf, NULL, NULL, 1))
-		return error(_("Could not remove config section '%s'"), buf.buf);
+	git_config_set_multivar_or_die(buf.buf, NULL, NULL, 1);
 	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old);
 	for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
 		char *ptr;
@@ -677,8 +668,7 @@ static int mv(int argc, const char **argv)
 				  "\tPlease update the configuration manually if necessary."),
 				buf2.buf);
 
-		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
-			return error(_("Could not append '%s'"), buf.buf);
+		git_config_set_multivar_or_die(buf.buf, buf2.buf, "^$", 0);
 	}
 
 	read_branches();
@@ -688,9 +678,7 @@ static int mv(int argc, const char **argv)
 		if (info->remote_name && !strcmp(info->remote_name, rename.old)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
-			if (git_config_set(buf.buf, rename.new)) {
-				return error(_("Could not set '%s'"), buf.buf);
-			}
+			git_config_set_or_die(buf.buf, rename.new);
 		}
 	}
 
@@ -788,10 +776,7 @@ static int rm(int argc, const char **argv)
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "branch.%s.%s",
 						item->string, *k);
-				if (git_config_set(buf.buf, NULL)) {
-					strbuf_release(&buf);
-					return -1;
-				}
+				git_config_set_or_die(buf.buf, NULL);
 			}
 		}
 	}
-- 
2.7.0
