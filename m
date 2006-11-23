X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] git-fetch: allow glob pattern in refspec
Date: Wed, 22 Nov 2006 23:24:05 -0800
Message-ID: <7vzmaik4mi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 07:24:27 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32119>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn8wV-0002LW-Q7 for gcvg-git@gmane.org; Thu, 23 Nov
 2006 08:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932935AbWKWHYK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 02:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWKWHYJ
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 02:24:09 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:6288 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1757288AbWKWHYG
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 02:24:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061123072406.FEAZ18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Thu, 23
 Nov 2006 02:24:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id q7QE1V0021kojtg0000000; Thu, 23 Nov 2006
 02:24:14 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This adds Andy's refspec glob.  You can have a single line:

	Pull: refs/heads/*:refs/remotes/origin/*

in your ".git/remotes/origin" and say "git fetch" to retrieve
all refs under heads/ at the remote side to remotes/origin/ in
the local repository.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Andy, I think this does the same thing as you wanted to do,
   but is cleaner implementation-wise and also at the concept
   level, to pretend as if the user listed the expanded form in
   the configuration.  I deliberately decided not to apply the
   wildcard expansion on refspecs that came from command line,
   but if we wanted to we can move the expand_refs_wildcard call
   a few lines down to make it also apply to them.

 git-parse-remote.sh |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index c325ef7..e281b7c 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -90,6 +90,39 @@ get_remote_default_refs_for_push () {
 	esac
 }
 
+# Called from canon_refs_list_for_fetch -d "$remote", which
+# is called from get_remote_default_refs_for_fetch to grok
+# refspecs that are retrieved from the configuration, but not
+# from get_remote_refs_for_fetch when it deals with refspecs
+# supplied on the command line.  $ls_remote_result has the list
+# of refs available at remote.
+expand_refs_wildcard () {
+	for ref
+	do
+		# a non glob pattern is given back as-is.
+		expr "z$ref" : 'zrefs/.*/\*:refs/.*/\*$' >/dev/null || {
+			echo "$ref"
+			continue
+		}
+		from=`expr "z$ref" : 'z\(refs/.*/\)\*:refs/.*/\*$'`
+		to=`expr "z$ref" : 'zrefs/.*/\*:\(refs/.*/\)\*$'`
+		echo "$ls_remote_result" |
+		(
+			IFS='	'
+			while read sha1 name
+			do
+				mapped=${name#"$from"}
+				if test "z$name" != "z${name#'^{}'}" ||
+					test "z$name" = "z$mapped"
+				then
+					continue
+				fi
+				echo "${name}:${to}${mapped}"
+			done
+		)
+	done
+}
+
 # Subroutine to canonicalize remote:local notation.
 canon_refs_list_for_fetch () {
 	# If called from get_remote_default_refs_for_fetch
@@ -107,6 +140,8 @@ canon_refs_list_for_fetch () {
 			merge_branches=$(git-repo-config \
 			    --get-all "branch.${curr_branch}.merge")
 		fi
+		set x $(expand_refs_wildcard "$@")
+		shift
 	fi
 	for ref
 	do
-- 
1.4.4.1.g77614

