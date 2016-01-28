From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/9] clone: handle config errors in cmd_clone
Date: Thu, 28 Jan 2016 10:00:32 +0100
Message-ID: <1453971637-22273-5-git-send-email-ps@pks.im>
References: <1453971637-22273-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 10:01:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOiS7-0007A6-8S
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 10:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136AbcA1JBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 04:01:12 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34967 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755189AbcA1JAq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 04:00:46 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id BF40121F16
	for <git@vger.kernel.org>; Thu, 28 Jan 2016 04:00:45 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 28 Jan 2016 04:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=gbNo
	W+WdR7tKPC0M11+qRKFnPKk=; b=oi1Pion6XuRQOUeV3tj/7dSkeUoe8hXBGzUG
	FxkaObuJK/Dbf0UE9FZ79bgGdbyogIT9aen0TrC1IzyvdwgefZVmxGNr3OK9VMhD
	0hHio4R6K3h0J9Daiq11TFqxVN5zeMGy8zBBzM+rOy3xl5Cwr9MWeHZoq8fyEn9z
	KHDzcdM=
X-Sasl-enc: bAjszBiv2xup8UiMHZCYf9/kBMDAr0z3jDL8e0P/oS5J 1453971645
Received: from localhost (f052174253.adsl.alicedsl.de [78.52.174.253])
	by mail.messagingengine.com (Postfix) with ESMTPA id 398F76800D1;
	Thu, 28 Jan 2016 04:00:45 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1453971637-22273-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285001>

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
index 8b11650..5f6f995 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -788,12 +788,12 @@ static void write_refspec_config(const char *src_ref_prefix,
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
@@ -951,14 +951,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
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
