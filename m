From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/14] merge: deprecate 'git merge <message> HEAD <commit>' syntax
Date: Sat, 25 Apr 2015 22:26:07 -0700
Message-ID: <1430025967-24479-15-git-send-email-gitster@pobox.com>
References: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
 <1430025967-24479-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 07:27:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmF5l-0003GC-Vl
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 07:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbbDZF0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 01:26:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751076AbbDZF03 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 01:26:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3ED346712;
	Sun, 26 Apr 2015 01:26:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=tulc
	ZDOFxJAvWvxh5uL7YkhdM1g=; b=SGIljE7QGYNnN+v04U2TtjJBppCFEZxcbV1r
	H997LCDbAP9wRn/QdZC9PcVxJQgrleBz5IaiN2OoO/0twI8n76oIdatgWviE8/Im
	pb6hHdhfwVhV2wKwgyg9JjSUPMz3h3TnXzKMao6AzvH9WSj13OKP18j5XWC7B1qh
	LwQgdpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ldOMvo
	afnPKE9BDCKhqqVNeB9/hBHulGo4NlQubjlcJBDc95DIYDPYte+hpWNkJg2A7TS4
	L1oos1ZL0zVv/2h/GFPxDls22xo0/xDOrmoeoIi9dTB5buNeZ8APhWicHtBu83Th
	bcnr6+aPTk6w16xanj9kybpzY4FJLGDWkF7vU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC6E846711;
	Sun, 26 Apr 2015 01:26:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2927346710;
	Sun, 26 Apr 2015 01:26:28 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-238-g36f5934
In-Reply-To: <1430025967-24479-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C9F4CDB8-EBD4-11E4-8B7C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267820>

We had this in "git merge" manual for eternity:

    'git merge' <msg> HEAD <commit>...

    [This] syntax (<msg> `HEAD` <commit>...) is supported for
    historical reasons.  Do not use it from the command line or in
    new scripts.  It is the same as `git merge -m <msg> <commit>...`.

With the update to "git merge" to make it understand what is
recorded in FETCH_HEAD directly, including Octopus merge cases, we
now can rewrite the use of this syntax in "git pull" with a simple
"git merge FETCH_HEAD".

Also there are quite a few fallouts in the test scripts, and it
turns out that "git cvsimport" also uses this old syntax to record
a merge.

Judging from this result, I would not be surprised if dropping the
support of the old syntax broke scripts people have written and been
relying on for the past ten years.  But at least we can start the
deprecation process by throwing a warning message when the syntax is
used.

With luck, we might be able to drop the support in a few years.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c               | 1 +
 git-cvsimport.perl            | 2 +-
 git-pull.sh                   | 3 +--
 t/t3402-rebase-merge.sh       | 2 +-
 t/t6020-merge-df.sh           | 2 +-
 t/t6021-merge-criss-cross.sh  | 6 +++---
 t/t9402-git-cvsserver-refs.sh | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 42f9fcc..67fbfaf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1299,6 +1299,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 */
 	if (!have_message &&
 	    is_old_style_invocation(argc, argv, head_commit->object.sha1)) {
+		warning("old-style 'git merge <msg> HEAD <commit>' is deprecated.");
 		strbuf_addstr(&merge_msg, argv[0]);
 		head_arg = argv[1];
 		argv += 2;
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 73d367c..82ecb03 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -1162,7 +1162,7 @@ sub commit {
 		die "Fast-forward update failed: $?\n" if $?;
 	}
 	else {
-		system(qw(git merge cvsimport HEAD), "$remote/$opt_o");
+		system(qw(git merge -m cvsimport), "$remote/$opt_o");
 		die "Could not merge $opt_o into the current branch.\n" if $?;
 	}
 } else {
diff --git a/git-pull.sh b/git-pull.sh
index 4d4fc77..15d9431 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -323,7 +323,6 @@ then
 	fi
 fi
 
-merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
 	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
@@ -334,7 +333,7 @@ true)
 	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
 	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
 	eval="$eval $gpg_sign_args"
-	eval="$eval \"\$merge_name\" HEAD $merge_head"
+	eval="$eval FETCH_HEAD"
 	;;
 esac
 eval "exec $eval"
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 5a27ec9..8f64505 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -47,7 +47,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'reference merge' '
-	git merge -s recursive "reference merge" HEAD master
+	git merge -s recursive -m "reference merge" master
 '
 
 PRE_REBASE=$(git rev-parse test-rebase)
diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index 27c3d73..2af1bee 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -24,7 +24,7 @@ test_expect_success 'prepare repository' '
 '
 
 test_expect_success 'Merge with d/f conflicts' '
-	test_expect_code 1 git merge "merge msg" B master
+	test_expect_code 1 git merge -m "merge msg" master
 '
 
 test_expect_success 'F/D conflict' '
diff --git a/t/t6021-merge-criss-cross.sh b/t/t6021-merge-criss-cross.sh
index d15b313..213deec 100755
--- a/t/t6021-merge-criss-cross.sh
+++ b/t/t6021-merge-criss-cross.sh
@@ -48,7 +48,7 @@ echo "1
 " > file &&
 git commit -m "C3" file &&
 git branch C3 &&
-git merge "pre E3 merge" B A &&
+git merge -m "pre E3 merge" A &&
 echo "1
 2
 3 changed in E3, branch B. New file size
@@ -61,7 +61,7 @@ echo "1
 " > file &&
 git commit -m "E3" file &&
 git checkout A &&
-git merge "pre D8 merge" A C3 &&
+git merge -m "pre D8 merge" C3 &&
 echo "1
 2
 3 changed in C3, branch B
@@ -73,7 +73,7 @@ echo "1
 9" > file &&
 git commit -m D8 file'
 
-test_expect_success 'Criss-cross merge' 'git merge "final merge" A B'
+test_expect_success 'Criss-cross merge' 'git merge -m "final merge" B'
 
 cat > file-expect <<EOF
 1
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index 1e266ef..d00df08 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -496,7 +496,7 @@ test_expect_success 'check [cvswork3] diff' '
 '
 
 test_expect_success 'merge early [cvswork3] b3 with b1' '
-	( cd gitwork3 && git merge "message" HEAD b1 ) &&
+	( cd gitwork3 && git merge -m "message" b1 ) &&
 	git fetch gitwork3 b3:b3 &&
 	git tag v3merged b3 &&
 	git push --tags gitcvs.git b3:b3
-- 
2.4.0-rc3-238-g36f5934
