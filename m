From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why is git-clone --reference so slow?
Date: Wed, 07 Feb 2007 02:03:01 -0800
Message-ID: <7vhcty8eui.fsf@assigned-by-dhcp.cox.net>
References: <1170676004.29759.767.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 11:03:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEjdt-0001RP-VP
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 11:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbXBGKDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 05:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbXBGKDG
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 05:03:06 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:61144 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161098AbXBGKDE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 05:03:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207100302.FELA1343.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 05:03:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id La321W0041kojtg0000000; Wed, 07 Feb 2007 05:03:02 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38906>

David Woodhouse <dwmw2@infradead.org> writes:

> My DSL line sucks; I know this. But why is git-clone so bad at using it?

I did the same and it initially got 45MB pack (14.5k objects).

For my case, the reason was because the repository I used as the
reference was pruned and packed its refs, and git-clone was not
fully using the refs from the reference repository.

The following patch made it to be almost instantaneous.  The
resulting clone has 600kB pack (0.5k objects).


diff --git a/git-clone.sh b/git-clone.sh
index 1710996..1bd54de 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -178,46 +178,32 @@ esac && export GIT_DIR && git-init ${template+"$template"} || usage
 
 if test -n "$reference"
 then
+	ref_git=
 	if test -d "$reference"
 	then
 		if test -d "$reference/.git/objects"
 		then
-			reference="$reference/.git"
+			ref_git="$reference/.git"
+		elif test -d "$reference/objects"
+		then
+			ref_git="$reference"
 		fi
-		reference=$(cd "$reference" && pwd)
-		echo "$reference/objects" >"$GIT_DIR/objects/info/alternates"
-		(cd "$reference" && tar cf - refs) |
-		(cd "$GIT_DIR/refs" &&
-		 mkdir reference-tmp &&
-		 cd reference-tmp &&
-		 tar xf - &&
-		 find refs ! -type d -print |
-		 while read ref
-		 do
-			if test -h "$ref"
-			then
-				# Old-style symbolic link ref.  Not likely
-				# to appear under refs/ but we might as well
-				# deal with them.
-				:
-			elif test -f "$ref"
-			then
-				point=$(cat "$ref") &&
-					case "$point" in
-					'ref: '*) ;;
-					*) continue ;;
-					esac
-			fi
-			# The above makes true ref to 'continue' and
-			# we will come here when we are looking at
-			# symbolic link ref or a textual symref (or
-			# garbage, like fifo).
-			# The true ref pointed at by it is enough to
-			# ensure that we do not fetch objects reachable
-			# from it.
-			rm -f "$ref"
-		 done
-		)
+	fi
+	if test -n "$ref_git"
+	then
+		ref_git=$(cd "$ref_git" && pwd)
+		echo "$ref_git/objects" >"$GIT_DIR/objects/info/alternates"
+		(
+			GIT_DIR="$ref_git" git for-each-ref \
+				--format='%(objectname) %(*objectname)'
+		) |
+		while read a b
+		do
+			test -z "$a" ||
+			git update-ref "refs/reference-tmp/$a" "$a"
+			test -z "$b" ||
+			git update-ref "refs/reference-tmp/$b" "$b"
+		done
 	else
 		die "reference repository '$reference' is not a local directory."
 	fi
