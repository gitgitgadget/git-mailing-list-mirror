Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F66207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967223AbdDZUVz (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:21:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:56843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935988AbdDZUVx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:21:53 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Metpl-1dRUTH1m2b-00OZUE; Wed, 26
 Apr 2017 22:21:50 +0200
Date:   Wed, 26 Apr 2017 22:21:48 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 23/26] remote: plug memory leak in match_explicit()
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <de562a0f541a8b25a14d3cf80dc677c59f795b37.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:913KC9cDGnxMpiNhoq5GTxKVdSdZFXx2nDzgo5rUhVXh0cs8pUo
 k0PjB3pvU2X0a7LSMivbS+r10YDlZqIEHM+2B4o5N2X1kf3LnqsrwrxiIQpg4brzs9CwG99
 sKsjMbgvkggkHj5EfSw3+twal4/tkqX/utAFlxUhJjn/jeYnsLz6rjRpUVH0j/igqBIsHbl
 f8XX/4xTnc15vdTqOc/sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x6pybuIB/K0=:vdrEqJ0Rly4NKD3ecESqGF
 DqJdHsPqhUtYfJQGVtbSezdmltV2TCQcjIGR+LrJ00jyN74xUoCOcI74CVIOyLQHwqzSMpMrn
 yGXJPxcnI4FbF42hHzXkaDSyKXoy3Cf6ZIDly8xfOf5qAM9GJNd5YW+apgi7LQDd5enhglJbJ
 xDypMHt7kXOS+FOCGjgxq3Kf3TtP24Xy0ut0g9h0TztQIQB6eDM4CzTaI+EoU3mjxpY6qD4mc
 pOCVJN6VRX7+vFZcMwLRXCnnX+9sSt8tGmVl66bSzQ8/QtpBvIUWcEBHt/1N40Hi6IPiFUQmq
 0ofM/z/N1++URyUKRotgDYDe8ZtDjqZOaeg9+3Gka0ip1XisjNY0G26ZJYXatkSL3QdPV0W68
 EvcOIwYfyEGUytQ5p89DMk1iOCDbqt20oFeybidMPWIHE2ElgWQZRMjPEousoyYUs7Ga3UEY0
 X5y4Lf93RGXQNThVtFNR+zCmTqHMJNgvP1kcwFwSVjI6S6vjuXPfpSajovNfUGtneGflIEiyE
 K/NIkUyGvJjwHw9nQKrIUmsOKwmC+1p/LYoYR0tH8rCu7Vi2kDZGBkhu44i/tgupn8Qg5neUu
 DmpdJQnmvvFDlb6NnNdFnOcZq0Vyd1cxpI2PiOpCgj2p/fFJ7SqAm5rvDQ5Fh3V7EJ3w2Oy4X
 2Mdkh58sasyIUWj6K1nuk69SmW0xY+Vm0jfzUGujnEc7p/XA2lBO3hNUhvXOaU35Zy2DYoCed
 XnEZnEHYDrbicsxXrwIJofFxcwL9VAJsoYIoXBeI9ARhtWOjWuO4tv5cQbwSOjgnlvVph8dt7
 KmioDgm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `guess_ref()` returns an allocated buffer of which `make_linked_ref()`
does not take custody (`alloc_ref()` makes a copy), therefore we need to
release the buffer afterwards.

Noticed via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 801137c72eb..72b4591b983 100644
--- a/remote.c
+++ b/remote.c
@@ -1191,9 +1191,10 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		else if (is_null_oid(&matched_src->new_oid))
 			error("unable to delete '%s': remote ref does not exist",
 			      dst_value);
-		else if ((dst_guess = guess_ref(dst_value, matched_src)))
+		else if ((dst_guess = guess_ref(dst_value, matched_src))) {
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
-		else
+			free(dst_guess);
+		} else
 			error("unable to push to unqualified destination: %s\n"
 			      "The destination refspec neither matches an "
 			      "existing ref on the remote nor\n"
-- 
2.12.2.windows.2.800.gede8f145e06


