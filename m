Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8FCD1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 19:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbfKGTIG (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 14:08:06 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196]:51803 "EHLO
        smtp1.lauterbach.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfKGTIF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 14:08:05 -0500
Received: (qmail 2045 invoked by uid 484); 7 Nov 2019 19:08:04 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.10.40 by smtp1.lauterbach.com (envelope-from <ingo.rohloff@lauterbach.com>, uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.10.40):. 
 Processed in 0.085952 secs); 07 Nov 2019 19:08:04 -0000
Received: from unknown (HELO ingpc3.intern.lauterbach.com) (Authenticated_SSL:irohloff@[10.2.10.40])
          (envelope-sender <ingo.rohloff@lauterbach.com>)
          by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <git@vger.kernel.org>; 7 Nov 2019 19:08:03 -0000
From:   Ingo Rohloff <ingo.rohloff@lauterbach.com>
To:     git@vger.kernel.org
Cc:     Ingo Rohloff <ingo.rohloff@lauterbach.com>
Subject: [PATCH v2 0/4] Do not create new refnames "refs" or "refs/*"
Date:   Thu,  7 Nov 2019 20:07:46 +0100
Message-Id: <20191107190750.26674-1-ingo.rohloff@lauterbach.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191106165628.28563-1-ingo.rohloff@lauterbach.com>
References: <20191106165628.28563-1-ingo.rohloff@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type:   text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the previous round of input:
The intention of this patch series is to make sure, that you always
might use "refs/<something>" to unambiguously refer to a specific 
reference.

Or put in another way: With this patch series, refnames for "git log", 
starting with "refs/" should never result in a
  warning: refname '...' is ambiguous.
Exceptions: 
You already have strangely named references in your repository.
You pull such strangely named references from a remote repository.

This patch series does not prevent you from creating various other
forms of ambiguous refnames. Example:

    git branch origin/master

This will very likely result in an ambiguity, because now the
references

   refs/heads/origin/master
   refs/remotes/origin/master

will very likely both exist. "origin/master" matches both refnames.

This patch series forbids to create new reference names, which start
with "refs" or "refs/*" with the commands

  git branch <name>
  git checkout -b <name>
  git tag <name>
  git remote add <name>

Note: This patch does NOT prevent you from working with references
which already exist.  It just prevents you from creating new ones
with the commands listed above.

That's also the reason why the '--force' option is not evaluated here.
I cannot think of a good reason, why you ever should want to create
refnames matching any of the following patterns:
   refs/heads/refs/*
   refs/tags/refs/*
   refs/remotes/refs/*
  

Ingo Rohloff (4):
  refs: new function newname_has_bad_prefix
  branch: Prevent creation of local branches named "refs" or "refs/*"
  remote: Prevent users from creating remotes named "refs" or "refs/*"
  tag: Prevent users from creating tags named "refs" or "refs/*"

 builtin/branch.c   |  6 ++++++
 builtin/checkout.c |  3 +++
 builtin/remote.c   |  3 +++
 builtin/tag.c      |  3 +++
 refs.c             | 30 ++++++++++++++++++++++++++++++
 refs.h             |  2 ++
 6 files changed, 47 insertions(+)

-- 
2.24.0

