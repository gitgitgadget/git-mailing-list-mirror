From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/14] introduce credentials API
Date: Fri, 22 Jul 2011 14:39:03 -0600
Message-ID: <20110722203901.GA11922@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718075034.GF12341@sigill.intra.peff.net>
 <7vy5zs4mxt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 22:39:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkMVA-0003jr-R0
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 22:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127Ab1GVUjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 16:39:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43042
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932096Ab1GVUjL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 16:39:11 -0400
Received: (qmail 23088 invoked by uid 107); 22 Jul 2011 20:39:39 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Jul 2011 16:39:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2011 14:39:03 -0600
Content-Disposition: inline
In-Reply-To: <7vy5zs4mxt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177666>

On Wed, Jul 20, 2011 at 03:17:02PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +`struct credential`::
> > +
> > +	This struct represents a single username/password combination.
> > +	The `username` and `password` fields should be heap-allocated
> > +	strings (or NULL if they are not yet known). The `unique` field,
> > +	if non-NULL, should be a heap-allocated string indicating a
> > +	unique context for this credential (e.g., a protocol and server
> > +	name for a remote credential). The `description` field, if
> > +	non-NULL, should point to a string containing a human-readable
> > +	description of this credential.
> 
> Am I confused to say "unique" is for code/machine and "description" is for
> human to identify what remote resource is being accessed using the
> credential?

No, you're not confused. That is the intent.

> Can two credentials have the same description but different unique,
> and if so what happens?

Yes, they could. In fact, you can do it with the code in my series. The
URL "http://example.com" will have unique context "http:example.com",
and a description of "example.com". The ssl-enabled version,
"https://example.com", will have the same description, but a different
unique context ("https:example.com").

I wanted the machine-readable token to be complete and unambiguous,
since it may be sent automatically. Deciding to send a password over
unencrypted http versus https is a policy decision that only the user
can make, and we should err on the side of caution.

The human-readable portion, on the other hand, can assume that the user
has some context for the request, and can make the right decision. So we
can afford to put less information it, if it makes the output prettier
to human eyes.

One could argue that we still need to provide as much information as
possible to a human user. For example, if I cut-and-paste a URL with
"http" instead of "https", I might fail to notice and provide my
password accidentally over an unencrypted link. Including the missing
information in the human-readable part could help with that case, at the
cost of making the prompt a little longer than necessary for other
cases.

Another example is that we say only "Password for 'certificate':" when
unlocking a certificate, even though the certificate's unique token
mentions the filename. This is the same case: the user has the extra
context to know which certificate we mean, so we can make the message
prettier. Again, I think one could argue that it's better to provide the
context to the user, in case they don't have it.

In both of the above paragraphs, my "one could argue..." statements can
be translated as "I argued with myself about this, and am on the fence.
If you feel strongly, it's easy to make it so."

> A plausible answer may be "the user cannot tell what username/password
> pair to give, but it is expected that such a nondescriptive context is
> only for certificate and it also is expected that only one certificate
> is used at a time", perhaps?

Right.

> I think "unique" vs "description" are secondary aspects of these things,
> and the primary aspect that they share is that they are about "context",
> as [11/14] describes.  Perhaps "context-id" vs "context-description" may
> be better names to reduce confusion?  I dunno.

Yeah, it might be better to unify the concepts by giving them similar
names. It might even make sense to call them "context_id" and
"context_human" to make the difference more clear.

Another option would be to drop the concept entirely, and simply give
the helpers as many descriptive tokens as we can. So instead of:

  unique=https:example.com
  description=example.com

and

  unique=cert:/path/to/cert.pem
  description=certificate

we would give:

  type=network
  proto=https
  host=example.com
  path=repo.git

and

  type=certificate
  file=/path/to/cert.pem

