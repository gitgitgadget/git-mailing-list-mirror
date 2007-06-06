From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] [RFC] Generational repacking
Date: Wed,  6 Jun 2007 23:08:25 +1200
Message-ID: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 13:08:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvtNY-0001I7-A7
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 13:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbXFFLId (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 07:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbXFFLId
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 07:08:33 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:58862 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbXFFLIc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 07:08:32 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1HvtNJ-0008Fl-8J; Wed, 06 Jun 2007 23:08:25 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 31E06CB9E8; Wed,  6 Jun 2007 23:08:25 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.0.45.gfea6d-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49283>

This is a quick hack at generational repacking.  The idea is that you
successively do larger repack runs as the number of packs accumulates.

The commandline interface for this should be considered development
grade only, and of course there are no tests and very verbose output
:)

The useful invocation of this is git-repack -d -g

The -a option then becomes a degenerate case of generative repacking.

The intention is that this should end up light enough to be triggered
automatically whenever the (approximate) count of loose objects hits a
threshold, like 100 or 1000 - making git repositories "maintenance
free".
---
 git-repack.sh |   79 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 8c32724..b26ca2a 100755
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
@@ -40,24 +42,74 @@ PACKTMP="$GIT_OBJECT_DIRECTORY/.tmp-$$-pack"
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
+		echo "Scanning for packs... generations: $generations, generation_width: $generation_width"
 		for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
 			| sed -e 's/^\.\///' -e 's/\.pack$//'`
 		do
+			echo -n "what about $e ? "
 			if [ -e "$PACKDIR/$e.keep" ]; then
 				: keep
+				echo "keep it - .keep exists"
 			else
-				args="$args --unpacked=$e.pack"
 				existing="$existing $e"
+				if [ -e "$PACKDIR/$e.gen" ]; then
+					gen=`cat $PACKDIR/$e.gen`
+				else
+					echo -n "assuming "
+					gen=1
+				fi
+				echo "generation $gen"
+				[ "$max_gen" -lt $gen ] && max_gen=$gen
+				eval "gen_${gen}=\"\$gen_${gen} $e\"";
+				eval "c_gen_${gen}=\$((\$c_gen_${gen} + 1))";
 			fi
 		done
+		i=$max_gen
+		packing=
+		while [ $i -gt 0 ]
+		do
+			c_gen=`eval "echo \\\$c_gen_$i"`
+			packs=`eval "echo \\\$gen_$i"`
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
@@ -95,20 +147,23 @@ for name in $names ; do
 		exit 1
 	}
 	rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
+	[ -n "$generation" ] && echo $generation > "$PACKDIR/pack-$name.gen"
 done
 
 if test "$remove_redundant" = t
 then
-	# We know $existing are all redundant.
-	if [ -n "$existing" ]
+    	echo "removing redundant packs"
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
-- 
1.5.2.0.45.gfea6d-dirty
