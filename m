From: Thomas Koch <thomas@koch.ro>
Subject: elegant(?) debian topgit workflow?
Date: Wed, 16 Dec 2009 11:13:38 +0100
Message-ID: <200912161113.38396.thomas@koch.ro>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
 debian-devel@lists.debian.org
To: vcs-pkg-discuss@lists.alioth.debian.org
X-From: bounce-debian-devel=debian-devel=m.gmane.org@lists.debian.org Wed Dec 16 11:14:17 2009
Return-path: <bounce-debian-devel=debian-devel=m.gmane.org@lists.debian.org>
Envelope-to: debian-devel@m.gmane.org
Received: from liszt.debian.org ([82.195.75.100])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKqtX-0001j1-6n
	for debian-devel@m.gmane.org; Wed, 16 Dec 2009 11:14:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with QMQP
	id 5586F2D0D24; Wed, 16 Dec 2009 10:14:08 +0000 (UTC)
Old-Return-Path: <thomas@koch.ro>
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on liszt.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=FOURLA,LDO_WHITELIST,
	MURPHY_DRUGS_REL8,WWWRO autolearn=no version=3.2.5
X-Original-To: lists-debian-devel@liszt.debian.org
Delivered-To: lists-debian-devel@liszt.debian.org
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with ESMTP id C1A5613A6207
	for <lists-debian-devel@liszt.debian.org>; Wed, 16 Dec 2009 10:14:01 +0000 (UTC)
X-Virus-Scanned: at lists.debian.org with policy bank en-ht
X-Amavis-Spam-Status: No, score=-4.88 tagged_above=-10000 required=5.3
	tests=[BAYES_00=-2, FOURLA=0.1, LDO_WHITELIST=-5,
	MURPHY_DRUGS_REL8=0.02, WWWRO=2] autolearn=no
Received: from liszt.debian.org ([127.0.0.1])
	by localhost (lists.debian.org [127.0.0.1]) (amavisd-new, port 2525)
	with ESMTP id ib+wkcHoA9cv for <lists-debian-devel@liszt.debian.org>;
	Wed, 16 Dec 2009 10:13:54 +0000 (UTC)
X-policyd-weight: DYN_NJABL=SKIP(0) NOT_IN_SBL_XBL_SPAMHAUS=-1.5 NOT_IN_BL_NJABL=-1.5 DSBL_ORG=SKIP(0) CL_IP_EQ_FROM_MX=-3.1; rate: -6.1
Received: from koch.ro (koch.ro [88.198.2.104])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by liszt.debian.org (Postfix) with ESMTPS id 9502A13A6206
	for <debian-devel@lists.debian.org>; Wed, 16 Dec 2009 10:13:48 +0000 (UTC)
Received: from 84-72-85-88.dclient.hispeed.ch ([84.72.85.88] helo=jona.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1NKqmF-0003Fa-IO; Wed, 16 Dec 2009 11:06:39 +0100
User-Agent: KMail/1.12.4 (Linux/2.6.31-1-amd64; KDE/4.3.4; x86_64; ; )
X-Rc-Virus: 2007-09-13_01
X-Rc-Spam: 2008-11-04_01
Resent-Message-ID: <SqVTfNZ6kDG.A.v3F.wLLKLB@liszt>
Resent-From: debian-devel@lists.debian.org
X-Mailing-List: <debian-devel@lists.debian.org> archive/latest/257967
X-Loop: debian-devel@lists.debian.org
List-Id: <debian-devel.lists.debian.org>
List-Post: <mailto:debian-devel@lists.debian.org>
List-Help: <mailto:debian-devel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-devel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-devel-request@lists.debian.org?subject=unsubscribe>
Precedence: list
Resent-Sender: debian-devel-request@lists.debian.org
Resent-Date: Wed, 16 Dec 2009 10:14:08 +0000 (UTC)
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135326>

CC (FYI) to git and debian-devel. see http://vcs-pkg.org

Hi,

would you be so kind to review my workflow proposal?

branches
--------

upstream
debian/*, fixes/*, features/* - topgit branches based on upstream
patches - the hero
master - contains the debian/ dir and is the branch we build from

All topgit branches are integrated in the patches branch, which is afterwards 
merged into master. The magic is, that the integration is not a regular merge, 
but a handcrafted merge and commit with quilt and git plumbing.

workflow
--------

Every merge starts with reseting "patches" to the state of upstream:

#> git checkout upstream
(for the first time: git checkout -b patches, otherwise:)
#> git symbolic-ref HEAD refs/heads/patches

Now we're on branch patches with the working tree and index in the pristine 
state of upstream. We can now integrate the topgit branches:

#> tg export --quilt debian/patches \
 -b debian/use-debian-java-libraries,debian/disable-tests-that-break-on-buildd

#> quilt push -a
#> git add debian/
#> rm -rf .pc
#> git add -u

Now let's create the commit and specify, which topgit branches were manually 
merged:

#> TREE=$(git write-tree)

#> COMMIT=$(git commit-tree $TREE \
     -p debian/use-debian-java-libraries \
     -p debian/disable-tests-that-break-on-buildd)

#> git update-ref refs/heads/patches $COMMIT

Now I can happily merge patches into master.

advantages
----------

- The commits of all ever merged topgit branches are preserved, even after tg 
delete

- easy to understand, non cluttered history

- Easy to retire topgit branches

- Easy to work on old package versions(?): just make a branch from master at 
desired version, eventually also branch patches branch to work on old patches

- The quilt patches are used and therefore tested in the same way, as dpkg-
source uses them in version 3

- Integrates with git-buildpackage

- Doesn't need anything, that topgit hasn't ATM

Todo
----

discuss, test, script

Best regards,

Thomas Koch, http://www.koch.ro
