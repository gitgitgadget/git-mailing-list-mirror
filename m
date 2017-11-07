Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93530202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 16:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbdKGQHL (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 11:07:11 -0500
Received: from marcos.anarc.at ([206.248.172.91]:36850 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754322AbdKGQHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 11:07:09 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 66AC31A00AA
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
Subject: [PATCH v5 5/7] remote-mediawiki: support fetching from (Main) namespace
Date:   Tue,  7 Nov 2017 11:06:59 -0500
Message-Id: <20171107160701.24202-6-anarcat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171107160701.24202-1-anarcat@debian.org>
References: <20171102212518.1601-1-anarcat@debian.org>
 <20171107160701.24202-1-anarcat@debian.org>
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
 contrib/mw-to-git/git-remote-mediawiki.perl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 611a04cd7..0e60b85c8 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -264,7 +264,12 @@ sub get_mw_tracked_categories {
 sub get_mw_tracked_namespaces {
     my $pages = shift;
     foreach my $local_namespace (@tracked_namespaces) {
-        my $namespace_id = get_mw_namespace_id($local_namespace);
+        my $namespace_id;
+        if ($local_namespace eq "(Main)") {
+            $namespace_id = 0;
+        } else {
+            $namespace_id = get_mw_namespace_id($local_namespace);
+        }
         # virtual namespaces don't support allpages
         next if !defined($namespace_id) || $namespace_id < 0;
         my $mw_pages = $mediawiki->list( {
-- 
2.11.0

