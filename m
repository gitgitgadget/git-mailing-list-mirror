From: "Joshua T. Corbin" <jcorbin@wunjo.org>
Subject: [PATCH] cogito - split out cg-X* to prefix/lib/cogito
Date: Tue, 26 Apr 2005 00:53:33 -0400
Message-ID: <200504260053.33506.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 26 06:50:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQI21-0005TF-58
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 06:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVDZEzg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 00:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVDZEzg
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 00:55:36 -0400
Received: from node1.wunjo.org ([64.62.190.230]:25780 "EHLO node1.wunjo.org")
	by vger.kernel.org with ESMTP id S261205AbVDZEyj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 00:54:39 -0400
Received: by node1.wunjo.org (Postfix, from userid 65534)
	id 8269542EFB; Tue, 26 Apr 2005 00:54:38 -0400 (EDT)
Received: from [192.168.1.100] (24.238.44.109.res-cmts.tv13.ptd.net [24.238.44.109])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by node1.wunjo.org (Postfix) with ESMTP id 2A34142B74
	for <git@vger.kernel.org>; Tue, 26 Apr 2005 00:54:35 -0400 (EDT)
To: git@vger.kernel.org
User-Agent: KMail/1.8
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on node1
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=5.0 tests=RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The following patch does the following:
  * Change the Makefile to install all cg-X* to $(prefix)/lib/cogito
  * Modify all cg-* to use this lib prefix.

Basically the cg-* script looks at $0, if it appears to be in a prefix/bin 
directory that also has a prefix/lib/cogito directory, look for the cg-X* 
there; otherwise things will work as in old.

Signed-off-by: Joshua T. Corbin <jcorbin@wunjo.org>

Index: Makefile
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/Makefile  (mode:100644 
sha1:4f01bbbbb3fd0e53e9ce968f167b6dae68fcfa92)
+++ bb131a04832677b22959ffe47f68900b94accc0c/Makefile  (mode:100644 
sha1:615ccd429dc7f90820442165c64b5d9c047bccbb)
@@ -21,6 +21,7 @@
 prefix=$(HOME)
 
 bindir=$(prefix)/bin
+libdir=$(prefix)/lib/cogito
 
 CC=gcc
 AR=ar
@@ -33,11 +34,12 @@
  diff-cache convert-cache http-pull rpush rpull rev-list git-mktag \
  diff-tree-helper
 
-SCRIPT= commit-id tree-id parent-id cg-Xdiffdo cg-Xmergefile \
- cg-add cg-admin-lsobj cg-cancel cg-clone cg-commit cg-diff \
- cg-export cg-help cg-init cg-log cg-ls cg-merge cg-mkpatch \
- cg-patch cg-pull cg-branch-add cg-branch-ls cg-rm cg-seek cg-status \
- cg-tag cg-update cg-Xlib
+SCRIPT= commit-id tree-id parent-id cg-add cg-admin-lsobj cg-cancel \
+ cg-clone cg-commit cg-diff cg-export cg-help cg-init cg-log cg-ls \
+ cg-merge cg-mkpatch cg-patch cg-pull cg-branch-add cg-branch-ls \
+ cg-rm cg-seek cg-status cg-tag cg-update
+
+SCRIPTLIB= cg-Xlib cg-Xdiffdo cg-Xmergefile
 
 COMMON= read-cache.o
 
@@ -96,7 +98,9 @@
 
 install: $(PROG) $(SCRIPTS) $(SCRIPT) $(GEN_SCRIPT)
 	install -m755 -d $(DESTDIR)$(bindir)
+	install -m755 -d $(DESTDIR)$(libdir)
 	install $(PROG) $(SCRIPTS) $(SCRIPT) $(GEN_SCRIPT) $(DESTDIR)$(bindir)
