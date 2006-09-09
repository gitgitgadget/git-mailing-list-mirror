From: Jeff King <peff@peff.net>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 16:43:07 -0400
Message-ID: <20060909204307.GB16906@coredump.intra.peff.net>
References: <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com> <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org> <17666.4936.894588.825011@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org> <17666.13716.401727.601933@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org> <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com> <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org> <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com> <Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 22:43:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM9fs-0005N7-Jf
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 22:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWIIUnL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 16:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWIIUnL
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 16:43:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:29923 "HELO
	peff.net") by vger.kernel.org with SMTP id S964847AbWIIUnJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 16:43:09 -0400
Received: (qmail 14027 invoked from network); 9 Sep 2006 16:42:33 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Sep 2006 16:42:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat,  9 Sep 2006 16:43:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26764>

On Sat, Sep 09, 2006 at 01:05:42PM -0700, Linus Torvalds wrote:

> The example is
> 
> 		    A		<--- tip of branch
> 		   / \
> 		  B   E
>                 |   |
> 		  |   F
> 		  | /
> 		  C 
> 		  |
> 		  D
> 		...
> 
> where the lettering is in "date order" (ie "A" is more recent than "B" 
> etc). In this situation, we'd start following the branch A->B->C->D->.. 
> before we even start looking at E and F, because they all _look_ more 
> recent.

I'm just coming into this discussion in the middle and know very little
about the rev-list code, so please humor me and tell me why my
suggestion is completely irrelevant.

The problem you describe seems to come from doing a depth-first display
of each branch. Why not look at the tip of each "active" branch
simultaneously and pick the one with the most recent date? Something
like:
  void show_all(commit_array start)
  {
    commit_array active;

    copy_array(active, start);
    sort_array(active);
    while (active.size > 0) {
      show_commit(active.data[0]);
      push_back(active.data[0].parents);
      pop_front(active);
      sort_array(active);
    }
  }
Obviously you could use a specialized data structure to add nodes into
the right place instead of resorting constantly.

-Peff
