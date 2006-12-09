X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Add branch.*.merge warning and documentation update
Date: Sat, 9 Dec 2006 02:28:26 +0100
Message-ID: <200612090228.26722.Josef.Weidendorfer@gmx.de>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <200612090017.44105.Josef.Weidendorfer@gmx.de> <7vu006ez1i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 01:28:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <7vu006ez1i.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33786>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsr13-0000H0-1q for gcvg-git@gmane.org; Sat, 09 Dec
 2006 02:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947622AbWLIB2d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 20:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947624AbWLIB2d
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 20:28:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:45744 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1947622AbWLIB2c
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 20:28:32 -0500
Received: (qmail invoked by alias); 09 Dec 2006 01:28:30 -0000
Received: from p5496AEC2.dip0.t-ipconnect.de (EHLO noname) [84.150.174.194]
 by mail.gmx.net (mp038) with SMTP; 09 Dec 2006 02:28:30 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This patch clarifies the meaning of the branch.*.merge option.
Previously, if branch.*.merge was specified but did not match any
ref, the message "No changes." was not really helpful regarding
the misconfiguration. This patch adds a warning for this.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
---

On Saturday 09 December 2006 00:41, Junio C Hamano wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> 
> > But the previous documentation simply was way to short.
> 
> Yes, your documentation updates seems to make it much clearer.
> 
> > Should I send a "simplified" patch?
> 
> Thanks, appreciated.

Done.

Josef

 Documentation/config.txt |   11 +++++++++--
 git-parse-remote.sh      |   11 +++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9090762..21ec557 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -125,10 +125,17 @@ apply.whitespace::
 
 branch.<name>.remote::
 	When in branch <name>, it tells `git fetch` which remote to fetch.
+	If this option is not given, `git fetch` defaults to remote "origin".
 
 branch.<name>.merge::
-	When in branch <name>, it tells `git fetch` the default remote branch
-	to be merged.
+	When in branch <name>, it tells `git fetch` the default refspec to
+	be marked for merging in FETCH_HEAD. The value has exactly to match
+	a remote part of one of the refspecs which are fetched from the remote
+	given by "branch.<name>.remote".
+	The merge information is used by `git pull` (which at first calls
+	`git fetch`) to lookup the default branch for merging. Without
+	this option, `git pull` defaults to merge the first refspec fetched.
+	Specify multiple values to get an octopus merge.
 
 pager.color::
 	A boolean to enable/disable colored output when the pager is in
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index da064a5..d72f061 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -134,6 +134,8 @@ canon_refs_list_for_fetch () {
 	# or the first one otherwise; add prefix . to the rest
 	# to prevent the secondary branches to be merged by default.
 	merge_branches=
+	found_mergeref=
+	curr_branch=
 	if test "$1" = "-d"
 	then
 		shift ; remote="$1" ; shift
@@ -171,6 +173,10 @@ canon_refs_list_for_fetch () {
 			    dot_prefix= && break
 			done
 		fi
+		if test -z $dot_prefix
+		then
+			found_mergeref=true
+		fi
 		case "$remote" in
 		'') remote=HEAD ;;
 		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
@@ -191,6 +197,11 @@ canon_refs_list_for_fetch () {
 		fi
 		echo "${dot_prefix}${force}${remote}:${local}"
 	done
+	if test -z "$found_mergeref" -a "$curr_branch"
+	then
+		echo >&2 "Warning: No merge candidate found because value of config option
+         \"branch.${curr_branch}.merge\" does not match any remote branch fetched."
+	fi
 }
 
 # Returns list of src: (no store), or src:dst (store)
-- 
1.4.4.2.g1d08-dirty