+	install $(SCRIPTLIB) $(DESTDIR)$(libdir)
 
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(GEN_SCRIPT) $(LIB_FILE)
Index: cg-Xdiffdo
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-Xdiffdo  (mode:100755 
sha1:e3907b39ea105acb2f2ac3659f16898604b72d09)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-Xdiffdo  (mode:100755 
sha1:832fd2c2a09274b5279327e1c31b99afc04fa7f1)
@@ -12,7 +12,16 @@
 #
 # Outputs a diff converting the first tree to the second one.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 
 id1=$1; shift
Index: cg-Xmergefile
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-Xmergefile  (mode:100755 
sha1:0109e0ff4572be5c8f123f9df573b56a42718a17)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-Xmergefile  (mode:100755 
sha1:b074685a23b33e42ec29734984f586b18e5f30de)
@@ -21,7 +21,16 @@
 # do any merges that migth change the tree layout
 #
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 # if the directory is newly added in a branch, it might not exist
 # in the current tree
Index: cg-add
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-add  (mode:100755 
sha1:1b7a821fd0b3f9702508503a082869ed4ec3ab52)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-add  (mode:100755 
sha1:034c164fefc6f61ab386f49b5d5bf63005ea0e77)
@@ -8,7 +8,16 @@
 # Optional "-n" parameter specifies that you don't want to add directories
 # recursively.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 [ "$1" ] || die "usage: cg-add [-n] FILE..."
 
Index: cg-admin-lsobj
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-admin-lsobj  (mode:100755 
sha1:c68d9176d843700df17b109389102ae84eab3888)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-admin-lsobj  (mode:100755 
sha1:95256f36dff108274cbdaff9c97eabc2976ae00e)
@@ -16,7 +16,16 @@
 #
 # Takes the object type as the first parameter, defaults to all objects.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 target=$1
 
Index: cg-branch-add
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-branch-add  (mode:100755 
sha1:7ae72b5e920a7977641dfca8f02dda21a730b907)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-branch-add  (mode:100755 
sha1:6b42c80b8102b42a0f391ca0b39746e6ef4fb167)
@@ -26,7 +26,16 @@
 #
 # Takes the branch' name and location (local path or rsync URL).
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 name=$1
 location=$2
Index: cg-branch-ls
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-branch-ls  (mode:100755 
sha1:20b0a30ce30f73020f9b02a5d606577182444186)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-branch-ls  (mode:100755 
sha1:998505a87567a123e42fbd7dbc0233f524f6ed0c)
@@ -5,7 +5,16 @@
 #
 # Takes no parameters.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 mkdir -p .git/branches
 [ "$(find .git/branches -follow -type f)" ] \
Index: cg-cancel
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-cancel  (mode:100755 
sha1:0637536030d340f5e812868b40eb5d1b20612839)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-cancel  (mode:100755 
sha1:19eaae5e9ac6490a5ded2a6ec52f68652b294d81)
@@ -10,7 +10,16 @@
 #
 # Takes no arguments and the evil changes from the tree.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 # Undo seek?
 branch=
Index: cg-clone
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-clone  (mode:100755 
sha1:4ee0685c358e094c5350b3968d013105da6ddf7e)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-clone  (mode:100755 
sha1:eacefb54e1b1893db819b169e4d9d8f442e8fbcf)
@@ -8,7 +8,16 @@
 #
 # Takes an parameter specifying location of the source repository.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 location=$1
 [ "$location" ] || die "usage: cg-clone SOURCE_LOC"
Index: cg-commit
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-commit  (mode:100755 
sha1:053554d7a3e23ddcdab91a5e58e50286386092f2)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-commit  (mode:100755 
sha1:3e521cd21bf104c746ff8a3f3248c2f898d1ac1d)
@@ -10,7 +10,16 @@
 #
 # FIXME: Gets it wrong for filenames containing spaces.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 
 [ -s .git/blocked ] && die "committing blocked: $(cat .git/blocked)"
