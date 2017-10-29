Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86320202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 16:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbdJ2QOn (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 12:14:43 -0400
Received: from marcos.anarc.at ([206.248.172.91]:50708 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbdJ2QOm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 12:14:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id F22341A00AD
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Cc:     Kevin <kevin@ki-ai.org>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
Subject: [PATCH 1/4] remote-mediawiki: add namespace support
Date:   Sun, 29 Oct 2017 12:08:54 -0400
Message-Id: <20171029160857.29460-2-anarcat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171029160857.29460-1-anarcat@debian.org>
References: <20171029160857.29460-1-anarcat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin <kevin@ki-ai.org>

this introduces a new remote.origin.namespaces argument that is a
space-separated list of namespaces. the list of pages extract is then
taken from all the specified namespaces.

Reviewed-by: Antoine Beaupré <anarcat@debian.org>
Signed-off-by: Antoine Beaupré <anarcat@debian.org>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 34 +++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index e7f857c1a..1c5e39831 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -17,6 +17,7 @@ use Git;
 use Git::Mediawiki qw(clean_filename smudge_filename connect_maybe
 					EMPTY HTTP_CODE_OK);
 use DateTime::Format::ISO8601;
+use Scalar::Util;
 use warnings;
 
 # By default, use UTF-8 to communicate with Git and the user
@@ -63,6 +64,10 @@ chomp(@tracked_pages);
 my @tracked_categories = split(/[ \n]/, run_git("config --get-all remote.${remotename}.categories"));
 chomp(@tracked_categories);
 
+# Just like @tracked_categories, but for MediaWiki namespaces.
+my @tracked_namespaces = split(/[ \n]/, run_git("config --get-all remote.${remotename}.namespaces"));
+chomp(@tracked_namespaces);
+
 # Import media files on pull
 my $import_media = run_git("config --get --bool remote.${remotename}.mediaimport");
 chomp($import_media);
@@ -256,6 +261,23 @@ sub get_mw_tracked_categories {
 	return;
 }
 
+sub get_mw_tracked_namespaces {
+    my $pages = shift;
+    foreach my $local_namespace (@tracked_namespaces) {
+        my $mw_pages = $mediawiki->list( {
+            action => 'query',
+            list => 'allpages',
+            apnamespace => get_mw_namespace_id($local_namespace),
+            aplimit => 'max' } )
+            || die $mediawiki->{error}->{code} . ': '
+                . $mediawiki->{error}->{details} . "\n";
+        foreach my $page (@{$mw_pages}) {
+            $pages->{$page->{title}} = $page;
+        }
+    }
+    return;
+}
+
 sub get_mw_all_pages {
 	my $pages = shift;
 	# No user-provided list, get the list of pages from the API.
@@ -319,6 +341,10 @@ sub get_mw_pages {
 		$user_defined = 1;
 		get_mw_tracked_categories(\%pages);
 	}
+    if (@tracked_namespaces) {
+        $user_defined = 1;
+        get_mw_tracked_namespaces(\%pages);
+    }
 	if (!$user_defined) {
 		get_mw_all_pages(\%pages);
 	}
@@ -1263,7 +1289,6 @@ my %cached_mw_namespace_id;
 sub get_mw_namespace_id {
 	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 	my $name = shift;
-
 	if (!exists $namespace_id{$name}) {
 		# Look at configuration file, if the record for that namespace is
 		# already cached. Namespaces are stored in form:
@@ -1331,7 +1356,12 @@ sub get_mw_namespace_id {
 sub get_mw_namespace_id_for_page {
 	my $namespace = shift;
 	if ($namespace =~ /^([^:]*):/) {
-		return get_mw_namespace_id($namespace);
+		my ($ns, $id) = split(/:/, $namespace);
+		if (Scalar::Util::looks_like_number($id)) {
+			return get_mw_namespace_id($ns);
+		} else{
+			return
+		}
 	} else {
 		return;
 	}
-- 
2.11.0

