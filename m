Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC96E20401
	for <e@80x24.org>; Mon, 19 Jun 2017 00:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbdFSAUe (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 20:20:34 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33835 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752871AbdFSAUd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 20:20:33 -0400
Received: by mail-pf0-f193.google.com with SMTP id d5so14290811pfe.1
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 17:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zZFAIkywwX4tnLEv5EmAHfwsqvBpvkF6DISqrw9knPs=;
        b=G8tLQzOGWv8DIpV+VoNIzk0UcI+34DjaVUmGpYwdZ8Rfgfbf4m43HpI6AvaJrI54/G
         94khOsCRLVC1sMLR+ct3oslft2Qczbk5mXWOXJueVUZy04DLDsOfdCVMgdfN3SoAd+lt
         HkufFWliI1SbKtsk2+WfNo9LOQhA18Ju6VtN/2lC5FzgzVLsX6Zd/n0AD4jYv5wit8bP
         Q3DAZhHmoPpXThEEwzeAlLltFFtn45J2307OafLAANhwEdXHC5PcOMUu/VH8ucsmMq4j
         43yQWABPHO/YVGUu9VGOFN6ytPmyiqjmTlguovlcRQlCon7Qwl7LzHyhWU4moXBJ3XBC
         nRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zZFAIkywwX4tnLEv5EmAHfwsqvBpvkF6DISqrw9knPs=;
        b=WmVWCaQvvwqDzmowGiE6WaTUYB4Ga/Z3GXYFR6oMBXPtwhbrcRZYiyUibCJqGShdoC
         Vwx06b2h5Yr97tsG98K0my4VOb+YwB6+2UQD/N+iYwFChO96nNiD6nmNEU+qSOoNzx/p
         WHCzuTGFUJLVpr6CublVAnh6iEi+yOXlGJYChpLKAE/L/zBqSxvllrLgKaig4nWJHVlA
         FUu0cc5BeRwgVlv5oQkfwF+OyCKaf312epuTXOajUMq2Up1wRhmnRVECHy01O5o0EiNF
         hXriXuXWDW0ATmRExMLVl4Y4xbbn0DTylEi5jqmQoB5YsDbVa6EQX0XITt2uzdK1zWjy
         jOXg==
X-Gm-Message-State: AKS2vOxlXIfhNqnr3rD7nzXAyAqCuid9aFOZMo3Pjlm7P9Ki7pvDhvw8
        i36jO2FCuQjQpFbddno=
X-Received: by 10.84.231.135 with SMTP id g7mr26389508plk.110.1497831632492;
        Sun, 18 Jun 2017 17:20:32 -0700 (PDT)
Received: from localhost.localdomain (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id a28sm16708941pfl.25.2017.06.18.17.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jun 2017 17:20:31 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Matthew Groth <mgroth49@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2] mergetools/meld: improve backwards-compatibiilty when using "--output"
Date:   Sun, 18 Jun 2017 17:20:27 -0700
Message-Id: <20170619002027.27346-1-davvid@gmail.com>
X-Mailer: git-send-email 2.13.1.453.gc0395165f3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Meld 3.16.0 requires a "=" in the --output argument, as it uses
a simple hand-rolled command-line parser.

Newer versions of Meld (3.16.4, and possibly earlier) use
optparse, which accepts either "--output <file>" or
"--output=<file>".

Use "--output=<file>" for better compatibility.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since v1:

Fixed an "optpaarse" -> "optparse" typo in the commit message.
This patch is otherwise identical to v1.

 mergetools/meld | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mergetools/meld b/mergetools/meld
index bc178e8882..7a08470f88 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -10,7 +10,7 @@ merge_cmd () {
 
 	if test "$meld_has_output_option" = true
 	then
-		"$merge_tool_path" --output "$MERGED" \
+		"$merge_tool_path" --output="$MERGED" \
 			"$LOCAL" "$BASE" "$REMOTE"
 	else
 		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
-- 
2.13.1.453.gc0395165f3

