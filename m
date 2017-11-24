Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE56820954
	for <e@80x24.org>; Fri, 24 Nov 2017 07:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbdKXHjO (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 02:39:14 -0500
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:53174 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbdKXHjN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 02:39:13 -0500
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Nov 2017 02:39:12 EST
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id A79F63C0016
        for <git@vger.kernel.org>; Fri, 24 Nov 2017 08:33:37 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QdQFMIdd8gIb for <git@vger.kernel.org>;
        Fri, 24 Nov 2017 08:33:31 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 3F4313C07D3
        for <git@vger.kernel.org>; Fri, 24 Nov 2017 08:33:31 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 24 Nov
 2017 08:33:31 +0100
Date:   Fri, 24 Nov 2017 08:33:27 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     <git@vger.kernel.org>
CC:     <erosca@de.adit-jv.com>
Subject: Make patch-id more flexible?
Message-ID: <20171124073327.GA15188@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git Community,

This is my first post to the git mailing list, so I would first like to
express my gratitude to everyone involved in developing one of my
favorite development tools.

I will make my question short and concrete. My day to day job is doing
Linux kernel integration, which also includes importing of out-of-tree
kernel modules into the kernel tree. Our team extensively uses cherry
picking for integration purpose, since most often merging work is simply
not possible because of a different kernel base used by our suppliers.
We don't rebase remote commits --onto our repository/branch, since
(compared to `git cherry-pick -x`) `git rebase --onto` doesn't
add source/origin information to commit description. The `(cherry
picked from *)` line is extremely helpful in generating proper commit
statistics on a given branch, which is interesting because of a high
amount of commits coming from various non-vanilla remotes.

Reviewing the cherry picked commits, we extensively rely on patch id
comparison. We've developed scripts that extract the remote commit hash
from the `(cherry picked from <commit-id>)` line in the commit
description, in order to produce tables like below:

Remote-commit-id   Local-commit-id    Patch-id-mismatch?
<rem-commit-id-1>  <loc-commit-id-1>  No
<rem-commit-id-2>  <loc-commit-id-2>  Yes
---------------------------------
<rem-commit-id-N>  <loc-commit-id-N>  No

This information helps the reviewer identify the non-clean picks, which
are oftentimes (but not always) caused by manual conflict resolution,
which we try to briefly document in square brackets above the
`Signed-off-by` signature. We feel that documenting any manual conflict
resolution is important, as it can be source of bugs if not done
properly.

Troubles begin when we import out-of-tree kernel modules in-tree (some
suppliers delivery many of them). We use subtree cherry picking [1] for
that. Because subtree strategy alters the file-names, there will always
be a patch id mismatch between the origin commit and its pick. To
overcome this, we are using alternatives to `git patch-id`, which ignore
file-names. Here comes my actual question. Would it be conceptually fine
to implement some `git patch-id` parameter, which would allow ignoring
the file-names (or reducing those to their `basename`) before computing
the patch id? Or would it break the concept of patch id (which shouldn't
accept variations)?

Thank you.
Eugeniu.

[1] git cherry-pick -x -s --no-merges --strategy=subtree -Xsubtree=drivers/staging/mymodule <commit-X>..<commit-Y>
