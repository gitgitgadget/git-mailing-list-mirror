From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/5] Extend pattern refspecs
Date: Fri, 6 Mar 2009 01:07:20 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903060038510.19665@iabervon.org>
References: <alpine.LNX.1.00.0903052346270.19665@iabervon.org> <76718490903052119y4d6a7e0ck24bfeb1c0964e413@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 07:09:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfTEy-0005H8-V8
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 07:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbZCFGHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 01:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbZCFGHY
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 01:07:24 -0500
Received: from iabervon.org ([66.92.72.58]:60275 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbZCFGHX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 01:07:23 -0500
Received: (qmail 23904 invoked by uid 1000); 6 Mar 2009 06:07:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Mar 2009 06:07:20 -0000
In-Reply-To: <76718490903052119y4d6a7e0ck24bfeb1c0964e413@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112390>

On Fri, 6 Mar 2009, Jay Soffian wrote:

> On Thu, Mar 5, 2009 at 11:56 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > This series only supports the narrowest case of having the * in the middle
> > of a side of a refspec: having it as a full path component on each side.
> >
> > Patches 1-3 centralize all of the parsing and matching rules to a pair of
> > functions; patch 4 makes the stored representation more convenient (and
> > serves as a distinguished bisection outcome for anything I missed that was
> > relying on the contents of struct refspec for patterns); and patch 5
> > extends the matching implementation and loosens the ref format
> > requirements to allow the * to be in the middle.
> >
> > An easy followup would relax the restrictions further without requiring
> > any particularly tricky further changes.
> 
> This series and js/remote-improvements (e5dcbfd) in pu may not get
> along completely. "git remote show" tries to show how the refspecs
> expand out. And actually, that should be fine since builtin-remote now
> uses the same code as fetch/push to expand the refs.
> 
> However, "git remote show -n" (-n means don't query the remote) makes
> use of a new function, get_push_ref_states_noquery(), which more or
> less tries to reverse the parsed refspec back into the original
> string. That function relies on the current (before your patch)
> refspec semantics and assumes if refspec.pattern is set, then the '*'
> is at the end. So it will need tweaking.

Actually, you should be able to just drop your "buf" and use spec->src and 
spec->dst, since it just stores the original strings. So that should be 
easy enough, although it might be good to go through a remote.c function 
just in case it becomes more complicated later. On the other hand, 
get_head_names() should probably get a patch like my 1/5 to have it use 
the remote.c parser, or should use a constant "head mirror" refspec like 
that tag_refspec already in remote.c

Do you have tests for "git remote show -n"? Merging my series (on top of 
origin/master) and e5dcbfd and adding a final '*' to the string in 
get_head_names() made everything pass for me, without doing anything about 
the extra *s, but the output is clearly not quite right.

I'm not seeing anything that makes assumptions about the matching 
semantics of pattern refspecs, just stuff about how the stored form 
relates to the config-file form.

	-Daniel
*This .sig left intentionally blank*
