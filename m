Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC1682022A
	for <e@80x24.org>; Mon,  7 Nov 2016 19:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933700AbcKGTCF (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 14:02:05 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:52934 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933693AbcKGTCB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 14:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=subject:to
        :references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=k1; bh=j1hyjvSQxSID4x
        cxAux766ofi2eF6y/Wy+a2DT/GaqQ=; b=U0DFWCwEg8sbNh3dmnez6Ed20x7ldn
        8XNSAMmrN8SVpvLiWtoI7ldLOmhBOTUMEBAqYDynbYMHCmbpdyU6cZ9ovSELyLkH
        DcEdXkSl8w2HHaeLU9dcW/0pea/QBMpzJuEw2MdlmkTSl4ghkN3+nQ2otRa0QYUI
        X5g7yd6Eud+Vg=
Received: (qmail 12278 invoked from network); 7 Nov 2016 20:01:59 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 7 Nov 2016 20:01:59 +0100
Subject: [PATCH 2/3] gitk: remove closed file descriptors from $blobdifffd
To:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de>
 <e09a5309-351d-d246-d272-f527f50ad444@jump-ing.de>
Cc:     Paul Mackerras <paulus@ozlabs.org>
From:   Markus Hitter <mah@jump-ing.de>
Message-ID: <8e1c5923-d2a6-bc77-97ab-3f154b41d2ea@jump-ing.de>
Date:   Mon, 7 Nov 2016 20:01:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <e09a5309-351d-d246-d272-f527f50ad444@jump-ing.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 0a463fcd977dc9558835c373e24a095e35ca3c82 Mon Sep 17 00:00:00 2001
From: Markus Hitter <mah@jump-ing.de>
Date: Mon, 7 Nov 2016 16:01:17 +0100
Subject: [PATCH 2/3] gitk: remove closed file descriptors from $blobdifffd

One shouldn't have descriptors of already closed files around.

The first idea to deal with this (previously) ever growing array
was to remove it entirely, but it's needed to detect start of a
new diff with ths old diff not yet done. This happens when a user
clicks on the same commit in the commit list repeatedly without
delay.

Signed-off-by: Markus Hitter <mah@jump-ing.de>
---
 gitk | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/gitk b/gitk
index 8654e29..518a4ce 100755
--- a/gitk
+++ b/gitk
@@ -8069,7 +8069,11 @@ proc getblobdiffline {bdf ids} {
     $ctext conf -state normal
     while {[incr nr] <= 1000 && [gets $bdf line] >= 0} {
 	if {$ids != $diffids || $bdf != $blobdifffd($ids)} {
+	    # Older diff read. Abort it.
 	    catch {close $bdf}
+	    if {$ids != $diffids} {
+		array unset blobdifffd $ids
+	    }
 	    return 0
 	}
 	parseblobdiffline $ids $line
@@ -8078,6 +8082,7 @@ proc getblobdiffline {bdf ids} {
     blobdiffmaybeseehere [eof $bdf]
     if {[eof $bdf]} {
 	catch {close $bdf}
+	array unset blobdifffd $ids
 	return 0
     }
     return [expr {$nr >= 1000? 2: 1}]
-- 
2.9.3

