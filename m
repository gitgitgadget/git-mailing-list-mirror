From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 10/15] clone: die on config error in cmd_clone
Date: Tue,  2 Feb 2016 12:51:51 +0100
Message-ID: <1454413916-31984-11-git-send-email-ps@pks.im>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 12:53:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQZWb-0007mg-Rq
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 12:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbcBBLxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 06:53:20 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55635 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754957AbcBBLxT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 06:53:19 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 867FC2069A
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 06:53:18 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 02 Feb 2016 06:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=lLsS
	JR6w2MIFwJ/znWDlrmv4ues=; b=P/b6M7PZ+Cm4LzcjZwRZfvhSwj3UKdc7gseN
	QMcNcbUz5GpK7HiIKvtjZm6OEWVv0I5CgIhw+T7RRqXwDabUlh9ZjctqUisMel+1
	3pMuzS5Kid7E6dXoWXV2YzOEmfkj1l8x0lPWGWdaF73hk/rX0vN0kRIaUDDSs7BR
	I8S8WdM=
X-Sasl-enc: r6LQyu5H/5A3cWhimqIKZBlQt8fd0PmbEk4B1DY63Wq5 1454413997
Received: from localhost (f052008117.adsl.alicedsl.de [78.52.8.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id DC637C0001B;
	Tue,  2 Feb 2016 06:53:17 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454413916-31984-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285264>

The clone command does not check for error codes returned by
`git_config_set` functions. This may cause the user to end up
with an inconsistent repository without any indication with what
went wrong.

Fix this problem by dying with an error message when we are
unable to write the configuration files to disk.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 81e238f..f2a2f9a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -786,12 +786,12 @@ static void write_refspec_config(const char *src_ref_prefix,
 		/* Configure the remote */
 		if (value.len) {
 			strbuf_addf(&key, "remote.%s.fetch", option_origin);
-			git_config_set_multivar(key.buf, value.buf, "^$", 0);
+			git_config_set_multivar_or_die(key.buf, value.buf, "^$", 0);
 			strbuf_reset(&key);
 
 			if (option_mirror) {
 				strbuf_addf(&key, "remote.%s.mirror", option_origin);
-				git_config_set(key.buf, "true");
+				git_config_set_or_die(key.buf, "true");
 				strbuf_reset(&key);
 			}
 		}
@@ -949,14 +949,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			src_ref_prefix = "refs/";
 		strbuf_addstr(&branch_top, src_ref_prefix);
 
-		git_config_set("core.bare", "true");
+		git_config_set_or_die("core.bare", "true");
 	} else {
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
 	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
 	strbuf_addf(&key, "remote.%s.url", option_origin);
-	git_config_set(key.buf, repo);
+	git_config_set_or_die(key.buf, repo);
 	strbuf_reset(&key);
 
 	if (option_reference.nr)
-- 
2.7.0
