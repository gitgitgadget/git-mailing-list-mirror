Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URI_HEX
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2EF20756
	for <e@80x24.org>; Thu, 12 Jan 2017 08:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbdALIay (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 03:30:54 -0500
Received: from acme.spoerlein.net ([46.20.246.113]:39466 "EHLO
        acme.spoerlein.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdALIaw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 03:30:52 -0500
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jan 2017 03:30:51 EST
Received: from localhost (acme.spoerlein.net [IPv6:2a02:2528:fa:1000:0:0:0:1])
        by acme.spoerlein.net (8.15.2/8.15.2) with ESMTPS id v0C8Lc2V050279
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jan 2017 09:21:39 +0100 (CET)
        (envelope-from uqs@FreeBSD.org)
Date:   Thu, 12 Jan 2017 09:21:38 +0100
From:   Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@FreeBSD.org>
To:     git@vger.kernel.org
Cc:     Ed Maste <emaste@freebsd.org>
Subject: git fast-import crashing on big imports
Message-ID: <20170112082138.GJ4426@acme.spoerlein.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

the FreeBSD svn2git conversion is crashing somewhat
non-deterministically during its long conversion process. From memory,
this was not as bad is it is with more recent versions of git (but I
can't be sure, really).

I have a dump file that you can grab at
http://scan.spoerlein.net/pub/freebsd-base.dump.xz (19G, 55G uncompressed)
that shows this problem after a couple of minutes of runtime. The caveat is
that for another member of the team on a different machine the crashes are on
different revisions.

Googling around I found two previous threads that were discussing
problems just like this (memory corruption, bad caching, etc)

https://www.spinics.net/lists/git/msg93598.html  from 2009
and
http://git.661346.n2.nabble.com/long-fast-import-errors-out-quot-failed-to-apply-delta-quot-td6557884.html
from 2011

% git fast-import --stats < ../freebsd-base.dump
...
progress SVN r49318 branch master = :49869
progress SVN r49319 branch stable/3 = :49870
progress SVN r49320 branch master = :49871
error: failed to apply delta
error: bad offset for revindex
error: bad offset for revindex
error: bad offset for revindex
error: bad offset for revindex
error: bad offset for revindex
fatal: Can't load tree b35ae4e9c2a41677e84a3f14bed09f584c3ff25e
fast-import: dumping crash report to fast_import_crash_29613


fast-import crash report:
    fast-import process: 29613
    parent process     : 29612
    at 2017-01-11 19:33:37 +0000

fatal: Can't load tree b35ae4e9c2a41677e84a3f14bed09f584c3ff25e


git fsck shows a somewhat incomplete pack file (I guess that's expected if the
process dies mid-stream?)

% git fsck
Checking object directories: 100% (256/256), done.
error: failed to apply delta6/614500)
error: cannot unpack d1d7ee1f81c6767c5e0f75d14d400d7512a85a0f from ./objects/pack/pack-e28fcea43fc221d2ebe92857b484da58bb888237.pack at offset 122654805
error: failed to apply delta
error: failed to read delta base object d1d7ee1f81c6767c5e0f75d14d400d7512a85a0f at offset 122654805 from ./objects/pack/pack-e28fcea43fc221d2ebe92857b484da58bb888237.pack
error: cannot unpack 8523bde63ef34bef725347994fdaec996d756510 from ./objects/pack/pack-e28fcea43fc221d2ebe92857b484da58bb888237.pack at offset 122671596
error: failed to apply delta0/614500)
error: failed to read delta base object d1d7ee1f81c6767c5e0f75d14d400d7512a85a0f at offset 122654805 from ./objects/pack/pack-e28fcea43fc221d2ebe92857b484da58bb888237.pack
...


Any comments on whether the original problems from 2009 and 2011 were ever
fixed and committed?

Some more facts:
- git version 2.11.0
- I don't recall these sorts of crashes with a git from 2-3 years ago
- adding more checkpoints does help, but not fix the problem, it merely shifts
  the crashes around to different revisions
- incremental runs of the conversion *will* complete most of the time, but
  depending on how often checkpoints are used, I've seen it croak on specific
  commits and not being able to progress further :(

Thanks for any pointers or things to try!
Cheers
Uli
