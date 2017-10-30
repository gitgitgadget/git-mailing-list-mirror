Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A2F202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 02:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbdJ3Cv4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 22:51:56 -0400
Received: from marcos.anarc.at ([206.248.172.91]:60710 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752052AbdJ3Cvx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 22:51:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 931AB1A00AF
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
Subject: [PATCH 5/7] remote-mediawiki: support fetching from (Main) namespace
Date:   Sun, 29 Oct 2017 22:51:40 -0400
Message-Id: <20171030025142.19421-6-anarcat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171030025142.19421-1-anarcat@debian.org>
References: <20171029160857.29460-2-anarcat@debian.org>
 <20171030025142.19421-1-anarcat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we specify a list of namespaces to fetch from, by default the MW
API will not fetch from the default namespace, refered to as "(Main)"
in the documentation:

https://www.mediawiki.org/wiki/Manual:Namespace#Built-in_namespaces

I haven't found a way to address that "(Main)" namespace when getting
the namespace ids: indeed, when listing namespaces, there is no
"canonical" field for the main namespace, although there is a "*"
field that is set to "" (empty). So in theory, we could specify the
empty namespace to get the main namespace, but that would make
specifying namespaces harder for the user: we would need to teach
users about the "empty" default namespace. It would also make the code
more complicated: we'd need to parse quotes in the configuration.

So we simply override the query here and allow the user to specify
"(Main)" since that is the publicly documented name.

Signed-off-by: Antoine Beaupré <anarcat@debian.org>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 5c85e64b6..2c2a7367b 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -264,9 +264,14 @@ sub get_mw_tracked_categories {
 sub get_mw_tracked_namespaces {
     my $pages = shift;
     foreach my $local_namespace (@tracked_namespaces) {
-        my $namespace_id = get_mw_namespace_id($local_namespace);
+        my ($namespace_id, $mw_pages);
+        if ($local_namespace eq "(Main)") {
+            $namespace_id = 0;
+        } else {
+            $namespace_id = get_mw_namespace_id($local_namespace);
+        }
         next if $namespace_id < 0; # virtual namespaces don't support allpages
-        my $mw_pages = $mediawiki->list( {
+        $mw_pages = $mediawiki->list( {
             action => 'query',
             list => 'allpages',
             apnamespace => $namespace_id,
-- 
2.11.0