Index: cg-diff
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-diff  (mode:100755 
sha1:b0c3e7389c06718c789e40b9a4fdce0afcb17917)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-diff  (mode:100755 
sha1:37b48a84bb140be9e61838f293f510d4be65b3b3)
@@ -16,7 +16,16 @@
 #
 # Outputs a diff converting the first tree to the second one.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 
 id1=" "
@@ -72,7 +81,7 @@
 	# FIXME: Update ret based on what did we match. And take "$@"
 	# to account after all.
 	ret=
-	diff-cache -r -z $tree | xargs -0 cg-Xdiffdo "$tree" uncommitted "$filter"
+	diff-cache -r -z $tree | xargs -0 ${COGITO_LIB}cg-Xdiffdo "$tree" 
uncommitted "$filter"
 
 	if [ "$id1" != " " ]; then
 		rm $GIT_INDEX_FILE
@@ -89,6 +98,6 @@
 
 [ "$id1" = "$id2" ] && die "trying to diff $id1 against itself"
 
-diff-tree -r -z $id1 $id2 | xargs -0 cg-Xdiffdo $id1 $id2 "$filter"
+diff-tree -r -z $id1 $id2 | xargs -0 ${COGITO_LIB}cg-Xdiffdo $id1 $id2 
"$filter"
 
 [ "$filter" ] && rm $filter
Index: cg-export
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-export  (mode:100755 
sha1:d39eb8e723c8cb74c96b64d510f49d1bfcd7d5f8)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-export  (mode:100755 
sha1:94d419de48a12f1ea1059451ac4cd489f7008916)
@@ -6,7 +6,16 @@
 # Takes a target directory and optionally an id as a parameter,
 # defaulting to HEAD.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 destdir=$1
 id=$(tree-id $2)
Index: cg-help
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-help  (mode:100755 
sha1:36480174eba9cc54e9baba100cbd368fbced5c76)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-help  (mode:100755 
sha1:9d059861d899862f736f91c07459569b57df34de)
@@ -3,7 +3,16 @@
 # The help for the Cogito toolkit.
 # Copyright (c) Petr Baudis, 2005
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 cat <<__END__
 The Cogito version control system  $(cg-version)
Index: cg-init
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-init  (mode:100755 
sha1:d249140002888742c46ecba5925cae7c8025ea93)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-init  (mode:100755 
sha1:12d4716eb1b04f9d76a97e68ef6abd9f4ae62ef9)
@@ -6,7 +6,16 @@
 # Takes an optional parameter which will make it "clone" a specified
 # remote repository.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 uri=$1
 
Index: cg-log
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-log  (mode:100755 
sha1:15016b6df35021af01ef8a564c47dbe2e08a78a2)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-log  (mode:100755 
sha1:c7c4ecccb0844055c23a957a57385b787909883d)
@@ -18,7 +18,16 @@
 # Takes an id resolving to a commit to start from (HEAD by default),
 # or id1:id2 representing an (id1;id2] range of commits to show.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 if [ "$1" = "-c" ]; then
 	shift
Index: cg-ls
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-ls  (mode:100755 
sha1:5c9a90963252746e743b9295a47ffafc25ece848)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-ls  (mode:100755 
sha1:a09eaeb6df0b082a4accfed7aaeec4654621708b)
@@ -5,7 +5,16 @@
 #
 # Optionally takes commit or tree id as a parameter, defaulting to HEAD.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 id=$(tree-id $1) || exit 1
 
Index: cg-merge
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-merge  (mode:100755 
sha1:6f145b432be23419c82d5941e29b6bf082973f65)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-merge  (mode:100755 
sha1:49c2a76243dc8f917107be619d205fe518946da9)
@@ -13,7 +13,16 @@
 # Alternatively, it will just bring the HEAD forward, if your current
 # HEAD is also the merge base.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 head=$(commit-id)
 
@@ -84,7 +93,7 @@
 
 
 read-tree -m $(tree-id $base) $(tree-id $head) $(tree-id $branch) || die 
