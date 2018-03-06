Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFADD1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 15:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeCFPYe (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 10:24:34 -0500
Received: from smtpcmd10108.aruba.it ([62.149.156.108]:47988 "EHLO
        smtpcmd10108.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753590AbeCFPYd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 10:24:33 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Mar 2018 10:24:33 EST
Received: from locati.it ([62.149.156.214])
        by smtpcmd10.ad.aruba.it with bizsmtp
        id JfHY1x00R4dpNnS01fHYcr; Tue, 06 Mar 2018 16:17:32 +0100
Date:   Tue,  6 Mar 2018 16:17:32 +0100
Message-Id: <P56D58$52E406B139FE9D3C295CB5ABAB5C8893@locati.it>
Subject: How to use filter-branch with --state-branch?
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   "Michele Locati" <michele@locati.it>
To:     git@vger.kernel.org
X-XaM3-API-Version: V4(R2)
X-SenderIP: 151.0.155.178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1520349452; bh=uax+cE9BsM9Gt3glIkn/P9ayIR5tGKffU0Lhor4/jRY=;
        h=Date:Subject:MIME-Version:Content-Type:From:To;
        b=blBXtMbYer7ubzkjkMadII8BGBGXSXon0UOfa+95CEDt3r1k1aiNbIhqKFjSO1TdG
         U2GKxwUq9eoewto31wn6AebqaHetDzFV59rPebbZTb6m540F+5EPyuSNSRJXtQafX/
         IZg71E59HhIu5nLT7lSq7Q/ZwWPF+UuxSqFtRkiHI8uB+Wh0LwCvcxCij7cUbvkyXl
         lqHbEUN59u0805blNcYs/Dvhdt4X4naAulDEPNDesBxuUOkEnyOUPHaIzXU/3HJSIB
         UEebGSeoG9elBSEvxdtTln6L6ZAifDwFORqoS0Oxf8oTJVq7p8zQQ2D5GoKU+9LXWr
         g9NmKrrKkYL/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recent versions of git filter-branch command introduced the --state-branc=
h
option.
BTW I can't find any info about how this can be actually used.

We have this repository on github:
https://github.com/concrete5/concrete5

When someone pushes to that repo, we clone it and execute
`git filter-branch --subdirectory-filter concrete`
to extract the concrete directory, and we push the result to
https://github.com/concrete5/concrete5-core
(including all the branches and tags)

The script at the moment is this one:
https://github.com/concrete5/core_splitter/blob/70879e676b95160f7fc5d0ffc=
22b8f7420b0580b/bin/splitcore

I tried to use the --state-branch option on a local mirror, so that we co=
uld
do an incremental filtering. Here's the script:

# Executed just one time
git clone --no-checkout --mirror \
   https://github.com/concrete5/concrete5.git work
cd work
git filter-branch \
   --subdirectory-filter concrete \
   --tag-name-filter cat \
   --prune-empty \
   --state-branch FILTERBRANCH_STATE \
   -- --all
# Executed every time the repo is updated
git remote update --prune
git filter-branch \
   --subdirectory-filter concrete \
   --tag-name-filter cat \
   --prune-empty \
   --state-branch FILTERBRANCH_STATE \
   -- --all

The first filter-branch call required 7168 steps, so did the second call.=
..
I also tried without the --prune option of remote update (I had to add
--force to the second filter-branch), but nothing changed.
