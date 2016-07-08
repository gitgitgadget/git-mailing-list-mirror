Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109BC2023C
	for <e@80x24.org>; Fri,  8 Jul 2016 11:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbcGHLnJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 07:43:09 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:46864 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177AbcGHLnI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 07:43:08 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bLUBS-0005e9-J9
	for git@vger.kernel.org; Fri, 08 Jul 2016 20:43:02 +0900
Date:	Fri, 8 Jul 2016 20:43:02 +0900
From:	Mike Hommey <mh@glandium.org>
To:	git@vger.kernel.org
Subject: Integer-overflow in read-cache.c can cause buffer-overflow (bug
 requires a crafted/corrupted index)
Message-ID: <20160708114302.GA20350@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

I had a procastination episode today and wrote
https://glandium.org/blog/?p=3659 . It started with me looking what git
was doing with the size of the index when writing the index header,
leading me to find a rather improbable integer overflow in
https://github.com/git/git/blob/5c589a73de4394ad125a4effac227b3aec856fa1/read-cache.c#L1040
requiring hundreds of gigabytes of memory before happening.

But right after I finished the post and clicked "publish", I actually
looked at the reading side and found another separate integer overflow
that can lead to buffer overflow.

The possible integer overflow is here:
https://github.com/git/git/blob/5c589a73de4394ad125a4effac227b3aec856fa1/read-cache.c#L1589

where alloc_nr is:
#define alloc_nr(x) (((x)+16)*3/2)

So a crafter header with a number of entries above 1.something billion
would overflow (cache_nr is an unsigned int), and istate->cache would
be allocated with less than it should.

Then there can be a buffer overflow when reading the entries.

But this all require a crafted or corrupted index. If an attacker has
been able to alter your index, you've already lost.

So I'd say the risk is rather low on the security scale.

Cheers,

Mike
