From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] contrib: add win32 credential-helper
Date: Fri, 23 Mar 2012 17:10:01 -0400
Message-ID: <20120323211001.GA18198@sigill.intra.peff.net>
References: <1332198414-5884-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 22:10:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBBkZ-0001v1-AV
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 22:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963Ab2CWVKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 17:10:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57768
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321Ab2CWVKE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 17:10:04 -0400
Received: (qmail 19163 invoked by uid 107); 23 Mar 2012 21:10:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Mar 2012 17:10:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Mar 2012 17:10:01 -0400
Content-Disposition: inline
In-Reply-To: <1332198414-5884-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193802>

On Tue, Mar 20, 2012 at 12:06:54AM +0100, Erik Faye-Lund wrote:

> This one pretty much sucks. Mem-leaks and a sketchy deletion-filter.

Thanks for moving forward on this. I'm sorry I can't be much help on the
Windows-specific knowledge, but I'll answer what I can.

> Currently uses "::" as an attribute-separator, but this is not robust
> without encoding if the attribute values themselves contains "::".

Yeah. Can you store arbitrary bytes? If so, NUL would be a good
terminator. Otherwise, newline is a reasonable choice, as the protocol
already can't communicate usernames/passwords with newlines (a
limitation that I accepted to make the protocol much simpler for
scripting use).

That being said, I realized when writing credential-store that you can
encode all of the components in a URL, like:

  proto://user:password@host/path

You do have to get the URL encoding/decoding right, of course, but since
it is a standard format, you may have library or OS support (for the
stock helpers, I was able to cheat and just link against git's code).

> I'm not really sure how to make it less sucky in some regards, part
> of this I blame on lacking documentation of the credential-helper
> prococol :P

Heh. OK, I'll take the blame. :)

>  1) Encoding of usernames. I'm assuming this is supposed to be
>  UTF-8, because SecKeychainFindInternetPassword which is used by
>  the OSX-helper is documented to take accountName as UTF-8.

Like many other parts of git, we treat the data as binary goo as much as
possible. So git hands the helper whatever bytes the user provided, and
ships off whatever bytes are provided by the helper over http without
any further processing. The only two exceptions are:

  1. Fields cannot contain NUL (which means wide encodings like utf-16
     are pretty much out).

  2. Fields cannot contain newline (which effectively means that the
     encoding needs to be some ascii superset like utf8 or latin1).

In practice, I would expect most usernames and passwords only contain
ascii bytes, if only because charset issues between the client and
server would lead to insanity.

>  2) Encoding of passwords. I'm assuming UTF-8, as mixing encodings
>  here would be insane :P

Same as above.

>  3) How to match credentials for look-up when not supplying all
>  attributes. I've implemented a kind-of dodgy matching; I use a
>  string that packs all supplied attributes. This seems to work,
>  but I'm a bit worried about what happens when people try to mix
>  credentials saved with credential.useHttpPath=true with those
>  saved with credential.useHttpPath=false.

See how credential_match in credential.c does it. For a get, the input
to the helper is basically a template saying "this is what I want to
match". If you have more information in your database than is in the
template, that's OK; anything the template doesn't specify should not be
considered a restriction.

So if you get:

  protocol=http
  host=example.com

you should match an entry previously stored for:

  protocol=http
  host=example.com
  path=foo.git

because what is being asked is a more generic form (if you had two
entries, one for foo.git and one for bar.git, it's unclear which should
be chosen; my implementations just pick the first match they encounter).

The same thing happens for usernames. You might get asked for a
credential for a specific username, or you might get asked for a
credential of any username at that host. It's nice in the latter case to
be able to respond with a previously-stored credential from the former.

But note that none of this advanced matching is strictly necessary. It's
purely a quality-of-implementation issue in the helper, and that's why I
left the details out of the documentation (also, I hoped many helpers
could just rely on OS-provided libraries to do the heavy lifting of the
match; that's how it is for OS X, but it seems Windows doesn't have
anything equivalent).

So I'm just describing here what git does for credential-store,
credential-cache, and for the internal config matching. You could do a
lot less in the helper. For example, I keep my passwords in a password
wallet that is backed by GPG-encrypted storage, and my config looks
like:

  [credential "https://github.com"]
    username = peff
    helper = "!f() { test $1 = get && echo password=`pass -n github.web.password`; }; f"
  [credential]
    helper = cache

So note that the helper is totally dumb and relies on the internal
config-matching to restrict when it gets used.

Likewise, you could be a lot smarter. You could conflate http and https
protocol entries according to some internal policy. You could
prefix-match paths so that a stored credential for
"http://example.com/foo" would be applied to a request for
"http://example.com/foo/bar.git". In my helpers, I drew the line where I
thought it was reasonable, but there's no reason other helpers have to
follow the exact same rules.

>  4) How to match credentials for deletion when not supplying
>  all attributes. It seems from the test-suite that a credential is
>  expected to be deleted even if the username is not given.

Yeah, that's what I would expect. The input is a template, so delete
anything that matches the template.

> But what happens in such a case when there's two different credentials
> for one domain, with different username? The OSX-helper seems to only
> delete one of them (but I'm not entirely sure which one, due to
> lacking documentation from Apple's side).

I'd expect them both to be deleted if no username is given (and I'm
pretty sure that's what the stock helpers will do). It may be that the
OS X helper does not (I don't recall testing it explicitly). You could
consider it a bug, or merely a different design decision.

When git deletes a credential, it should provide the username (because
it only does so after trying to use the credential and getting a
rejection). Again, I intentionally left corner cases like this
unspecified, because I didn't want to force helpers to behave one way or
the other (especially when git itself doesn't care either way). I hoped
that helper writers would then be free to do whatever behavior made
sense to them and to their implementation.  But from the writer's
perspective, I guess it looks like the behavior is simply
under-specified. :)

>  The OSX-helper also have a comment saying "Require at least a
>  protocol and host for removal, which is what git will give us; if
>  you want to do  something more fancy, use the Keychain manager".
>  This comment puzzles me a bit; won't git also give us path in case
>  of credential.useHttpPath=true?

Yes; git will provide _at least_ the protocol and host. That code and
comment came out of discussion with Junio, where we realized that an
"empty" template would cause everything to be deleted. So doing this:

  git credential-foo erase </dev/null

would delete everything! Which maybe is something you would want to do,
but it seemed too easy to accidentally trigger this destructive
behavior. So I require some input as a sanity-check, and if you want to
do something like "delete all entries", you will have to use the
separate keychain manager program.

Does that make more sense?

>  5) How overwriting credentials work. If there's a credential where
>  all attributes except for the password match, will "store" just
>  overwrite it? Should it complain?

In the stock implementations, we will overwrite. I don't think it
matters to git, though. If the helper gives us a credential that works,
we will not bother parroting it back[1]. If we get one that does not
work, we will erase it.

[1] That was my intent, anyway. But I think it may parrot it back,
    anyway. We should probably set the "approved" flag on a credential
    given to us by a helper, as there is not much point in asking them
    to store it again afterwards.

> I'm guessing that a lot of these questions fall in the "who cares"
> category. For instance, git probably never tries to create a
> credential it already has stored. But at least saying "This cannot
> happen" in the documentation makes it a lot easier to write a
> credential-helper.

The problem is that it is not "this cannot happen", but rather "git does
not currently do this". I wanted to specify as little as possible so
that future versions could change those corner cases if they wanted to
(or somebody could write a more advanced tool to interact with the
helpers).

But maybe we should be more explicit about that in the api-credential
document.

-Peff
