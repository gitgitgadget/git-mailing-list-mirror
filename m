From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/9] remote: handle config errors in set_url
Date: Thu, 28 Jan 2016 10:00:31 +0100
Message-ID: <1453971637-22273-4-git-send-email-ps@pks.im>
References: <1453971637-22273-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 10:00:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOiRh-0006rD-Al
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 10:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933578AbcA1JAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 04:00:49 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41653 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755207AbcA1JAp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 04:00:45 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 5DF8E21EE9
	for <git@vger.kernel.org>; Thu, 28 Jan 2016 04:00:44 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 28 Jan 2016 04:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Un40
	Fk7ptpo16QQF+yc1u4eduM0=; b=E68tjETcGLpESaH8JkwWjCgWKub2yzTx9elC
	jkmrvIntNfKH6U5qc3Xf3ywOEdIg8S8QJmWngDcDbP77r7C7/b29NEnz1TapMkyT
	x/Suw/TmcpyCFSOrKLDtT3OG18laeStz3fKQtOd75ywGjIrsMA23nPN2evWKTJ1l
	DjF6OoQ=
X-Sasl-enc: y5mrktAVdSOMO7o73vlrRd1LE6zgWc+g1oWXWcLhCo2d 1453971643
Received: from localhost (f052174253.adsl.alicedsl.de [78.52.174.253])
	by mail.messagingengine.com (Postfix) with ESMTPA id EA417C00012;
	Thu, 28 Jan 2016 04:00:43 -0500 (EST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1453971637-22273-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284994>

The return codes for function calls that write the new URL
configuration are not being checked in `set_url`. As the function
is exposed to the user directly through `git remote set-url` we
want to inform her that we were not able to complete the request
and abort the program.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c  | 11 ++++++-----
 t/t5505-remote.sh |  9 +++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 2b2ff9b..8b78c3d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1583,11 +1583,12 @@ static int set_url(int argc, const char **argv)
 	/* Special cases that add new entry. */
 	if ((!oldurl && !delete_mode) || add_mode) {
 		if (add_mode)
-			git_config_set_multivar(name_buf.buf, newurl,
-				"^$", 0);
+			git_config_set_multivar_or_die(name_buf.buf, newurl,
+						       "^$", 0);
 		else
-			git_config_set(name_buf.buf, newurl);
+			git_config_set_or_die(name_buf.buf, newurl);
 		strbuf_release(&name_buf);
+
 		return 0;
 	}
 
@@ -1608,9 +1609,9 @@ static int set_url(int argc, const char **argv)
 	regfree(&old_regex);
 
 	if (!delete_mode)
-		git_config_set_multivar(name_buf.buf, newurl, oldurl, 0);
+		git_config_set_multivar_or_die(name_buf.buf, newurl, oldurl, 0);
 	else
-		git_config_set_multivar(name_buf.buf, NULL, oldurl, 1);
+		git_config_set_multivar_or_die(name_buf.buf, NULL, oldurl, 1);
 	return 0;
 }
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 1a8e3b8..e019f27 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -932,6 +932,15 @@ test_expect_success 'get-url on new remote' '
 	echo foo | get_url_test --push --all someremote
 '
 
+test_expect_success 'remote set-url with locked config' '
+	test_when_finished "rm -f .git/config.lock" &&
+	git config --get-all remote.someremote.url >expect &&
+	>.git/config.lock &&
+	test_must_fail git remote set-url someremote baz &&
+	git config --get-all remote.someremote.url >actual &&
+	cmp expect actual
+'
+
 test_expect_success 'remote set-url bar' '
 	git remote set-url someremote bar &&
 	echo bar >expect &&
-- 
2.7.0
