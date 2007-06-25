From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: DWIM ref names for push/fetch
Date: Mon, 25 Jun 2007 12:27:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706251216210.4740@iabervon.org>
References: <Pine.LNX.4.64.0706241808550.4740@iabervon.org>
 <7v3b0gq4id.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0706242234250.4740@iabervon.org>
 <7vodj4o973.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 18:27:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2rP9-0004gC-D1
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 18:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbXFYQ1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 12:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbXFYQ1F
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 12:27:05 -0400
Received: from iabervon.org ([66.92.72.58]:4884 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbXFYQ1E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 12:27:04 -0400
Received: (qmail 22630 invoked by uid 1000); 25 Jun 2007 16:27:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jun 2007 16:27:02 -0000
In-Reply-To: <7vodj4o973.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50907>

On Sun, 24 Jun 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I was actually thinking exclusively of the matching of strings like "HEAD" 
> > or "origin/next" or "master" to refs from the list of available refs. It 
> > seems to me like the push code does a better job of handling the same 
> > sorts of things that get_sha1() handles.
> >
> > In particular, the handling of "refs/my/funny/thing" is really wrong: it 
> > gets treated as refs/heads/refs/my/funny/thing.
> 
> git-parse-remote.sh::canon_refs_list_for_fetch() seems to say
> otherwise, though.
> 
>  - When unspecified, or explicitly spelled HEAD, take HEAD;
>  - Anything that begins with refs/, use it as is;
>  - Anything that begins with heads/, tags/, remotes/, assume
>    it is a branch, a tag, or a tracking branch;
>  - Otherwise assume a branch;
> 
> So I suspect refs/my/funny/thing is covered by the second rule.

Ah, okay. I think a few bits got lost somewhat in Julian's translation to 
C. I agree with the first three rules there, and with the last rule being 
the last rule, and sticking more things in between those sets is easy 
enough.

> But I do agree "otherwise assume a branch" part has huge room
> for improvement.  Especially...
> 
> > I think that "origin/next" 
> > should also be assumed to be refs/remotes/origin/next instead of 
> > refs/heads/origin/next, at least if you have refs/remotes/origin/ and not 
> > refs/heads/origin/.
> 
> ... I think that makes perfect sense -- the code should
> interpret your example as a request to start using a new
> tracking branch refs/remotes/origin/next.

Currently, it doesn't even notice if you've got the tracking branch 
already. Should it have some rule to prefer things that exist over things 
that don't?

When refs/remotes/origin/next doesn't exist, should it require that 
refs/remotes/origin/ already exist?

In any case, the big question is whether the push code should use these 
rules, too, for the corresponding portions, in which case I can share the 
code (and, for that matter, the documentation, which would be even nicer, 
because we've currently got a lot of hints about refspecs in different 
places but nothing complete anywhere).

	-Daniel
*This .sig left intentionally blank*
