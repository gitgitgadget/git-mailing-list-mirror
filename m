From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Fri, 22 Jul 2005 09:56:19 -0700
Message-ID: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jul 22 18:56:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw0p4-0005wX-Fb
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 18:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVGVQ4X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 12:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVGVQ4X
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 12:56:23 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:36856 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262115AbVGVQ4V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 12:56:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722165617.RVHE22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 12:56:17 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In mid April, Ingo announced availability of his conversion from
CVS to a flat patchset format:

    From: Ingo Molnar <mingo@elte.hu>
    Subject: full kernel history, in patchset format
    Message-ID: <20050416131528.GB19908@elte.hu>

    the history data starts at 2.4.0 and ends at 2.6.12-rc2. I've included a 
    script that will apply all the patches in order and will create a 
    pristine 2.6.12-rc2 tree.
    ...
    note: i kept the patches the cvsps utility generated as-is, to have a 
    verifiable base to work on. There were a very small amount of deltas 
    missed (about a dozen), probably resulting from CVS related errors, 
    these are included in the diff-CVS-to-real patch. Also, the patch format 

I was futzing with the script in Ingo's tarball, which
originally used "patch".  After converting it to use
'git-apply', I had some troubles with applying patches, which
eventually led me to find out and fix a corner case bug ---
git-apply did not handle files with an incomplete line correctly
in some cases.

After I fixed that problem, the script still found some more
errors in the patchset, but after manual inspection it looked to
me that they are problems not on the patch application side, but
on the patch generation side.  I only checked 2.4.0, 2.6.9,
2.6.11 and 2.6.12-rc2, but the trees built were byte-to-byte
equivalent, except that the file executable bits, which are
preserved in the patch series.

The patch attached to this message is not for inclusion in the
git source tree.  It is the script I used for conversion.  You
will need the following patches to apply.c for it to work, which
will be sent separately:

  [PATCH 1/2] apply.c: handle incomplete lines correctly.
  [PATCH 2/2] apply.c: --exclude=fnmatch-pattern option.

I did this not because I was particularly interested in the
ancient kernel history, but because I wanted to see how well
packs perform.  Here are some numbers that may be of interest.

    26M pack-000002.pack    18M pack-015360.pack
    48M pack-001024.pack    21M pack-016384.pack
    22M pack-002048.pack    18M pack-017408.pack
    20M pack-003072.pack    19M pack-018432.pack
    21M pack-004096.pack    17M pack-019456.pack
    24M pack-005120.pack    22M pack-020480.pack
    20M pack-006144.pack    20M pack-021504.pack
    20M pack-007168.pack    17M pack-022528.pack
    24M pack-008192.pack    23M pack-023552.pack
    19M pack-009216.pack    16M pack-024576.pack
    24M pack-010240.pack    21M pack-025600.pack
    20M pack-011264.pack    19M pack-026624.pack
    23M pack-012288.pack    18M pack-027648.pack
    21M pack-013312.pack    17M pack-028237.pack
    18M pack-014336.pack

The script makes a full pack after importing 2.4.0 (which is the
patchset #2), and then makes an incremental every 1024 commits,
so the baseline pack is 26MB and the first incremental up to the
patchset #1024 is 48MB.  It averages at around 20MB per 1024
commits.  The repository with the full history, repacked into a
single pack, is 203MB (370291 objects).


------------
A script to slurp full 2.4.0->2.6.12-rc2 history.

Create an empty directory, put the "build-git-tree" script in it, 
and extract Ingo's CVSPS conversion result, available at:

  http://kernel.org/pub/linux/kernel/people/mingo/Linux-2.6-patchset/

in it.  Make sure the definition of variable PS matches the name
of the directory you extracted the tarball, and run the script.
Some hours later, you will have linux/ directory whose .git
subdirectory has a GITified full 2.4.0->2.6.12-rc2 history.

Now if we had a mechanism to graft a later history which starts
at 2.6.12-rc2 on top of this earlier history leading up to
it,...  ;-)

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 build-git-tree |  177 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 177 insertions(+), 0 deletions(-)

