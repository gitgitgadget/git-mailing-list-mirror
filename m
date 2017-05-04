Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F14207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755320AbdEDN7c (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:59:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:51202 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755483AbdEDN7T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:59:19 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LqALY-1djzks06Ma-00dm6A; Thu, 04
 May 2017 15:59:02 +0200
Date:   Thu, 4 May 2017 15:59:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 22/25] remote: plug memory leak in match_explicit()
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <9bfe852b8f8e4abd1ec4ffea9b2f9867a8bb167b.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Cedot9xelgzEyBMN173qi8DNzLcV3n1nEXbt0k1NefU9WRd8I92
 CQSnMuFUh7JFVb72g/kxUmiQoOnRGJpBAWZIj2ZWr+jMH6JXNUNuBpERczl/gMexOJ7Il4s
 blPcSaNAba1xv7EWzLHLGg0cUJWHf2dwyIOnpuDKiNMFoA5wv+byQtcSvcyP+k3lUXkEAEN
 9hei6LjNYNrNwwKasoqRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N9AoSE34D0k=:MeGLLxNx5S2m10LAwUuzx0
 2/8YqcHRdfZUkvgP2H+hygxRk4Q7aDQV3uubzi1LX646XBVWfyKU+PgafnAAaeURLOjVlkYBA
 7O0xiwhw7ebnrnbfCEPuDc7x3V8CeTB6z1ylDcy+r4CFfOFdh8LItfsfucmTwG1ehffJRnZUz
 pEEN/hCz2aahmy41ZBEsRIEAbtIN8BVvqs2EGrAf192wylVfKDTwAQlrKZiOFU6JT6VnoC2JK
 YXvvr3KhNEcUMED+WNseJ0syH94DVBYNfBfyk8+93Mk5VyRQnAmSJnhbsB3RRb6IXDAKbdyec
 NQCIvU1bb7OAKD9xlq+RkFKRIal8OiMQiMS3wy8J+SPloo/cO+2PJqfBNvcisbkOgzji2eHA/
 pnFikxi9GDZ2wm12gdFpwGavbpuz5AK0NfCmYApSkouOw+Nr1+5RAlFAGWjE5r07JG0XNlXvw
 3N2bk0pIt8EFgBievJJpORLpbdX1+8khfKW7s9szkWlyMTjEliRPWZHMkVinP9tMXDNULKdV6
 WLwonFLLTInzYG8y8IGbOZV9pRs5j33ywMm1PZyMVtl1e1OEDAfhG8ZZ+eqxWgTPTdVtFZome
 JrO4w3/l629NZeDS6hz7afTwCPnl/T8FbupMjLSvckfkUszp8eHKPyJX9n8dH0ufDUyDvwF0W
 QycT/9KNLscBFo+WadFYF5LljOpIYVj/SYx5c+AWdkKPxVKdMR8bIHglF5zICxbbrF3zseVLf
 W5ne4VdLlLrmg5vdH6fx8bN7X/AKbtOnXFJPDPvWKHlbMWk1YN/WvbY/N2qs7nFR3giRrZ+KO
 cG3DOKm
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


