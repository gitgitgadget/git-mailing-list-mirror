From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [script] ge: export commits as patches
Date: Tue, 19 Apr 2005 20:56:07 +0200
Message-ID: <20050419185607.GA26756@elte.hu>
References: <20050419134843.GA19146@elte.hu> <20050419170320.GG12757@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 20:53:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNxps-0000kD-Bk
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 20:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVDSS4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 14:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVDSS4n
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 14:56:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16082 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261573AbVDSS4k (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 14:56:40 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id BA44231FF47;
	Tue, 19 Apr 2005 20:55:28 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 3AA441FC2; Tue, 19 Apr 2005 20:56:11 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050419170320.GG12757@pasky.ji.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Petr Baudis <pasky@ucw.cz> wrote:

> Dear diary, on Tue, Apr 19, 2005 at 03:48:43PM CEST, I got a letter
> where Ingo Molnar <mingo@elte.hu> told me that...
> > is there any 'export commit as patch' support in git-pasky? I didnt find 
> > any such command (maybe it got added meanwhile), so i'm using the 'ge' 
> > hack below.
> > 
> > e.g. i typically look at commits via 'git log', and then when i see 
> > something interesting, i look at the commit via the 'ge' script. E.g.  
> > "ge 834f6209b22af2941a8640f1e32b0f123c833061" done in the kernel tree 
> > will output a particular commit's header and the patch.
> 
> Nice idea. I will add it, probably as 'git patch'.
> 
> > TREE1=$(cat-file commit 2>/dev/null $1 | head -4 | grep ^tree | cut -d' ' -f2)
> > if [ "$TREE1" = "" ]; then echo 'ge <commit-ID>'; exit -1; fi
> > PARENT=$(cat-file commit 2>/dev/null $1 | head -4 | grep ^parent | cut -d' ' -f2)
> > if [ "$PARENT" = "" ]; then echo 'ge <commit-ID>'; exit -1; fi
> > TREE2=$(cat-file commit 2>/dev/null $PARENT | head -4 | grep ^tree | cut -d' ' -f2)
> > if [ "$TREE2" = "" ]; then echo 'ge <commit-ID>'; exit -1; fi
> 
> commit-id and parent-id tools might be useful. ;-)

find a cleaned up 'ge' script below.

and please fix gitXnormid.sh to simply echo nothing and return with a -1 
exit value when a nonsensical ID is passed to it. Right now the output 
is quite ugly if you do 'ge blah'.

	Ingo

#!/bin/bash

usage ()
{
 echo 'usage: ge <commit-ID>'
 exit -1
}

if [ $# != 1 ]; then
 usage
fi

ME=    $(commit-id $1);      [ "$ME"     = "" ] && usage
PARENT=$(parent-id $ME);     [ "$PARENT" = "" ] && usage
TREE1= $(tree-id   $ME);     [ "$TREE1"  = "" ] && usage
TREE2= $(tree-id   $PARENT); [ "$TREE2"  = "" ] && usage

cat-file commit $ME
echo
git diff -r $TREE2:$TREE1

