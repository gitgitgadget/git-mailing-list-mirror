Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935171F453
	for <e@80x24.org>; Thu, 18 Oct 2018 10:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeJRSBA (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 14:01:00 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:44884 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbeJRSBA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 14:01:00 -0400
Received: from lindisfarne.localdomain ([92.26.121.144])
        by smtp.talktalk.net with SMTP
        id D56VgJF7wbZX5D56hgkniR; Thu, 18 Oct 2018 11:00:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539856843;
        bh=T62OXjZH3GqFJmUirrEecnCqMn1pnIq4R4pxhPCNAUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=n7eNmrAqGnyLdT+3uJAYquBqNByNW8bYwEXRFEQzTSqsIZ2/sDQH/LNuuHcy+caci
         AeicIVMOSj4KTFoDMhogvjglrmaKvYfexe9e3Z+tcUa9y09v+EGg/yFrpS7Ti6BwLV
         Ns/IB+mkgYKNuMVz+gUqqBHrbjaWMuapl8efplBE=
X-Originating-IP: [92.26.121.144]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=AM9PLn0bJgvrHi3wmEITIQ==:117
 a=AM9PLn0bJgvrHi3wmEITIQ==:17 a=evINK-nbAAAA:8 a=Ci-q4SUaBBSLNT-odzMA:9
 a=_FElnbUD08B2i4wl:21 a=5JVnrwbNiQWVHTK8:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/5] am: improve author-script error reporting
Date:   Thu, 18 Oct 2018 11:00:20 +0100
Message-Id: <20181018100023.7327-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181018100023.7327-1-phillip.wood@talktalk.net>
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20181018100023.7327-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKmVpjlB4rrh4zSBTAcx5gLMG6nVgNV/ttGT1fgM9wEHzwxzM/V0+CB3MacMwWJZT+JzzHf0SgdQMQR1Bf9cTSXO45dPKXSWnSwMQJKozLaxIvTZ2JQu
 aCRCtK8UBh6ROMqXQCPYucvmqBYA9FgcjBDRgYoxd2V/hlmMX7nAB/TTl8sTqz9/MnyfUMdlzqO3ay/uYh8n7BeCFJX5ItfvYtq+qBjpuLB+DSwYjya1wfJW
 ERJCuAf8gEAEAgqJhA6MCYhNBZZMPAaVneZhPiF0BoKdOljQnp506wBWBqYCKq592dkBvabPekyu/NLG2gSC0qaMyTkwQIjnOXFEWxXpIvc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there are errors in a user edited author-script there was no
indication of what was wrong. This commit adds some specific error messages
depending on the problem. It also relaxes the requirement that the
variables appear in a specific order in the file to match the behavior
of 'rebase --interactive'.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/am.c | 49 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index b68578bc3f..d42b725273 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -270,8 +270,11 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
 		struct string_list_item *item;
 		char *np;
 		char *cp = strchr(buf, '=');
-		if (!cp)
-			return -1;
+		if (!cp) {
+			np = strchrnul(buf, '\n');
+			return error(_("unable to parse '%.*s'"),
+				     (int) (np - buf), buf);
+		}
 		np = strchrnul(cp, '\n');
 		*cp++ = '\0';
 		item = string_list_append(list, buf);
@@ -280,7 +283,8 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
 		*np = '\0';
 		cp = sq_dequote(cp);
 		if (!cp)
-			return -1;
+			return error(_("unable to dequote value of '%s'"),
+				     item->string);
 		item->util = xstrdup(cp);
 	}
 	return 0;
@@ -308,6 +312,7 @@ static int read_author_script(struct am_state *state)
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list kv = STRING_LIST_INIT_DUP;
 	int retval = -1; /* assume failure */
+	int i, name_i = -2, email_i = -2, date_i = -2, err = 0;
 	int fd;
 
 	assert(!state->author_name);
@@ -326,14 +331,38 @@ static int read_author_script(struct am_state *state)
 	if (parse_key_value_squoted(buf.buf, &kv))
 		goto finish;
 
-	if (kv.nr != 3 ||
-	    strcmp(kv.items[0].string, "GIT_AUTHOR_NAME") ||
-	    strcmp(kv.items[1].string, "GIT_AUTHOR_EMAIL") ||
-	    strcmp(kv.items[2].string, "GIT_AUTHOR_DATE"))
+	for (i = 0; i < kv.nr; i++) {
+		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
+			if (name_i >= 0)
+				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
+			else
+				name_i = i;
+		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_EMAIL")) {
+			if (email_i >= 0)
+				email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
+			else
+				email_i = i;
+		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_DATE")) {
+			if (date_i >= 0)
+				date_i = error(_("'GIT_AUTHOR_DATE' already given"));
+			else
+				date_i = i;
+		} else {
+			err = error(_("unknown variable '%s'"),
+				    kv.items[i].string);
+		}
+	}
+	if (name_i == -2)
+		error(_("missing 'GIT_AUTHOR_NAME'"));
+	if (email_i == -2)
+		error(_("missing 'GIT_AUTHOR_EMAIL'"));
+	if (date_i == -2)
+		error(_("missing 'GIT_AUTHOR_DATE'"));
+	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
 		goto finish;
-	state->author_name = kv.items[0].util;
-	state->author_email = kv.items[1].util;
-	state->author_date = kv.items[2].util;
+	state->author_name = kv.items[name_i].util;
+	state->author_email = kv.items[email_i].util;
+	state->author_date = kv.items[date_i].util;
 	retval = 0;
 finish:
 	string_list_clear(&kv, !!retval);
-- 
2.19.0

