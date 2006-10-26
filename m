X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (resend)] gitweb: Use --no-commit-id in git_commit and git_commitdiff
Date: Thu, 26 Oct 2006 10:50:20 +0200
Message-ID: <200610261050.21214.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 08:50:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rQyf7UXt/sa28WtC2zdGvs/vkLYwuz5BN7o0wYjDCs1Oj5jq4jOZFTLEenK2kjCd/yugV+vxyi4oTM7shQ8lsLHOvNqgrPhT78X2tIaMbs6fVK/iMAjzxOtpQeNI1ESmFbj/8ThtgQw/vbVpfpaZPjsd4NjitQt2uLVLuJNoMBU=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30156>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd0wW-0003MV-PO for gcvg-git@gmane.org; Thu, 26 Oct
 2006 10:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751758AbWJZItr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 04:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbWJZItr
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 04:49:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:62229 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1751758AbWJZItq
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 04:49:46 -0400
Received: by ug-out-1314.google.com with SMTP id 32so310289ugm for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 01:49:44 -0700 (PDT)
Received: by 10.67.101.10 with SMTP id d10mr2356565ugm; Thu, 26 Oct 2006
 01:49:43 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110]) by
 mx.google.com with ESMTP id m4sm2977348ugc.2006.10.26.01.49.43; Thu, 26 Oct
 2006 01:49:43 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Use --no-commit-id option to git-diff-tree command in git_commit and
git_commitdiff to filter out commit ID output that git-diff-tree adds
when called with only one <tree-ish> (not only for --stdin). Remove
filtering commit IDs from git-diff-tree output.

This option is in git since at least v1.0.0, so make use of it.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d7034b4..35a9afb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3133,14 +3133,12 @@ sub git_commit {
 	if (!defined $parent) {
 		$parent = "--root";
 	}
-	open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts, $parent, $hash
+	open my $fd, "-|", git_cmd(), "diff-tree", '-r', "--no-commit-id",
+		@diff_opts, $parent, $hash
 		or die_error(undef, "Open git-diff-tree failed");
 	my @difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-diff-tree failed");
 
-	# filter out commit ID output
-	@difftree = grep(!/^[0-9a-fA-F]{40}$/, @difftree);
-
 	# non-textual hash id's can be cached
 	my $expires;
 	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
@@ -3453,15 +3451,14 @@ sub git_commitdiff {
 	my @difftree;
 	if ($format eq 'html') {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+			"--no-commit-id",
 			"--patch-with-raw", "--full-index", $hash_parent, $hash
 			or die_error(undef, "Open git-diff-tree failed");
 
 		while (chomp(my $line = <$fd>)) {
 			# empty line ends raw part of diff-tree output
 			last unless $line;
-			# filter out commit ID output
-			push @difftree, $line
-				unless $line =~ m/^[0-9a-fA-F]{40}$/;
+			push @difftree, $line;
 		}
 
 	} elsif ($format eq 'plain') {
-- 
1.4.3.3
