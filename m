From: Jeff King <peff@peff.net>
Subject: Re: git-mailinfo doesn't stop parsing at the end of the header
Date: Wed, 18 Nov 2009 12:24:24 -0500
Message-ID: <20091118172424.GA24416@coredump.intra.peff.net>
References: <aa2993680911180620g151d8a07t11144d150cd6e29e@mail.gmail.com>
 <20091118155154.GA15184@coredump.intra.peff.net>
 <aa2993680911180911o7e3af804m4ebdc20096baa609@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Philip Hofstetter <phofstetter@sensational.ch>
X-From: git-owner@vger.kernel.org Wed Nov 18 18:24:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAoGi-00041U-Qe
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 18:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967AbZKRRYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 12:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757880AbZKRRYV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 12:24:21 -0500
Received: from peff.net ([208.65.91.99]:60305 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757879AbZKRRYU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 12:24:20 -0500
Received: (qmail 31165 invoked by uid 107); 18 Nov 2009 17:28:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Nov 2009 12:28:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Nov 2009 12:24:24 -0500
Content-Disposition: inline
In-Reply-To: <aa2993680911180911o7e3af804m4ebdc20096baa609@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133192>

On Wed, Nov 18, 2009 at 06:11:36PM +0100, Philip Hofstetter wrote:

> > As I explained above, there is a reason, but I don't think it's rude to
> > have either of those lines. You were, after all, writing a commit
> > message, not an email (and even if you were, it is a failure of the
> > storage format if it can't represent your data correctly). So I think
> > git is to blame here.
> 
> IMHO, another workable solution would be to reject a commit that later
> can't be handled. That way the current attempts at getting an email
> address can remain intact and the (much more) unlikely case that
> somebody begins the commit message with from: will be caught before
> damage is done.

I'm not sure I like that solution for a few reasons:

  1. It creates a bad user experience. You are not unreasonable for
     wanting to put some specific text in your commit message. Having
     git come back and say "oops, I might get confused by this later"
     just seems like an annoyance to the user.

  2. Mailinfo has to deal with data created by older versions of git. So
     in your case, the rebase was a bomb waiting to go off. If we can
     fix it so that an existing bomb doesn't go off, rather than not
     creating the bomb in the first place, then we are better off.

  3. Commit has to know about rules for mailinfo, even versions of
     mailinfo that will exist in the future. Probably the rules aren't
     going to change much, but it is a weakness.

  4. Commit messages can come from other places than "git commit". What
     should we do with a commit message like this that is imported from
     SVN? Reject the import? Munge the message?

Of course all of that presupposes that we can correctly handle the
existing data after the fact. Even with my patch, you still can't write
"From: foo@example.com" as the first line of your commit body. But that
is, IMHO, getting even more unlikely than your "From:" (which already
seems fairly unlikely).

I also think "git commit" would not be the right time for such a
feature. The problem is not that you have this text in your commit
message. The problem is that the "format-patch | am" transport is lossy.
You would do better to have format-patch say "Ah, this is going to
create a bogus email address" and somehow quote it appropriately.

-Peff
