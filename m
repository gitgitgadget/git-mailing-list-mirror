X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Michael Loeffler <zvpunry@zvpunry.de>
Subject: [PATCH 3/3] git-fetch: allow regular expressions in the refspec
Date: Mon, 04 Dec 2006 20:45:33 +0100
Message-ID: <1165261534.20871.1.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 19:48:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Evolution 2.6.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33231>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrJnE-0001Qe-De for gcvg-git@gmane.org; Mon, 04 Dec
 2006 20:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937352AbWLDTqN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 14:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937351AbWLDTqD
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 14:46:03 -0500
Received: from mx01.ap-wdsl.de ([88.198.184.82]:34817 "EHLO mx01.ap-wdsl.de"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937335AbWLDTp6
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 14:45:58 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This allows the use of regex in refspecs, but it does not support
extended regex because the option -r is a GNU-sed extension.

Now it is possible to write the following refspecs:

Pull: refs/heads/master:refs/remotes/origin/master
Pull: refs/heads/:refs/remotes/origin/
Pull: refs/heads/\(.*fetch.*\):refs/heads/fetch/\1

Signed-off-by: Michael Loeffler <zvpunry@zvpunry.de>
---
This patch has still some problems with MacOS X (I think it is the
sed-script). I will look at it tomorrow.

What do you think about this?

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 38af4cb..0162154 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -100,30 +100,86 @@ expand_refs_wildcard () {
 	for ref
 	do
 		lref=${ref#'+'}
-		# a non glob pattern is given back as-is.
-		expr "z$lref" : 'zrefs/.*/:refs/.*/$' >/dev/null || {
-			echo "$ref"
-			continue
-		}
-
-		from=`expr "z$lref" : 'z\(refs/.*/\):refs/.*/$'`
-		to=`expr "z$lref" : 'zrefs/.*/:\(refs/.*/\)$'`
 		local_force=
 		test "z$lref" = "z$ref" || local_force='+'
-		echo "$ls_remote_result" |
-		(
-			IFS='	'
-			while read sha1 name
-			do
-				mapped=${name#"$from"}
-				if test "z$name" != "z${name%'^{}'}" ||
-					test "z$name" = "z$mapped"
-				then
-					continue
-				fi
-				echo "${local_force}${name}:${to}${mapped}"
-			done
-		)
+
+		if expr "z$lref" : 'zrefs/.*/:refs/.*/$' >/dev/null
+		then
+			from=`expr "z$lref" : 'z\(refs/.*/\):refs/.*/$'`
+			to=`expr "z$lref" : 'zrefs/.*/:\(refs/.*/\)$'`
+			echo "$ls_remote_result" |
+			(
+				IFS='	'
+				while read sha1 name
+				do
+					mapped=${name#"$from"}
+					if test "z$name" != "z${name%'^{}'}" ||
+						test "z$name" = "z$mapped"
+					then
+						continue
+					fi
+					echo "${local_force}${name}:${to}${mapped}"
+				done
+			)
+		else
+			local srcref dstref sedscript mapped
+
+			srcref=`expr "z$lref" : "z\(refs/[^:]*\):refs/[^:]*$"`
+			dstref=`expr "z$lref" : "zrefs/[^:]*:\(refs/[^:]*\)$"`
+			sedscript="
+# ignore dereferenced tags
+/\^{}$/{
+	# delete pattern space and start next cycle
+	d
+}
+
+# remove sha1 and the '\t'
+s/^[a-f0-9]\{40\}\t//
+
+# for each matching ref, do the following
+\:${srcref}:{
+	# copy the ref name into the hold space
+	h
+
+	# prepend local_force to the new srcref
+	s/^/${local_force}/
+
+	# append an colon to the new srcref
+	s/$/:/
+
+	# exchange pattern and hold space
+	x
+
+	# do the substitution
+	s:${srcref}:${dstref}:
+
+	# append the new dstref to the hold space
+	H
+
+	# exchange pattern and hold space
+	x
+
+	# remove the embedded newline to build the new refspec
+	s/:\n/:/
+
+	# print the new refspec
+	p
+}
+"
+			mapped=$(echo "$ls_remote_result" | sed -n -e "$sedscript")
+
+			if test "$?" -ne 0
+			then
+				echo "The failed refspec was: ${srcref}:${dstref}" >&2
+			fi
+
+			if test -z "$mapped"
+			then
+				echo "$ref"
+			else
+				echo "$mapped"
+			fi
+		fi
 	done
 }
 
-- 
1.4.4

