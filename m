Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04112202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 16:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbdJ2QOo (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 12:14:44 -0400
Received: from marcos.anarc.at ([206.248.172.91]:50702 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbdJ2QOm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 12:14:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 6F2911A00B5
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
Subject: [PATCH 4/4] remote-mediawiki: allow using (Main) as a namespace and skip special namespaces
Date:   Sun, 29 Oct 2017 12:08:57 -0400
Message-Id: <20171029160857.29460-5-anarcat@debian.org>
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

Reviewed-by: Antoine Beaupré <anarcat@debian.org>
Signed-off-by: Antoine Beaupré <anarcat@debian.org>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 31 +++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 07cc74bac..ccefde4dc 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -264,16 +264,27 @@ sub get_mw_tracked_categories {
 
 sub get_mw_tracked_namespaces {
     my $pages = shift;
-    foreach my $local_namespace (@tracked_namespaces) {
-        my $mw_pages = $mediawiki->list( {
-            action => 'query',
-            list => 'allpages',
-            apnamespace => get_mw_namespace_id($local_namespace),
-            aplimit => 'max' } )
-            || die $mediawiki->{error}->{code} . ': '
-                . $mediawiki->{error}->{details} . "\n";
-        foreach my $page (@{$mw_pages}) {
-            $pages->{$page->{title}} = $page;
+    foreach my $local_namespace (sort @tracked_namespaces) {
+        my ($mw_pages, $namespace_id);
+        if ($local_namespace eq "(Main)") {
+            $namespace_id = 0;
+        } else {
+            $namespace_id = get_mw_namespace_id($local_namespace);
+        }
+        if ($namespace_id >= 0) {
+            if ($mw_pages = $mediawiki->list( {
+                action => 'query',
+                list => 'allpages',
+                apnamespace => $namespace_id,
+                aplimit => 'max' } )) {
+                print {*STDERR} "$#{$mw_pages} found in namespace $local_namespace ($namespace_id)\n";
+                foreach my $page (@{$mw_pages}) {
+                    $pages->{$page->{title}} = $page;
+                }
+            } else {
+                warn $mediawiki->{error}->{code} . ': '
+                    . $mediawiki->{error}->{details} . "\n";
+            }
         }
     }
     return;
-- 
2.11.0

