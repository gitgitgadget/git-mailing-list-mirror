From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] merge: deprecate 'git merge <message> HEAD <commit>' syntax
Date: Wed, 25 Mar 2015 21:58:45 -0700
Message-ID: <xmqqvbhoz75m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 05:58:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yazsb-0007US-MR
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 05:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbbCZE6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 00:58:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750836AbbCZE6r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 00:58:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D2C2044A56;
	Thu, 26 Mar 2015 00:58:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=M
	JVFUchKsTIl1Rau8Uc9ekplUaw=; b=K9P+YM2oyBIUtLAgHmGWhqHoGOxBeqocj
	dpHFveauRA9Nxm51SxoDy1B3v9eYqjxl/YpCF+pGgvL7f2EtNhUFn2an19Z/7K4F
	O30O2amXNpuZJaLLnvy/9GzYlgjEMFUgLTSNQehZ6Jfz/ol0vpLhdqBdnKMMO4sF
	GLnD7gGtBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Syj
	sAGfGSHwXRD8Nx5tzYjOEkRyconTb4sU14KzlBEN/OUX0LkcCF6giGusF9NO0+iy
	JPbcq1GpSIYCOl/tcSFy2JD3582Bc9SGh46nLjFxYD9JzGkBiL3rSaspQEgWMwNw
	adcrFQnbATingQsUYK4//FX/RnUducAXATAz+GPk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC6F544A55;
	Thu, 26 Mar 2015 00:58:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3AEDB44A54;
	Thu, 26 Mar 2015 00:58:46 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C890A154-D374-11E4-A678-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266310>

We had this in "git merge" manual for eternity:

    'git merge' <msg> HEAD <commit>...

    [This] syntax (<msg> `HEAD` <commit>...) is supported for
    historical reasons.  Do not use it from the command line or in
    new scripts.  It is the same as `git merge -m <msg> <commit>...`.

I wanted to see how much damage we would incur to people by checking
what the damage to _our_ system, including the test scripts, if we
dropped the support for the syntax.  The last time I tried this, I
thought that replacing the use of this syntax in "git pull" with its
obvious and trivial rewrite 'git merge -m <msg> <commit>' broke some
output, and that is the primary reason why I stayed away from trying
this again, but it no longer seems to be the case with today's code
for some reason.

There are quite a few fallouts in the test scripts, and it turns out
that "git cvsimport" also uses this old syntax to record a merge.

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
 git-pull.sh                   | 2 +-
 t/t3402-rebase-merge.sh       | 2 +-
 t/t6021-merge-criss-cross.sh  | 6 +++---
 t/t9402-git-cvsserver-refs.sh | 2 +-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 3b0f8f9..0795358 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1182,6 +1182,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	if (!have_message && head_commit &&
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
index 4d4fc77..252969e 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -334,7 +334,7 @@ true)
 	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
 	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
 	eval="$eval $gpg_sign_args"
-	eval="$eval \"\$merge_name\" HEAD $merge_head"
+	eval="$eval -m \"\$merge_name\" $merge_head"
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
2.3.4-475-g3180e2e
