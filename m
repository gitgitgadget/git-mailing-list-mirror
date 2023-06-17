Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A42EB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 06:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjFQGnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 02:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345698AbjFQGms (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 02:42:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C503C26
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 23:41:42 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30c55d2b9f3so1053599f8f.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 23:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686984101; x=1689576101;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JIbPgdsiKpXM1bp1v3FWE/MNtsf9HHnjwD9ou7ZyOE=;
        b=S+YB7Ic0YaMyRPH9hf3kE4Bu+iTTbPrAnUUpO91GVrlDTYK5LATalVi+9Z/GA1WcRQ
         T+WKMYqFiCeyyAoE8L0l1yuafRkzcbafqSLFXhAmi4ly+k0WJskVUZezLMgWe5R/pmBH
         JnqOlsUW4q6Ih/b9Bt7ZkZ/gM64GmZ6QldJOHjg+HQ9zMK1v/j5iNHPoOjPaZ1vNnDgx
         dtyC8P6hwJepggC/W/WJXxwpDanGOSvfhWfwVeP6XIW7ruOg5dbAEebEUuz57bqVHpc8
         sVXM8qMQcVcgOHK6mOcIuHj0QBHWo19xvZucgtO7dFASyQ0/qrpip2Xlh1drBDf6qraD
         5cLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686984101; x=1689576101;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JIbPgdsiKpXM1bp1v3FWE/MNtsf9HHnjwD9ou7ZyOE=;
        b=P/tYPmkVgfEq8HE1YKlfc4R7+MjIDA/mNr6v0H8LbSZOSdvRpCh2ZV3qfphPorrrfW
         XwNhJQ8ZU5pyc4f6IL10OSfJlsMJgvi0ZKhj2HMRv/ofE94xT0WOJP6Nm1XaWwQjinFW
         7+DlYBflbiEU3dKkzW24+7lzNQiYZijihYO6LIAR3XkOmm24w9a9B+7pWXMLzHrU6MvP
         q1xID8ej468ICGhDj2zoOKSiwH10CYGSKc0ddA42SAlliHNA7RM/qVci0u5Dgsmgm0fZ
         hVM937NQmuXAZ0nczRZFdfB2F71hhJF3WL76wde3Q8gJhV0qECBswsjAdiUlnJ+S1Pfk
         LixA==
X-Gm-Message-State: AC+VfDwGFkNvYZYlLBtBblolOhGr08FiunT/PwziqXngidFzqWS8e7DC
        PFjqjr+FN+W/EQnOBA+l3yk=
X-Google-Smtp-Source: ACHHUZ7PlY0FjvUDLJcS2CtlfnMSyd2vHu8WpoCpzgJxJNgeInO3pa2gZNzDIf4P75oy9z/v3lqMaw==
X-Received: by 2002:a5d:4008:0:b0:2ff:f37:9d0f with SMTP id n8-20020a5d4008000000b002ff0f379d0fmr2341265wrp.57.1686984101188;
        Fri, 16 Jun 2023 23:41:41 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id cs6-20020a056000088600b0030ae849c70csm25452170wrb.37.2023.06.16.23.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 23:41:40 -0700 (PDT)
Subject: [PATCH v3 4/5] config: fix a leak in
 git_config_copy_or_rename_section_in_file
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
 <71b49be1-eeef-2f60-38f1-cfcbe4c8252f@gmail.com>
Message-ID: <33fb45d2-5c6a-b5ad-d405-e7acb8fdbabf@gmail.com>
Date:   Sat, 17 Jun 2023 08:41:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <71b49be1-eeef-2f60-38f1-cfcbe4c8252f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A branch can have its configuration spread over several configuration
sections.  This situation was already foreseen in 52d59cc645 (branch:
add a --copy (-c) option to go with --move (-m), 2017-06-18) when
"branch -c" was introduced.

Unfortunately, a leak was also introduced:

   $ git branch foo
   $ cat >> .git/config <<EOF
   [branch "foo"]
   	some-key-a = a value
   [branch "foo"]
   	some-key-b = b value
   [branch "foo"]
   	some-key-c = c value
   EOF
   $ git branch -c foo bar

   Direct leak of 130 byte(s) in 2 object(s) allocated from:
       ... in xrealloc wrapper.c
       ... in strbuf_grow strbuf.c
       ... in strbuf_vaddf strbuf.c
       ... in strbuf_addf strbuf.c
       ... in store_create_section config.c
       ... in git_config_copy_or_rename_section_in_file config.c
       ... in git_config_copy_section_in_file config.c
       ... in git_config_copy_section config.c
       ... in copy_or_rename_branch builtin/branch.c
       ... in cmd_branch builtin/branch.c
       ... in run_builtin git.c

Let's fix it.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.c b/config.c
index 39a7d7422c..207e4394a3 100644
--- a/config.c
+++ b/config.c
@@ -3833,6 +3833,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 						output[0] = '\t';
 					}
 				} else {
+					strbuf_release(&copystr);
 					copystr = store_create_section(new_name, &store);
 				}
 			}
-- 
2.40.1
