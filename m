Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 771322013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbdBPAWW (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:22:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:42629 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754119AbdBPAWU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:22:20 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2017 16:22:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,167,1484035200"; 
   d="scan'208";a="1127483886"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.35.174])
  by fmsmga002.fm.intel.com with ESMTP; 15 Feb 2017 16:22:14 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3] reset: add an example of how to split a commit into two
Date:   Wed, 15 Feb 2017 16:22:12 -0800
Message-Id: <20170216002212.31088-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.12.0.rc0.177.g63172abf21d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

It is often useful to break a commit into multiple parts that are more
logical separations. This can be tricky to learn how to do without the
brute-force method if re-writing code or commit messages from scratch.

Add a section to the git-reset documentation which shows an example
process for how to use git add -p and git commit -c HEAD@{1} to
interactively break a commit apart and re-use the original commit
message as a starting point when making the new commit message.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
The interdiff between v2 and v3 is not really worth showing since I
basically re-wrote the entire section a bit. I reworded the descriptions
and steps to indicate that you can break a commit apart into an
arbitrary number of separate commits. I also added a bit more
explanation to each step, and separately numbered the "repeat some steps
multiple times" portion.

 Documentation/git-reset.txt | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 25432d9257f9..67a63574092d 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -292,6 +292,54 @@ $ git reset --keep start                    <3>
 <3> But you can use "reset --keep" to remove the unwanted commit after
     you switched to "branch2".
 
+Split a commit apart into a sequence of commits::
++
+Suppose that you have create lots of logically separate changes and commit them
+together. Then, later you decide that it might be better to have each logical
+chunk associated with its own commit. You can use git reset to rewind history
+without changing the contents of your local files, and then successively use
+git add -p to interactively select which hunks to include into each commit,
+using git commit -c to pre-populate the commit message.
++
+------------
+$ git reset -N HEAD^                        <1>
+$ git add -p                                <2>
+$ git diff --cached                         <3>
+$ git commit -c HEAD@{1}                    <4>
+...                                         <5>
+$ git add ...                               <6>
+$ git diff --cached                         <7>
+$ git commit ...                            <8>
+------------
++
+<1> First, reset the history back one commit so that we remove the original
+    commit, but leave the working tree with all the changes. The -N ensures
+    that any new files added with HEAD are still marked so that git add -p
+    will find them.
+<2> Next, we interactively select diff hunks to add using the git add -p
+    facility. This will ask you about each diff hunk in sequence and you can
+    use simple commands such as "yes, include this", "No don't include this"
+    or even the very powerful "edit" facility.
+<3> Once satisfied with the hunks you want to include, you should verify what
+    has been prepared for the first commit by using git diff --cached. This
+    shows all the changes that have been moved into the index and are about
+    to be committed.
+<4> Next, commit the changes stored in the index. The -c option specifies to
+    pre-populate the commit message from the original message that you started
+    with in the first commit. This is helpful to avoid retyping it. The HEAD@{1}
+    is a special notation for the commit that HEAD used to be at prior to the
+    original reset commit (1 change ago). See linkgit:git-reflog[1] for more
+    details. You may also use any other valid commit reference.
+<5> You can repeat steps 2-4 multiple times to break the original code into
+    any number of commits.
+<6> Now you've split out many of the changes into their own commits, and might
+    no longer use the patch mode of git add, in order to select all remaining
+    uncommitted changes.
+<7> Once again, check to verify that you've included what you want to. You may
+    also wish to verify that git diff doesn't show any remaining changes to be
+    committed later.
+<8> And finally create the final commit.
+
 
 DISCUSSION
 ----------
-- 
2.12.0.rc0.177.g63172abf21d0

