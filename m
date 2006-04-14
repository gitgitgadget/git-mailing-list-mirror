From: Junio C Hamano <junkio@cox.net>
Subject: Re: Solaris test t5500 race condition
Date: Thu, 13 Apr 2006 22:34:05 -0700
Message-ID: <7vhd4wvhyq.fsf@assigned-by-dhcp.cox.net>
References: <20060414031759.GA9524@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 07:34:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUGwf-0003HO-U5
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 07:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWDNFeK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 01:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWDNFeJ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 01:34:09 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:31466 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965102AbWDNFeI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 01:34:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060414053407.YYUO24255.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 01:34:07 -0400
To: "Peter Eriksen" <s022018@student.dtu.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18685>

"Peter Eriksen" <s022018@student.dtu.dk> writes:

>     Generating pack...
>     Done counting 3 objects.
>     Deltifying 3 objects.
>       33% (1/3) done^M  66% (2/3) done^M 100% (3/3) done
>     Total 3Unpacking , written 33 objects          <------------
>      (delta 0), reused 0 (delta 0)
>     11fa2f0cb58ed7f02dbd5ac75ed82a53fae62a7b refs/heads/A

Hmph.  Not good.  Before the writer managed to flush the report
the reader has already decoded the header and reports the number
of objects it is going to unpack.

Unfortunately the Solaris box I have access to is perhaps
sufficiently slow that this is not an issue X-<.

I think test based on the eye-candy is fragile anyway.  We would
want to probably _count_ before and after to see if the command
did what we expected.

There is a subtle difficulty doing so, however.  The test is
trying to see if fetch-pack vs upload-pack negotiations result
in minimal transfer, but if it is not, unpack side would just
happily say "I received this one, oh, I already have it".

We could do "fetch-pack -k" to keep the result packed, count the
number of objects in the resulting pack.

How about doing something like this instead?

-- >8 --
[PATCH] t5500: test fix

Relying on eye-candy progress bar was fragile to begin with.
Run fetch-pack with -k option, and count the objects that are in
the pack that were transferred from the other end.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 t/t5500-fetch-pack.sh |   33 ++++++++++++++-------------------
 1 files changed, 14 insertions(+), 19 deletions(-)

7f732c632ff7a1adc2309257becdc0c1fe76b514
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index e15e14f..92f12d9 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -12,11 +12,6 @@ # Test fetch-pack/upload-pack pair.
 
 # Some convenience functions
 
-function show_count () {
-	commit_count=$(($commit_count+1))
-	printf "      %d\r" $commit_count
-}
-
 function add () {
 	local name=$1
 	local text="$@"
@@ -55,13 +50,6 @@ function test_expect_object_count () {
 		"test $count = $output"
 }
 
-function test_repack () {
-	local rep=$1
-
-	test_expect_success "repack && prune-packed in $rep" \
-		'(git-repack && git-prune-packed)2>>log.txt'
-}
-
 function pull_to_client () {
 	local number=$1
 	local heads=$2
@@ -70,13 +58,23 @@ function pull_to_client () {
 
 	cd client
 	test_expect_success "$number pull" \
-		"git-fetch-pack -v .. $heads > log.txt 2>&1"
+		"git-fetch-pack -k -v .. $heads"
 	case "$heads" in *A*) echo $ATIP > .git/refs/heads/A;; esac
 	case "$heads" in *B*) echo $BTIP > .git/refs/heads/B;; esac
 	git-symbolic-ref HEAD refs/heads/${heads:0:1}
+
 	test_expect_success "fsck" 'git-fsck-objects --full > fsck.txt 2>&1'
-	test_expect_object_count "after $number pull" $count
-	pack_count=$(grep Unpacking log.txt|tr -dc "0-9")
+
+	test_expect_success 'check downloaded results' \
+	'mv .git/objects/pack/pack-* . &&
+	 p=`ls -1 pack-*.pack` &&
+	 git-unpack-objects <$p &&
+	 git-fsck-objects --full'
+
+	test_expect_success "new object count after $number pull" \
+	'idx=`echo pack-*.idx` &&
+	 pack_count=`git-show-index <$idx | wc -l` &&
+	 test $pack_count = $count'
 	test -z "$pack_count" && pack_count=0
 	if [ -z "$no_strict_count_check" ]; then
 		test_expect_success "minimal count" "test $count = $pack_count"
@@ -84,6 +82,7 @@ function pull_to_client () {
 		test $count != $pack_count && \
 			echo "WARNING: $pack_count objects transmitted, only $count of which were needed"
 	fi
+	rm -f pack-*
 	cd ..
 }
 
@@ -117,8 +116,6 @@ git-symbolic-ref HEAD refs/heads/B
 
 pull_to_client 1st "B A" $((11*3))
 
-(cd client; test_repack client)
-
 add A11 $A10
 
 prev=1; cur=2; while [ $cur -le 65 ]; do
@@ -129,8 +126,6 @@ done
 
 pull_to_client 2nd "B" $((64*3))
 
-(cd client; test_repack client)
-
 pull_to_client 3rd "A" $((1*3)) # old fails
 
 test_done
-- 
1.3.0.rc3.g9306
