Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B40F320954
	for <e@80x24.org>; Thu, 30 Nov 2017 10:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750849AbdK3KHr (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 05:07:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:50201 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750760AbdK3KHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 05:07:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8B7C0AAA3;
        Thu, 30 Nov 2017 10:07:45 +0000 (UTC)
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCH] imap-send: URI encode server folder
To:     git@vger.kernel.org
Cc:     daniel@haxx.se, jrnieder@gmail.com, doron.behar@gmail.com,
        peff@peff.net
References: <20171129171301.l3coiflkfyy533yz@NUC.localdomain>
Message-ID: <18c9478b-19fc-69f2-229f-67c05a42d4f5@suse.com>
Date:   Thu, 30 Nov 2017 11:07:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101
 Thunderbird/57.0
MIME-Version: 1.0
In-Reply-To: <20171129171301.l3coiflkfyy533yz@NUC.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

URI encode the server folder string before passing it to libcurl.
This fixes the access to the draft folder on Gmail accounts (named [Gmail]/Drafts)

Reported-by: Doron Behar <doron.behar@gmail.com>
Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
---
 imap-send.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 54e6a80fd..36c7c1b4f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1412,6 +1412,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 {
 	CURL *curl;
 	struct strbuf path = STRBUF_INIT;
+	char *uri_encoded_folder;
 
 	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
 		die("curl_global_init failed");
@@ -1429,7 +1430,12 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	strbuf_addstr(&path, server.host);
 	if (!path.len || path.buf[path.len - 1] != '/')
 		strbuf_addch(&path, '/');
-	strbuf_addstr(&path, server.folder);
+
+	uri_encoded_folder = curl_easy_escape(curl, server.folder, 0);
+	if (!uri_encoded_folder)
+		die("failed to encode server folder");
+	strbuf_addstr(&path, uri_encoded_folder);
+	curl_free(uri_encoded_folder);
 
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
-- 
2.15.1.272.g8e603414b

