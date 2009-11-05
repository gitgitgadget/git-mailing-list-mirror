From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 09/13] Honour the refspec when updating refs after 
 import
Date: Thu, 5 Nov 2009 00:34:38 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911050016360.14365@iabervon.org>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>  <1257364098-1685-10-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041601170.14365@iabervon.org>  <fabb9a1e0911041321i1ccec898r53ddafb9405c6331@mail.gmail.com> 
 <alpine.LNX.2.00.0911041624401.14365@iabervon.org> <fabb9a1e0911041745x577f7e4rc678da4d7d559193@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 06:34:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5uzd-00080j-0u
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 06:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbZKEFee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 00:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbZKEFee
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 00:34:34 -0500
Received: from iabervon.org ([66.92.72.58]:60616 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbZKEFed (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 00:34:33 -0500
Received: (qmail 11175 invoked by uid 1000); 5 Nov 2009 05:34:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2009 05:34:38 -0000
In-Reply-To: <fabb9a1e0911041745x577f7e4rc678da4d7d559193@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132198>

On Thu, 5 Nov 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Wed, Nov 4, 2009 at 22:30, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > On Wed, 4 Nov 2009, Sverre Rabbelier wrote:
> >> On Wed, Nov 4, 2009 at 22:20, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >> > That's not true for "git pull <url> <branch>"; we do want the remote ref,
> >> > but it doesn't have a local peer.
> 
> No, I don't think that's right, when doing a fetch we want to store
> the refs somewhere, sure, but not under 'refs/heads/<branch>', perhaps
> 'refs/hg/fetch/<branch>', either way, the current code does not work.

I think you've still got things backwards. From the point of view of 
transport.c, refs/<vcs> is entirely opaque, and we never look at it. Those 
aren't local peers. They're a way for the helper to communicate to 
transport-helper.c. The user says: pull refs/heads/master of this hg 
repo. Transport.c tries to fetch refs/heads/master and get the sha1 to 
write into FETCH_HEAD or wherever. Transport-helper.c says "import 
refs/heads/master", and git-fast-import reads the resulting script and 
writes some ref that the helper tells it to write. Then transport-helper.c 
figures out where the ref was written, reads it, and updates the struct 
ref representing the remote info. Then builtin-fetch looks at the struct 
ref and writes it to the local repositories ref namespace or FETCH_HEAD.

> >> >I think going straight to the refspec
> >> > command is the right answer.
> >>
> >> Can you clarity what you mean with "the refspec command"?
> >
> > Whatever it is that lets the helper tell the transport code where in the
> > helper's private namespace to look for refs. I'd been thinking the helper
> > would advertize the "refspec" capability, and the transport code would
> > call the "refspec" command in order to get the helper to report that; but
> > then I actually only said that the helper reports refspec, and not
> > proposed a name for the command.
> 
> Currently I'm implementing so that it would work like this for the svn helper:
> 
> $ echo capabilities | git remote-svn origin /path/to/hg/repo
> import
> refspec +refs/trunk:refs/svn/origin/trunk
> refspec +refs/branches/*:refs/svn/origin/*
> 
> That way we can put the refspec in the config file at clone time.
> 
> Now I've been browsing through the builtin-fetch code, and it looks
> like the main problem is going to be to apply this refspec at all.
> I'll have a more extensive look tomorrow.

This is entirely not what I think we should have. The config file should 
say refs/heads/*:refs/remotes/origin/* like it always does, because the 
transport will list the refs like refs/heads/* and refs/tags/* and return 
them like that.

I'll see if I can write up an untested patch that does what I'm thinking 
of.

	-Daniel
*This .sig left intentionally blank*
