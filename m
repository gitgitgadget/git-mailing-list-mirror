From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow user aliases for the --author parameter
Date: Fri, 22 Aug 2008 12:50:48 -0400
Message-ID: <20080822165047.GA3339@sigill.intra.peff.net>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <fork0@users.sourceforge.net>, git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Aug 22 18:52:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWZrh-0000Ef-0F
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 18:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbYHVQuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 12:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbYHVQuv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 12:50:51 -0400
Received: from peff.net ([208.65.91.99]:4552 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbYHVQuu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 12:50:50 -0400
Received: (qmail 22829 invoked by uid 111); 22 Aug 2008 16:50:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 22 Aug 2008 12:50:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Aug 2008 12:50:48 -0400
Content-Disposition: inline
In-Reply-To: <48AE786C.20201@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93326>

[oops, this accidentally got taken off the list, so here is a repost to
the list and all interested parties]

On Fri, Aug 22, 2008 at 10:27:24AM +0200, Michael J Gruber wrote:

> There's also git svn.
> I think all of these serve different purposes, and have different
> typical numbers of entries.
> 
> - mailmap maps email addresses to full names, for display purposes only.
> Typically a long list.
> 
> - git svn's author file maps usernames to fullname <email>. But for
> every svn repo I need a file following their chosen keys (usernames),
> rather than abbreviations I would remember.
> 
> - alias files for send-email map keys to fullname <email>. That indeed
> is a mapping and a purpose similar to my intention for git commit
> --author. Problem here is that it's in perl and supports various
> different formats.

I agree with your analysis here. The mapping done by mailmap and git-svn
aren't the same. The ones for send-email are, but there is simply an
implementation hurdle.

> I think for send-email you would typically use your mua's alias file.
> 
> For git commit --author abbreviations at least I would typically need
> only very few entries (be it per repo or globally), which means they can
> be much shorter (than my mua aliases) in order to be unique, and I don't
> really want an extra file for that.

I think this depends on your situation. In your case, it sounds like you
want to configure a few names that frequently have --author fields for
your specific workflow. For me, even though only 1% of the people in my
mua's alias file might send me patches, 99% of the people I would want
to use --author on are in my mua's alias file.

So while there are may only be a few needed entries, they are already
there for me. Of course, I don't really use --author much, since most
people I talk to are already git users. ;) So I am extrapolating a bit.

> >> The "--committer" argument to git commit is not treated because I
> >> don't consider it worthwhile.
> 
> I managed to fool everyone, including myself. There is no --committer
> option. I feel in good company now ;)

Heh.

> There is GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL, and likewise for
> author. My patch does not use any of these, it only deals with (the)
> option argument(s). Explicitely set *_{NAME,EMAIL} should be respected
> as is.

I think that is sensible.

> > I haven't traced all of the uses of author_name and author_email, but
> >  all of the other codepaths seem to allocate a new string, whereas
> 
> ..because they need to make a local (for the function) string global
> (for the file)...
> 
> > this uses the existing strings.
> 
> ...because they are (file) global already.
> 
> > Is this going to accidentally free()
> > from the users list, or are we just leaking those other strings now?
> 
> Same as branches in remote.c, see below. They're not freed accidentally
> in builtin-commit.c

OK, I see. I wonder if it is worth xstrdup'ing them _anyway_, so that
determine_author_info produces a consistent result, and the person who
later does the free() cleanup won't get a nasty surprise. But the
leakage is probably not enough to really care about in this instance.

> I was looking all over the existing code for a function which would do
> what "git config --get $key" does, and didn't find any. I ended up
> copying the logic (and code) from remote.c's parsing of "branch.*.*".
> [Should I have attributed this somehow? ]

No, no need to attribute in this case, I think.

I think the way you have done the config is fine, unless somebody else
has a major style objection (and yes, there are examples of similar
styles).

-Peff
