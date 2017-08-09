Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817241F991
	for <e@80x24.org>; Wed,  9 Aug 2017 14:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753295AbdHIOqY (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 10:46:24 -0400
Received: from 4.mo64.mail-out.ovh.net ([46.105.45.191]:46540 "EHLO
        4.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbdHIOqY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 10:46:24 -0400
X-Greylist: delayed 112169 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Aug 2017 10:46:23 EDT
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id 55FCD6D595;
        Wed,  9 Aug 2017 16:46:22 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 9 Aug
 2017 16:46:21 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [RFC 3/3] imap_send: add support for curl over tunnel
To:     <git@vger.kernel.org>
CC:     <peff@peff.net>
References: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
Message-ID: <3f49822c-2766-1904-4449-716dadec958f@morey-chaisemartin.com>
Date:   Wed, 9 Aug 2017 16:46:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: CAS3.indiv2.local (172.16.1.3) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 2323294458382837751
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkeehgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Starting from libcurl 7.21.5, libcurl can be tricked into using
an already open socket.
This allows to use tunneling with libcurl instead of the legacy imap code.

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 Documentation/git-imap-send.txt |  4 ++--
 imap-send.c                     | 45 +++++++++++++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 5d1e4c80c..e765c08d7 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -38,8 +38,8 @@ OPTIONS
 	Be quiet.
 
 --curl::
-	Use libcurl to communicate with the IMAP server, unless tunneling
-	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
+	Use libcurl to communicate with the IMAP server.
+	Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
 	option set.
 
 --no-curl::
diff --git a/imap-send.c b/imap-send.c
index e5ff70096..31b93d873 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1408,6 +1408,26 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 }
 
 #ifdef USE_CURL_FOR_IMAP_SEND
+static curl_socket_t curl_tunnel_socket(void *clientp,
+					curlsocktype purpose,
+					struct curl_sockaddr *address)
+{
+	return (unsigned long)clientp;
+}
+
+static int sockopt_callback(void *clientp, curl_socket_t curlfd,
+				 curlsocktype purpose)
+{
+	/* CURL_SOCKOPT_ALREADY_CONNECTED was intreocued in 7.21.5
+	 * and is needed to get curl working on an existing fd */
+#if LIBCURL_VERSION_NUM >= 0x071505
+	return CURL_SOCKOPT_ALREADY_CONNECTED;
+#else
+	return CURL_SOCKOPT_ERROR;
+#endif
+}
+
+
 static CURL *setup_curl(struct imap_server_conf *srvc)
 {
 	CURL *curl;
@@ -1424,8 +1444,21 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
 	curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
 	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
 
-	strbuf_addstr(&path, server.use_ssl ? "imaps://" : "imap://");
-	strbuf_addstr(&path, server.host);
+	if (srvc->tunnel) {
+		int fds[2];
+
+		setup_tunnel(srvc, fds);
+		curl_easy_setopt(curl, CURLOPT_OPENSOCKETFUNCTION, curl_tunnel_socket);
+		curl_easy_setopt(curl, CURLOPT_OPENSOCKETDATA, (unsigned long)fds[0]);
+		curl_easy_setopt(curl, CURLOPT_SOCKOPTFUNCTION, sockopt_callback);
+		/* Create a fake hostname to avoid resolution issue and in case
+		 * imap.host was not set */
+		strbuf_addstr(&path, "imap://localhost");
+	} else {
+		strbuf_addstr(&path, server.use_ssl ? "imaps://" : "imap://");
+		strbuf_addstr(&path, server.host);
+	}
+
 	if (!path.len || path.buf[path.len - 1] != '/')
 		strbuf_addch(&path, '/');
 	strbuf_addstr(&path, server.folder);
@@ -1570,12 +1603,12 @@ int cmd_main(int argc, const char **argv)
 
 	/* write it to the imap server */
 
-	if (server.tunnel)
-		return append_msgs_to_imap(&server, &all_msgs, total);
-
 #ifdef USE_CURL_FOR_IMAP_SEND
 	if (use_curl)
-		return curl_append_msgs_to_imap(&server, &all_msgs, total);
+#if LIBCURL_VERSION_NUM < 0x071505
+		if (!server.tunnel)
+#endif
+			return curl_append_msgs_to_imap(&server, &all_msgs, total);
 #endif
 
 	return append_msgs_to_imap(&server, &all_msgs, total);
-- 
2.14.0.3.gb4ff627ec.dirty

