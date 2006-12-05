X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 3/5] git-svn: collect SVK source URL on mirror paths
Date: Tue, 05 Dec 2006 16:17:38 +1100
Message-ID: <20061205051738.16552.99307.stgit@localhost>
References: <20061205051738.16552.8987.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Tue, 5 Dec 2006 05:22:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061205051738.16552.8987.stgit@localhost>
User-Agent: StGIT/0.10
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33300>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrSlB-0001ly-IO for gcvg-git@gmane.org; Tue, 05 Dec
 2006 06:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967643AbWLEFW0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 00:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967636AbWLEFW0
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 00:22:26 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:36768 "EHLO
 magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937358AbWLEFWY (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 00:22:24 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003) id 7F884139B0D;
 Tue,  5 Dec 2006 18:22:18 +1300 (NZDT)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

From: Sam Vilain <sam@vilain.net>

If you use git-svn to import a mirror path within an SVK depot
directly (eg, file:///home/you/.svk/local/mirror/foo), then the URLs
and revisions in the generated commits will be of the wrong URL.

When we set up with git-svn multi-init, check whether the base URL is
(the root of) a mirror path, and store it for later.  Set up a couple
of globals and helper functions for later use.
---

 git-svn.perl |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 93cfcc4..800c579 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5,6 +5,7 @@ use warnings;
 use strict;
 use vars qw/	$AUTHOR $VERSION
 		$SVN_URL $SVN_INFO $SVN_WC $SVN_UUID
+		$SVM_URL $SVM_UUID
 		$GIT_SVN_INDEX $GIT_SVN
 		$GIT_DIR $GIT_SVN_DIR $REVDB/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
@@ -733,6 +734,21 @@ sub multi_init {
 		init($_trunk);
 		sys('git-repo-config', 'svn.trunk', $_trunk);
 	}
+	if ( $url ) {
+		# check for the case of SVK mirror path
+		my ($ents, $props) = libsvn_ls_fullurl($url, "1");
+		if ( my $src = $props->{'svm:source'} ) {
+			$src =~ s{!$}{};  # don't know wtf a ! is there for
+			$src =~ s{(^[a-z\+]*://)[^/@]*@}{$1}; # username of no interest
+
+			# store the source as a repo-config item
+			sys('git-repo-config', 'svn.svkmirrorpath', $src);
+			my $uuid = $props->{'svm:uuid'};
+			$uuid =~ m{^[0-9a-f\-]{36,}}
+				or croak "doesn't look right - svm:uuid is '$uuid'";
+			sys('git-repo-config', 'svn.svkuuid', $uuid);
+		}
+	}
 	complete_url_ls_init($url, $_branches, '--branches/-b', '');
 	complete_url_ls_init($url, $_tags, '--tags/-t', 'tags/');
 }
@@ -2084,6 +2100,11 @@ sub check_repack {
 	}
 }
 
+sub get_svm_url {
+	chomp($SVM_URL = `git-repo-config --get svn.svkmirrorpath`);
+	chomp($SVM_UUID = `git-repo-config --get svn.svkuuid`);
+}
+
 sub set_commit_env {
 	my ($log_msg) = @_;
 	my $author = $log_msg->{author};
