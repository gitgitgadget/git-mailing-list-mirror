From: Ingo Molnar <mingo@elte.hu>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 16:56:22 +0200
Message-ID: <20080723145622.GA23440@elte.hu>
References: <20080723130518.GA17462@elte.hu> <20080723131736.GA9100@elte.hu> <20080723134926.GA12888@elte.hu> <76718490807230747w5d0350b8v6feba00fb8837617@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:57:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfmd-0002Xt-Gi
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbYGWO4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 10:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbYGWO4e
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:56:34 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:42769 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbYGWO4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:56:34 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KLflP-0000lN-Ej
	from <mingo@elte.hu>; Wed, 23 Jul 2008 16:56:31 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 5F7293E21B0; Wed, 23 Jul 2008 16:56:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <76718490807230747w5d0350b8v6feba00fb8837617@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0006]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89674>


* Jay Soffian <jaysoffian@gmail.com> wrote:

> > CACHE=$MERGECACHE/$HEAD_SHA1/$BRANCH_SHA1
> >
> > [ -f "$CACHE" -a "$CACHE" -nt .git/refs/heads/$BRANCH_SHA1 ] && {
> 
> Shouldn't this be:
> 
> [ -f "$CACHE" -a "$CACHE" -nt .git/refs/heads/$BRANCH ] && {
> 
> ?

yeah, i just figured it out too ... the hard way :)

Updated script below. This works fine across resets in the master 
branch.

While it's fast in the empty-merge case, it's not as fast as i'd like it 
to be in the almost-empty-merge case.

	Ingo

--------------{ git-fastmerge }-------------------->
#!/bin/bash

usage () {
  echo 'usage: tip-fastmerge <refspec>..'
  exit -1
}

[ $# = 0 ] && usage

BRANCH=$1

MERGECACHE=.git/mergecache

[ ! -d $MERGECACHE ] && { mkdir $MERGECACHE || usage; }

HEADREF=.git/$(cut -d' ' -f2 .git/HEAD)

HEAD_SHA1=$(git-log -1 --pretty=format:"%H")
BRANCH_SHA1=$(git-log -1 --pretty=format:"%H" $BRANCH)

CACHE=$MERGECACHE/$HEAD_SHA1/$BRANCH_SHA1

[ -f "$CACHE" -a "$CACHE" -nt "$HEADREF" ] && {
# echo "merge-cache hit on HEAD <= $1"
  exit 0
}

git-merge $1 && {
  mkdir -p $(dirname $CACHE)
  touch $CACHE
}
