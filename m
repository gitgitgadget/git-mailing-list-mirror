Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7712C2D0EF
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 04:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF77206D9
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 04:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392038AbgDPEtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 00:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390974AbgDPEt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 00:49:29 -0400
X-Greylist: delayed 1470 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Apr 2020 21:49:29 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A019C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 21:49:29 -0700 (PDT)
Received: from p576124-ipngn200707tokaisakaetozai.aichi.ocn.ne.jp ([122.31.139.124] helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1jOw57-0006kZ-MZ
        for git@vger.kernel.org; Thu, 16 Apr 2020 04:24:54 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1jOw53-000GEC-BJ
        for git@vger.kernel.org; Thu, 16 Apr 2020 13:24:49 +0900
Date:   Thu, 16 Apr 2020 13:24:49 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: Order of operations at the end of fast-import?
Message-ID: <20200416042449.ztgyrdunsrzt7avp@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just noticed that the order of operations at the end of fast-import
are:
- end_packfile
- dump_branches
- dump_tags

The first may create loose objects if the pack is small (per
fastimport.unpackLimit, defaulting to 100). The latter two create refs.

There seems to be a theoretical race condition here, if something else
triggers a gc at the "wrong" time, the loose objects might be cleaned up
and the branches/tags refs become dangling.

I understand that the packfile does need to be finished before creating
the refs, and that the unpacking replaces that when there aren't enough
objects, but wouldn't it be more data-safe to actually finish the pack,
create the refs, and then unpack?

Mike
