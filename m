Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6B3C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 09:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903A26120C
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 09:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhGVIua (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 04:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhGVIu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 04:50:28 -0400
X-Greylist: delayed 156 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jul 2021 02:31:03 PDT
Received: from utm.cloud6.fr (utm.cloud6.fr [IPv6:2a03:18e0:12:100::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B75FC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 02:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=md6.fr; s=dkim-20171024;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From; bh=rSGtuKU4vv0LMEZ5HnGk7OfaoMFAe4mSvBKN2ht/zsg=;
        b=ljdvfpxoJf+BjrgcVtRwrwXe5xDV5VHoBjUbLAT4ZSefRqlxjmKETTDtdDEu9y0F2HtzNq5rBlGkHoRnlPkfRb2JsUREvU75zxYbiwHqrm+7RQvKx7uXe/4AHhAMdZHFBOie4m1CMxEbCufUPfcmAb7/zvs0AzFCHzbDQegWmMo=;
Received: from wscorpmbx1.corp.lan ([10.100.0.21]:58712)
        by utm.cloud6.fr with esmtps (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <sylvain.bentz@md6.fr>)
        id 1m6V01-00042B-1t
        for git@vger.kernel.org; Thu, 22 Jul 2021 11:28:13 +0200
Received: from WSCORPMBX1.corp.lan (10.100.0.21) by WSCORPMBX1.corp.lan
 (10.100.0.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 22 Jul
 2021 11:28:13 +0200
Received: from WSCORPMBX1.corp.lan ([::1]) by WSCORPMBX1.corp.lan ([::1]) with
 mapi id 15.01.2176.009; Thu, 22 Jul 2021 11:28:13 +0200
X-CTCH-RefID: str=0001.0A782F1D.60F93A2D.0086,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   BENTZ Sylvain <sylvain.bentz@md6.fr>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug: Commit a merge resolution with non-closed conflict markers leads
 to errs, segfault
Thread-Topic: Bug: Commit a merge resolution with non-closed conflict markers
 leads to errs, segfault
Thread-Index: Add+2nkEiZmufg3zQy2G6lCpX2KZXw==
Date:   Thu, 22 Jul 2021 09:28:13 +0000
Message-ID: <bdb6c03f290c49bb96e6c0a3d9742a52@md6.fr>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.100.0.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've stumbled on a segmentation fault while resolving merge conflicts.
Basically, I missed to remove some conflict markers, tried to commit the
(faulty) merge resolution, and Git mishandles that.

The original issue happened applying a patch using 3-way merge.  The minima=
l
working example below creates a conflict with a simple `git merge` command.


Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1. Create a merge conflict
2. Edit the conflicted file, keep some conflict markers (more on that below=
 [1])
3. Commit (works but errors are reported!)
4. Fix the file, by removing all conflict markers
5. Commit (works but segmentation fault!)
6. Commit again, with some changes or with an empty commit (fatal error!)

See shell script (MWE) below [2].


What did you expect to happen? (Expected behavior)

At step 3, Git should return an error without committing.


What happened instead? (Actual behavior)

Git works and breaks at the same time.
Step 3 : It throws error messages without returning an error, and it does c=
ommit.
Step 5 : It breaks (segfault), manages to commit, but fails to remove a loc=
kfile.

See terminal output below [3].

Then, if I reset hard to the commit named "master", delete the lockfile, an=
d
repeat the process, I still get errors in step 3, but no segfault in step 5=
.


What's different between what you expected and what actually happened?

Git shouldn't segfault obviously. See gdb output below [4].


Anything else you want to add:

Tested versions: 2.20 (debian stable), 2.32 (alpine 3.14), next (alpine 3.1=
4)

[1] Some configurations of conflict markers triggers that bug, others don't=
.
    The minimal working example shows the case (A).

Failure cases:
(A)        (B)        (C)
<<<<<<<<<  <<<<<<<<<  <<<<<<<<<
           >>>>>>>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D

Not failure cases:
(D)        (E)        (F)
=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D  >>>>>>>>>
>>>>>>>>>                     =20

[2] Shell script (MWE)

# Setup conflicting branches `master' and `conflict'

FOLDER=3D${1:-git-break}
mkdir "$FOLDER"
cd "$FOLDER"
git init
echo '' > README
git add README
git commit -m "First commit"
echo master > README
git commit -i README -m "master"
git checkout -b conflict HEAD~
echo conflict > README
git commit -i README -m "conflict"
git checkout master

# Convenience functions

mer() { set -x; git merge conflict; }
com() { set -x; git add README; git commit -m "$1"; }
del() { set -x; for arg; do sed -i "/$arg/ d" README; done; cat README; }
see() { set -x; git log -p -n2; }

# Script

mer                  # Create a merge conflict
del =3D '>'            # Keep the conflict marker `<<<<<<<<<<<'
com "Merge commit"   # Commit (errors reported)
del '<'              # Fix by deleting the remaining marker
com "Fix the merge"  # Commit (segfault)
echo next >> README  # Do some changes...
com "next"           # Commit (fatal error)

[3] Terminal output

####### START TERMINAL OUTPUT ########

/git-min # see
+ see
+ set -x
+ git log -p -n2
commit 9a9dd03509b8cf45c8037c60c256d6ef67f9e431 (HEAD -> master)
Author: sylvain.bentz <sylvain.bentz@md6.fr>
Date:   Wed Jul 21 14:50:37 2021 +0200

    master

diff --git a/README b/README
index 8b13789..1f7391f 100644
--- a/README
+++ b/README
@@ -1 +1 @@
-
+master

commit cfb5d5cd9f28e1dcca7a1d1088405d8ec4ebf713
Author: sylvain.bentz <sylvain.bentz@md6.fr>
Date:   Wed Jul 21 14:49:36 2021 +0200

    First commit

diff --git a/README b/README
new file mode 100644
index 0000000..8b13789
--- /dev/null
+++ b/README
@@ -0,0 +1 @@
+

/git-min # mer
+ mer
+ set -x
+ git merge conflict
Auto-merging README
CONFLICT (content): Merge conflict in README
Recorded preimage for 'README'
Automatic merge failed; fix conflicts and then commit the result.

/git-min # del =3D '>'
+ del '=3D' '>'
+ set -x
+ sed -i '/=3D/ d' README
+ sed -i '/>/ d' README
+ cat README
<<<<<<< HEAD
master
conflict

/git-min # com merge
+ com merge
+ set -x
+ git add README
+ git commit -m merge
error: could not parse conflict hunks in 'README'
error: could not parse conflict hunks in 'README'
Recorded preimage for 'README'
[master ab6c525] merge

/git-min # del '<'
+ del '<'
+ set -x
+ sed -i '/</ d' README
+ cat README
master
conflict

/git-min # com mergefix
+ com mergefix
+ set -x
+ git add README
+ git commit -m mergefix
Segmentation fault

/git-min # see
+ see
+ set -x
+ git log -p -n2
commit 8ea1a55602ba5ae505b43f2ae3a49b3a9a26b2fe (HEAD -> master)
Author: Your Name <you@example.com>
Date:   Wed Jul 21 15:38:35 2021 +0000

    mergefix

diff --git a/README b/README
index 59c1bc9..6ecc231 100644
--- a/README
+++ b/README
@@ -1,3 +1,2 @@
-<<<<<<< HEAD
 master
 conflict

commit ab6c52591506ac2e75745814527f062d767b4e11
Merge: 9a9dd03 42a166a
Author: Your Name <you@example.com>
Date:   Wed Jul 21 15:38:18 2021 +0000

    merge

/git-min # echo 'next' >> README
+ echo next

/git-min # com next
+ com next
+ set -x
+ git add README
+ git commit -m next
fatal: Unable to create '/git-min/.git/MERGE_RR.lock': File exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.

/git-min # git --version
+ git --version
git version 2.32.0.473.g1bb01aad6f

/git-min # git config --list
+ git config --list
user.email=3Dyou@example.com
user.name=3DYour Name
core.repositoryformatversion=3D0
core.filemode=3Dtrue
core.bare=3Dfalse
core.logallrefupdates=3Dtrue
core.pager=3Dcat
color.ui=3Dnever

####### END TERMINAL OUTPUT ########

[4] GDB Output

(gdb) run
Starting program: /usr/local/bin/git commit -m Fix\ the\ merge
warning: Error disabling address space randomization: Operation not permitt=
ed

Program received signal SIGSEGV, Segmentation fault.
0x000055dbdff61748 in do_rerere_one_path (update=3D0x7ffffce68720, rr_item=
=3D0x7f5ed8e20340,
    istate=3D0x55dbe00ef520 <the_index>) at rerere.c:736
736


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.32.0.473.g1bb01aad6f
cpu: x86_64
built from commit: 1bb01aad6fdafaac7a11bed18a67384f28ab735b
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.72-microsoft-standard-WSL2 #1 SMP Wed Oct 28 23:40:43 UTC =
2020 x86_64
compiler info: gnuc: 10.3
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>

[Enabled Hooks]
