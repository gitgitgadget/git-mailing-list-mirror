Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2581FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 15:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbdJKPaW (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 11:30:22 -0400
Received: from continuum.iocl.org ([217.140.74.2]:35707 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdJKPaT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 11:30:19 -0400
X-Greylist: delayed 1469 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Oct 2017 11:30:18 EDT
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id v9BF5k609874;
        Wed, 11 Oct 2017 17:05:46 +0200
Date:   Wed, 11 Oct 2017 17:05:46 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     Git Users <git@vger.kernel.org>
Subject: git repack leaks disk space on ENOSPC
Message-ID: <20171011150546.GC32090@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I observed (again) an annoying behavior of 'git repack':
When the new pack file cannot be fully written because
the disk gets full beforehand, the tmp_pack file isn't
deleted, meaning the disk stays full:

  $ df -h .; git repack -ad; df -h .; ls -lart .git/objects/pack/tmp*; rm .git/objects/pack/tmp*; df -h .
  Filesystem                        Size  Used Avail Use% Mounted on
  /dev/mapper/vg02-localworkspaces  250G  245G  5.1G  98% /workspaces/calvin
  Counting objects: 4715349, done.
  Delta compression using up to 8 threads.
  Compressing objects: 100% (978051/978051), done.
  fatal: sha1 file '.git/objects/pack/tmp_pack_xB7DMt' write error: No space left on device
  Filesystem                        Size  Used Avail Use% Mounted on
  /dev/mapper/vg02-localworkspaces  250G  250G   20K 100% /workspaces/calvin
  -r--r--r-- 1 andrkrey users 5438435328 Oct 11 17:03 .git/objects/pack/tmp_pack_xB7DMt
  rm: remove write-protected regular file '.git/objects/pack/tmp_pack_xB7DMt'? y
  Filesystem                        Size  Used Avail Use% Mounted on
  /dev/mapper/vg02-localworkspaces  250G  245G  5.1G  98% /workspaces/calvin

- Andreas

git version 2.15.0.rc0

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
