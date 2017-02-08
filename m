Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC5A81FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 01:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755358AbdBHBKH (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 20:10:07 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33980 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753568AbdBHBKG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 20:10:06 -0500
Received: by mail-pf0-f181.google.com with SMTP id e4so37229794pfg.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 17:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tnebM71V0sbPj36JGqzqjhG0yC2rfOLOem8rUHzBXzM=;
        b=gbnxi091x+UZlal9Qzz9yfsmaGdXeXnkvdRCn/WoG8pS4niM2pPAUiyTGipwpGc8B/
         QqVr0QxSpb3ry+omoHJVj1218IDXOJGaP+/L3xqANAQX8XYJ1PEskAhZwKub6I09VG0J
         kRbCIC8si48TvlFrG6TvCTmmGh83XP1A7je++TxWBL0mI2QQTIXlBmUP1W907qd0UPVg
         3wTsLY283HVCE0okRj6n4X3bGwZLPX88l2L4zm5pAZA2048uR+vVzclPNDHEJY5v92WJ
         ecODLR51SXeFDVjlKqcjfVn/N8ltCijr0Vk20iQDuz5NyTv7yE0Yw3HIKwqdBtI/3Bjw
         6B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tnebM71V0sbPj36JGqzqjhG0yC2rfOLOem8rUHzBXzM=;
        b=FGLwprS5KJ6iUIK8AfeXSDQTv8kl0jasZ/aZ1PEqXrXmdkHOV2E0b2spltN+m+5lgP
         cowzjQLbWLez92UPNKo1o7dNPyEKzZkUpp/skS3TBJlw1DjrlqHfRGg9z4773CfqwHhj
         erwkcF7g6ywaRbtvQaLMZ3iaxwwsQaVmWuTnW4WSqItoTmuOaFnmvFd8NLcUjciwDK2X
         PdrpaN/5H0S32HsaUlUNkeFO3iPK+yI8u8x3WqdTUwCrE/7J8L0qsM1ZmVuRPExuZXsR
         Xg4sjAunPA4AvjZNT9e1qvhfLJaTDXlECZArvZf/qjbpEgaZ+ufRGxHyo6DFTP+fkYGl
         uvHw==
X-Gm-Message-State: AIkVDXK9i0UkcINRDNQLXpl7R7bYW574cmemlSCuHrOSVHTztq4huPPus675eFJrhhklI1m2
X-Received: by 10.84.218.76 with SMTP id f12mr30148244plm.146.1486516205938;
        Tue, 07 Feb 2017 17:10:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6d54:c963:93d3:32c7])
        by smtp.gmail.com with ESMTPSA id m6sm14487941pfm.22.2017.02.07.17.10.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 17:10:05 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] push options: fail properly in the stateless case
Date:   Tue,  7 Feb 2017 17:09:54 -0800
Message-Id: <20170208010954.19478-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.1.g018cb5e6f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using non-builtin protocols relying on a transport helper
(such as http), push options are not propagated to the helper.

Fix this by propagating the push options to the transport helper and
adding a test that push options using http fail properly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/gitremote-helpers.txt |  3 +++
 t/t5545-push-options.sh             | 15 +++++++++++++++
 transport-helper.c                  |  7 +++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 9e8681f9e1..6145d4d8df 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -462,6 +462,9 @@ set by Git if the remote helper has the 'option' capability.
 'option pushcert {'true'|'false'}::
 	GPG sign pushes.
 
+'option push-option <c-string>::
+	Transmit this push option.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index ea813b9383..9a57a7d8f2 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -3,6 +3,8 @@
 test_description='pushing to a repository using push options'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
 
 mk_repo_pair () {
 	rm -rf workbench upstream &&
@@ -100,4 +102,17 @@ test_expect_success 'two push options work' '
 	test_cmp expect upstream/.git/hooks/post-receive.push_options
 '
 
+test_expect_success 'push option denied properly by http remote helper' '\
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions false &&
+	git -C upstream config http.receivepack true &&
+	cp -R upstream/.git "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git &&
+	git clone "$HTTPD_URL"/smart/upstream test_http_clone &&
+	test_commit -C test_http_clone one &&
+	test_must_fail git -C test_http_clone push --push-option=asdf origin master &&
+	git -C test_http_clone push origin master
+'
+
+stop_httpd
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 91aed35ebb..1258d6aedd 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -826,6 +826,13 @@ static void set_common_push_options(struct transport *transport,
 		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "if-asked") != 0)
 			die("helper %s does not support --signed=if-asked", name);
 	}
+
+	if (flags & TRANSPORT_PUSH_OPTIONS) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, transport->push_options)
+			if (set_helper_option(transport, "push-option", item->string) != 0)
+				die("helper %s does not support 'push-option'", name);
+	}
 }
 
 static int push_refs_with_push(struct transport *transport,
-- 
2.12.0.rc0.1.g018cb5e6f4

