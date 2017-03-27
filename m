Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E17711FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 21:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbdC0VJz (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 17:09:55 -0400
Received: from siwi.pair.com ([209.68.5.199]:47905 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751898AbdC0VJx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 17:09:53 -0400
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EA25384616;
        Mon, 27 Mar 2017 17:09:51 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 0/2] read-cache: call verify_hdr() in a background thread
Date:   Mon, 27 Mar 2017 21:09:37 +0000
Message-Id: <1490648979-49580-1-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 2 of this patch series simplifies this to just
turn off the hash verification.  Independent comments
from Linus and Peff suggested that we could just turn
this off and not worry about it.  So I've updated this
patch to do that.  I added a global variable to allow
the original code path to be used.  I also added a
t/helper command to demonstrate the differences.

On the Linux repo, the effect is rather trivial:

    $ ~/work/gfw/t/helper/test-skip-verify-index -c 3
    0.029884 0 [cache_nr 57994]
    0.031035 0 [cache_nr 57994]
    0.024308 0 [cache_nr 57994]
    0.028409 0 avg
    0.018359 1 [cache_nr 57994]
    0.017025 1 [cache_nr 57994]
    0.011087 1 [cache_nr 57994]
    0.015490 1 avg

On my Windows source tree (450MB index), I'm seeing a
savings of 0.6 seconds -- read_index() went from 1.2 to 0.6
seconds.

=====================

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

Jeff Hostetler (2):
  read-cache: skip index SHA verification
  skip_verify_index: helper test

 Makefile                          |  1 +
 cache.h                           |  5 +++
 read-cache.c                      |  6 ++++
 t/helper/.gitignore               |  1 +
 t/helper/test-skip-verify-index.c | 73 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+)
 create mode 100644 t/helper/test-skip-verify-index.c

-- 
2.7.4

