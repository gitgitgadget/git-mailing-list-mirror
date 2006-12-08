X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Add branch.*.localmerge and documentation update
Date: Fri, 8 Dec 2006 20:12:18 +0100
Message-ID: <200612082012.19167.Josef.Weidendorfer@gmx.de>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <8aa486160612071756s18f9530cr7ed26e4b7b47d1de@mail.gmail.com> <200612081823.45565.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 19:12:51 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <200612081823.45565.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33722>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsl9J-0006oN-Ih for gcvg-git@gmane.org; Fri, 08 Dec
 2006 20:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1426139AbWLHTM0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 14:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426144AbWLHTMZ
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 14:12:25 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:65183 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1426139AbWLHTMY (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 14:12:24 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 8BED82848; Fri,  8
 Dec 2006 20:12:22 +0100 (MET)
To: "Santi =?iso-8859-1?q?B=E9jar?=" <sbejar@gmail.com>
Sender: git-owner@vger.kernel.org

Clarify the meaning of branch.*.merge option and add a similar
branch.*.localmerge option, which can be used to specify a local
tracking branch to be merged by default.

Previously, if branch.*.merge was specified but did not match any
ref, the message "No changes." was not really helpful regarding
the misconfiguration. This now gives a warning.

The value of branch.*.merge can be a list to get an octopus
merge. I chose the same way for branch.*.localmerge, and if
you specify both options, the octopus merge will have even
more parents ;-)

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
---

This implements to branch.*.localmerge option as counterpart
to branch.*.merge as discussed.

To get the "No default merge when any branch.*.(local)merge is given,
but not in current branch" feature, what is the way to check this,
as git-repo-config can not match with regexps against config keys?

Josef

 Documentation/config.txt |   23 +++++++++++++++++++++--
 git-parse-remote.sh      |   40 +++++++++++++++++++++++++++++++---------
 2 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9090762..6e19130 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -125,10 +125,29 @@ apply.whitespace::
 
 branch.<name>.remote::
 	When in branch <name>, it tells `git fetch` which remote to fetch.
+	If this option is not given, `git fetch` defaults to "origin".
 
 branch.<name>.merge::
-	When in branch <name>, it tells `git fetch` the default remote branch
-	to be merged.
+	When in branch <name>, it tells `git fetch` the default refspec to
+	be marked for merging in FETCH_HEAD. The value has to exactly
+	match a remote part of the refspecs which are fetched from the remote
+	repository given by "branch.<name>.remote".
+	The merge information is used by `git pull` (which first calls
+	`git fetch`) for the default merge action.
+	Without this or a "branch.<name>.localmerge" option, `git pull` defaults to
+	the first refspec fetched.
+	Specify multiple values to get an octopus merge.
+
+branch.<name>.localmerge::
+	When in branch <name>, it tells `git fetch` the default refspec to
+	be marked for merging in FETCH_HEAD. The value has to exactly
+	match a local part (i.e. the local tracking branch) of the refspecs
+	which are fetched from the remote repository given by "branch.<name>.remote".
+	The merge information is used by `git pull` (which first calls
+	`git fetch`) for the default merge action.
+	Without this or a "branch.<name>.merge" option, `git pull` defaults to the
+	first refspec fetched.
+	Specify multiple values to get an octopus merge.
 
 pager.color::
 	A boolean to enable/disable colored output when the pager is in
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index da064a5..08ab272 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -133,7 +133,9 @@ canon_refs_list_for_fetch () {
 	# leave the branches in branch.${curr_branch}.merge alone,
 	# or the first one otherwise; add prefix . to the rest
 	# to prevent the secondary branches to be merged by default.
-	merge_branches=
+	merge_remotebranches=
+	merge_localbranches=
+	found_mergerefs=
 	if test "$1" = "-d"
 	then
 		shift ; remote="$1" ; shift
@@ -141,8 +143,10 @@ canon_refs_list_for_fetch () {
 		then
 			curr_branch=$(git-symbolic-ref HEAD | \
 			    sed -e 's|^refs/heads/||')
-			merge_branches=$(git-repo-config \
+			merge_remotebranches=$(git-repo-config \
 			    --get-all "branch.${curr_branch}.merge")
+			merge_localbranches=$(git-repo-config \
+			    --get-all "branch.${curr_branch}.localmerge")
 		fi
 		set x $(expand_refs_wildcard "$@")
 		shift
@@ -160,17 +164,31 @@ canon_refs_list_for_fetch () {
 		remote=$(expr "z$ref" : 'z\([^:]*\):')
 		local=$(expr "z$ref" : 'z[^:]*:\(.*\)')
 		dot_prefix=.
-		if test -z "$merge_branches"
+		if test ! -z "$merge_remotebranches"
 		then
-			merge_branches=$remote
-			dot_prefix=
-		else
-			for merge_branch in $merge_branches
+			for merge_branch in $merge_remotebranches
 			do
-			    [ "$remote" = "$merge_branch" ] &&
-			    dot_prefix= && break
+				[ "$remote" = "$merge_branch" ] &&
+				dot_prefix= && break
 			done
 		fi
+		if test ! -z "$merge_localbranches"
+		then
+			for merge_branch in $merge_localbranches
+			do
+				[ "$local" = "$merge_branch" ] &&
+				dot_prefix= && break
+			done
+		fi
+		if test -z "$merge_remotebranches" -a -z "$merge_localbranches"
+		then
+			merge_remotebranches=$remote
+			dot_prefix=
+		fi
+		if test -z $dot_prefix
+		then
+			found_mergeref=true
+		fi
 		case "$remote" in
 		'') remote=HEAD ;;
 		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
@@ -191,6 +209,10 @@ canon_refs_list_for_fetch () {
 		fi
 		echo "${dot_prefix}${force}${remote}:${local}"
 	done
+	if test -z $found_mergeref
+	then
+		echo >&2 "Warning: No merge candidate because of no match with branch.*.merge or branch.*.localmerge"
+	fi
 }
 
 # Returns list of src: (no store), or src:dst (store)
-- 
