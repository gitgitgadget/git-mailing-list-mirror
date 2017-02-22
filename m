Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F6F1201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 17:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933165AbdBVRj7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 12:39:59 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:36336 "EHLO
        homiemail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932858AbdBVRj5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 12:39:57 -0500
Received: from homiemail-a12.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTP id 5273B26206D;
        Wed, 22 Feb 2017 09:39:56 -0800 (PST)
Received: from localhost.localdomain (gzac12-mdf2-1.aoa.twosigma.com [208.77.215.155])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTPSA id C933926206A;
        Wed, 22 Feb 2017 09:39:55 -0800 (PST)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <dturner@twosigma.com>
Subject: [PATCH] http(s): automatically try NTLM authentication first
Date:   Wed, 22 Feb 2017 12:39:36 -0500
Message-Id: <20170222173936.25016-1-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is common in corporate setups to have permissions managed via a
domain account. That means that the user does not really have to log in
when accessing a central repository via https://, but that the login
credentials are used to authenticate with that repository.

The common way to do that used to require empty credentials, i.e. hitting
Enter twice when being asked for user name and password, or by using the
very funny notation https://:@server/repository

A recent commit (5275c3081c (http: http.emptyauth should allow empty (not
just NULL) usernames, 2016-10-04)) broke that usage, though, all of a
sudden requiring users to set http.emptyAuth = true.

Which brings us to the bigger question why http.emptyAuth defaults to
false, to begin with.

It would be one thing if cURL would not let the user specify credentials
interactively after attempting NTLM authentication (i.e. login
credentials), but that is not the case.

It would be another thing if attempting NTLM authentication was not
usually what users need to do when trying to authenticate via https://.
But that is also not the case.

So let's just go ahead and change the default, and unbreak the NTLM
authentication. As a bonus, this also makes the "you need to hit Enter
twice" (which is hard to explain: why enter empty credentials when you
want to authenticate with your login credentials?) and the ":@" hack
(which is also pretty, pretty hard to explain to users) obsolete.

This fixes https://github.com/git-for-windows/git/issues/987

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: David Turner <dturner@twosigma.com>
---
This has been in git for Windows for a few months (without the
config.txt change).  We've also been using it internally.  So I think
it's time to merge back to upstream git.

 Documentation/config.txt | 3 ++-
 http.c                   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fc5a28a320..b0da64ed33 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1742,7 +1742,8 @@ http.emptyAuth::
 	Attempt authentication without seeking a username or password.  This
 	can be used to attempt GSS-Negotiate authentication without specifying
 	a username in the URL, as libcurl normally requires a username for
-	authentication.
+	authentication.  Default is true, since if this fails, git will fall
+	back to asking the user for their username/password.
 
 http.delegation::
 	Control GSSAPI credential delegation. The delegation is disabled
diff --git a/http.c b/http.c
index 90a1c0f113..943e630ea6 100644
--- a/http.c
+++ b/http.c
@@ -109,7 +109,7 @@ static int curl_save_cookies;
 struct credential http_auth = CREDENTIAL_INIT;
 static int http_proactive_auth;
 static const char *user_agent;
-static int curl_empty_auth;
+static int curl_empty_auth = 1;
 
 enum http_follow_config http_follow_config = HTTP_FOLLOW_INITIAL;
 
-- 
2.11.GIT

