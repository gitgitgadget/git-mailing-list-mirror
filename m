From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 01 Aug 2007 23:09:13 -0700
Message-ID: <7vejim1n92.fsf@assigned-by-dhcp.cox.net>
References: <200708010216.59750.jnareb@gmail.com>
	<alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
	<7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
	<20070801092428.GB28106@thunk.org>
	<7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
	<87tzrjfe5h.wl%cworth@cworth.org>
	<alpine.LFD.0.999.0708010937050.3582@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 02 08:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGTsJ-0000Rh-LL
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 08:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbXHBGJR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 02:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbXHBGJR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 02:09:17 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:58298 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbXHBGJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 02:09:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802060915.IOMH7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 02:09:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Wu9D1X00L1kojtg0000000; Thu, 02 Aug 2007 02:09:15 -0400
In-Reply-To: <alpine.LFD.0.999.0708010937050.3582@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 1 Aug 2007 10:03:37 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54518>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> We might make it something like: "if you use an url, we don't default to 
> local", so the difference would be that
>
> 	git clone file:///directory/to/repo
>
> would work the way it does now, but
>
> 	git clone /directory/to/repo
>
> would default to "-l" behaviour. That kind of would make sense (and should 
> be easy to implement: it would be a trivial fixup to "connect.c".

The attached does not default to "-l", but filesystem level copy
behaviour, which is what happens with "clone -l" across
filesystem boundaries with the current code.

Clone of linux-2.6 repository (the source is well packed)

(hardlink -- obviously, almost no cost)
$ /usr/bin/time git clone -l --bare linux-2.6 l-clone.git
Initialized empty Git repository in /git/l-clone.git/
0 blocks
0.55user 1.00system 0:01.56elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+206724minor)pagefaults 0swaps

(same-as-network)
$ /usr/bin/time git clone --bare file://`pwd`/linux-2.6 n-clone.git
Initialized empty Git repository in /git/n-clone.git/
remote: Generating pack...
remote: Counting objects: 1076746
remote: Done counting 1169654 objects.
remote: Deltifying 1169654 objects...
remote:  100% (1169654/1169654) done
Indexing 1169654 objects...
 100% (1169654/1169654) done
remote: Total 1169654 (delta 959223), reused 1160595 (delta 950164)
Resolving 959223 deltas...
 100% (959223/959223) done
172.85user 20.94system 4:25.88elapsed 72%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (6294major+2019874minor)pagefaults 0swaps

(copy -- takes a lot more than hardlink but cheaper than net)
$ /usr/bin/time git clone --bare linux-2.6 c-clone.git
Initialized empty Git repository in /git/c-clone.git/
1266644 blocks
0.92user 10.81system 0:38.38elapsed 30%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (406major+204775minor)pagefaults 0swaps

I am ambivalent between -l vs no -l.

 * Without -l (i.e. have all objects/ copied via cpio) would not
   catch the source repository corruption, and also risks
   corrupted recipient repository if an alpha-particle hits
   memory cell while indexing and resolving deltas.  As long as
   the recipient is made uncorrupted, you have a good back-up.

 * same-as-network is expensive, but it would catch if the
   source is already corrupted.  It still risks corrupted
   recipient repository.  As long as the recipient is made
   uncorrupted, you have a good back-up.

 * With -l, as long as the source repository is healthy, it is
   very likely that the recipient would be, too.  Also it is
   very cheap.  You do not get any back-up benefit.

None of the method is resilient against the source repository
corruption, so let's discount that from the comparison.  Then
the differences between -l and non -l matters primarily if you
value the back-up benefit or not.  If you want to use the cloned
repository as a back-up, then it is cheaper to do a non -l clone
and two git-fsck (source before clone, recipient after clone)
than same-as-network clone, especially as you are likely to do a
git-fsck on the recipient if you are so paranoid anyway.

Which leads me to believe that being able to use file:/// is
probably a good idea, if only for testability, but probably of
little practical value, and we can default to -l for everyday
use, and paranoids can use non -l as a way to make a back-up.

---

 git-clone.sh               |   61 +++++++++++++++++++++++---------------------
 t/t5500-fetch-pack.sh      |    2 +-
 t/t5700-clone-reference.sh |    2 +-
 t/t5701-clone-local.sh     |   17 ++++++++++++
 4 files changed, 51 insertions(+), 31 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 0922554..0583f64 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -87,7 +87,7 @@ Perhaps git-update-server-info needs to be run there?"
 
 quiet=
 local=no
