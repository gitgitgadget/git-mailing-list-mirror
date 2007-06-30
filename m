From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-repack: generational repacking (and example hook script)
Date: Sat, 30 Jun 2007 20:56:21 +1200
Message-ID: <1183193782608-git-send-email-sam.vilain@catalyst.net.nz>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822950-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823588-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 10:57:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4YlP-0006AV-2j
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 10:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbXF3I4s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 04:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbXF3I4r
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 04:56:47 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:56653 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbXF3I40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 04:56:26 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I4Ykh-0008UU-0Q; Sat, 30 Jun 2007 20:56:23 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id F07DD62CE9; Sat, 30 Jun 2007 20:56:22 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
In-Reply-To: <11831937823588-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51205>

Add an option to git-repack that makes the repack run suitable for
running very often.  The idea is that packs get given a "generation",
and that the number of packs in each generation (except the last one)
is bounded.

The useful invocation of this is git-repack -d -g

The -a option then becomes a degenerate case of generative repacking.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/git-repack.txt |    6 +++
 git-repack.sh                |   74 +++++++++++++++++++++++++++++++++++-------
 templates/hooks--post-commit |   14 +++++++-
 3 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index be8e5f8..d458377 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -42,6 +42,12 @@ OPTIONS
 	existing packs redundant, remove the redundant packs.
 	Also runs gitlink:git-prune-packed[1].
 
+-g::
+	Enable "generational" repacking.  This attempts to keep the
+	number of packs under control when repacking very often.  Most
+	useful when called from the `post-commit` hook (see
+	link:hooks.html[hooks] for more information).
+
 -l::
         Pass the `--local` option to `git pack-objects`, see
         gitlink:git-pack-objects[1].
diff --git a/git-repack.sh b/git-repack.sh
index 8c32724..3d253fa 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -3,19 +3,21 @@
 # Copyright (c) 2005 Linus Torvalds
 #
 
-USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--depth=N]'
+USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [-g] [--max-pack-size=N] [--window=N] [--depth=N]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
-no_update_info= all_into_one= remove_redundant=
-local= quiet= no_reuse= extra=
+no_update_info= generations= remove_redundant=
+local= quiet= no_reuse= extra= generation_width=
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
 	-n)	no_update_info=t ;;
-	-a)	all_into_one=t ;;
+	-a)	generations=0 ;;
 	-d)	remove_redundant=t ;;
 	-q)	quiet=-q ;;
+	-g)	generations=3 generation_width=10 ;;
+	-G)	generations=$2; generation_width=5; shift ;;
 	-f)	no_reuse=--no-reuse-object ;;
 	-l)	local=--local ;;
 	--max-pack-size=*) extra="$extra $1" ;;
@@ -40,24 +42,69 @@ PACKTMP="$GIT_OBJECT_DIRECTORY/.tmp-$$-pack"
 rm -f "$PACKTMP"-*
 trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
 
+generation=
+redundant=
+
 # There will be more repacking strategies to come...
-case ",$all_into_one," in
+case ",$generations," in
 ,,)
 	args='--unpacked --incremental'
 	;;
-,t,)
+,*,)
 	if [ -d "$PACKDIR" ]; then
+		max_gen=0
 		for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
 			| sed -e 's/^\.\///' -e 's/\.pack$//'`
 		do
 			if [ -e "$PACKDIR/$e.keep" ]; then
 				: keep
 			else
-				args="$args --unpacked=$e.pack"
 				existing="$existing $e"
+				if [ -e "$PACKDIR/$e.gen" ]; then
+					gen=`cat $PACKDIR/$e.gen`
+				else
+					gen=1
+				fi
+				[ "$max_gen" -lt $gen ] && max_gen=$gen
+				eval "gen_${gen}=\"\$gen_${gen} $e\"";
+				eval "c_gen_${gen}=\$((\$c_gen_${gen} + 1))";
 			fi
 		done
+		i=$max_gen
+		packing=
+		while [ $i -gt 0 ]
+		do
+			eval "c_gen=\$c_gen_$i"
+			eval "packs=\$gen_$i"
+			if [ -n "$c_gen" -a $i -gt "$generations" ]
+			then
+				echo "saw $c_gen packs at generation $i"
+				echo "therefore, repacking everything"
+				packing=1
+				[ -z "$generation" ] && generation=$(($i + 1))
+			elif [ -n "$c_gen" -a "$c_gen" -ge "$generation_width" -a "$i" -lt "$generations" ]
+			then
+				echo -n "generation $i has too many packs "
+				echo "($c_gen >= $generation_width)"
+				echo "repacking at this level and below"
+				packing=1
+				[ -z "$generation" ] && generation=$(($i + 1))
+			fi
+			if [ -n "$packing" ]
+			then
+				for x in $packs; do
+					args="$args --unpacked=$x.pack"
+					redundant="$redundant $x"
+				done
+			fi
+			i=$(($i - 1))
+		done
+		if [ -n "$generation" ]; then
+			[ "$generation" -gt "$generations" ] && generation=$generations
+			[ "$generation" -eq 0 ] && generation=1
+		fi
 	fi
+
 	[ -z "$args" ] && args='--unpacked --incremental'
 	;;
 esac
@@ -95,20 +142,23 @@ for name in $names ; do
 		exit 1
 	}
 	rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
+	[ -n "$generation" ] && echo $generation > "$PACKDIR/pack-$name.gen"
 done
 
 if test "$remove_redundant" = t
 then
-	# We know $existing are all redundant.
-	if [ -n "$existing" ]
+	echo "removing redundant packs"
+	# We know $redundant are all redundant.
+	if [ -n "$redundant" ]
 	then
 		sync
 		( cd "$PACKDIR" &&
-		  for e in $existing
+		  for e in $redundant
 		  do
 			case " $fullbases " in
-			*" $e "*) ;;
-			*)	rm -f "$e.pack" "$e.idx" "$e.keep" ;;
+			*" $e "*) echo "ignoring $e" ;;
+			*)	echo "removing $e.pack etc";
+				rm -f "$e.pack" "$e.idx" "$e.keep" ;;
 			esac
 		  done
 		)
diff --git a/templates/hooks--post-commit b/templates/hooks--post-commit
index 8be6f34..669f1fc 100644
--- a/templates/hooks--post-commit
+++ b/templates/hooks--post-commit
@@ -5,4 +5,16 @@
 #
 # To enable this hook, make this file executable.
 
-: Nothing
+threshold=`git-config gc.threshold`
+threshold=${threshold-250}
+
+gd=`git-rev-parse --git-dir`
+found=$(find $gd/objects/?? -type f | head -$threshold | wc -l)
+
+if [ $found -ge $threshold ]
+then
+    echo "At least $threshold loose objects, running generational repack"
+    git-repack -g -d
+else
+    echo "Found only $found loose objects, less than $threshold"
+fi
-- 
1.5.2.1.1131.g3b90
