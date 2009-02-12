From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] builtin-remote: move duplicated cleanup code its
 own  function
Date: Thu, 12 Feb 2009 15:13:31 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902121458450.19665@iabervon.org>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com>  <1234332083-45147-2-git-send-email-jaysoffian@gmail.com>  <20090212001836.GB30231@coredump.intra.peff.net> <76718490902111744p27e83238x34cb7004d8e3e48f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:15:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXhxi-0006BF-2Z
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 21:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756980AbZBLUNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 15:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756610AbZBLUNd
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 15:13:33 -0500
Received: from iabervon.org ([66.92.72.58]:45808 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbZBLUNd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 15:13:33 -0500
Received: (qmail 26638 invoked by uid 1000); 12 Feb 2009 20:13:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Feb 2009 20:13:31 -0000
In-Reply-To: <76718490902111744p27e83238x34cb7004d8e3e48f@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109638>

On Wed, 11 Feb 2009, Jay Soffian wrote:

> On Wed, Feb 11, 2009 at 7:18 PM, Jeff King <peff@peff.net> wrote:
> > On Wed, Feb 11, 2009 at 01:01:21AM -0500, Jay Soffian wrote:
> >
> >> +static void free_remote_ref_states(struct ref_states *states)
> >> +{
> >> +     /* NEEDSWORK: free remote */
> >> +     string_list_clear(&states->new, 0);
> >> +     string_list_clear(&states->stale, 0);
> >> +     string_list_clear(&states->tracked, 0);
> >> +}
> >
> > Hmm. I don't know anything about this code, so maybe it is not trivial.
> > But anytime you are touching an area that NEEDSWORK, I think it is worth
> > looking at whether you can fix that problem (since you have already
> > spent a few brain cycles understanding what is going on in general).
> 
> I spent about 5 minutes which was enough time for me to realize that
> the reason the previous author left it as "NEEDSWORK" is because
> fixing it is more than 5 minutes of work. This is the remote object --
> maybe you could offer me some clues that allow me to know which of its
> fields need to be freed individually:
> 
> struct remote {
> 	const char *name;
> 	int origin;
> 
> 	const char **url;
> 	int url_nr;
> 	int url_alloc;
> 
> 	const char **push_refspec;
> 	struct refspec *push;
> 	int push_refspec_nr;
> 	int push_refspec_alloc;
> 
> 	const char **fetch_refspec;
> 	struct refspec *fetch;
> 	int fetch_refspec_nr;
> 	int fetch_refspec_alloc;
> 
> 	/*
> 	 * -1 to never fetch tags
> 	 * 0 to auto-follow tags on heuristic (default)
> 	 * 1 to always auto-follow tags
> 	 * 2 to always fetch tags
> 	 */
> 	int fetch_tags;
> 	int skip_default_update;
> 	int mirror;
> 
> 	const char *receivepack;
> 	const char *uploadpack;
> 
> 	/*
> 	 * for curl remotes only
> 	 */
> 	char *http_proxy;
> };
> 
> I *think* const is a clue that the field need not be freed, because
> the pointer is to storage that is on the stack. But I wasn't sure, esp
> with the double pointers. And I really wasn't sure about the struct
> pointers.

Actually, the comment is wrong; "remote" comes from remote_get(), which 
returns things from a cache in remote.c; there could be a remote_put() to 
let the code know that the caller is done with the object, but it wouldn't 
presently do anything.

(The code actually reads the config files once, generating info for all of 
the configured remotes, and just returns them, except that it will 
generate a new object for unconfigured, individually requested URLs)

	-Daniel
*This .sig left intentionally blank*