"read-tree failed"
-if ! merge-cache cg-Xmergefile -a || [ "$careful" ]; then
+if ! merge-cache ${COGITO_LIB}cg-Xmergefile -a || [ "$careful" ]; then
 	checkout-cache -f -a
 
 	# "Resolve" merges still in the cache (conflicts).
Index: cg-mkpatch
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-mkpatch  (mode:100755 
sha1:5ba423cbbb3e5f72cd7fb74f2873d49b60557f12)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-mkpatch  (mode:100755 
sha1:ae47a32b6ff819177301f339735366fdcf1fd207)
@@ -6,7 +6,16 @@
 # Takes commit ID, defaulting to HEAD, or id1:id2, forming a range
 # (id1;id2]. (Use "id1:" to take just everything from id1 to HEAD.)
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 
 showpatch () {
Index: cg-patch
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-patch  (mode:100755 
sha1:779c5985b78bc055d5296407d23cc00f628c9d23)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-patch  (mode:100755 
sha1:c2a57eadf8069c5cbec84979561bb2291f733f21)
@@ -8,7 +8,16 @@
 #
 # Takes the diff on stdin.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 gonefile=$(mktemp -t gitapply.XXXXXX)
 todo=$(mktemp -t gitapply.XXXXXX)
Index: cg-pull
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-pull  (mode:100755 
sha1:5cd67519fc5399886f22e8758d6d34e0e3014cbb)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-pull  (mode:100755 
sha1:e7a70ad7cb48ded1b28b9d2b137b4d50980bd0b7)
@@ -7,7 +7,16 @@
 #
 # Takes the branch' name.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 name=$1
 
Index: cg-rm
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-rm  (mode:100755 
sha1:1e0c64567767668454a0360785ac84883c7bbd58)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-rm  (mode:100755 
sha1:f2d2e0c042fdf9496d53e833a50d960331e145b4)
@@ -8,7 +8,16 @@
 # Optional "-n" parameter specifies that you don't want to remove directories
 # recursively.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 [ "$1" ] || die "usage: cg-rm [-n] FILE..."
 
Index: cg-seek
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-seek  (mode:100755 
sha1:29224219fc08893a41e75412dca2ac576f93c30e)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-seek  (mode:100755 
sha1:7537fcb6bfc00635cdd0d009a71e7786a7b367f7)
@@ -20,7 +20,16 @@
 #
 # Takes the target commit ID.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 dstcommit=$1
 
Index: cg-status
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-status  (mode:100755 
sha1:c9b69b9d54b6a6756f0ecad5324642eb66810b33)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-status  (mode:100755 
sha1:17bd538d9117b0b8bd7f7eaaaf1e2fd6552b9685)
@@ -5,7 +5,16 @@
 #
 # Takes no arguments.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 {
 	show-files -z -t --others --deleted --unmerged
Index: cg-tag
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-tag  (mode:100755 
sha1:a48da6d3e584d78aab30ffb0a5e93b29986eb5a1)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-tag  (mode:100755 
sha1:abc8dd69c1f9d0e023c2ed2d0b9982eb674f4f01)
@@ -8,7 +8,16 @@
 #
 # Takes the tag's name and optionally the associated ID.
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 name=$1
 id=$2
Index: cg-update
===================================================================
--- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-update  (mode:100755 
sha1:956b69db12df0e41d0ff01ade090ef87f7c3fa22)
+++ bb131a04832677b22959ffe47f68900b94accc0c/cg-update  (mode:100755 
sha1:292faa316195fe254552367f849c60403d0770da)
@@ -6,7 +6,16 @@
 # Takes the branch' name; no parameter will cause it to update
 # against HEAD (only recovers lost files for now).
 
-. cg-Xlib
+if [ -z "$COGITO_LIB" ]; then
+  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
+  if [ -d $COGITO_LIB ]; then
+    COGITO_LIB=$COGITO_LIB/
+  else
+    COGITO_LIB=
+  fi
+fi
+
+. ${COGITO_LIB}cg-Xlib
 
 name=$1
 
