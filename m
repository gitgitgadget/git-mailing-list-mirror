Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC701FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 13:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756819AbdCXN2L (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 09:28:11 -0400
Received: from siwi.pair.com ([209.68.5.199]:40586 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755211AbdCXN2K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 09:28:10 -0400
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 451E684613;
        Fri, 24 Mar 2017 09:28:09 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH] read-cache: call verify_hdr() in a background thread
Date:   Fri, 24 Mar 2017 13:27:50 +0000
Message-Id: <1490362071-46932-1-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This patch contains a performance optimization to run
verify_hdr() in a background thread while the foreground
thread parses the index.  This allows do_read_index() to
complete faster.

This idea was recently discussed on the mailing list in:
https://public-inbox.org/git/85221b97-759f-b7a9-1256-21515d163cbf@jeffhostetler.com/
during a discussion on sha1dc.

Our testing on Windows showed that verifying the SHA1 hash
on the index file takes approximately the same amount of time
as parsing the file and building the array of cache_entries.
(It could also be that having 2 threads better ammortizes the
page faults of reading from the mmap'd file.)

An earlier version of this change has been in use in GfW since December:
https://github.com/git-for-windows/git/pull/978


Jeff Hostetler (1):
  read-cache: call verify_hdr() in a background thread

 read-cache.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

-- 
2.7.4

