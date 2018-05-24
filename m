Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AF821F42D
	for <e@80x24.org>; Thu, 24 May 2018 23:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964990AbeEXXCg (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 19:02:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:40110 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935346AbeEXXCf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 19:02:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2018 16:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,437,1520924400"; 
   d="scan'208";a="53658204"
Received: from mwm-dev.jf.intel.com ([10.54.75.6])
  by orsmga003.jf.intel.com with ESMTP; 24 May 2018 16:02:34 -0700
From:   Mike Mason <michael.w.mason@intel.com>
To:     marc.herbert@intel.com
Cc:     andy.work@nglowry.com, git@vger.kernel.org, gitster@pobox.com,
        josh@joshtriplett.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, lists@nerdbynature.de,
        michael.w.mason@intel.com, peff@peff.net,
        nico-linuxsetlocalversion@schottelius.org
Subject: Re: Wrong -dirty suffix set by setlocalversion (was: BUG in git diff-index) 
Date:   Thu, 24 May 2018 16:03:34 -0700
Message-Id: <20180524230334.12452-1-michael.w.mason@intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <89d82c84-7a3b-9c4c-679e-a7a723669592@intel.com>
References: <89d82c84-7a3b-9c4c-679e-a7a723669592@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How about something like this? It ignores attributes that should have no
bearing on whether the kernel is considered dirty. Copied trees with no other
changes would no longer be marked with -dirty. Plus it works on read-only
media since no index updating is required.

Would this also be considered kosher, at least for the purposes of
setlocalversion?

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 71f39410691b..9da4c5e83285 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -73,8 +73,10 @@ scm_version()
 			printf -- '-svn%s' "`git svn find-rev $head`"
 		fi
 
-		# Check for uncommitted changes
-		if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
+		# Check for uncommitted changes. Only check mtime and size.
+       # Ignore insequential ctime, uid, gid and inode differences.
+		if git -c "core.checkstat=minimal" diff-index --name-only HEAD | \
+				grep -qv "^scripts/package"; then
 			printf '%s' -dirty
 		fi
 
