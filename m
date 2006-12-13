X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: More merge-recursive woes
Date: Wed, 13 Dec 2006 02:36:39 -0500
Message-ID: <20061213073639.GA9289@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 12:08:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34214>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuSuc-0001QC-0O for gcvg-git@gmane.org; Wed, 13 Dec
 2006 13:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964864AbWLMMIX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 07:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWLMMIX
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 07:08:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33866 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964896AbWLMMIV (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 07:08:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuOfR-00044C-5X for git@vger.kernel.org; Wed, 13 Dec 2006 02:36:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 E90D420FB6E; Wed, 13 Dec 2006 02:36:39 -0500 (EST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Today I found two new bugs in git-merge-recursive.  I'm still
researching them, but I at least have a test case for one of the
two:

Bug #1: If one branch renames a file which existed in the merge base,
when we merge that change into a different branch the old version
of the file is not deleted from the working directory.  The attached
test script shows this ("BAD: A still exists in working directory").

Bug #2: In that horrible repository that I have where I ran into the
empty tree missing bug I now have a pair of commits which when merged
together cause git-merge-recursive to go into an infinite loop,
or least burn CPU for hours on end without doing squat.  I have
not been able to get enough data to even write a good analysis
of it yet.  I'll try to do that this week, as I cannot share the
repository itself.  It just happens to be two new commits along
the same two branches however.  :-(

Both bugs are appearing with current 'next' (8662d0ea).

After I eat something and weed through my inbox I may take a stab
at the first one, if I haven't passed out on the couch.  :-)


->->->->->->--t6024-merge-rename2.sh-->->->->->->->->-
#!/bin/sh

test_description='Merge-recursive merging renames'
. ./test-lib.sh

test_expect_success setup \
'
cat >A <<\EOF &&
a aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
b bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
c cccccccccccccccccccccccccccccccccccccccccccccccc
d dddddddddddddddddddddddddddddddddddddddddddddddd
e eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
f ffffffffffffffffffffffffffffffffffffffffffffffff
g gggggggggggggggggggggggggggggggggggggggggggggggg
h hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
i iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
j jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj
k kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
l llllllllllllllllllllllllllllllllllllllllllllllll
m mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
n nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
o oooooooooooooooooooooooooooooooooooooooooooooooo
EOF

cat >M <<\EOF &&
A AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
B BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
D DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
E EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
F FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
G GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
H HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
I IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
J JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
K KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
L LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
M MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
N NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
O OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
EOF

git add A M &&
git commit -m "initial has A and M" &&
git branch white &&
git branch red &&

git checkout white &&
sed -e "/^g /s/.*/g : white changes a line/" <A >B &&
sed -e "/^G /s/.*/G : colored branch changes a line/" <M >N &&
rm -f A M &&
git update-index --add --remove A B M N &&
git commit -m "white renames A->B, M->N" &&

git checkout red &&
echo created by red >R &&
git update-index --add R &&
git commit -m "red creates R" &&

git checkout master'

test_expect_success 'merge white into red' \
'
	git checkout -b red-white red &&
	git merge white &&
	git write-tree >/dev/null || {
		echo "BAD: merge did not complete"
		return 1
	}

	test -f B || {
		echo "BAD: B does not exist in working directory"
		return 1
	}
	test -f N || {
		echo "BAD: N does not exist in working directory"
		return 1
	}
	test -f R || {
		echo "BAD: R does not exist in working directory"
		return 1
	}

	test -f A && {
		echo "BAD: A still exists in working directory"
		return 1
	}
	test -f M && {
		echo "BAD: M still exists in working directory"
		return 1
	}
'

