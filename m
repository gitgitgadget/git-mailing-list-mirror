Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96BD201A7
	for <e@80x24.org>; Mon, 15 May 2017 20:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964926AbdEOUFd (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 16:05:33 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:14585 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932677AbdEOUFc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 16:05:32 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wRWlt3zn3z5tlF;
        Mon, 15 May 2017 22:05:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B1AE9EF;
        Mon, 15 May 2017 22:05:29 +0200 (CEST)
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: t5400 failure on Windows
Message-ID: <50f6d8b7-383b-7673-22ad-9a9b80bec2d1@kdbg.org>
Date:   Mon, 15 May 2017 22:05:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I observe the following failure on Windws with origin/next, in
t5400-send-pack.sh

+++ diff -u expect refs
--- expect      Mon May 15 06:54:59 2017
+++ refs        Mon May 15 06:54:59 2017
@@ -1,4 +1,3 @@
 5285e1710002a06a379056b0d21357a999f3c642 refs/heads/master
-5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/HEAD
 5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/master
 53d9066ca10f2e103b33caf3a16a723553c33b00 .have
error: last command exited with $?=1
not ok 16 - receive-pack de-dupes .have lines


The trace file looks like this:

-------- trace --------
packet: receive-pack> 5285e1710002a06a379056b0d21357a999f3c642 refs/heads/master\0report-status delete-refs side-band-64k quiet atomic ofs-delta agent=git/2.13.0.497.g5af12421b0
packet: receive-pack> 5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/HEAD
packet:         push< 5285e1710002a06a379056b0d21357a999f3c642 refs/heads/master\0report-status delete-refs side-band-64k quiet atomic ofs-delta agent=git/2.13.0.497.g5af12421b0
packet: receive-pack> 5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/master
packet:         push< 5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/master
packet: receive-pack> 53d9066ca10f2e103b33caf3a16a723553c33b00 .have
packet:         push< 53d9066ca10f2e103b33caf3a16a723553c33b00 .have
packet: receive-pack> 0000
packet:         push< 0000
packet:         push> 0000000000000000000000000000000000000000 b1a1c97e94b6388c108e195d28a3e89f00c81698 refs/heads/foo\0 report-status agent=git/2.13.0.497.g5af12421b0
packet:         push> 0000
packet: receive-pack< 0000000000000000000000000000000000000000 b1a1c97e94b6388c108e195d28a3e89f00c81698 refs/heads/foo\0 report-status agent=git/2.13.0.497.g5af12421b0
packet: receive-pack< 0000
packet: receive-pack> unpack ok
packet: receive-pack> ok refs/heads/foo
packet: receive-pack> 0000
packet:         push< unpack ok
packet:         push< ok refs/heads/foo
packet:         push< 0000
-------- end of trace --------

Where should I start looking? On a Linux box, the test case does
produce an additional line

packet:         push< 5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/HEAD

in the trace file. I also do not see that any tests would be skipped
on Windows. (But I forgot to check whether refs/remotes/origin/HEAD
is present in any of the repositories.)

-- Hannes
