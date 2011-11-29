From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/13] credentials: add "store" helper
Date: Tue, 29 Nov 2011 16:38:46 -0500
Message-ID: <20111129213846.GE1793@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111124110756.GJ8417@sigill.intra.peff.net>
 <7vsjl6ssf9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 22:38:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVVOB-000106-C6
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 22:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839Ab1K2Vis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 16:38:48 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55858
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756717Ab1K2Vis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 16:38:48 -0500
Received: (qmail 3053 invoked by uid 107); 29 Nov 2011 21:45:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Nov 2011 16:45:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2011 16:38:46 -0500
Content-Disposition: inline
In-Reply-To: <7vsjl6ssf9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186086>

On Tue, Nov 29, 2011 at 10:19:06AM -0800, Junio C Hamano wrote:

> > +	while (strbuf_getline(&line, fh, '\n') != EOF) {
> > +		credential_from_url(&entry, line.buf);
> > +		if (entry.username && entry.password &&
> > +		    credential_match(c, &entry)) {
> 
> This looks curious; isn't checking .username and .password part of the
> responsibility of credential_match()? And even if entry lacks password
> (which won't happen in the context of this program, given the
> implementation of store_credential() below) shouldn't it still be
> considered a match?

credential_match will check .username, if the pattern mentions it. It
will never check .password. My intent here was to enforce well-formed
entries in the credential file. So you could add:

  http://example.com/

to the credential file, but it's just meaningless noise. It
doesn't actually tell us a username or password.

The helper won't add such an entry itself, but given the simplicity of
the format, I wanted to leave the door open for curious hackers to
populate it manually if they choose.

I think you're right that:

  http://user@example.com/

is potentially meaningful, and this would skip that. OTOH, you would be
much better served to just do:

  git config credential.http://example.com.username user

So I consider it a slight abuse of this helper in the first place.

> > +static void rewrite_credential_file(const char *fn, struct credential *c,
> > +				    struct strbuf *extra)
> > +{
> > +	umask(077);
> 
> Curious placement of umask(). I would expect a function that has its own
> call to umask() restore it before it returns, and a stand-alone program
> whose sole purpose is to work with a private file, setting a tight umask
> upfront at the beginning of main() may be easier to understand.

I think that is largely a holdover from the original implementation,
which set the umask and did other black magic before calling
git_config_set. I agree it would make more sense at the beginning of the
program. Will change.

> > +	if (hold_lock_file_for_update(&credential_lock, fn, 0) < 0)
> > +		die_errno("unable to get credential storage lock");
> > +	parse_credential_file(fn, c, NULL, print_line);
> > +	if (extra)
> > +		print_line(extra);
> 
> An entry for a newly updated password comes at the end of the file,
> instead of replacing an entry already in the file in-place? Given that
> parse_credential_file() when processing a look-up request (which is the
> majority of the case) stops upon finding a match, it might make more sense
> to have the new one (which may be expected to be used often) at the
> beginning instead, no?

Yeah. It's a linear search. Your worst-case is always going to be O(n),
but I just assumed n would remain relatively small and we wouldn't care
(if it isn't, the right solution is probably a smarter data structure).

But your optimization is trivial to implement, so it's probably worth
doing.

> > +	if (commit_lock_file(&credential_lock) < 0)
> > +		die_errno("unable to commit credential store");
> > +}
> > +
> > +static void store_credential(const char *fn, struct credential *c)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +
> > +	if (!c->protocol || !(c->host || c->path) ||
> > +	    !c->username || !c->password)
> > +		return;
> [...]
> > +static void remove_credential(const char *fn, struct credential *c)
> > +{
> > +	if (!c->protocol || !(c->host || c->path))
> > +		return;
> 
> The choice of the fields looks rather arbitrary. I cannot say "remove all
> the credentials whose username is 'gitster' at 'github.com' no matter what
> protocol is used", but I can say "remove all credentials under any name
> for any host as long as the transfer goes over 'https' and accesses a
> repository at 'if/xyzzy' path", it seems.

It is kind of arbitrary. The storage format is URLs, which is why
store_credential is a little pedantic. We can't store something that
doesn't have a protocol part, as that is a required part of the URL
(actually, in URL-speak this is the "scheme"; I wonder if we should use
the same term here).

I was thinking we need a protocol for the same reason in
remove_credential, but I think you are right. We never actually convert
it to a URL, so in theory you could do:

  git credential-store erase <<\EOF
  username=gitster
  host=github.com
  EOF

Again, not an operation that git will ever perform, but I guess
something that people might want to do (I had always assumed the
"$EDITOR ~/.git-credentials" was going to be the preferred way of doing
such operations :) ).

I don't think there's any harm in loosening that condition.

-Peff
