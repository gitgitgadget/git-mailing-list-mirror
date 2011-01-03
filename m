From: "Zivkov, Sasa" <sasa.zivkov@sap.com>
Subject: Stashing subset of changed file plus a new file
Date: Mon, 3 Jan 2011 15:05:02 +0100
Message-ID: <B221C4384AE5104EB414A877DFD0372C0BD779C260@DEWDFECCR04.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 03 15:14:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZlAy-0003Et-Lj
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 15:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab1ACOOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 09:14:15 -0500
Received: from smtpgw01.sap-ag.de ([155.56.66.96]:14822 "EHLO smtpgw.sap-ag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754400Ab1ACOOO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jan 2011 09:14:14 -0500
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jan 2011 09:14:14 EST
Thread-Topic: Stashing subset of changed file plus a new file
Thread-Index: AcurTzbIeLSmBZxEQ3CGsreO49Sqmg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164449>

Let's suppose I changed a file e.txt and introduced two changes to it: C1 and
C2. Additionally, I have a new file n.txt in my working tree. My goal is to
stash the change C1 plus the complete file n.txt while keeping the change C2 in
the working tree.

For Git experts who don't want to read the complete post: what is the best
(most intuitive) way to achieve that?


I don't know if I somehow missed a trivial and obvious solution but here is
what I went through:

1) First, I tried:
        > git stash --patch
and answered 'y' for C1 and 'n' for C2. For the e.txt this worked as expected
but git stash didn't ask me about the (changes of the) file n.txt. n.txt
remained in the working tree.  OK, reading through this list I found out that
git stash never looks at the non-tracked files.

2) Second trial:
        > git add n.txt
        > git stash --patch
and again answered the same for C1 and C2 as in 1). However, this again didn't
ask me about the n.txt and n.txt remained in the working tree.

3) Thinking how to make git stash --patch not ignore the n.txt. Obviously, it
looks only at the hunks produced by the diff between the working tree and the
index... let me add the n.txt to the index but not its content (thus producing
the desired diff):
        > git add -N n.txt
        > git stash --patch
        n.txt: not added yet
        fatal: git-write-tree: error building trees
        Cannot save the current index state

4) Similar like 3) trying to make diff between the index and working tree for
n.txt:
        > git add n.txt
        > rm n.txt
        > git stash --patch
this went through but again didn't ask me for n.txt and n.txt wasn't part of
the stash commit:
        > git stash show
        ... no n.txt ...


5) Giving up git stash --patch, using git add --patch:
        > git add --patch
        ... skipped C1, added C2 ...
        > git add n.txt
        > git stash --keep-index
finally, produced the stash that includes the creation of the n.txt! However,
the n.txt is still in both the working tree and the index and it has to be
removed:
        > git rm -f n.txt
using the -f option in order to remove it both from the index and the working
tree.

The 5) is a solution but it has its drawbacks:
- one has to remove the new files after git stash
- when using git add --patch one has to select hunks that have to stay in the
  working tree which is exactly opposite as when using git stash --patch where
  one has to select the hunks to be stashed.
- unintuitive:
        new files are added to the index in order to be stashed
        hunks of diff of an existing file are added to the index in order to stay
        in the working tree

Questions:
Is there any solution better than 5) ?
Is git stash --patch at all able to stash new files?


Sasa Zivkov
