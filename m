Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FE1B2047F
	for <e@80x24.org>; Fri,  4 Aug 2017 18:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbdHDSqc (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 14:46:32 -0400
Received: from 6.mo64.mail-out.ovh.net ([46.105.48.16]:59210 "EHLO
        6.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdHDSqc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 14:46:32 -0400
X-Greylist: delayed 8400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Aug 2017 14:46:31 EDT
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id 4DABF6D901
        for <git@vger.kernel.org>; Fri,  4 Aug 2017 18:16:54 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 4 Aug
 2017 18:16:53 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [RFC] imap-send: escape backslash in password
To:     <git@vger.kernel.org>
Message-ID: <58b783d6-c024-4491-2f88-edfb9c43c55c@morey-chaisemartin.com>
Date:   Fri, 4 Aug 2017 18:16:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: EX3.indiv2.local (172.16.2.3) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 11382285110081611741
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrjeehgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Password containing backslashes need to have them doubled to have them properly interpreted by the imap server.

A password terminating with a blackslash used to trigger this error:
IMAP command 'LOGIN <user> <pass>' returned response (BAD) - Missing '"'

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 imap-send.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index b2d0b849b..7fde6ec96 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -926,6 +926,32 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
 	return 0;
 }
 
+static char* imap_escape_password(const char *passwd)
+{
+	const unsigned passwd_len = strlen(passwd);
+	char *escaped = xmalloc(2 * passwd_len + 1);
+	const char *passwd_cur = passwd;
+	char *escaped_cur = escaped;
+
+	do {
+		char *next = strchr(passwd_cur, '\\');
+
+		if (!next) {
+			strcpy(escaped_cur, passwd_cur);
+		} else {
+			int len = next - passwd_cur + 1;
+
+			memcpy(escaped_cur, passwd_cur, len);
+			escaped_cur += len;
+			next++;
+			*(escaped_cur++) = '\\';
+		}
+		passwd_cur = next;
+	} while(passwd_cur);
+
+	return escaped;
+}
+
 static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *folder)
 {
 	struct credential cred = CREDENTIAL_INIT;
@@ -1090,7 +1116,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
 			if (!srvc->user)
 				srvc->user = xstrdup(cred.username);
 			if (!srvc->pass)
-				srvc->pass = xstrdup(cred.password);
+				srvc->pass = imap_escape_password(cred.password);
 		}
 
 		if (srvc->auth_method) {