-use_local=no
+use_local_hardlink=no
 local_shared=no
 unset template
 no_checkout=
@@ -108,9 +108,10 @@ while
 	  no_checkout=yes ;;
 	*,--na|*,--nak|*,--nake|*,--naked|\
 	*,-b|*,--b|*,--ba|*,--bar|*,--bare) bare=yes ;;
-	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
+	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local)
+	  use_local_hardlink=yes ;;
         *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared)
-          local_shared=yes; use_local=yes ;;
+          local_shared=yes; ;;
 	1,--template) usage ;;
 	*,--template)
 		shift; template="--template=$1" ;;
@@ -249,34 +250,36 @@ fi
 rm -f "$GIT_DIR/CLONE_HEAD"
 
 # We do local magic only when the user tells us to.
-case "$local,$use_local" in
-yes,yes)
+case "$local" in
+yes)
 	( cd "$repo/objects" ) ||
-		die "-l flag seen but repository '$repo' is not local."
+		die "cannot chdir to local '$repo/objects'."
 
-	case "$local_shared" in
-	no)
-	    # See if we can hardlink and drop "l" if not.
-	    sample_file=$(cd "$repo" && \
-			  find objects -type f -print | sed -e 1q)
-
-	    # objects directory should not be empty since we are cloning!
-	    test -f "$repo/$sample_file" || exit
-
-	    l=
-	    if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
-	    then
-		    l=l
-	    fi &&
-	    rm -f "$GIT_DIR/objects/sample" &&
-	    cd "$repo" &&
-	    find objects -depth -print | cpio -pumd$l "$GIT_DIR/" || exit 1
-	    ;;
-	yes)
-	    mkdir -p "$GIT_DIR/objects/info"
-	    echo "$repo/objects" >> "$GIT_DIR/objects/info/alternates"
-	    ;;
-	esac
+	if test "$local_shared" = yes
+	then
+		mkdir -p "$GIT_DIR/objects/info"
+		echo "$repo/objects" >>"$GIT_DIR/objects/info/alternates"
+	else
+		l= &&
+		if test "$use_local_hardlink" = yes
+		then
+			# See if we can hardlink and drop "l" if not.
+			sample_file=$(cd "$repo" && \
+				      find objects -type f -print | sed -e 1q)
+			# objects directory should not be empty because
+			# we are cloning!
+			test -f "$repo/$sample_file" || exit
+			if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
+			then
+				rm -f "$GIT_DIR/objects/sample"
+				l=l
+			else
+				echo >&2 "Warning: -l asked but cannot hardlink to $repo"
+			fi
+		fi &&
+		cd "$repo" &&
+		find objects -depth -print | cpio -pumd$l "$GIT_DIR/" || exit 1
+	fi
 	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
 	;;
 *)
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 7da5153..7b6798d 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -129,7 +129,7 @@ pull_to_client 2nd "B" $((64*3))
 
 pull_to_client 3rd "A" $((1*3)) # old fails
 
-test_expect_success "clone shallow" "git-clone --depth 2 . shallow"
+test_expect_success "clone shallow" "git-clone --depth 2 file://`pwd`/. shallow"
 
 (cd shallow; git count-objects -v) > count.shallow
 
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 6d43252..4e93aaa 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -51,7 +51,7 @@ diff expected current'
 cd "$base_dir"
 
 test_expect_success 'cloning with reference (no -l -s)' \
-'git clone --reference B A D'
+'git clone --reference B file://`pwd`/A D'
 
 cd "$base_dir"
 
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index b093327..032c498 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -43,4 +43,21 @@ test_expect_success 'local clone from x.git that does not exist' '
 	fi
 '
 
+test_expect_success 'Without -l, local will make a copy' '
+	cd "$D" &&
+	git clone --bare x w &&
+	cd w &&
+	linked=$(find objects -type f ! -links 1 | wc -l) &&
+	test "$linked" = 0
+'
+
+test_expect_success 'With -l, local will make a hardlink' '
+	cd "$D" &&
+	rm -fr w &&
+	git clone -l --bare x w &&
+	cd w &&
+	copied=$(find objects -type f -links 1 | wc -l) &&
+	test "$copied" = 0
+'
+
 test_done
