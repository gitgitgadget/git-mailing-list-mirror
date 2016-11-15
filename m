Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735842021E
	for <e@80x24.org>; Tue, 15 Nov 2016 19:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933845AbcKOTKq (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 14:10:46 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:37861 "EHLO
        homiemail-a62.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933649AbcKOTKq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Nov 2016 14:10:46 -0500
Received: from homiemail-a62.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a62.g.dreamhost.com (Postfix) with ESMTP id 4C898634082;
        Tue, 15 Nov 2016 11:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        in-reply-to:references:from:date:subject:to:cc
        :content-transfer-encoding:message-id:mime-version; s=
        mattmccutchen.net; bh=MVZ94N29pN36aa2pKzlY9J/baeM=; b=J0bMXNXxri
        JD/v8SV11SnFePhSK5+FbBXRM9ZlpFCg7lfjcFGLGHWBSINMU5QW2+5f5hCAKDDo
        h8K+CG3RehuJtnLFwUJPr1NUX5rKpORyDaMp5T68NcDPT+Y8GgUAKa8UC121UV0S
        PsjQMUo6ZdqdAUGw837UjHrB4RwRdWzng=
Received: from main (30-10-119.wireless.csail.mit.edu [128.30.10.119])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a62.g.dreamhost.com (Postfix) with ESMTPSA id EC78B63407C;
        Tue, 15 Nov 2016 11:10:44 -0800 (PST)
In-Reply-To: <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net>
References: <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net>
From:   Matt McCutchen <matt@mattmccutchen.net>
Date:   Tue, 15 Nov 2016 14:08:51 -0500
Subject: [PATCH] git-gc.txt: expand discussion of races with other processes
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 7bit
Message-ID: <1479237042.2406.89.camel@mattmccutchen.net>
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In general, "git gc" may delete objects that another concurrent process
is using but hasn't created a reference to.  Git has some mitigations,
but they fall short of a complete solution.  Document this in the
git-gc(1) man page and add a reference from the documentation of the
gc.pruneExpire config variable.

Based on a write-up by Jeff King:

http://marc.info/?l=git&m=147922960131779&w=2

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
 Documentation/config.txt |  4 +++-
 Documentation/git-gc.txt | 34 ++++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 21fdddf..3f1d931 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1409,7 +1409,9 @@ gc.pruneExpire::
 	Override the grace period with this config variable.  The value
 	"now" may be used to disable this grace period and always prune
 	unreachable objects immediately, or "never" may be used to
-	suppress pruning.
+	suppress pruning.  This feature helps prevent corruption when
+	'git gc' runs concurrently with another process writing to the
+	repository; see the "NOTES" section of linkgit:git-gc[1].
 
 gc.worktreePruneExpire::
 	When 'git gc' is run, it calls
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index bed60f4..852b72c 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -63,11 +63,10 @@ automatic consolidation of packs.
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
 	overridable by the config variable `gc.pruneExpire`).
-	--prune=all prunes loose objects regardless of their age (do
-	not use --prune=all unless you know exactly what you are doing.
-	Unless the repository is quiescent, you will lose newly created
-	objects that haven't been anchored with the refs and end up
-	corrupting your repository).  --prune is on by default.
+	--prune=all prunes loose objects regardless of their age and
+	increases the risk of corruption if another process is writing to
+	the repository concurrently; see "NOTES" below. --prune is on by
+	default.
 
 --no-prune::
 	Do not prune any loose objects.
@@ -138,17 +137,36 @@ default is "2 weeks ago".
 Notes
 -----
 
-'git gc' tries very hard to be safe about the garbage it collects. In
+'git gc' tries very hard not to delete objects that are referenced
+anywhere in your repository. In
 particular, it will keep not only objects referenced by your current set
 of branches and tags, but also objects referenced by the index,
 remote-tracking branches, refs saved by 'git filter-branch' in
 refs/original/, or reflogs (which may reference commits in branches
 that were later amended or rewound).
-
-If you are expecting some objects to be collected and they aren't, check
+If you are expecting some objects to be deleted and they aren't, check
 all of those locations and decide whether it makes sense in your case to
 remove those references.
 
+On the other hand, when 'git gc' runs concurrently with another process,
+there is a risk of it deleting an object that the other process is using
+but hasn't created a reference to. This may just cause the other process
+to fail or may corrupt the repository if the other process later adds a
+reference to the deleted object. Git has two features that significantly
+mitigate this problem:
+
+. Any object with modification time newer than the `--prune` date is kept,
+  along with everything reachable from it.
+
+. Most operations that add an object to the database update the
+  modification time of the object if it is already present so that #1
+  applies.
+
+However, these features fall short of a complete solution, so users who
+run commands concurrently have to live with some risk of corruption (which
+seems to be low in practice) unless they turn off automatic garbage
+collection with 'git config gc.auto 0'.
+
 HOOKS
 -----
 
-- 
2.7.4


