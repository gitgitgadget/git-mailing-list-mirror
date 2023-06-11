Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386AAC7EE2E
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjFKSuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjFKSut (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:50:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35728E64
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:50:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30ad458f085so2544303f8f.0
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686509446; x=1689101446;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JIbPgdsiKpXM1bp1v3FWE/MNtsf9HHnjwD9ou7ZyOE=;
        b=gFY5h5KR/O2d7uvF2STYmSpJ5OnJkxfK+tPTRQ+CNhNegHaLP6qmDS/bCp5uWn4wJ7
         1EMV3NYw3rd9pq1cwMnRcJ5J5gxeXroclhgijoMlQXovRGrD7e4SmmJ7jaHUE8Mn18+b
         1rRsJhHOj/DaAUUqCdz2Am6Esm5o6Dq+r8bNRf81cmZr7rHCLjHGVTrZE2Ut8OK78fZN
         fkYnAUOJfWlG8tjshiPGwPwisOV2svr/zWNizykmkHaxCjVGxWOM/Fvg8kdsteyZgqS5
         UUwPp4RPAgv9Eyelje+8C3OrSYvQ5HcXedwlzP+W8dnDm2bH7BcbMBJnjBnc3/GLBMit
         hvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686509446; x=1689101446;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JIbPgdsiKpXM1bp1v3FWE/MNtsf9HHnjwD9ou7ZyOE=;
        b=Rboi3OVw7BuT83xAyqcNZKzffHoc9pz6z/AIazK3xDuF4tgFmqvU/fb03pDYzjL6ii
         AyHarXbA2nWkgxyaSQsB02wMwsOsSO1dh5GFjXFtYaSeIr64iZATLkUJHGYmCAcLTdJy
         sw+TDOOsR5Txzw+bJ35L6pzjNh59vwL5HGqOpdW09jCam7/MgoMGFX2u/JLyL50IgFUs
         2mjSxfFXO0DS5uTmFjLC+QoZ0offo0l0WMLyOs+p83fHMv0ooiPAy7/FlLuqnUQ3TRwZ
         QujxClgolsn7zYwWDcNj9ZMwQEEODDiVRN2dths9GkyUdz0kVMq8ahLcypblq/mzYGIV
         X1KQ==
X-Gm-Message-State: AC+VfDwkfAhBtm7uKy1JqRtkx6G/IxW6rXUVjcq5IpdFeKxf2BYq8fH3
        vDPQ+UCaIzrZCL+vG5VkjYXWeS0nPus=
X-Google-Smtp-Source: ACHHUZ7erxxYmvg6M6PhjuG3u6RMtfnNjsvXq/N1kBKtg93W0ODAKcJaw4MVv2NnY1ZK/x4yacKsdg==
X-Received: by 2002:adf:f0c9:0:b0:307:95c9:c010 with SMTP id x9-20020adff0c9000000b0030795c9c010mr3298952wro.34.1686509446650;
        Sun, 11 Jun 2023 11:50:46 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c2c4b00b003f7eb5375ddsm9159576wmg.15.2023.06.11.11.50.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 11:50:46 -0700 (PDT)
Subject: [PATCH 10/11] config: fix a leak in
 git_config_copy_or_rename_section_in_file
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Message-ID: <3ee93720-dce0-8f90-68bf-0242e5731a36@gmail.com>
Date:   Sun, 11 Jun 2023 20:50:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
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
