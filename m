Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD235C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E31760E8C
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJUDmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUDmE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 23:42:04 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04753C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:39:49 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z69so24114172iof.9
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XBhPzETMNSo70eaqyYiIaSZIT7Nf4nlhyp+Bstz0o+4=;
        b=kAqo3mHS/HUn7FfuQldeinWQSW3PhL7GIoNmQsAwe/3X0Tg8+mItXDIw1L3gyhS8NO
         jlnQTLl8k+Z9fOnrhzOrvbGRpegodLXchCznaF6BTExfRRWp5inD0pvlk2/uXu2TNgdR
         75toFw2weTDEvngt9qrTzab2Csf5qNPRRCNbaBtFObcMXyyCRlc5EVQKrIwHTI6m1TGU
         WGXREkCRkm7E5C+9TvP4cO4AOV4pVX+iBUdTlZ6ObXovneK04xeZranNNKiPi9OzPvJg
         ca7W1CbX4eLI3bj+24UpxhV8v2WaHdU2FTOA+uyHMiPn9lYdAE7/SPvi6kJVdedn0izv
         qTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XBhPzETMNSo70eaqyYiIaSZIT7Nf4nlhyp+Bstz0o+4=;
        b=eBPAZlOrRc483hbNcuAdb50jfCWNVwMlEI+eEpy+5FH7jKYJDSejfx5NfxmbFZP1MM
         rwf3w/nyROFVYDz8iio9VPZEIewf05bJ1KMpzqjtAUwlEpsMyZlUr4Jc/zxn307Z7jkX
         bJQveLBAkgiX6AQ3LMie3QkGyTNwJEC2yghX6SXyhT6qCP2B2k5cd2ZINJSshGnHBQgT
         eiY1Z7eFRQQpDzFJ1TrlfPRerKUq7BeUxMbsMRVKW3doEenBfI8Ai85HyY/vtJ0Canwj
         yIIuWB2PuDWFTL7YVHOKFK4I5FrBagPqpAb0tpmmzqMaHhFfT3xXhK4hoDfwsYR2KgO/
         ZL/w==
X-Gm-Message-State: AOAM532estaObyhXYpTB9+MaWW0nsjCa1Rf1Xx43MVynqjtH5ZRBNes+
        W+EMDXisnA5z5vsa1DJD0OPTBi4pGmR3/A==
X-Google-Smtp-Source: ABdhPJzFc8lqvmlEi3AXQ8iu2dQA2CMAa+RPx/UIAg+m45d2iLu508i5BteX53i+7VKvf3AlPAb6pw==
X-Received: by 2002:a05:6602:1594:: with SMTP id e20mr2346772iow.14.1634787588381;
        Wed, 20 Oct 2021 20:39:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p3sm427766ilj.81.2021.10.20.20.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:39:48 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:39:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 01/11] midx.c: clean up chunkfile after reading the MIDX
Message-ID: <30f6f23daf49814f479865eea5f9ee68de209d5f.1634787555.git.me@ttaylorr.com>
References: <cover.1634787555.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1634787555.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to read the contents of a MIDX, we initialize a chunkfile
structure which can read the table of contents and assign pointers into
different sections of the file for us.

We do call free(), since the chunkfile struct is heap allocated, but not
the more appropriate free_chunkfile(), which also frees memory that the
structure itself owns.

Call that instead to avoid leaking memory in this function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
The patch contents are from Ævar, but the message is mine. I hope that
he doesn't mind me forging his sign-off here.

 midx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 8433086ac1..36e4754767 100644
--- a/midx.c
+++ b/midx.c
@@ -179,12 +179,13 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	trace2_data_intmax("midx", the_repository, "load/num_packs", m->num_packs);
 	trace2_data_intmax("midx", the_repository, "load/num_objects", m->num_objects);

+	free_chunkfile(cf);
 	return m;

 cleanup_fail:
 	free(m);
 	free(midx_name);
-	free(cf);
+	free_chunkfile(cf);
 	if (midx_map)
 		munmap(midx_map, midx_size);
 	if (0 <= fd)
--
2.33.0.96.g73915697e6

