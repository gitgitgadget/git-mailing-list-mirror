Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FFF32047F
	for <e@80x24.org>; Thu, 21 Sep 2017 07:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbdIUHto (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 03:49:44 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:43237 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751588AbdIUHti (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Sep 2017 03:49:38 -0400
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=celaeno.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ijc-relay-phiayoh8@benson.default.arb33.uk0.bigv.io>)
        id 1duwEq-0005OS-CT; Thu, 21 Sep 2017 08:49:36 +0100
Received: from dagon.hellion.org.uk ([192.168.1.7])
        by celaeno.hellion.org.uk with smtp (Exim 4.84_2)
        (envelope-from <ijc@hellion.org.uk>)
        id 1duwEo-0000hn-RI; Thu, 21 Sep 2017 08:49:35 +0100
Received: by dagon.hellion.org.uk (sSMTP sendmail emulation); Thu, 21 Sep 2017 08:49:34 +0100
From:   Ian Campbell <ijc@hellion.org.uk>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Ian Campbell <ijc@hellion.org.uk>
Subject: [PATCH v3 3/4] filter-branch: stash away ref map in a branch
Date:   Thu, 21 Sep 2017 08:49:31 +0100
Message-Id: <20170921074932.5490-3-ijc@hellion.org.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1505980146.4636.9.camel@hellion.org.uk>
References: <1505980146.4636.9.camel@hellion.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With "--state-branch=<branchname>" option, the mapping from old object names
and filtered ones in ./map/ directory is stashed away in the object database,
and the one from the previous run is read to populate the ./map/ directory,
allowing for incremental updates of large trees.

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
---
I have been using this as part of the device tree extraction from the Linux
kernel source since 2013, about time I sent the patch upstream!

v2:
- added several preceding cleanup patches, including:
  - new: use of mktag --allow-missing tagger.
  - split-out: preserving $GIT_*.
- use git rev-parse rather than git show-ref.
- improved error handling for Perl sub-processes.
- collapsed some shell pipelines involving piping output of git and ls into
  Perl into the Perl scripts.
- style fixes for conditionals and sub-shells.
- fixup indentation.
- added documentation.
- improved commit message.
---
 Documentation/git-filter-branch.txt |  8 +++++-
 git-filter-branch.sh                | 49 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 9e5169aa6..bebdcdec5 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	[--commit-filter <command>] [--tag-name-filter <command>]
 	[--subdirectory-filter <directory>] [--prune-empty]
 	[--original <namespace>] [-d <directory>] [-f | --force]
-	[--] [<rev-list options>...]
+	[--state-branch <branch>] [--] [<rev-list options>...]
 
 DESCRIPTION
 -----------
@@ -198,6 +198,12 @@ to other tags will be rewritten to point to the underlying commit.
 	directory or when there are already refs starting with
 	'refs/original/', unless forced.
 
+--state-branch <branch>::
+	This option will cause the mapping from old to new objects to
+	be loaded from named branch upon startup and saved as a new
+	commit to that branch upon exit, enabling incremental of large
+	trees. If '<branch>' does not exist it will be created.
+
 <rev-list options>...::
 	Arguments for 'git rev-list'.  All positive refs included by
 	these options are rewritten.  You may also specify options
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 9edb94206..956869b8e 100755
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
@@ -259,6 +263,26 @@ export GIT_INDEX_FILE
 # map old->new commit ids for rewriting parents
 mkdir ../map || die "Could not create map/ directory"
 
+if test -n "$state_branch"
+then
+	state_commit=$(git rev-parse --no-flags --revs-only "$state_branch")
+	if test -n "$state_commit"
+	then
+		echo "Populating map from $state_branch ($state_commit)" 1>&2
+		perl -e'open(MAP, "-|", "git show $ARGV[0]:filter.map") or die;
+			while (<MAP>) {
+				m/(.*):(.*)/ or die;
+				open F, ">../map/$1" or die;
+				print F "$2" or die;
+				close(F) or die;
+			}
+			close(MAP) or die;' "$state_commit" \
+				|| die "Unable to load state from $state_branch:filter.map"
+	else
+		echo "Branch $state_branch does not exist. Will create" 1>&2
+	fi
+fi
+
 # we need "--" only if there are no path arguments in $@
 nonrevs=$(git rev-parse --no-revs "$@") || exit
 if test -z "$nonrevs"
@@ -590,6 +614,29 @@ test -z "$ORIG_GIT_COMMITTER_DATE" || {
 	export GIT_COMMITTER_DATE
 }
 
+if test -n "$state_branch"
+then
+	echo "Saving rewrite state to $state_branch" 1>&2
+	state_blob=$(
+		perl -e'opendir D, "../map" or die;
+			open H, "|-", "git hash-object -w --stdin" or die;
+			foreach (sort readdir(D)) {
+				next if m/^\.\.?$/;
+				open F, "<../map/$_" or die;
+				chomp($f = <F>);
+				print H "$_:$f\n" or die;
+			}
+			close(H) or die;' || die "Unable to save state")
+	state_tree=$(/bin/echo -e "100644 blob $state_blob\tfilter.map" | git mktree)
+	if test -n "$state_commit"
+	then
+		state_commit=$(/bin/echo "Sync" | git commit-tree "$state_tree" -p "$state_commit")
+	else
+		state_commit=$(/bin/echo "Sync" | git commit-tree "$state_tree" )
+	fi
+	git update-ref "$state_branch" "$state_commit"
+fi
+
 cd "$orig_dir"
 rm -rf "$tempdir"
 
-- 
2.11.0

