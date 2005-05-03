From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: RFC: adding xdelta compression to git
Date: Tue, 3 May 2005 11:10:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031048440.13099@bigblue.dev.mdolabs.com>
References: <200505030657.38309.alonz@nolaviz.org>
 <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
 <Pine.LNX.4.58.0505022215110.21733@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.61.0505031151380.32767@cag.csail.mit.edu>
 <Pine.LNX.4.58.0505031031240.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "C. Scott Ananian" <cscott@cscott.net>,
	Alon Ziv <alonz@nolaviz.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 20:05:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT1lC-0003Pg-Vp
	for gcvg-git@gmane.org; Tue, 03 May 2005 20:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVECSKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 14:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVECSKx
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 14:10:53 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:57043 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261499AbVECSKi
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 14:10:38 -0400
X-AuthUser: davidel@xmailserver.org
Received: from bigblue.dev.mdolabs.com
	by xmailserver.org with [XMail 1.21 ESMTP Server]
	id <S17B8F9> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Tue, 3 May 2005 11:13:12 -0700
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505031031240.3594@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 3 May 2005, Linus Torvalds wrote:

> On Tue, 3 May 2005, C. Scott Ananian wrote:
> > 
> > Linus knows this.  His point is just to be sure you actually *code* that 
> > walk in fsck, and (hopefully) do so w/o complicating the fsck too much.
> 
> Indeed. It's also a performance issue.
> 
> If you do xdelta objects, and don't tell fsck about it, then fsck will 
> just check every object as a blob. Why is that bad?
> 
> Think about it: let's say that you have a series of xdelta objects, and a 
> fsck that is xdelta-unaware. It will unpack each object independently, 
> which means that it will keep on doing the same early xdelta work over and 
> over and over again. Instead of just applying them in order, and checking 
> the sha1 of the result at each point.
> 
> Now, You probably want to limit the length of the chains to some firly 
> small number anyway, so maybe that's not a big deal. Who knows. And I'm 
> actually still so anal that I don't think I'd use this for _my_ tree, just 
> because I'm a worry-wart (and I still think disk is incredibly cheap ;)

If you use a "full tip" metadata format with reverse deltas, you drop a 
"full" version "time to time" along the chain, and you keep a small index 
file, you have:

1) No matter how big it becomes the xdelta collection object, you are only 
   touching very limited regions of it (due the small index file, that can 
   be less than 20+8 bytes per entry in the xdelta blob)

2) Checkout happens w/out even doing xpatching (since the tip is full)

3) Checkins requires only one xdelta operation (since the tip is full), 
   and zero if it is the time to store a full version along the chain (I 
   use to drop one every 10-16 xdeltas, depending on the progressive size 
   of the delta operations)

4) Worst case performance in reconstructing histories are bound by the 
   longest xdelta chain (10-16)

In some way I tend to agree (strangely ;) with you about the disk-cheap 
mantra, but network bandwidth matter IMO. So, if you do not want (being a 
real worry-wart) to use xdelta leverage on the FS trees, you can have way 
smarter network protocols using xdelta plus the knowledge of the git 
history structure. The rsync algo uses xdelta, but the poor guy is not 
able to leverage from the knowledge of the history that only git knows. 
So, if Larry and Greg shares a common object A, Larry changes A and makes 
a new git object B, rsync will transfer the whole object B, because it 
does not have any idea of the git structure. Git though, has this 
knowledge, and it can say to the remote fetcher: Look, I have this new 
thing called B, that is basically your thing A plus this very small xdelta 
(B-A). And typical xdelta diffs are really small (1/7 to 1/10 of classical 
'diff -u' ones).




- Davide

