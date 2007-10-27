From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: recent change in git.git/master broke my repos
Date: Sat, 27 Oct 2007 16:06:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710271600440.7345@iabervon.org>
References: <86oden6z97.fsf@blue.stonehenge.com> <20071025165633.GA24143@coredump.intra.peff.net>
 <Pine.LNX.4.64.0710251351330.7345@iabervon.org> <7vejfhulzn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 22:06:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ilrvn-0007bb-QX
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 22:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbXJ0UGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 16:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752740AbXJ0UGj
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 16:06:39 -0400
Received: from iabervon.org ([66.92.72.58]:53246 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbXJ0UGi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 16:06:38 -0400
Received: (qmail 23170 invoked by uid 1000); 27 Oct 2007 20:06:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Oct 2007 20:06:37 -0000
In-Reply-To: <7vejfhulzn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62509>

On Fri, 26 Oct 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Thu, 25 Oct 2007, Jeff King wrote:
> >
> >> On Thu, Oct 25, 2007 at 07:32:36AM -0700, Randal L. Schwartz wrote:
> >> 
> >> > I have echo "ref: refs/remotes/origin/master" >.git/refs/heads/upstream
> >> > so that my daily update script can go:
> >> > 
> >> >    git-fetch
> >> >    if [ repo is on master, and is not dirty ];
> >> >       git-merge upstream
> >> >    fi
> >> > 
> >> > Yesterday that worked.
> >> > 
> >> > Today I get a rash of:
> >> > 
> >> >   fatal: Couldn't find remote ref refs/remotes/origin/master
> >> > 
> >> > from my git-fetch.
> >> 
> >> Randal and I discussed this a bit on IRC, and it turns out not to be
> >> related to the 'upstream' symref. Instead, he had a broken
> >> branch.master.merge config that pointed to "refs/remotes/origin/master"
> >> (which you can see from his script above doesn't actually get used).
> >> 
> >> So presumably the old git-fetch didn't care that the contents of
> >> branch.*.master didn't exist (it's just that nothing got marked for
> >> merging), but the one just merged from the db/fetch-pack topic does.
> >> 
> >> Is this behavior change intentional?
> >
> > It's not exactly intentional; it's just that nobody seems to have tested 
> > this particular misconfiguration. It should probably report an error 
> > (since the configuration is, in fact, broken and potentially misleading), 
> > but it probably shouldn't be fatal and certainly shouldn't be so 
> > uninformative.
> 
> How would we proceed from here, then?
> 
> If you had "branch.master.merge = refs/heads/foobar", kept
> running happily, and suddenly the remote stopped carrying that
> foobar branch, you would get a configuration that uses
> nonexistent remote branch name, so this is not purely a
> configuration error on the fetcher's side.

True, although I'd consider that a matter of configuration rot rather than 
it being an okay configuration; the user probably still needs to figure 
out what happened to it and what to use instead. Maybe we want to output a 
message to stderr (although higher than the die() used to be, so that we 
can report the reason that it was looking for the missing remote ref).

> Older git used to enumerate remote tracking branches explicitly,
> and one of the remote.origin.fetch entries would have said
> "refs/heads/foobar:refs/remotes/origin/foobar", and that would
> have made git-fetch fail with the error, complaining that such a
> branch does not exist.
> 
> You are suggesting that git-fetch should not fail if
> remote.origin.fetch is refs/heads/*:refs/remotes/origin/*
> wildcard, and I think I can agree with that; "git pull" however
> should notice and and exit with an error.
> 
> Perhaps something like this?

That looks like what I was going to write when I got to it (although I 
would have had the flag inverted, which is less git style, I guess).

Acked-By: Daniel Barkalow <barkalow@iabervon.org>

	-Daniel
*This .sig left intentionally blank*
