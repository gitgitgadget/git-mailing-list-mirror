Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F1E20986
	for <e@80x24.org>; Tue,  4 Oct 2016 15:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbcJDPIv (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 11:08:51 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:55418 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbcJDPIu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 11:08:50 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1brRKq-00026D-00; Tue, 04 Oct 2016 15:08:48 +0000
Date:   Tue, 4 Oct 2016 11:08:48 -0400
From:   Rich Felker <dalias@libc.org>
To:     git@vger.kernel.org
Cc:     musl@lists.openwall.com
Subject: Regression: git no longer works with musl libc's regex impl
Message-ID: <20161004150848.GA7949@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit broke support for using git with musl libc:

https://github.com/git/git/commit/2f8952250a84313b74f96abb7b035874854cf202

Rather than depending on non-portable GNU regex extensions, there is a
simple portable fix for the issue this code was added to work around:
When a text file is being mmapped for use with string functions which
depend on null termination, if the file size:

1. is nonzero mod page size, it just works; the remainder of the last
   page reads as zero bytes when mmapped.

2. if an exact multiple of the page size, then instead of directly
   mmapping the file, first mmap a mapping 1 byte (thus 1 page) larger
   with MAP_ANON, then use MAP_FIXED to map the file over top of all
   but the last page. Now the mmapped buffer can safely be used as a C
   string.

If such a solution is acceptable I can try to prepare a patch.

Rich
