From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH/RFC] Teach repack to optionally retain otherwise lost objects
Date: Thu, 29 Nov 2007 03:41:42 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711290340470.27959@racer.site>
References: <200711181225.52288.johannes.sixt@telecom.at>
 <7v3av3wg7h.fsf@gitster.siamese.dyndns.org> <200711182101.53936.johannes.sixt@telecom.at>
 <7v7ikfuxfk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 04:42:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxaI3-00021c-No
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 04:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbXK2Dl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 22:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbXK2Dl4
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 22:41:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:37733 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754228AbXK2Dlz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 22:41:55 -0500
Received: (qmail invoked by alias); 29 Nov 2007 03:41:52 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp058) with SMTP; 29 Nov 2007 04:41:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187RSNn36A7Yc2xyNHH+7yI5TJwnzPnJNkTFlMWpi
	LCGRlrxLD/zcT3
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7ikfuxfk.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66498>


When specifying --attic=<prefix>, the objects that would be lost when
calling repack with -d will be put into a packfile (or multiple
packfiles), using the file name prefix <prefix>.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This implements the idea of Hannes.

	The plan for repo.or.cz is now to invoke repack with
	"--attic=attic" and copied attic-*.{idx,pack} to all the forks'
	object stores, then delete the original attic-*{.idx,pack}.

	The beauty of that approach is that the order in which the
	repositories are repacked is no longer important.

	This patch is marked RFC since there is a severe bottleneck
	here: the new pack's index is sorted and made unique and every
	SHA-1 displayed twice, then the old pack's index is sorted and
	made unique.  Then the combined result is sorted and only the
	now-unique SHA-1s are actually packed.

	(The sort is not necessary if there is only _one_ pack.
	However, we cannot guarantee that.)

	Of course, this is quick 'n dirty, and the price to be paid
	is a substantial performance hit: in my tests, linux-2.6.git
	needed half a second to show its pack's index, but that
	sed 's/^.* //' | sort | uniq | sed p mantra needs 19 seconds.

	The obvious thing is to exploit the fact that the pack indices
	are already sorted:

	I started patch git-show-index so it takes an argument
	--missing-objects, followed by the new pack index file names,
	followed by --, followed be the old pack index file names.

	Then it would traverse all of them simultaneously, outputting
	only the SHA-1s of objects that are in an old pack, but not
	in any of the new packs.

	Two issues: there might be a whole lot of pack files (Pasky
	told me today that in one instance there were 416 pack files!)
	and that might well exceed the maximum number of open files.

	Second issue: there are two different pack index formats, and
	the code is not easily refactored AFAICT.

	Probably a better method would be not to read the files
	simultaneously, but fill a "struct decorate *" with objects
	(which can be faked, as we do not really need to parse them)
	of the new packs, and then only use decorate_lookup() to determine
	for all old packs' objects if they are present in the new ones.

	The latter approach would allow for a relatively easy refactoring
	of show-index.c; just provide a callback for each entry.

	However, I am way too tired today to do it.

	Besides, a completely different idea just struck me: before
	repacking, .git/objects/pack/* could be _hard linked_ to the
	forkee's object stores.  Then nothing in git-repack's code
	needs to be changed.

	Oh, well.  I just wasted 1.5 hours.

 Documentation/git-repack.txt |    4 +++
 git-repack.sh                |   40 +++++++++++++++++++++++++++++++++----
 t/t5303-repack-attic.sh      |   44 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 5 deletions(-)
 create mode 100644 t/t5303-repack-attic.sh

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 12e2079..ec2c2bf 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -84,6 +84,10 @@ OPTIONS
 	If specified,  multiple packfiles may be created.
 	The default is unlimited.
 
+--attic=<prefix>::
+	Put all objects that would/will be lost when running with `-d`
+	into its own packfile(s), with file name prefix `<prefix>`.
+
 
 Configuration
 -------------
diff --git a/git-repack.sh b/git-repack.sh
index e18eb3f..f83d6f0 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -18,12 +18,13 @@ window=         size of the window used for delta compression
 window-memory=  same as the above, but limit memory size instead of entries count
 depth=          limits the maximum delta depth
 max-pack-size=  maximum size of each packfile
+attic=          pack no-longer-packed used objects into an "attic" pack
 "
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
 no_update_info= all_into_one= remove_redundant= keep_unreachable=
-local= quiet= no_reuse= extra=
+local= quiet= no_reuse= extra= attic=
 while test $# != 0
 do
 	case "$1" in
@@ -37,6 +38,8 @@ do
 	-l)	local=--local ;;
 	--max-pack-size|--window|--window-memory|--depth)
 		extra="$extra $1=$2"; shift ;;
+	--attic)
+		attic="$2"; shift ;;
 	--) shift; break;;
 	*)	usage ;;
 	esac
@@ -119,6 +122,36 @@ for name in $names ; do
 	rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
 done
 
+new_existing=
+for e in $existing
+do
+	case "$ fullbases " in
+	*" $e "*) ;;
+	*)
+		new_existing="$new_existing $e"
+		;;
+	esac
+done
+existing="$new_existing"
+
+if test ! -z "$attic"
+then
+	# Find the objects which were in the existing packs, but are no
+	# longer in the new ones.
+	#
+	# This could be much more efficient.
+	(for name in $names
+	 do
+		git show-index < $PACKDIR/pack-$name.idx
+	 done | sed 's/^.* //' | sort | uniq | sed p &&
+	 for e in $existing
+	 do
+		git show-index < "$PACKDIR/$e.idx"
+	 done | sed 's/^.* //' | sort | uniq) | sort | uniq -u |
+	git pack-objects --non-empty "$attic" ||
+		die "Could not create attic '$attic'."
+fi
+
 if test "$remove_redundant" = t
 then
 	# We know $existing are all redundant.
@@ -128,10 +161,7 @@ then
 		( cd "$PACKDIR" &&
 		  for e in $existing
 		  do
-			case " $fullbases " in
-			*" $e "*) ;;
-			*)	rm -f "$e.pack" "$e.idx" "$e.keep" ;;
-			esac
+			rm -f "$e.pack" "$e.idx" "$e.keep"
 		  done
 		)
 	fi
diff --git a/t/t5303-repack-attic.sh b/t/t5303-repack-attic.sh
new file mode 100644
index 0000000..9777748
--- /dev/null
+++ b/t/t5303-repack-attic.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='repack with an attic pack'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	echo "Ten weary, footsore wanderers," > file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	echo "all in a woeful plight," >> file &&
+	test_tick &&
+	git commit -m second file &&
+	echo "sought shelter in a wayside-inn" >> file &&
+	test_tick &&
+	git commit -m third file &&
+	echo "one dark and lonely night." >> file &&
+	test_tick &&
+	git commit -m fourth file &&
+	echo ">>Nine rooms, no more<<, the landlord said," >> file &&
+	test_tick && git commit -m fifth file &&
+	git repack -a -d &&
+	! ls .git/objects/??/*
+
+'
+
+test_expect_success 'create attic pack' '
+
+	LAST_VERSION=$(git rev-parse --verify HEAD:file) &&
+	git reset --hard HEAD^ &&
+	rm .git/logs/HEAD .git/logs/refs/heads/master &&
+	git cat-file blob $LAST_VERSION &&
+	git repack --attic=attic -a -d &&
+	! git cat-file blob $LAST_VERSION &&
+	test -f attic-*.idx &&
+	cat attic-*.idx | git show-index | grep $LAST_VERSION
+
+'
+
+test_done
-- 
1.5.3.6.2066.g09421
