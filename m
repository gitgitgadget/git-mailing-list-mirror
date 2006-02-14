From: Ben Clifford <benc@hawaga.org.uk>
Subject: maildir / read-tree trivial merging getting in the way?
Date: Tue, 14 Feb 2006 02:18:19 +0000 (GMT)
Message-ID: <Pine.LNX.4.60.0602140217380.19093@mundungus.clifford.ac>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Tue Feb 14 03:19:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8pmY-0007jk-SY
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 03:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWBNCTG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 21:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWBNCTG
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 21:19:06 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:12811 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1750927AbWBNCTF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 21:19:05 -0500
Received: from mundungus.clifford.ac (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id k1E2IPCd001717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Feb 2006 02:18:28 GMT
Received: from localhost (benc@localhost)
	by mundungus.clifford.ac (8.13.3/8.13.3/Submit) with ESMTP id k1E2ILeq001714;
	Tue, 14 Feb 2006 02:18:24 GMT
X-Authentication-Warning: mundungus.clifford.ac: benc owned process doing -bs
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16101>


I've spent a few hours playing round with maildir-aware merging.

The basic idea I'm trying to implement is to flip the index round so that 
instead of looking at how the content has changed for a particular filename, 
I'm looking at how the filenames have changed for a particular content.

So I'm using git read-tree -m to populate the index with entries for the 
branches to merge so that I can then diddle round with those.

But the read-tree trivial merge logic seems to be getting in the way a bit.

In my test repo, I have two branches ('master' and 'red') forked from the base 
point 'base':

in 'base':

$ ls
A    fish one

in 'red':

$ ls
B         billygoat one

in 'master'

$ ls
A    lion two

> From base, I renamed and cg add / cg rm'd to change A to B, one to two, 
and fish to billygoat and lion to give the above.

When I read in the tree I get automatic resolving (down to stage 0) for the 
added files. But actually in the output of my merge, I'm not always going to 
want that to happen: In the A->B case, I do want to keep B (and need to remove 
A), likewise in the one->two case.

But for fish->{billygoat,lion}, I only want one file to end up at stage 0, and 
it might not be called either billygoat or lion - in maildir, the filenames are 
more structured, and given a filename like
foo:2,SR and foo:2,SF I would want to compose the filenames to give me 
foo:2,SRF.


$ git read-tree -m base master red

$ git ls-files  --stage
100644 40e0a6f540b1b457c61315f3ccf2f5ed628e2f36 1       A
100644 40e0a6f540b1b457c61315f3ccf2f5ed628e2f36 2       A
100644 40e0a6f540b1b457c61315f3ccf2f5ed628e2f36 0       B
100644 a8150e61a3a4c9941d29169ee639396547f40de2 0       billygoat
100644 a8150e61a3a4c9941d29169ee639396547f40de2 1       fish
100644 a8150e61a3a4c9941d29169ee639396547f40de2 0       lion
100644 b67e17aeb5938def7ee105c2afe9fbb30a28a872 1       one
100644 b67e17aeb5938def7ee105c2afe9fbb30a28a872 3       one
100644 b67e17aeb5938def7ee105c2afe9fbb30a28a872 0       two

Now, I think maybe I can just look at what has made it to stage 0 and play 
round with those, but it makes me feel a little dirty - if anything, the index 
indicates that a bunch of stuff has been correctly merged (by being at stage 0) 
when in fact it hasn't.

So basically my question is: should I feel dirty about doing this and diddle 
read-tree so that there's a flag to not do the trivial merges automatically?

-- 
