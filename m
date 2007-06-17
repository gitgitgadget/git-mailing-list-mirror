From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: config-glob-octopus
Date: Sat, 16 Jun 2007 23:28:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706162321060.4740@iabervon.org>
References: <Pine.LNX.4.64.0706162039530.4740@iabervon.org>
 <7vtzt71hks.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 05:29:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzlSB-0004OH-7G
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 05:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758809AbXFQD2v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 23:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758937AbXFQD2v
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 23:28:51 -0400
Received: from iabervon.org ([66.92.72.58]:3075 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753494AbXFQD2u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 23:28:50 -0400
Received: (qmail 32448 invoked by uid 1000); 17 Jun 2007 03:28:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jun 2007 03:28:49 -0000
In-Reply-To: <7vtzt71hks.fsf@assigned-by-dhcp.pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50330>

On Sat, 16 Jun 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > With this configuration:
> >
> > [remote "config-glob"]
> > 	fetch = refs/heads/one:refs/remotes/rem/one
> > 	fetch = refs/heads/two:refs/remotes/rem/two
> > 	fetch = refs/heads/three:refs/remotes/rem/three
> > [branch "br-config-glob-octopus"]
> > 	remote = config-glob
> > 	merge = refs/heads/one
> > 	merge = two
> > 	merge = remotes/rem/three
> >
> > It seems to me like "two" should be marked for merge, since "two" 
> > canonicalizes to "refs/heads/two", which matches the pattern and is 
> > fetched. However, current git-fetch marks it not-for-merge, and the test 
> > demands this.
> >
> > Shouldn't the value of "merge" permit the same shortcuts that the lhs of 
> > "fetch" permits, even if the matching fetch line isn't using them in this 
> > case? (And vice versa, for a canonical value of merge when the fetch is a 
> > shortcut)
> 
> I do not see much reason for that kind of complication.
> Honestly speaking, I do not like the fallback that we use for
> the third one (using the remote tracking name).

Actually, with my current code it's a simplification to have the code 
expand all shortcuts up front and do all of the matching on explicit 
names. I'm trying to use "struct ref" for fetching, and it doesn't work if 
you have to store both the name that would match a "merge" setting and the 
name that would match the actual remote ref.

> When you are righting down your configuration file, you are
> doing so to reuse that entry over and over, so why not be
> explicit for once and not worry about cases where the remote
> adds ambiguous 'two' that is not refs/heads/two?

I'd personally be in favor of requiring the config file to be explicit 
everywhere, for just this reason, but we've got tests, if not 
documentation (and I haven't checked documentation on this one) saying 
that shortcuts work in config files.

This is, this is supported, and marks refs/heads/two for merge:

[remote "config-glob"]
	fetch = refs/heads/one:refs/remotes/rem/one
	fetch = two:refs/remotes/rem/two
	fetch = refs/heads/three:refs/remotes/rem/three
[branch "br-config-glob-octopus"]
	remote = config-glob
	merge = refs/heads/one
	merge = two
	merge = remotes/rem/three

But I'd prefer to by able to discard the information of whether a short 
form was used early.

	-Daniel
*This .sig left intentionally blank*
