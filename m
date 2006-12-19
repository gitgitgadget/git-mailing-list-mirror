X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Move "no merge candidate" warning into git-pull
Date: Tue, 19 Dec 2006 02:01:55 +0100
Message-ID: <200612190201.55300.Josef.Weidendorfer@gmx.de>
References: <20061218081631.GA9727@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 01:02:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <20061218081631.GA9727@spearce.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34778>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwTMy-00061I-Tu for gcvg-git@gmane.org; Tue, 19 Dec
 2006 02:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932582AbWLSBCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 20:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWLSBCJ
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 20:02:09 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:52481 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S932549AbWLSBCI (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 20:02:08 -0500
Received: from dhcp-3s-52.lrr.in.tum.de (dhcp-3s-52.lrr.in.tum.de
 [131.159.35.52]) by mail.in.tum.de (Postfix) with ESMTP id A0E4C2819 for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 02:02:06 +0100 (MET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

The warning triggered even when running "git fetch" only
when resulting .git/FETCH_HEAD only contained
branches marked as 'not-for-merge'.

Signed-off-by: Josef Weidendorfer <weidendo@gmx.de>
---

[Resent to mailing list; I forgot to add it]

On Monday 18 December 2006 09:16, Shawn Pearce <spearce@spearce.org> wrote:
> Current 'next':
> 
>   $ git fetch
>   Warning: No merge candidate found because value of config option
>            "branch.sp/username-reflog.merge" does not match any remote branch fetched.
> 
> uhhh.. i asked for a fetch, not a merge.

Oops.
I hope this does it right. Testing by the same person which does the patch
is obviously almost the same as not testing at all.

Josef

 git-parse-remote.sh |   10 ----------
 git-pull.sh         |    4 ++++
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 6ae534b..d02f404 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -134,7 +134,6 @@ canon_refs_list_for_fetch () {
 	# or the first one otherwise; add prefix . to the rest
 	# to prevent the secondary branches to be merged by default.
 	merge_branches=
-	found_mergeref=
 	curr_branch=
 	if test "$1" = "-d"
 	then
@@ -173,10 +172,6 @@ canon_refs_list_for_fetch () {
 			    dot_prefix= && break
 			done
 		fi
-		if test -z $dot_prefix
-		then
-			found_mergeref=true
-		fi
 		case "$remote" in
 		'') remote=HEAD ;;
 		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
@@ -197,11 +192,6 @@ canon_refs_list_for_fetch () {
 		fi
 		echo "${dot_prefix}${force}${remote}:${local}"
 	done
-	if test -z "$found_mergeref" -a "$curr_branch"
-	then
-		echo >&2 "Warning: No merge candidate found because value of config option
-         \"branch.${curr_branch}.merge\" does not match any remote branch fetched."
-	fi
 }
 
 # Returns list of src: (no store), or src:dst (store)
diff --git a/git-pull.sh b/git-pull.sh
index e23beb6..1703091 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -76,6 +76,10 @@ merge_head=$(sed -e '/	not-for-merge	/d' \
 
 case "$merge_head" in
 '')
+	curr_branch=$(git-symbolic-ref HEAD | \
+		sed -e 's|^refs/heads/||')
+	echo >&2 "Warning: No merge candidate found because value of config option
+         \"branch.${curr_branch}.merge\" does not match any remote branch fetched."
 	echo >&2 "No changes."
 	exit 0
 	;;
-- 
1.4.4.2.gee60-dirty