diff --git a/build-git-tree b/build-git-tree
new file mode 100755
--- /dev/null
+++ b/build-git-tree
@@ -0,0 +1,177 @@
+#!/bin/sh
+
+PS=linux-2.4.0-to-2.6.12-rc2-patchset
+cat build-git-tree >build-git-tree-next
+cat >sayVersion <<\EOF
+default:
+	@echo "v$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)"
+EOF
+
+: >duplicate-tags
+
+: ${END=28237}
+: ${CPP=1024}
+
+sedScript='
+    /^Date: /{
+	s/^Date: \(.*\)/\1/
+        s/'\''/'\''\\'\'''\''/g
+	s/^.*/DATE='\''&'\''/p
+    }
+    /^Author: /{
+	s/^Author: \(.*\)/\1/
+        s/'\''/'\''\\'\'''\''/g
+	s/^.*/AUTHOR='\''&'\''/p
+    }
+    /^Log:$/{
+	n
+	b LOOP
+    }
+    b
+   : LOOP
+    /^BKrev: /{
+	g
+	s/^\n//
+	s/\n$//
+	s/'\''/'\''\\'\'''\''/g
+	s/^.*/LOG='\''&'\''/p
+	q
+    }
+    H
+    n
+    b LOOP
+'
+
+rm -fr errs linux pack && mkdir -p linux/Documentation errs pack || exit
+cp $PS/logo.gif linux/Documentation
+
+cd linux
+git-init-db
+git-ls-files --cached -z |
+xargs -0 -r git-update-cache --add --remove --
+find ?* -type f -print0 | xargs -0 -r git-update-cache --add --
+
+N=1 P=
+while expr $N \<= $END >/dev/null
+do
+  NN=$(printf "%06d" $N)
+  FILE=../$PS/patches/$N.patch
+
+  e=`sed -ne "$sedScript" $FILE` &&
+  eval "$e" &&
+
+  GIT_AUTHOR_NAME="$AUTHOR" &&
+  GIT_AUTHOR_EMAIL="$AUTHOR" &&
+  GIT_COMMITTER_NAME="$AUTHOR" &&
+  GIT_COMMITTER_EMAIL="$AUTHOR" &&
+  GIT_AUTHOR_DATE="+0000 $DATE" &&
+  GIT_COMMITTER_DATE="+0000 $DATE" &&
+
+  export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME \
+         GIT_COMMITTER_EMAIL GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
+
+  echo "* $NN - $AUTHOR - $DATE" &&
+
+  git-apply --exclude='BitKeeper/*' --index --summary --apply \
+  	<$FILE >../errs/$NN.out 2>&1 || {
+    # Special case.
+    patch -E -p1 <$FILE >../errs/$NN.spc 2>&1
+    sed -ne 's|^File \(.*\) is not empty after patch, as expected$|\1|p' \
+        <../errs/$NN.spc |
+    while read path
+    do
+        echo "* expected to be empty: $path"
+        ls -l "$path"
+	rm -f "$path"
+    done >.tmp
+    cat .tmp >>../errs/$NN.spc
+    rm -f .tmp
+
+    # Some patches (like 678) do not have Index line for everything,
+    # so looking for Index: line is not good enough.
+    sed -n -e 's|^--- linux/\([^	]*\).*|\1|p' \
+	   -e 's|^+++ linux/\([^	]*\).*|\1|p' $FILE |
+    sort -u |
+    xargs -r git-update-cache --add --remove --
+    if test -d BitKeeper
+    then
+      find BitKeeper -type f -print |
+      while read path
+      do
+      	echo removing "$path"
+      done | tee -a ../errs/$NN.spc
+      find BitKeeper -type f -print0 |
+      xargs -0 -r git-update-cache --force-remove --
+      rm -fr BitKeeper
+    fi
+  }
+
+  T=`git-write-tree` &&
+  C=$(echo "$LOG" | git-commit-tree $T $P) &&
+  echo $C >.git/HEAD &&
+
+  P="-p $C" || exit
+
+  # Look at the Makefile change and make a tag.
+  git-diff-tree -p $C Makefile |
+  sed -ne '
+    /^[-+]VERSION =/{
+  	p
+	q
+    }
+    /^[-+]PATCHLEVEL =/{
+  	p
+	q
+    }
+    /^[-+]SUBLEVEL =/{
+  	p
+	q
+    }
+    /^[-+]EXTRAVERSION =/{
+  	p
+	q
+    }
+  ' >.tmp
+  if test -s .tmp
+  then
+      v=$((sed -ne '/^VERSION/p;/^PATCHLEVEL/p;/^SUBLEVEL/p;/^EXTRAVERSION/p' \
+          Makefile; cat ../sayVersion) | make -f -)
+      if test -f ".git/refs/tags/$v"
+      then
+          echo "* $v (duplicate)"
+	  echo "$C	$v" >>../duplicate-tags
+      else
+	  echo "$C" >".git/refs/tags/$v"
+	  echo "* $v"
+      fi
+  fi
+  rm -f .tmp
+
+  # 70a29f4bd97bbb78fac1cc7f87c13fb08d1a12cd == v2.4.0.6
+
+  # Pack
+  if expr \( $N = 2 \) \| \( $N % $CPP = 0 \) >/dev/null
+  then
+    {
+	echo "* packing"
+	du -sh .git/objects &&
+	case "$N" in
+	2)
+	    pack=$(git-rev-list --objects $C | \
+		   git-pack-objects ../pack/pack-$NN)
+	    ;;
+	*)
+	    pack=$(git-rev-list --unpacked --objects $C | \
+		   git-pack-objects --incremental ../pack/pack-$NN)
+	    ;;
+	esac &&
+	ln ../pack/pack-$NN-$pack.idx ../pack/pack-$NN-$pack.pack \
+		.git/objects/pack/. &&
+	git-prune-packed &&
+	du -sh .git/objects
+    } 2>&1 | tee ../errs/$NN.packlog
+  fi
+  test -f ../errs/$NN.spc || rm -f ../errs/$NN.out
+
+  N=`expr $N + 1`
+done
