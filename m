Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E401FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 22:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbdBHWEe (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 17:04:34 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:36896 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdBHWEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 17:04:32 -0500
Received: by mail-it0-f47.google.com with SMTP id r185so2617418ita.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 14:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X57ifUPO4vp4HiHbU0kM3IGmCPhf9EEmpX1Er6fuDA0=;
        b=sRHGOQ1zafztXYwdCJWAOGYBV2qRP0UAabuUa3VMQHxwoWXWfCQlmspOsqKXp73fl1
         2AU21SMCqiKxgVkoim9jukecpP9VTlXAZBwajo82VkQPfu07rrXy7f58KDWntWEs0dbg
         hROTpvduNKkxPKGjDMlFy1T+TI/VbloCsTNQdBWzmo+vQxrdL/l9wfGrJZZouNzta7Pp
         2iGBS98zZ7EJJAn7hzgYZd5jv1gz90MC3PTmNrjgYLVRvcVaYMIA2My17pXnWeKPPJSG
         mmJ0wFKyIuUYuBUz8u5WxN/miQIiOKbM6vN/dQss8iXDpXJLb05/bO77uPyosvYwbeMt
         4P8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X57ifUPO4vp4HiHbU0kM3IGmCPhf9EEmpX1Er6fuDA0=;
        b=qP16weXZPXKigUvAzDHK/+xHESt2Php6bIxiFZ3c9cpo96RH+Lo90GZKU8NOvVegeS
         iDfJNtFbGc+eSdUGgRdY2nb9I6Nf1u0OHlFzUX9MsaY04UjJU+ktzp0MqOAmDvm+BC2X
         2Yl3/XEt7eHayo3XTS2k3J0humw4hivdwTvdF5/lUxwNEZOYyIoj+C6QYo+5D+hpbbny
         a2k4ZUeBVELRuPblU80uQ81BZ5sW6yJf0PKiygQGA8wwMrOmSNDB5TRR+AakorWP9AWm
         oMce6mv8QHH2UaWrJqZqL3Fo51RGfIx5/WNAhyU2Kp+mf/wBXm+hDHeW7mYeZ76hC+ua
         /hFQ==
X-Gm-Message-State: AIkVDXJPD5exGngTYuO8qHgLzLsds89n6BVaVL+iQXH7kSCR2sr0PzjyEqjInHuCnUsX4YpN
X-Received: by 10.84.142.101 with SMTP id 92mr36141857plw.66.1486591443447;
        Wed, 08 Feb 2017 14:04:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:684e:2fd8:5eea:9943])
        by smtp.gmail.com with ESMTPSA id t185sm22847773pgb.32.2017.02.08.14.04.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 14:04:03 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] push options: pass push options to the transport helper
Date:   Wed,  8 Feb 2017 14:04:00 -0800
Message-Id: <20170208220400.17069-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.1.g018cb5e6f4
In-Reply-To: <xmqqpoiswo0l.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoiswo0l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using non-builtin protocols relying on a transport helper
(such as http), push options are not propagated to the helper.

The user could ask for push options and a push would seemingly succeed,
but the push options would never be transported to the server,
misleading the users expectation.

Fix this by propagating the push options to the transport helper.

This is only addressing the first issue of
   (1) the helper protocol does not propagate push-option
   (2) the http helper is not prepared to handle push-option

Once we fix (2), the http transport helper can make use of push options
as well, but that happens as a follow up. (1) is a bug fix, whereas (2)
is a feature, which is why we only do (1) here.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/gitremote-helpers.txt |  4 ++++
 t/t5545-push-options.sh             | 15 +++++++++++++++
 transport-helper.c                  |  7 +++++++
 3 files changed, 26 insertions(+)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 9e8681f9e1..23474b1eab 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -462,6 +462,10 @@ set by Git if the remote helper has the 'option' capability.
 'option pushcert {'true'|'false'}::
 	GPG sign pushes.
 
+'option push-option <string>::
+	Transmit <string> as a push option. As the a push option
+	must not contain LF or NUL characters, the string is not encoded.
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

