From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tests: fix autostash
Date: Sat, 8 Jun 2013 09:01:05 -0500
Message-ID: <CAMP44s1p-VDMLNhoym5fH3XAn8CWqu2yqGq0mb+55qHOq-r_ww@mail.gmail.com>
References: <1370648714-7872-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=OdcLDCd9OonUS6kBZhA=oz3HYJT8Eiqnh1A++s5yWww@mail.gmail.com>
	<CAMP44s3rYXOmGWR3JM8xy8ON4pqDRhYWVMQqOAyODVr5myq+yg@mail.gmail.com>
	<CALkWK0=qVXL=DtJzYRGFLQQh3_-cGC_t_zpaiTL9KVKN4--mVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 16:01:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJhq-0004Lh-90
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 16:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab3FHOBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 10:01:08 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:62841 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab3FHOBH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 10:01:07 -0400
Received: by mail-lb0-f171.google.com with SMTP id 13so1822494lba.2
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 07:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QbuOYdsw/m/vpPGn9G2HZKVgqtFoZNxVmWuPm4S+aUs=;
        b=G9lsM6TaRgah/ZgkCAT0pBjHm/gZfa1P/5DxcepSwOZ0h3ziMdcoIjkgepLLQr/aeu
         tw39lPmSWLc9plUcheXEWr5Tp5tRINHBWIbVuunHNIBcber1iFnv/Zx+yybdwyNv1BsX
         NS12vl/Np60Xbk9NdZsNsRSPVIBcy295buPrdgaaUfYRlz00QR/CwWj2naKr0ZbtjT/U
         rqzi0Chyv0iMRqQUzD8ExOIz1Lpx2vj6IrKn4UsD9+o+TViBAClnS94PTPg3BMSEeSzb
         j+XQbmvrRgXsoafwSpdPB2k34bY+s/jSBLmo6WSH10o9AMmMQGjkixKGwF7rO7FQXAWX
         V4SQ==
X-Received: by 10.152.27.170 with SMTP id u10mr1422989lag.45.1370700065543;
 Sat, 08 Jun 2013 07:01:05 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 07:01:05 -0700 (PDT)
In-Reply-To: <CALkWK0=qVXL=DtJzYRGFLQQh3_-cGC_t_zpaiTL9KVKN4--mVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226824>

On Sat, Jun 8, 2013 at 8:19 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:

>> Doing 'rm -rf $dotest' is even worst than 'git rebase --abort',
>> because it relies on the implementation of 'git rebase', which might
>> need to remove more files than $dotest.
>
> Huh?  Tests aren't allowed to rely on how a command is implemented?
>
>   $ git grep test_path t
>
> Ofcourse they're implementation details.  Even in this very test, I
> check $dotest/autostash plenty of times.

The more the test relies on implementation details, the worst.

> Have you read rr/rebase-autostash?  The whole idea is to inject
> $dotest/autostash and teach various scripts about how their
> assumptions about $dotest have changed.
>
>> This wouldn't be a problem if the tests were implemented correctly,
>> but they are not, so 'git rebase --abort' is the only sane option.
>
> Then show me how to do it correctly.

Something like this.

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 6ba449b..b96a56a 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -33,54 +33,56 @@ test_expect_success setup '
 	git commit -m "related commit"
 '

+setup_tmp () {
+	git clone . tmp &&
+	cd tmp &&
+	git fetch -u origin "refs/heads/*:refs/heads/*" &&
+	test_config rebase.autostash true &&
+	git checkout -b rebased-feature-branch feature-branch
+}
+
 testrebase() {
 	type=$1
 	dotest=$2

 	test_expect_success "rebase$type: dirty worktree, non-conflicting rebase" '
-		test_config rebase.autostash true &&
-		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		echo dirty >>file3 &&
 		git rebase$type unrelated-onto-branch &&
 		grep unrelated file4 &&
-		grep dirty file3 &&
-		git checkout feature-branch
+		grep dirty file3
+		)
 	'

 	test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
-		test_config rebase.autostash true &&
-		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		echo dirty >>file3 &&
 		git add file3 &&
 		git rebase$type unrelated-onto-branch &&
 		grep unrelated file4 &&
-		grep dirty file3 &&
-		git checkout feature-branch
+		grep dirty file3
+		)
 	'

 	test_expect_success "rebase$type: conflicting rebase" '
-		test_config rebase.autostash true &&
-		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
-		false ! grep dirty file3 &&
-		rm -rf $dotest &&
-		git reset --hard &&
-		git checkout feature-branch
+		! grep dirty file3
+		)
 	'

 	test_expect_success "rebase$type: --continue" '
-		test_config rebase.autostash true &&
-		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
@@ -89,45 +91,43 @@ testrebase() {
 		git add file2 &&
 		git rebase --continue &&
 		test_path_is_missing $dotest/autostash &&
-		grep dirty file3 &&
-		git checkout feature-branch
+		grep dirty file3
+		)
 	'

 	test_expect_success "rebase$type: --skip" '
-		test_config rebase.autostash true &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
 		! grep dirty file3 &&
 		git rebase --skip &&
 		test_path_is_missing $dotest/autostash &&
-		grep dirty file3 &&
-		git checkout feature-branch
+		grep dirty file3
+		)
 	'

 	test_expect_success "rebase$type: --abort" '
-		test_config rebase.autostash true &&
-		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
 		! grep dirty file3 &&
 		git rebase --abort &&
 		test_path_is_missing $dotest/autostash &&
-		grep dirty file3 &&
-		git checkout feature-branch
+		grep dirty file3
+		)
 	'

 	test_expect_success "rebase$type: non-conflicting rebase, conflicting stash" '
-		test_config rebase.autostash true &&
-		git reset --hard &&
-		git checkout -b rebased-feature-branch feature-branch &&
-		test_when_finished git branch -D rebased-feature-branch &&
+		test_when_finished "rm -rf tmp" &&
+		(
+		setup_tmp &&
 		echo dirty >file4 &&
 		git add file4 &&
 		git rebase$type unrelated-onto-branch &&
@@ -138,6 +138,7 @@ testrebase() {
 		git checkout feature-branch &&
 		git stash pop &&
 		grep dirty file4
+		)
 	'
 }

-- 
Felipe Contreras
