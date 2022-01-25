Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02230C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiAYWlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiAYWlH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:41:07 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D191C06173B
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:07 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n17so9661960iod.4
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bIcoz3Z9QjwR7h3bDE2omLcbLQgfoWs33/88JQSMYyg=;
        b=JLofjaO0tfeFqfwr1/ELGviCrl5ejg0W6kUpcTzNeUyouRj0WuFjHUhWkqfXsvtjdN
         VeSDac8jwdIscAXx0zRKokRzZcqaG6TdXHm1sBwYJSn24e3KRDocnriSFEoLPC1AeIhc
         MU4qqus34uDCcRwx9rNECv4VzV3jffTqBCR4TWkIPBRD1YvmgdcIm2w9SSoZAGhd1sDD
         YuYDLj8vdPCyhzWlOuBxFr+a/HhAa/MV6hH/f8XljapG0OtMtaP0O7DMa6IkUDFlevch
         vC9LTgdWcbNnWJuY/GDXioCqQVddpTRNbW8e8A/vWhDVRNZhoBn33lKa/vlmaLTGNzoq
         +Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bIcoz3Z9QjwR7h3bDE2omLcbLQgfoWs33/88JQSMYyg=;
        b=izl2RwUbu04Ptq4uxJz0cncC1VpYKoHuO5Fd9iGD2+C8NEV3BYAc7sfP1jNZJcF2hY
         bR9WJZntma3Jslx27eXiPFFkVOW9Uf0fNmhZ92IVRG1NIszFVCuQwwgME4X34x79hKIE
         aZQKTQWs7qkqbm+0P/X+ropfDa+FICYOcrfOvtIg9K1YlJzWwn5L+YGqXZSgKnjlZPML
         iV5HJhg7TOnvI9c5Kn7wguUeJa/O3y/CK3Dw4xj7063cdwHYoyXD+JDlCZiFCTdkbHWm
         nI+CQ+KQqAhfuFgEGH5OrpA5jfll8Oc1U3A4FgEfpMnsDNWRVTscc6FGPqwyAQHTOnXy
         nLag==
X-Gm-Message-State: AOAM532C9+KW03omzThaFb1wFb0DGCBTMPbElICAZavS4f34RTyrYuzq
        953/uP+4epAAjEjXQnQAb4ksaRUV7fUuhw==
X-Google-Smtp-Source: ABdhPJwZ59wNlyqtbykLwNCLHoXo05/IspJkJFZR2tdvLz+1MjJHjLqaDjgea6D+E3rMi3DMgdU1XQ==
X-Received: by 2002:a05:6602:2c0c:: with SMTP id w12mr12202861iov.125.1643150466697;
        Tue, 25 Jan 2022 14:41:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g7sm9848980ild.3.2022.01.25.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:41:06 -0800 (PST)
Date:   Tue, 25 Jan 2022 17:41:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, stolee@gmail.com
Subject: [PATCH v4 3/9] pack-revindex.c: instrument loading on-disk reverse
 index
Message-ID: <abc18613e04a3bb8571926cb653296fe6b49cc60.1643150456.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1643150456.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent commit, we'll use the MIDX's new 'RIDX' chunk as a
source for the reverse index's data. But it will be useful for tests to
be able to determine whether the reverse index was loaded from the
separate .rev file, or from a chunk within the MIDX.

To instrument this, add a trace2 event which the tests can look for in
order to determine the reverse index's source.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index 70d0fbafcb..bd15ebad03 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -301,6 +301,9 @@ int load_midx_revindex(struct multi_pack_index *m)
 	if (m->revindex_data)
 		return 0;
 
+	trace2_data_string("load_midx_revindex", the_repository,
+			   "source", "rev");
+
 	get_midx_rev_filename(&revindex_name, m);
 
 	ret = load_revindex_from_disk(revindex_name.buf,
-- 
2.34.1.455.gd6eb6fd089

