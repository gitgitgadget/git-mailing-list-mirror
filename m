Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304371F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968352AbeCSR4S (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:56:18 -0400
Received: from avasout04.plus.net ([212.159.14.19]:53032 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965686AbeCSR4N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:56:13 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id xz11eXQqesD7bxz12e8N7q; Mon, 19 Mar 2018 17:56:12 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=WGXUhORLsxBks2-AVLEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/2] read-cache: fix an -Wmaybe-uninitialized warning
Message-ID: <6d434e76-cfa0-2a6e-f163-b54316a24cee@ramsayjones.plus.com>
Date:   Mon, 19 Mar 2018 17:56:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOmj39MAuA/Ep/KwV4VHrCPNrBum7CmV8m+gqT96uquEfablYqN3lvvXN586Ws4FRk2D8vFFo2qafiaDgHXo4zVfaxQBp/k/Ex/gLUdv35/Lm4BXiQn4
 cZ1C4iQj0DlSNzPHBLSKg7Oi4tvn3QBctsZBKFjRTBfJn9Na6mqD0oTS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The function ce_write_entry() uses a 'self-initialised' variable
construct, for the symbol 'saved_namelen', to suppress a gcc
'-Wmaybe-uninitialized' warning, given that the warning is a false
positive.

For the purposes of this discussion, the ce_write_entry() function has
three code blocks of interest, that look like so:

        /* block #1 */
        if (ce->ce_flags & CE_STRIP_NAME) {
                saved_namelen = ce_namelen(ce);
                ce->ce_namelen = 0;
        }

        /* block #2 */
        /*
	 * several code blocks that contain, among others, calls
         * to copy_cache_entry_to_ondisk(ondisk, ce);
         */

        /* block #3 */
        if (ce->ce_flags & CE_STRIP_NAME) {
                ce->ce_namelen = saved_namelen;
                ce->ce_flags &= ~CE_STRIP_NAME;
        }

The warning implies that gcc thinks it is possible that the first
block is not entered, the calls to copy_cache_entry_to_ondisk()
could toggle the CE_STRIP_NAME flag on, thereby entering block #3
with saved_namelen unset. However, the copy_cache_entry_to_ondisk()
function does not write to ce->ce_flags (it only reads). gcc could
easily determine this, since that function is local to this file,
but it obviously doesn't.

In order to suppress this warning, we make it clear to the reader
(human and compiler), that block #3 will only be entered when the
first block has been entered, by introducing a new 'stripped_name'
boolean variable. We also take the opportunity to change the type
of 'saved_namelen' to 'unsigned int' to match ce->ce_namelen.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 read-cache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b..49607ddcd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2104,13 +2104,15 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 			  struct strbuf *previous_name, struct ondisk_cache_entry *ondisk)
 {
 	int size;
-	int saved_namelen = saved_namelen; /* compiler workaround */
 	int result;
+	unsigned int saved_namelen;
+	int stripped_name = 0;
 	static unsigned char padding[8] = { 0x00 };
 
 	if (ce->ce_flags & CE_STRIP_NAME) {
 		saved_namelen = ce_namelen(ce);
 		ce->ce_namelen = 0;
+		stripped_name = 1;
 	}
 
 	if (ce->ce_flags & CE_EXTENDED)
@@ -2150,7 +2152,7 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
 		strbuf_splice(previous_name, common, to_remove,
 			      ce->name + common, ce_namelen(ce) - common);
 	}
-	if (ce->ce_flags & CE_STRIP_NAME) {
+	if (stripped_name) {
 		ce->ce_namelen = saved_namelen;
 		ce->ce_flags &= ~CE_STRIP_NAME;
 	}
-- 
2.16.0
