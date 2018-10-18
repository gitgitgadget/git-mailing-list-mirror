Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088991F453
	for <e@80x24.org>; Thu, 18 Oct 2018 10:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeJRSA7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 14:00:59 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:9293 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbeJRSA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 14:00:59 -0400
Received: from lindisfarne.localdomain ([92.26.121.144])
        by smtp.talktalk.net with SMTP
        id D56VgJF7wbZX5D56egkniL; Thu, 18 Oct 2018 11:00:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539856843;
        bh=GwZjmySp6tXp8SBPHEMS6m5179Gk5+ME9omTk/KyHJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=b1x1Szrf4TbdCC+5iwl0nLse/3jwFRjUTMKeMTlSLb3ilhRNwDsFhW4DShpbnxd+X
         hzzj7p/iaIewsS+iYx7zCyXCzqlIb58RZ+g/4loDIH+n6FyLkCiyG+jkOfK+z+J0D5
         ZKyK3JOVFsTX2YDzcwTcwnWvkV0hA8ZEbjSVqjI4=
X-Originating-IP: [92.26.121.144]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=AM9PLn0bJgvrHi3wmEITIQ==:117
 a=AM9PLn0bJgvrHi3wmEITIQ==:17 a=evINK-nbAAAA:8 a=BCjA09oAAAAA:8
 a=1ulBX1ryXkBVU36sZhAA:9 a=1mN8BR69xVlCBuyq:21 a=iSUq80Ko9vD66vLc:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=jYKBPJSq9nmHKCndOPe9:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/5] am: don't die in read_author_script()
Date:   Thu, 18 Oct 2018 11:00:19 +0100
Message-Id: <20181018100023.7327-2-phillip.wood@talktalk.net>
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

The caller is already prepared to handle errors returned from this
function so there is no need for it to die if it cannot read the file.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/am.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 5e866d17c7..b68578bc3f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -318,7 +318,8 @@ static int read_author_script(struct am_state *state)
 	if (fd < 0) {
 		if (errno == ENOENT)
 			return 0;
-		die_errno(_("could not open '%s' for reading"), filename);
+		return error_errno(_("could not open '%s' for reading"),
+				   filename);
 	}
 	strbuf_read(&buf, fd, 0);
 	close(fd);
-- 
2.19.0

