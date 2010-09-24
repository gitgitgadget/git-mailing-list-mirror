From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Find out on which branch a commit was originally made) (was ANNOUNCE git-what-branch)
Date: Fri, 24 Sep 2010 16:57:19 -0400
Message-ID: <201009242057.o8OKvJRE024995@no.baka.org>
References: <201009222326.o8MNQJ2E022410@no.baka.org> <32741263.335615.1285247653984.JavaMail.root@mail.hq.genarts.com> <AANLkTinw2bWWYD7UcS8P=uDJm8p3TGuWA133+BsnZPGH@mail.gmail.com>
        <4C9BC757.3050803@gmail.com>
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 22:57:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzFKn-0003CF-D0
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 22:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141Ab0IXU52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 16:57:28 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:42261 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711Ab0IXU51 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 16:57:27 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id o8OKvJhG029554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 24 Sep 2010 16:57:19 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id o8OKvJRE024995;
	Fri, 24 Sep 2010 16:57:19 -0400
In-reply-to: <4C9BC757.3050803@gmail.com>
Comments: In reply to a message from "Artur Skawina <art.08.09@gmail.com>" dated "Thu, 23 Sep 2010 23:32:07 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157059>


In message <4C9BC757.3050803@gmail.com>, Artur Skawina writes:

    $ time git-show-merge-path 86ab04c8c1df51df master release
    b1bc81a0ef86 M: 'master'@$KO/linville/wireless-next-2.6        090607 11:24
    36432dae73cf M: 'master'@$KO/davem/net-next-2.6                090611 14:00
    2ed0e21b30b5 M: $KO/davem/net-next-2.6                         090615 16:40
    # Merged into release and master
    0m3.056s user   0m0.207s system   0m3.154s elapsed   103.46% CPU

    Script below; w/ one or two args works like the previous
    git-find-branch-for, except it's ~two times faster for expensive
    queries and does that silly five old branch request in <13s, for
    *all* 150 heads

Thanks to your suggestion about using git rev-list with more than two
references I was able to massively increase the performance of my
script, from 26 minutes to 26 seconds, for the linux kernel search
test.

I have updated http://github.com/SethRobertson/git-what-branch to
release v0.2.1 with the performance boost and some display enhancements.

--------------------------------------------------
time git-what-branch --reference master 86ab04c8c1df51df
86ab04c8c1df51df used the following minimal temporal path:
  merged to v2.6.30-rc6-1103-gb1bc81a @Sun Jun  7 07:24:21 2009
  merged to v2.6.30-5398-g2ed0e21     @Mon Jun 15 12:40:05 2009
  v2.6.30-5398-g2ed0e21 is on master
5.97user 0.45system 0:06.08elapsed
--------------------------------------------------

    Still no ff-detection, mostly due to lack of (real) test case.

Here are some fake test cases.  The question is which branch do tags
masterE and newbrBB appear on.

# Demonstrates picking wrong branch for "master"
MERGE="git merge"
mkdir foo; cd foo; git init; echo A > A; git add A; git commit -a -m "initial"
echo B >> A; git commit -a -m "B"; echo C >> A; git commit -a -m "C"
git branch newbr; echo AB > B; git add B; git commit -a -m "newbr"
git checkout master; echo D >> A; git commit -a -m "D"; git tag masterD;
git checkout newbr; $MERGE master; echo BB >> B; git commit -a -m "BB"; git tag newbrBB
git checkout master; echo E >> A; git commit -a -m "E"; git tag masterE;
git checkout newbr; $MERGE master; echo CB >> B; git commit -a -m "CB"
git checkout master; echo F >> A; git commit -a -m "F"
git checkout newbr; $MERGE master; echo DB >> B; git commit -a -m "DB"
git checkout master; $MERGE newbr; echo G >> A; git commit -a -m "G"
echo H >> A; git commit -a -m "H"; echo J >> A; git commit -a -m "J"; git tag masterJ
git checkout newbr; $MERGE master; echo eB >> B; git commit -a -m "EB"; git tag newbrEB
git checkout master; echo K >> A; git commit -a -m "K"; $MERGE newbr
unset MERGE

# Demonstrates picking the wrong branch for "newbr"
MERGE="git merge"
mkdir foo; cd foo; git init; echo A > A; git add A; git commit -a -m "initial"
echo B >> A; git commit -a -m "B"; echo C >> A; git commit -a -m "C"
git branch newbr; echo AB > B; git add B; git commit -a -m "newbr"
git checkout master; echo D >> A; git commit -a -m "D"; git tag masterD;
git checkout newbr; $MERGE master; echo BB >> B; git commit -a -m "BB"; git tag newbrBB
git checkout master; echo E >> A; git commit -a -m "E"; git tag masterE;
git checkout newbr; $MERGE master; echo CB >> B; git commit -a -m "CB"
git checkout master; echo F >> A; git commit -a -m "F"
git checkout newbr; echo DB >> B; git commit -a -m "DB"
git checkout master; $MERGE newbr; echo G >> A; git commit -a -m "G"
echo H >> A; git commit -a -m "H"; echo J >> A; git commit -a -m "J"; git tag masterJ
git checkout newbr; $MERGE master; echo eB >> B; git commit -a -m "EB"; git tag newbrEB
git checkout master; echo K >> A; git commit -a -m "K"; $MERGE newbr
unset MERGE


					-Seth Robertson
