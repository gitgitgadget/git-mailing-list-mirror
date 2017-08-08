Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D1E91F991
	for <e@80x24.org>; Tue,  8 Aug 2017 08:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbdHHIsE (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 04:48:04 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:36130 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752064AbdHHIsC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Aug 2017 04:48:02 -0400
X-Greylist: delayed 2497 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Aug 2017 04:48:01 EDT
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=celaeno.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ijc-relay-phiayoh8@benson.default.arb33.uk0.bigv.io>)
        id 1dezWw-00010U-EM; Tue, 08 Aug 2017 09:06:22 +0100
Received: from dagon.hellion.org.uk ([192.168.1.7])
        by celaeno.hellion.org.uk with smtp (Exim 4.84_2)
        (envelope-from <ijc@hellion.org.uk>)
        id 1dezWu-0006Ek-Ru; Tue, 08 Aug 2017 09:06:21 +0100
Received: by dagon.hellion.org.uk (sSMTP sendmail emulation); Tue, 08 Aug 2017 09:06:20 +0100
From:   Ian Campbell <ijc@hellion.org.uk>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Ian Campbell <ijc@hellion.org.uk>
Subject: [PATCH 1/2] filter-branch: Add --state-branch to hold pickled copy of ref map
Date:   Tue,  8 Aug 2017 09:06:19 +0100
Message-Id: <20170808080620.9536-1-ijc@hellion.org.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1502179560.2735.22.camel@hellion.org.uk>
References: <1502179560.2735.22.camel@hellion.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allowing for incremental updates of large trees.

I have been using this as part of the device tree extraction from the Linux
kernel source since 2013, about time I sent the patch upstream!

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
---
 git-filter-branch.sh | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 3a74602ef..d07db3fee 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -86,7 +86,7 @@ USAGE="[--setup <command>] [--env-filter <command>]
 	[--parent-filter <command>] [--msg-filter <command>]
 	[--commit-filter <command>] [--tag-name-filter <command>]
 	[--subdirectory-filter <directory>] [--original <namespace>]
-	[-d <directory>] [-f | --force]
+	[-d <directory>] [-f | --force] [--state-branch <branch>]
 	[--] [<rev-list options>...]"
 
 OPTIONS_SPEC=
@@ -106,6 +106,7 @@ filter_msg=cat
 filter_commit=
 filter_tag_name=
 filter_subdir=
+state_branch=
 orig_namespace=refs/original/
 force=
 prune_empty=
@@ -181,6 +182,9 @@ do
 	--original)
 		orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/
 		;;
+	--state-branch)
+		state_branch="$OPTARG"
+		;;
 	*)
 		usage
 		;;
@@ -252,6 +256,20 @@ export GIT_INDEX_FILE
 # map old->new commit ids for rewriting parents
 mkdir ../map || die "Could not create map/ directory"
 
+if [ -n "$state_branch" ] ; then
+	state_commit=`git show-ref -s "$state_branch"`
+	if [ -n "$state_commit" ] ; then
+		echo "Populating map from $state_branch ($state_commit)" 1>&2
+		git show "$state_commit":filter.map |
+		    perl -n -e 'm/(.*):(.*)/ or die;
+				open F, ">../map/$1" or die;
+				print F "$2" or die;
+				close(F) or die'
+	else
+		echo "Branch $state_branch does not exist. Will create" 1>&2
+	fi
+fi
+
 # we need "--" only if there are no path arguments in $@
 nonrevs=$(git rev-parse --no-revs "$@") || exit
 if test -z "$nonrevs"
@@ -544,6 +562,25 @@ if [ "$filter_tag_name" ]; then
 	done
 fi
 
+if [ -n "$state_branch" ] ; then
+	echo "Saving rewrite state to $state_branch" 1>&2
+	STATE_BLOB=$(ls ../map |
+	    perl -n -e 'chomp();
+			open F, "<../map/$_" or die;
+			chomp($f = <F>); print "$_:$f\n";' |
+	    git hash-object -w --stdin )
+	STATE_TREE=$(/bin/echo -e "100644 blob $STATE_BLOB\tfilter.map" | git mktree)
+	STATE_PARENT=$(git show-ref -s "$state_branch")
+	unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
+	unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL GIT_COMMITTER_DATE
+	if [ -n "$STATE_PARENT" ] ; then
+	    STATE_COMMIT=$(/bin/echo "Sync" | git commit-tree "$STATE_TREE" -p "$STATE_PARENT")
+	else
+	    STATE_COMMIT=$(/bin/echo "Sync" | git commit-tree "$STATE_TREE" )
+	fi
+	git update-ref "$state_branch" "$STATE_COMMIT"
+fi
+
 cd "$orig_dir"
 rm -rf "$tempdir"
 
-- 
2.11.0