and then let the helper generate an appropriate token or description
from those fields. That provides more flexibility for a helper to make a
decision. I avoided doing that in the first place for two reasons:

  1. It pushes more work onto the helpers to generate a token, or
     to generate a nice human-readable prompt. So we may end up with
     inconsistency between helpers, both in terms of messages shown to
     the user and in security properties (e.g., helpers may decide
     differently on policy issues like "are http and https similar
     enough to share passwords? What about imaps and https?"). Not to
     mention the duplicated effort among helper writers.

  2. I didn't know where it would end. Right now, those examples above
     are enough for what git uses. But when we add new credential
     locations (certainly imap-send is a place we could use it; probably
     send-email could also use it for smtp auth), will it be enough? How
     will already-written credential helpers cope with the new fields?

The Gnome Keyring API seems to just provide space for a free-form set of
key/value pairs. But I haven't found a micro-format which says which
fields should be used, so I guess it's up to the application to use them
consistently. The OS X keychain API has very specific fields for
protocol, hostname, etc (and even has different classes of "this is an
internet password" versus "this is a generic password").

So maybe it is simply better to break the information down as much as
possible and let the password wallet helpers do what they will with it.

> > +`credential_reject`::
> > +
> > +	Inform the credential subsystem that the provided credentials
> > +	have been rejected. This will clear the username and password
> > +	fields in `struct credential`, as well as notify any helpers of
> > +	the rejection (which may, for example, purge the invalid
> > +	credentials from storage).
> 
> What hints do helpers get when this is called? Do they get username,
> unique and description to allow them to selectively purge the bad ones
> while keeping good ones, or the username is already cleared by the time
> the helpers are notified and they have no clue?

They get username, unique, and description, to let them purge the
minimal amount (they are always free to ignore the username and purge
more, of course, if they are backed by less-capable storage).

We could also hold open a connection to the helper that gave us
information, try the credential, and then say either "OK" or "FAIL".
I specifically tried to avoid bi-directional interactive communication
in this protocol, though, in the name of simplicity. The helper gets
everything from git in one shot via the command line, and then dumps
everything back in one shot via stdout.

>From looking at a few APIs of system password wallets, it seems that
many expose functionality that is just "get" and "put". So normal use
would be something like:

  while (1) {
    if (!wallet_get(&cred))
      ask_user(&cred);
    if (request_with_cred(&cred))
      break;
  }
  wallet_put(&cred);

and it is up to the program to implement "ask_user".  So another option
would be to just expose "get" and "put" via credential helpers, which
keeps things pretty simple.  In my proposal, helpers are actually
responsible for asking the user.

I did that intentionally to provide a mechanism for system-specific
prompts. For example, you could pop up a single dialog with both
username and password fields. The username field might be filled in
already, but the user could override it.  You can't do anything quite as
nice with the askpass interface, which receives the questions one at a
time.

I also wanted to make sure we were flexible to systems which do
incorporate the "ask the user" step automatically. From my brief reading
of the freedesktop Secrets API, it does so.

> > +`credential_getpass`::
> > +
> > +	Fetch credentials from the user either using an "askpass" helper
> > +	(see the discussion of core.askpass and GIT_ASKPASS in
> > +	linkgit:git-config[1] and linkgit:git[1], respectively) or by
> > +	prompting the user via the terminal.
> 
> It sounds like that users of the API should call fill_credential() and let
> the machinery fall back to this function as needed. Does this need to be
> part of the public API functions?

The "getpass" helper calls it, though I suppose it could also just use
credential_fill with an empty list. I mainly left it as a convenience
function if there is something that doesn't want to use the regular
"fill" process, but I don't think it's critical.

> > +static int read_credential_response(struct credential *c, FILE *fp)
> > +{
> > +	struct strbuf response = STRBUF_INIT;
> > +
> > +	while (strbuf_getline(&response, fp, '\n') != EOF) {
> > +		char *key = response.buf;
> > +		char *value = strchr(key, '=');
> > +
> > +		if (!value) {
> > +			warning("bad output from credential helper: %s", key);
> > +			strbuf_release(&response);
> > +			return -1;
> > +		}
> > +		*value++ = '\0';
> > +
> > +		if (!strcmp(key, "username")) {
> > +			free(c->username);
> > +			c->username = xstrdup(value);
> 
> The document did not say anything about escaping/quoting of values, but it
> may not be a bad idea to make it more explicit over there.

There is no quoting or escaping. As the document says, "the value may
contain any bytes except a newline". It doesn't mention that keys cannot
contain an "=" or a newline, though that is also true.

Again, I went for simplicity of helper implementation, in the hope that
usernames and passwords could get by without newline characters. We
could switch it to "\0" if it matters. That makes shell implementations
of helpers a little tougher. But it's much easier than quoting.

-Peff
