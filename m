From: Ingo Molnar <mingo@elte.hu>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 15:49:26 +0200
Message-ID: <20080723134926.GA12888@elte.hu>
References: <20080723130518.GA17462@elte.hu> <20080723131736.GA9100@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 15:50:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLejo-0007bA-Tz
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 15:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbYGWNtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 09:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbYGWNtl
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 09:49:41 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60718 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbYGWNtl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 09:49:41 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1KLeig-0004Pi-Sg
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Wed, 23 Jul 2008 15:49:39 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 2E04D3E21AB; Wed, 23 Jul 2008 15:49:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080723131736.GA9100@elte.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89653>


* Ingo Molnar <mingo@elte.hu> wrote:

> So i guess it's better to just create a separate 
> .git/refs/merge-cache/ hierarchy with timestamps of last merged 
> branches and their head sha1 ... but maybe i'm banging on open doors?

here's the git-fastmerge script i've whipped up in 10 minutes. It does 
the trick nicely for me:

first run:

  real    0m53.228s
  user    0m41.134s
  sys     0m11.405s

second run:

  real    0m2.751s
  user    0m1.280s
  sys     0m1.491s

or a 20x speedup. Yummie! :-)

It properly notices when i commit to a topic branch, and it maintains a 
proper matrix of <A> <- <B> merge timestamps. It even embedds the sha1's 
in the timestamp path so it should be quite complete. It should work 
fine across resets, re-merges, etc. too i think. It should work well 
with renamed branches as well i think. (although i dont do that all that 
often)

In fact even if i delete the whole .git/mergecache/ hierarchy and run a 
'cold' merge, it's much faster:

  real    0m32.129s
  user    0m24.456s
  sys     0m7.603s

Because many of the branches have the same sha1 so it's already 
half-optimized even on the first run.

Much of the remaining 2.7 seconds overhead comes from the git-log runs 
to retrieve the sha1s, so i guess it could all be made even faster.

Now this scheme assumes that there's a sane underlying filesystem that 
can take these long pathnames and which has good timestamps (which i 
have, so it's not a worry for me).

Hm?

	Ingo

-----------------{ git-fastmerge }--------------------->
#!/bin/bash

usage () {
  echo 'usage: git-fastmerge <refspec>..'
  exit -1
}

[ $# = 0 ] && usage

BRANCH=$1

MERGECACHE=.git/mergecache

[ ! -d $MERGECACHE ] && { mkdir $MERGECACHE || usage; }

HEAD_SHA1=$(git-log -1 --pretty=format:"%H")
BRANCH_SHA1=$(git-log -1 --pretty=format:"%H" $BRANCH)

CACHE=$MERGECACHE/$HEAD_SHA1/$BRANCH_SHA1

[ -f "$CACHE" -a "$CACHE" -nt .git/refs/heads/$BRANCH_SHA1 ] && {
  echo "merge-cache hit on HEAD <= $1"
  exit 0
}

git-merge $1 && {
  mkdir -p $(dirname $CACHE)
  touch $CACHE
}
