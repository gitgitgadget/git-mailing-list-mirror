Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62162C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 01:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243563AbhLNBzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 20:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243506AbhLNBzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 20:55:36 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F57C061751
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:35 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id i12so16112872qvh.11
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=StB/LK9blxjkJOwppFu/JcsUXmSSKIHCZYIhAhYeOQM=;
        b=lI6ZErtc3HHhHyh0yxzMo9ChxxLU3ThWQhTxtp/dr98cx4oQ+H0dpc6pIQR6xw/aK4
         taKhDDdrimepAD07MBWJEhUVgSHwjHgvJaZTh2agAEwto6VY5s+3YdJnP2VHLD1Yu5GH
         YEE+N6iR3e4hufnYrc/FHXePFDZs8n7ZsND7YCdhyFk+c9bTAMcFZAA9lOnRKuakaQSw
         sQ8WjvtZKLAM65NJytSZU/jfOfQYpSdjBT5m5FL+7Y3OTv4vB3JIy/U+9SvUyKkePFu1
         gKZbbCxrHZIXbxdy75xcHcyNXCLqlNKELjPd2z2zSCqrQ99TeEqYHOtoY+sEXXBlW8so
         k7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=StB/LK9blxjkJOwppFu/JcsUXmSSKIHCZYIhAhYeOQM=;
        b=zVxNfKDZy+VxAw3REV4QL4JwOpHezpBmah9qByv2xXynQn3wmQLSVO5+B8VFckQ3kR
         rj9nBnxcU1WfJWL7N6R3rmsbQWfhklihCl0cg1GIeCvkKCbkdCGy2xi3R5OwmRRFTKo7
         apWhDGrqqk3pdhd8rER1Qa0K2Ik/v/NQJDPq5Dc7ZbzOEhXjqqj/9D2cEO8/x/f9n6Y4
         Fh5QDXHYH/IU1cy7JmL67Dj8ZBsHqtWfLfupvWV7N8zp7WVJCqrRweavlSxHCgqEPHe5
         UVcGCY0Z/doZqL8x5KnOwTE3ePZJRP+wst2GbTF3LC94nMouTZAwBbB2bXEaXW7hIduO
         5UCQ==
X-Gm-Message-State: AOAM531aHkWuBpS0aEU1eOspy2KqeQwSyWZugvRun1UNDYI8kGcvm8lm
        bdnTlOKX/RWlg31w02lpCqt9Vt35FlelMx21
X-Google-Smtp-Source: ABdhPJyAwRNc+ze/2g9sS1tZEff1qM+KeVEFWl5p/TPGJjewDu/eV8d6WZFyk1rxKVOa/IPSGFxGxg==
X-Received: by 2002:a05:6214:508f:: with SMTP id kk15mr2248813qvb.3.1639446934953;
        Mon, 13 Dec 2021 17:55:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x16sm6936166qko.15.2021.12.13.17.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 17:55:34 -0800 (PST)
Date:   Mon, 13 Dec 2021 20:55:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com
Subject: [PATCH v2 3/8] pack-revindex.c: instrument loading on-disk reverse
 index
Message-ID: <b630fea149f840ad049a4089047bb35d59f00c28.1639446906.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1639446906.git.me@ttaylorr.com>
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
2.34.1.25.gb3157a20e6

