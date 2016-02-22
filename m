From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 07/15] remote: die on config error when setting URL
Date: Mon, 22 Feb 2016 12:23:28 +0100
Message-ID: <1456140216-24169-8-git-send-email-ps@pks.im>
References: <1456140216-24169-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	ps@pks.im, Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Blume <blume.mike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 12:25:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXocI-0001DF-IW
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 12:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbcBVLZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 06:25:19 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40979 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754659AbcBVLYo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 06:24:44 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 433E020C40
	for <git@vger.kernel.org>; Mon, 22 Feb 2016 06:24:43 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 22 Feb 2016 06:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=0WP2
	x0Bl3kvc0Imjlvgre0Xleto=; b=IWAGItfz5+4oBi2gvK3vpZjO//5T4FE0i3Ot
	MN4bYCkx4M0bh13w4yppMI/PkgIpQOTwQP/5j+Qd501zxdF68lIoiZmTfE+z9HOB
	O3XGlvTbIphurn2Acw2NwRX3Xkhf5bStBLpwab4Hawk8EL9/8Cy0RXHh3/rqGHbh
	IgzMrXg=
X-Sasl-enc: Tua/amUA7OdEF7VooStXmziMM+j5KWLiPGFwQ/8s86b5 1456140282
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id C15B2C00016;
	Mon, 22 Feb 2016 06:24:42 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456140216-24169-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286922>

When invoking `git-remote --set-url` we do not check the return
value when writing the actual new URL to the configuration file,
pretending to the user that the configuration has been set while
it was in fact not persisted.

Fix this problem by dying early when setting the config fails.

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
2.7.1
