Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52864C433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A0220767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JFFQQOad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgFVSEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:04:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40002 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730296AbgFVSEd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 14:04:33 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0013A60436;
        Mon, 22 Jun 2020 18:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592849072;
        bh=WmegmhgXn6MZu3uuVPkEYPE6vUeT+x15UP1L4Sg+pnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JFFQQOadtXaeZa+roRtogQLEVtHpT9KKXXqDIgq2FMf4HAJZuSe0Cc1NpAXZqsqHQ
         180n+Tz9CUVFXzWcH3uGTKLTxpmkO58ytTk7ATFmUsXLkYNGmiYszWQPjmJxCSLXEw
         viIy3LJ96LYBAXLByny3plH0YSHMWDRBubblaq7a8UDKs8po2G3L1oSWkpHkRc6mkX
         KZS0vfdteKwcl4qDPPep/SYl80xGQmyjCpDYys+Ucy1o0XQuCIboxy9qqrgVvxb3Y9
         gBEQlQTUShjq+4fbnmbCpcIxP4ffFFILzrS9IKeLLpiBVhxvYfFP6jSHsql4WappCl
         GFTag5EDq1eJnHmXngttYq4azPxKg1XOvJokwoMrCmyt7lbwB1v0gTksfv/NzE0rAl
         sXeSSLTjqQk9JA8DUgMjLnwAZGWaUy41+w6t/zlFKuUl4sHlCAtTnwDbgI73AdMZ7P
         RjaIUgN/pKNHZZZ85jUWjkdESwNDhYDSdmBbQAfPxWVy5NM6Ve1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/14] git-cvsexportcommit: port to SHA-256
Date:   Mon, 22 Jun 2020 18:04:18 +0000
Message-Id: <20200622180418.2418483-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200622180418.2418483-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
 <20200622180418.2418483-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we apply a binary patch, we must have the full object ID in the
header in order to apply it; without that, any attempt to apply it will
fail.  If we set GIT_DIR to empty, git apply does not know about the
hash algorithm we're using, and consequently any attempt to apply a
patch using SHA-256 will fail, since the object ID is the wrong length.

The reason we set the GIT_DIR environment variable is because we don't
want to modify the index; we just want to know whether the patch
applies.  Instead, let's just use a temporary file for the index, which
will be cleaned up automatically when the object goes out of scope.

Additionally, read the configuration for the repository and compute the
length of an object ID based on it.  Use that when matching object IDs
with a regex or computing the all-zeros object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-cvsexportcommit.perl | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index fc00d5946a..6483d792d3 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -22,6 +22,10 @@
 my $repo = Git->repository();
 $opt_w = $repo->config('cvsexportcommit.cvsdir') unless defined $opt_w;
 
+my $tmpdir = File::Temp->newdir;
+my $hash_algo = $repo->config('extensions.objectformat') || 'sha1';
+my $hexsz = $hash_algo eq 'sha256' ? 64 : 40;
+
 if ($opt_w || $opt_W) {
 	# Remember where GIT_DIR is before changing to CVS checkout
 	unless ($ENV{GIT_DIR}) {
@@ -96,7 +100,7 @@
     }
 
     if ($stage eq 'headers') {
-	if ($line =~ m/^parent (\w{40})$/) { # found a parent
+	if ($line =~ m/^parent ([0-9a-f]{$hexsz})$/) { # found a parent
 	    push @parents, $1;
 	} elsif ($line =~ m/^author (.+) \d+ [-+]\d+$/) {
 	    $author = $1;
@@ -111,7 +115,7 @@
     }
 }
 
-my $noparent = "0000000000000000000000000000000000000000";
+my $noparent = "0" x $hexsz;
 if ($parent) {
     my $found;
     # double check that it's a valid parent
@@ -174,7 +178,7 @@
 print "Checking if patch will apply\n";
 
 my @stat;
-open APPLY, "GIT_DIR= git-apply $context --summary --numstat<.cvsexportcommit.diff|" || die "cannot patch";
+open APPLY, "GIT_INDEX_FILE=$tmpdir/index git-apply $context --summary --numstat<.cvsexportcommit.diff|" || die "cannot patch";
 @stat=<APPLY>;
 close APPLY || die "Cannot patch";
 my (@bfiles,@files,@afiles,@dfiles);
@@ -329,7 +333,7 @@
 if ($opt_W) {
     system("git checkout -q $commit^0") && die "cannot patch";
 } else {
-    `GIT_DIR= git-apply $context --summary --numstat --apply <.cvsexportcommit.diff` || die "cannot patch";
+    `GIT_INDEX_FILE=$tmpdir/index git-apply $context --summary --numstat --apply <.cvsexportcommit.diff` || die "cannot patch";
 }
 
 print "Patch applied successfully. Adding new files and directories to CVS\n";
@@ -407,7 +411,7 @@
 
 if ($opt_W) {
     system("git checkout $go_back_to") && die "cannot move back to $go_back_to";
-    if (!($go_back_to =~ /^[0-9a-fA-F]{40}$/)) {
+    if (!($go_back_to =~ /^[0-9a-fA-F]{$hexsz}$/)) {
 	system("git symbolic-ref HEAD $go_back_to") &&
 	    die "cannot move back to $go_back_to";
     }
