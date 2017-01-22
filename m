Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B05A020A17
	for <e@80x24.org>; Sun, 22 Jan 2017 20:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbdAVUJz (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 15:09:55 -0500
Received: from st13p29im-asmtp003.me.com ([17.164.110.64]:42479 "EHLO
        st13p29im-asmtp003.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdAVUJx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 15:09:53 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jan 2017 15:09:53 EST
Received: from process-dkim-sign-daemon.st13p29im-asmtp003.me.com by
 st13p29im-asmtp003.me.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 id <0OK7007003KS1500@st13p29im-asmtp003.me.com> for git@vger.kernel.org; Sun,
 22 Jan 2017 19:09:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=4d515a;
 t=1485112192;  bh=5MSSY/roV5PzGGF96zSRT5kuJA8A4RwcDIWkwS4A/t0=;
        h=From:Content-type:MIME-version:Subject:Message-id:Date:To;
        b=lKuLXfMacKkc9derPtIa4exqdYc+6o7OD/ZtxEjcNXfJ3Wam/boQAzROBn0sg28tl
 T10jW3/fIcBSc2VKvHsNliSckgyRbS0o/QouikF/znlAFYB3Xal44ZHKVxDNkSOWOe
 5eYf5p3JDrkQO2hI1/Re4qcRbaRBAnpEBcFbXefE4XCiFkoDYoJHL4ybuH4+SHEx3y
 dbdOgarNcgnRlwLjNEjktxaU/PCJ9mhXuVD0Pispgiz1d1Ho6k3PUEyuZhgeB3paW8
 HncOeqMLi2Eku8w9fA6qkMU8HjzDIYfawwhQsgfbyb+fnwfoW49jUvuZ7xhxa+WtVi
 yUarKNsjN+eUg==
Received: from azdavis-mbp.wv.cc.cmu.edu
 (azdavis-mbp.wv.cc.cmu.edu [128.237.194.55]) by st13p29im-asmtp003.me.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 with ESMTPSA id <0OK700FAJ3WFLV30@st13p29im-asmtp003.me.com> for
 git@vger.kernel.org; Sun, 22 Jan 2017 19:09:52 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2017-01-22_11:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1034 suspectscore=13 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1603290000 definitions=main-1701220271
From:   Ariel Davis <ariel.z.davis@icloud.com>
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: quoted-printable
MIME-version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: interaction between git-diff-index and git-apply
Message-id: <C45218A3-8A81-4307-AADB-FBA4F51EAC51@icloud.com>
Date:   Sun, 22 Jan 2017 14:09:51 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3259)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have noticed an interesting interaction between git-diff-index and =
git-apply.
Essentially, it seems that if we start with a clean working tree, then
git-apply a patch, then git-apply the reverse of that patch, =
git-diff-index
still thinks files are modified. But then, if we git-status, =
git-diff-index
seems to "realize" the files are actually not modified.

Below are steps to reproduce, as well as information about my machine, =
which I
discovered this behavior on.

Reproduction instructions:

$ mkdir -p test/repo
$ cd test/repo
$ git init -q
$ echo 1 > file
$ git add file
$ git commit -qm 1
$ echo 2 >> file
$ git add file
$ git commit -qm 2
$ git diff @~ > ../patch
$ git apply --reverse ../patch
$ git diff-index --name-only @
file
$ git apply ../patch
$ git diff-index --name-only @
file
$ git status
On branch master
nothing to commit, working tree clean
$ git diff-index --name-only @
$ echo hmm
hmm

System information:

$ uname -a
Darwin azdavis-mbp 16.3.0 Darwin Kernel Version 16.3.0: Thu Nov 17 =
20:23:58 PST
2016; root:xnu-3789.31.2~1/RELEASE_X86_64 x86_64 i386 MacBookPro12,1 =
Darwin
$ sw_vers
ProductName:    Mac OS X
ProductVersion: 10.12.2
BuildVersion:   16C67
$ git --version
git version 2.11.0

Thank you for your time.

Ariel Davis

