Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B7E20179
	for <e@80x24.org>; Sun, 26 Jun 2016 17:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbcFZRyy (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 13:54:54 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:54162 "EHLO
	homiemail-a76.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751141AbcFZRyy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2016 13:54:54 -0400
Received: from homiemail-a76.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a76.g.dreamhost.com (Postfix) with ESMTP id 860B045807B;
	Sun, 26 Jun 2016 10:54:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id; s=novalis.org; bh=MwkFnH899/c6XdFnR5Zr
	cV0eh0o=; b=b1O/lzU+1VynXLKN4juYpUGTDctu3QeFyO9r1xVry3nHu77/mZrx
	iOqwSgY2VIDbaKxx8p+YDwA3oCYPTbUXEWWvJ4xHMmQBa6eBUW3h8FfVmErwbcqp
	h9GBuEdaIGlcs5DmE+IybrgIelqTBp0siyPUjZ7RZoOYM9JIcb673dQ=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a76.g.dreamhost.com (Postfix) with ESMTPSA id EBD59458071;
	Sun, 26 Jun 2016 10:54:52 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kamggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v13 20/20] index-helper: indexhelper.exitafter config
Date:	Sun, 26 Jun 2016 13:54:39 -0400
Message-Id: <1466963679-9947-1-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.20.g1d4f562
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

Add a configuration variable, indexhelper.exitafter, which provides a
default time to keep the index-helper alive.  This is useful with
indexhelper.autorun; some users will want to keep the
automatically-run index-helper alive across their lunch break and will
thus set indexhelper.exitafter to a high value.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 4 ++++
 index-helper.c           | 2 ++
 t/t7900-index-helper.sh  | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 385ea66..336d5a2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1860,6 +1860,10 @@ indexhelper.autorun::
 	Automatically run git index-helper when any builtin git
 	command is run inside a repository.
 
+indexhelper.exitafter::
+	When no exit-after argument is given, git index-helper defaults
+	to this number of seconds. Specify 0 to wait forever. Default is 600.
+
 init.templateDir::
 	Specify the directory from which templates will be copied.
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
diff --git a/index-helper.c b/index-helper.c
index f57fc14..a8071ae 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -433,6 +433,8 @@ int main(int argc, char **argv)
 	git_extract_argv0_path(argv[0]);
 	git_setup_gettext();
 
+	git_config_get_int("indexhelper.exitafter", &idle_in_seconds);
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(usage_text, options);
 
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 3cfdf63..6c9b4dd 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -66,4 +66,12 @@ test_expect_success 'index-helper autorun works' '
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

