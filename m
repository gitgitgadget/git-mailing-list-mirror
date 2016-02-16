From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 10/15] clone: die on config error in cmd_clone
Date: Tue, 16 Feb 2016 13:56:37 +0100
Message-ID: <1455627402-752-11-git-send-email-ps@pks.im>
References: <1455627402-752-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 13:59:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfDt-0003ZE-Fs
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 13:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbcBPM5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 07:57:08 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41200 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932067AbcBPM5E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 07:57:04 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id CFEFA20B24
	for <git@vger.kernel.org>; Tue, 16 Feb 2016 07:57:03 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 16 Feb 2016 07:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=SRd7
	w6BwWj5Ov4UsIWdAWgc8Xao=; b=QOBeJXXFmB4JjWw7MPNp4uVf2sxTq/AZKSkf
	T6+ysBgHmMk8uZIRDHNc9g0K5rYI4wxbdmxpqJ+YfOIuC6PRWT+J9q7LQJP9ipA5
	e6fLWet2PU9glWlMBdvgtaWtOsMGtzFjnvlUYHdsSL1Uedp/RV8fCosKT1Ys8MIB
	e3SCnpI=
X-Sasl-enc: PstFqxC61TMOl+jtnnetkGL/APIxOF3qWFkC4fvKzOUA 1455627423
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 526F1C00014;
	Tue, 16 Feb 2016 07:57:03 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455627402-752-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286348>

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
index bcba080..164038a 100644
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
2.7.1
