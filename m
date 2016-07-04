Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3A621006
	for <e@80x24.org>; Mon,  4 Jul 2016 06:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbcGDGFc (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 02:05:32 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:57483 "EHLO
	homiemail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750898AbcGDGFb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2016 02:05:31 -0400
Received: from homiemail-a18.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a18.g.dreamhost.com (Postfix) with ESMTP id B784D258064;
	Sun,  3 Jul 2016 23:05:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id; s=novalis.org; bh=6gpwa19YI5OXCLocuxYw
	I0J/7oM=; b=AavcBzDtO3ECXr7ByS3sbaH8eW7iJxZcvf4C1y7E24h782VnncU8
	WQm+EAUnfU1hsX8uDjsH3eeMUNS0XDuLOw2oK+uxytB1jvGVaq1W74JKataHoMSG
	wrYyr339hDwt15aHW22xsAKdRuN1GoceBJLLGSH91doBxBHFdFm/G34=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a18.g.dreamhost.com (Postfix) with ESMTPSA id 16362258062;
	Sun,  3 Jul 2016 23:05:29 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v14 20/21] index-helper: indexhelper.exitAfter config
Date:	Mon,  4 Jul 2016 02:05:23 -0400
Message-Id: <1467612324-23556-1-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.11.g9232872.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

Add a configuration variable, indexhelper.exitAfter, which provides a
default time to keep the index-helper alive.  This is useful with
indexhelper.autorun; some users will want to keep the
automatically-run index-helper alive across their lunch break and will
thus set indexhelper.exitAfter to a high value.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 4 ++++
 index-helper.c           | 2 ++
 t/t7900-index-helper.sh  | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 385ea66..a6330b1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1860,6 +1860,10 @@ indexhelper.autorun::
 	Automatically run git index-helper when any builtin git
 	command is run inside a repository.
 
+indexhelper.exitAfter::
+	When no exit-after argument is given, git index-helper defaults
+	to this number of seconds. Specify 0 to wait forever. Default is 600.
+
 init.templateDir::
 	Specify the directory from which templates will be copied.
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
diff --git a/index-helper.c b/index-helper.c
index af35485..7e62425 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -399,6 +399,8 @@ int main(int argc, char **argv)
 	git_extract_argv0_path(argv[0]);
 	git_setup_gettext();
 
+	git_config_get_int("indexhelper.exitafter", &idle_in_seconds);
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(usage_text, options);
 
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 15ba612..12b5bf7 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -68,4 +68,12 @@ test_expect_success 'index-helper autorun works' '
 	test_path_is_missing .git/index-helper.sock
 '
 
+test_expect_success 'indexhelper.exitafter config works' '
+	test_when_finished "git index-helper --kill" &&
+	test_config indexhelper.exitafter 1 &&
+	git index-helper --detach &&
+	sleep 3 &&
+	test_path_is_missing .git/index-helper.sock
+'
+
 test_done
-- 
1.9.1

