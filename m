From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix branches file configuration
Date: Wed, 26 Mar 2008 02:51:28 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803260240570.19665@iabervon.org>
References: <alpine.LNX.1.00.0803251931500.19665@iabervon.org> <7v3aqel5ms.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 07:52:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JePUc-0007IR-7a
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 07:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbYCZGvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 02:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbYCZGva
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 02:51:30 -0400
Received: from iabervon.org ([66.92.72.58]:38823 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbYCZGva (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 02:51:30 -0400
Received: (qmail 16235 invoked by uid 1000); 26 Mar 2008 06:51:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Mar 2008 06:51:28 -0000
In-Reply-To: <7v3aqel5ms.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78268>

On Tue, 25 Mar 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > It turns out that .git/branches/foo should fetch into refs/heads/foo.
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> > We still don't have a test for that bit of the behavior, so I could have 
> > it still doing the wrong thing. But it at least should do what I think 
> > people want.
> >
> > Andrew, could you give this a try, on top of current master (or, for that 
> > matter, any released version that doesn't work), and let me know if it 
> > does the wrong thing?
> 
> To give bystanders a bit of context, Andrew had an old Cogito-style
> 
> 	.git/branches/foo
> 
> that had a URL (and no #frag) in it.  "git fetch foo" should have fetched
> from the 'master' branch of the named repository and stored it in his
> refs/heads/foo, and git up to 1.5.3.X series do so correctly, but we had
> this uncaught regression in 1.5.4 (the support for "branches" file is not
> deprecated, even though I personally do not see a reason to use it in new
> repositories).
> 
> Now, Daniel, I was independently fixing this one and had a question about
> this code.
> 
> What is the deal with this "slash" magic?  It appears that when you are
> fed:
> 
> 	git fetch foo/bar
> 
> you look up ".git/branches/foo" for $URL and #$branch, then use "$URL/bar"
> as the URL and $branch (or 'master' if you did not see '#') as the branch
> to fetch from, and store it in "foo/bar" locally.  Is that really what
> should have happened?  I am reasonably sure about "fetching from $URL/bar"
> part, but I am unsure about "store in foo/bar" part.
> 
> Any Cogito survivers out there who knows how this was supposed to have
> worked?  We can go back and look at git-fetch.sh (in contrib/examples),
> but I'd rather be lazy ;-)

This code actually is from Linus, nearly 2 years ago, converting 
git-push.sh; I then moved it from builtin-push.c to remote.c and later 
added support to remote.c for the fetch side aspects while leaving that 
part of the code alone. Of course, I didn't realize at any point that, as 
a fetch configuration, a branches configuration ever stored things 
anywhere, and it looks like it didn't with a slash. (See line 115 of 
755225de:git-parse-remote.sh)

So I guess there should be:

> >  	add_url_alias(remote, p);
> > -	add_fetch_refspec(remote, branch);
        if (!slash)
> > +	strbuf_addf(&branch, ":refs/heads/%s", remote->name);
> > +	add_fetch_refspec(remote, strbuf_detach(&branch, 0));
> >  	remote->fetch_tags = 1; /* always auto-follow */
> >  }

	-Daniel
*This .sig left intentionally blank*
