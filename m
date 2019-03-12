Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A39DD20248
	for <e@80x24.org>; Tue, 12 Mar 2019 01:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCLByB (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 21:54:01 -0400
Received: from avasout04.plus.net ([212.159.14.19]:34057 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfCLByB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 21:54:01 -0400
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 3WcAhTPf42Jqz3WcBhfGw3; Tue, 12 Mar 2019 01:53:59 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=I9lLuuog c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=4cNkkQ8e9kMkqHJb52sA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] upload-pack: fix sparse warnings
Message-ID: <5f0c12d5-6714-1516-3579-33d839ad7b7e@ramsayjones.plus.com>
Date:   Tue, 12 Mar 2019 01:53:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJqf8i5xVFfLfNLUaBy/j1VyD3oA/6vl68PmhfriR9Dntxxmfzi4G/UhhkAopRzkOjLCGXbbUqEvov7wcN/p4qCaeJByzQZ5YzYkjEZrGLo/YYWV5hgh
 cXc8M7tT0W7wQNz3UaOXzDc3/a6+1ly17TBsoV3puakuCPsaKBmPJHsr71B2UitM4lKslqr/tgu5DQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jonathan,

If you need to re-roll your 'jt/fetch-cdn-offload' branch, could
you please squash this into the relevant patches. (The first hunk
into commit a8d662e3da4 ("upload-pack: refactor reading of pack-objects
out", 2019-03-08) and the second hunk into commit 820a5361db1
("upload-pack: send part of packfile response as uri", 2019,-03-08)).

[Johannes mentioned 'clang' complaining - I have clang v5.0.1 and
it does not issue any warnings for the new initialization.]

This patch fixes the following sparse warnings:

  $ diff psp-out psp-out1
  190,191d189
  < upload-pack.c:182:45: warning: missing braces around initializer
  < upload-pack.c:1167:56: warning: Using plain integer as NULL pointer
  $ 

If you don't like the new initializer expression, maybe don't
initialize in the declaration and use a traditional:

   memset(&output_state, 0, sizeof(struct output_state));

instead?

Thanks!

ATB,
Ramsay Jones


 upload-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index d36e1fc06a..52309d40ae 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -179,7 +179,7 @@ static void create_pack_file(const struct object_array *have_obj,
 			     const struct string_list *uri_protocols)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
-	struct output_state output_state = {0};
+	struct output_state output_state = { { 0 }, 0, 0, 0 };
 	char progress[128];
 	char abort_msg[] = "aborting due to possible repository "
 		"corruption on the remote side.";
@@ -1164,7 +1164,7 @@ void upload_pack(struct upload_pack_options *options)
 	if (want_obj.nr) {
 		struct object_array have_obj = OBJECT_ARRAY_INIT;
 		get_common_commits(&reader, &have_obj, &want_obj);
-		create_pack_file(&have_obj, &want_obj, 0);
+		create_pack_file(&have_obj, &want_obj, NULL);
 	}
 }
 
-- 
2.21.0
