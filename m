X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH/RFC] Implemented glob support in pull refspecs
Date: Wed, 22 Nov 2006 22:13:44 +0000
Message-ID: <200611222213.44336.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 22:16:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=I2Mcg41u5VZXLWbafZniHNlEnedkMstgfIuBRmA4BNHe0OlRiYZOL3xJJ1U78/ZAQnBplszUlgEBAhR5OSJDFATQXB065SYfh4ov+FJry3ZAm1pCgBf71OvexBpTZebEXF8mxz7a7+Rr3uJ29zBJkxkgqBpU+nR0LsNI1v61vgA=
X-TUID: b058e8d06bd74ea5
X-UID: 167
X-Length: 5107
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32105>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn0OP-0006cl-2v for gcvg-git@gmane.org; Wed, 22 Nov
 2006 23:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757073AbWKVWQ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 17:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757079AbWKVWQ3
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 17:16:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:2654 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1757068AbWKVWQ2
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 17:16:28 -0500
Received: by ug-out-1314.google.com with SMTP id 44so311630uga for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 14:16:26 -0800 (PST)
Received: by 10.67.119.9 with SMTP id w9mr4097769ugm.1164233786162; Wed, 22
 Nov 2006 14:16:26 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 24sm12196784ugf.2006.11.22.14.16.25; Wed, 22 Nov
 2006 14:16:26 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

git-ls-remote is now called early on and the list categorised into heads and
tags.  Any time a refspec has a "*" in the remote part, the git-ls-remote head
list is searched for matches against that refspec.  If found then the part of
the remote ref that matches the "*" is substituted into the local part of the
refspec.

This allows refspecs like
 refs/heads/*:refs/remotes/origin/*
Which will ensure that all branches on the remote are created locally.

Note, no local branch will be deleted, so if it is deleted upstream it will
remain in the local repository.

As an added bonus, because the output of git-ls-remote is now stored, the other
calls to it for tag processing are replaced with simple accesses to the
previously stored remote tag list

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
The problem with this patch is that I had to disable the safety check 
in git-parse-remote.sh to allow the "*" in the refspec.  I'm not sure what
the appropriate place to put that call now is?  Perhaps after the expansion
of the globbed refspecs?

 git-fetch.sh        |   77 +++++++++++++++++++++++++++++++++++++++++++++-----
 git-parse-remote.sh |   10 +++---
 2 files changed, 74 insertions(+), 13 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index eb32476..1875fe9 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -224,6 +224,24 @@ case "$update_head_ok" in
 	;;
 esac
 
+# Prefetch the remote list and categorise it into tags and heads
+remotereflist=$(git-ls-remote $upload_pack "$remote")
+remoteheads=
+remotetags=
+for ref in $remotereflist
+do
+	# Convert the tab to a comma so that the case below works
+	ref=$(echo $ref | sed -e "s/\t/,/")
+	case $ref in
+	*,refs/heads/*)
+		remoteheads="$remoteheads$ref$LF"
+		;;
+	*,refs/tags/*)
+		remotetags="$remotetags$ref$LF"
+		;;
+	esac
+done
+
 # If --tags (and later --heads or --all) is specified, then we are
 # not talking about defaults stored in Pull: line of remotes or
 # branches file, and just fetch those and refspecs explicitly given.
@@ -232,12 +250,9 @@ esac
 reflist=$(get_remote_refs_for_fetch "$@")
 if test "$tags"
 then
-	taglist=`IFS="	" &&
-		  (
-			git-ls-remote $upload_pack --tags "$remote" ||
-			echo fail ouch
-		  ) |
-	          while read sha1 name
+	taglist=`IFS="," &&
+		  echo -n $remotetags |
+	      while read sha1 name
 		  do
 			case "$sha1" in
 			fail)
@@ -263,6 +278,52 @@ then
 	fi
 fi
 
+# Expand any refspecs that contain "*"
+newreflist=
+for refspec in $reflist
+do
+	remotename=$(expr "z$refspec" : 'z\([^:]*\):')
+	localname=$(expr "z$refspec" : 'z[^:]*:\(.*\)')
+	if gotglob=$(expr "z$remotename" : 'zrefs/.*/\*$')
+	then
+		# If this is a glob-containing ref, then expand it using every
+		# matching remote head
+		for remoteref in $remoteheads
+		do
+			# remoteheads stores the heads with the hashes still present
+			remoteref=$(expr "$remoteref" : "$_x40,\\(.*\\)")
+
+			# For example, if
+			#  remotename = refs/heads/*
+			#  localname = refs/remotes/up/*
+			# Then we find a potential remote head of
+			#  remoteref = refs/heads/branchname
+
+			# First see if it matches the remotename glob
+			case $remoteref in
+			$remotename)
+				# So we know remoteref is the going to be the remote
+				# in the new fetch line, however we need to substitute the
+				# "*" in the local part to get the local name
+				# First we manufacture the regexps to do the work
+				remotereg=$(echo $remotename | sed -e 's/\*/\\(.*\\)/')
+				remotebranch=$(expr "$remoteref" : "$remotereg")
+				# Now substitute this into the localname
+				localref=$(echo $localname | sed -e "s|\\*|$remotebranch|")
+				# And construct the new refspec
+				newreflist="$newreflist$remoteref:$localref$LF"
+				;;
+			esac
+
+		done
+	else
+		# Non glob refs just get copied literally
+		newreflist="$newreflist$ref$LF"
+	fi
+done
+reflist=$newreflist
+
+
 fetch_main () {
   reflist="$1"
   refs=
@@ -430,8 +491,8 @@ case "$no_tags$tags" in
 	*:refs/*)
 		# effective only when we are following remote branch
 		# using local tracking branch.
-		taglist=$(IFS=" " &&
-		git-ls-remote $upload_pack --tags "$remote" |
+		taglist=$(IFS="," &&
+		echo -n $remotetags |
 		sed -n	-e 's|^\('"$_x40"'\)	\(refs/tags/.*\)^{}$|\1 \2|p' \
 			-e 's|^\('"$_x40"'\)	\(refs/tags/.*\)$|\1 \2|p' |
 		while read sha1 name
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index c325ef7..e541144 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -145,11 +145,11 @@ canon_refs_list_for_fetch () {
 		*) local="refs/heads/$local" ;;
 		esac
 
-		if local_ref_name=$(expr "z$local" : 'zrefs/\(.*\)')
-		then
-		   git-check-ref-format "$local_ref_name" ||
-		   die "* refusing to create funny ref '$local_ref_name' locally"
-		fi
+#		if local_ref_name=$(expr "z$local" : 'zrefs/\(.*\)')
+#		then
+#		   git-check-ref-format "$local_ref_name" ||
+#		   die "* refusing to create funny ref '$local_ref_name' locally"
+#		fi
 		echo "${dot_prefix}${force}${remote}:${local}"
 	done
 }
-- 
1.4.3.5
