From: "Brown, Len" <len.brown@intel.com>
Subject: RE: new file leaked onto release branch
Date: Wed, 14 Dec 2005 04:41:32 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300567ED87@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 10:47:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmT8u-00019c-Eq
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 10:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVLNJlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 04:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVLNJlq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 04:41:46 -0500
Received: from fmr13.intel.com ([192.55.52.67]:9865 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932231AbVLNJlp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 04:41:45 -0500
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr001.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id jBE9fZnB028913;
	Wed, 14 Dec 2005 09:41:35 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id jBE9fZBV025517;
	Wed, 14 Dec 2005 09:41:35 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005121401413511569
 ; Wed, 14 Dec 2005 01:41:35 -0800
Received: from fmsmsx311.amr.corp.intel.com ([132.233.42.214]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 01:41:34 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx311.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 01:41:34 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: new file leaked onto release branch
Thread-Index: AcYAiZa04iaqTPOpTT+Xd9miLY4vXwABjPRw
To: "Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 14 Dec 2005 09:41:34.0669 (UTC) FILETIME=[9251AFD0:01C60092]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13625>

>> I package up a tar-file for the remote machines with
>> git-tar-tree $BRANCH $REPO | gzip -1 > $TARFILE
>> But I still need to generate a patch containing all the local
>> changes that I haven't checked into git yet.
>
>Let me understand what you have correctly:
>
>    You have the latest commit, changes needed to be tested in
>    working tree, and index is somewhere in-between, because of
>    "git-update-index --add" you did for patch generation; but
>    ideally you would want to keep HEAD and index in sync.

Right, I updated the index so that git diff would work.

I guess I don't really have my head around the index concept.
Yes, it seems perhaps that HEAD and index disagreeing about what is
in the repo is what caused the problem at hand.

>And you need a way to do the above tar-tree + patch equivanent
>to move what you have in your working tree to other machines for
>pre-commit testing.  Some random thoughts on ways to do it.
>
>(1) NFS with "make O=dir/to/store/output/files/"?

I think I prefer the build boxes to be more independent.

They build about a dozen kernels from scratch each,
so I can't really keep my working repo frozen for
the duration of the builds.

Also, sometimes I have them building different branches
and different versions, depending on what is going on.

Also, sometimes I apply a local test patch to the
build box that isn't (yet) shared with the other boxes.
 
>(2) Do you have git on other build boxes?  Perhaps
>
>    mainbox$ edit on "acpica" branch
>    mainbox$ git checkout -b build-test ;# branch from it
>    mainbox$ git add some files
>    mainbox$ git commit -a -m "Build test $(date)" ;# take all
>
>    mainbox$ ssh i386box
>    i386box$ git pull mainbox:/home/lnx/.git build-test
>    Fast forward.
>    i386box$ make ;# happy
>
>    mainbox$ git checkout acpica ; git pull . build-test ;# 
>fast forward

sure, I have git everwhere.  But check-in is not a lightweight
process for me -- I like to get the contributor & comments right
on the check-in as if I'm creating permanent history.  I hate
checking in a patch just to have to check in a build fix for
it 20 minutes later.

this is why I use quilt.  I just pop the patches, fix the
broken one, and push them back.  after build and boot tests,
that is when I do the git commit.

>(3) Tarball approach, but taking the local modifications along
>    as well:
>
>    mainbox$ git update-index all-changed-paths-not-just-add
>    mainbox$ git-tar-tree $(git-write-tree) $REPO | gzip >$TARFILE
>    mainbox$ git reset ;# unregisters all mods since HEAD from index
>    mainbox$ scp $TARFILE i386box:/home/lnx/
>
>I suspect the last one is the least disruptive to your existing
>workflow.

yes, this is along the lines of what I do now.
do these steps capture the changed uncommited source files in
my repo?

actually, since the mis-hap with the update-index, what I do now
is a make clean mrproper, move the .git directory out of the source tree
tar what is left, and then restore the .git directory...
this has the nice side effect of taking along the quilt patches directory,
and sometimes I've found it useful to do individual build/test
between patches in the quilt stack, though I'd probably lose track
of what I'm doing if I did that all the time.

thanks,
-Len
