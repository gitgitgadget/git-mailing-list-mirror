From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's
 keychain
Date: Mon, 3 Oct 2011 06:59:08 -0400
Message-ID: <20111003105908.GF16078@sigill.intra.peff.net>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
 <20110929075627.GB14022@sigill.intra.peff.net>
 <CAG+J_DwntGc+j3duCVqsnoJGV18FqnwXJ99C1XqKope_zbGHAA@mail.gmail.com>
 <20110930221111.GB9384@sigill.intra.peff.net>
 <CAG+J_Dww1yOeq1LHQYMiObPKqrWbk4t8Hn=G9WpYWXFBbHiuhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 12:59:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAgEt-00024e-PC
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 12:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459Ab1JCK7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 06:59:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51562
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753649Ab1JCK7K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 06:59:10 -0400
Received: (qmail 27433 invoked by uid 107); 3 Oct 2011 11:04:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Oct 2011 07:04:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2011 06:59:08 -0400
Content-Disposition: inline
In-Reply-To: <CAG+J_Dww1yOeq1LHQYMiObPKqrWbk4t8Hn=G9WpYWXFBbHiuhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182651>

On Fri, Sep 30, 2011 at 06:42:22PM -0400, Jay Soffian wrote:

> Usually it won't. In the default case, the keychain is unlocked and no
> permission is needed to add an entry, nor to retrieve that entry by
> the application which added it. The prompt will only occur if the
> credential helper is not on the entry's ACL, or if the keychain is
> locked.

Yeah. I was thinking the ACL prompt would come up more often, but I
guess most people would hit "allow always", since it would get annoying
pretty quickly otherwise (I didn't, because I was testing).

Side note: do you know how to edit those ACLs? I couldn't find it in the
keychain manager. It would be helpful for testing to be able to tweak it
(as a workaround, I just modified the binary, which apparently the
keychain code cares about).

> > Another example: if you're running gpg-agent, and you run "git tag -s",
> > you'll be prompted for your key passphrase in an out-of-band dialog.
> >
> > Maybe it doesn't make sense for the actual username/password, though.
> 
> Personally, it made sense to me do it at the CLI (obviously). But the
> source code in in contrib now. :-)

Let's leave it that way, then. It's open source, after all. If somebody
really wants a dialog, they can add it. They can even make it optional
(you can do "git config credential.helper 'osxkeychain --dialog'" if the
thing actually takes options).

> >> I found it ugly that git's native getpass doesn't echo the username
> >> back, and it seems hackish to me for the credential helper to turn
> >> back around and invoke it in any case. :-(
> >
> > Yes, but I think that's a bug that should be fixed in git. :)
> 
> Yes it should. :-)

I think the only thing holding this back is portability. But it's awful
to make reasonable platforms suffer because it can't be done portably.
We should at least do the right thing when we can, and fall back to
using getpass() otherwise. I'll see what I can do.

> I think that actually makes more sense. There's already an existing
> mechanism to customized (2) via GIT_ASKPASS, right? So it overlaps for
> the credential helper to do that doesn't it?

Sort of. The askpass interface was really invented for asking for ssh
passphrases. So:

  1. It can only ask for one thing at a time. So you get two dialogs,
     not one, and there's no place for anything else, like a "remember
     this password" checkbox.

  2. Like the getpass() hack in git, it won't show you what you've typed
     so far for the username (there are several implementations, so it's
     possible one could have an extra feature for this, but the ones
     I've seen just always show some opaque image for each character
     typed).

  3. There's no way to pre-fill the username field, and let the user
     override. So you end up just taking whatever username we already
     have, ask for the password, and then try the authentication. The
     user's only recourse is to restart the command with a different URL
     (with the alternative username in the URL).

> Okay, the more I think about this, the more I think the existing
> design is both too much (asking the credential helper to do anything
> other than store/retrieve passwords) and too little (not breaking out
> the fields distinctly).

I remember in some initial research that there may have been some system
which really wanted to do the prompting itself. But now I can't find any
reference to it. I think it may have been the freedesktop Secrets API,
but now that I read their documentation again, I think I may simply have
been mistaking the prompt for unlocking the secure storage itself, not
the actual username and password.

> > That's not an unreasonable attitude. I mostly let the browser store
> > passwords, but sometimes override it for specific sites. But in this
> > case, I think it would be more per-repo. And you can turn off the helper
> > for a particular repo (actually, I'm not sure you can, but you probably
> > should be able to).
> 
> If the credential helper becomes no more than a store/retrieve, it's
> git that would do the prompting "Store credentials via
> git-osxkeychain?" after logging in successfully with the credentials.

Maybe. I had assumed we would hand it off to the helper, and it would
make the decision (possibly after consulting with the user). But I
suppose git could do it itself.

-Peff
