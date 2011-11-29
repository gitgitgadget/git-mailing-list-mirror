From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/13] introduce credentials API
Date: Tue, 29 Nov 2011 00:04:25 -0500
Message-ID: <20111129050425.GA32022@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111124110105.GA8417@sigill.intra.peff.net>
 <7v4nxnvs1w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 06:04:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVFru-0001s1-MJ
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 06:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020Ab1K2FE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 00:04:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54220
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809Ab1K2FE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 00:04:27 -0500
Received: (qmail 28405 invoked by uid 107); 29 Nov 2011 05:11:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Nov 2011 00:11:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2011 00:04:25 -0500
Content-Disposition: inline
In-Reply-To: <7v4nxnvs1w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186043>

On Mon, Nov 28, 2011 at 01:46:35PM -0800, Junio C Hamano wrote:

> > diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
> > new file mode 100644
> > index 0000000..3061077
> > --- /dev/null
> > +++ b/Documentation/technical/api-credentials.txt
> > @@ -0,0 +1,148 @@
> > + ...
> > +`credential_fill`::
> > +
> > +	Attempt to fill the username and password fields of the passed
> > +	credential struct, first consulting storage helpers, then asking
> > +	the user. Guarantees that the username and password fields will
> > +	be filled afterwards (or die() will be called).
> > +
> > +`credential_reject`::
> > +
> > +	Inform the credential subsystem that the provided credentials
> > +	have been rejected. This will notify any storage helpers of the
> > +	rejection (which allows them to, for example, purge the invalid
> > +	credentials from storage), and then clear the username and
> > +	password fields in `struct credential`. It can then be
> > +	`credential_fill`-ed again.
> > +
> > +`credential_approve`::
> > +
> > +	Inform the credential subsystem that the provided credentials
> > +	were successfully used for authentication. This will notify any
> > +	storage helpers of the approval, so that they can store the
> > +	result to be used again.
> 
> It's a bit hard to read and understand which part of the system calls
> these and which other part of the system is responsible for implementing
> them, and how "helper" fits into the picture (perhaps calling some of
> these interfaces will result in "helper" getting called?).

How about following it with a rough example of how they would be used,
like:

  /*
   * Create a credential with some context; we don't yet know the
   * username or password.
   */
  struct credential c = CREDENTIAL_INIT;
  c.protocol = xstrdup("https");
  c.host = xstrdup("example.com");
  c.path = xstrdup("foo.git");

  /*
   * Fill in the username and password fields by contacting helpers
   * and/or asking the user. The function will die if it fails.
   */
  credential_fill(&c);

  /*
   * And then finally make our request, reporting back to the credential
   * system on whether it succeeded or failed.
   */
  if (make_http_request(c.host, c.path, c.username, c.password) < 0)
          credential_reject(&c);
  else
          credential_accept(&c);

Does that make it more clear?

> > +Credential Storage Helpers
> > +--------------------------
> > +
> > +Credential storage helpers are programs executed by git to fetch or save
> > +credentials from and to long-term storage (where "long-term" is simply
> > +longer than a single git process; e.g., credentials may be stored
> > +in-memory for a few minutes, or indefinitely on disk).
> > +
> > +Helper scripts should generally be found in the PATH, and have names of
> > +the form "git-credential-$HELPER".
> 
> Is this normal PATH or can a helper be moved away into $GIT_EXEC_PATH?

They are executed as normal git commands, so $GIT_EXEC_PATH. Actually,
they could even be aliases or builtins, for that matter. I'll update the
documentation to reflect that.

> I briefly wondered if they want to be git-credential--$HELPER; I do not
> deeply care either way, though.

Yeah, I thought about that. In some ways they are implementation details
that you don't care about, and that makes the "--" separator make sense.
But some of them may want to expose other actions to the user. For
example, git-credential-cache has an "exit" action that you can call to
ask the cache daemon to exit prematurely, forgetting all credentials.
Git will never use it; it's purely an end-user interface.

I think it might also make sense to ask helpers to provide a "clear"
operation which will delete any stored items. Git wouldn't use it, but
it would be helpful for testing.

> > When the helper string "$HELPER" is
> > +passed to credential functions, they will run "git-credential-$HELPER"
> > +via the shell. If the first word of $HELPER contains non-alphanumeric
> > +characters, then $HELPER is executed as a shell command. This makes it
> > +possible to specify individual scripts by their full path (e.g.,
> > +`/path/to/helper`) or even shell snippets (`f() { do_whatever; }; f`).
> 
> The definition of "the first word" above is not specified but it seems to
> be "space separated". In other words, 'f() { do_whatever; }; f' would be
> OK but 'f () { do_whatever; }; f' would not be. Am I reading and guessing
> your intention correctly?

Yes, that is my intent, though I am not altogether happy with it, as
there are too many confusing corner cases (e.g., your "f ()" example
above). My thinking was guided by these requirements:

  1. Users who are using one of the included helpers or a drop-in
     third-party helper should be able to just do:

        git config credential.helper cache

     which is extremely readable and intuitive. Thus, I want to prepend
     "git credential-" at least for simple cases.

  2. You should be able to add arguments to a helper, if it takes them.
     For example, with the current code you can do:

       git config credential.helper 'cache --timeout=300'

     or

       git config credential.helper 'store --store=/some/path'

     and that's all interpreted by the shell, and the helpers receive
     your configuration (the "--store" name is a holdover from version 1
     of the series, which had many more options. Probably "--path" or
     "--file" would be better name).

     So that means that the rule for when to prepend "git credential-"
     is not simply "when the helper is a single token". It can be
     arbitrary arguments, and should be interpreted by the shell (to
     handle things like quoting).

  3. You should be able to use a full path, like:

       git config credential.helper '/path/to/git-credential-foo'

     This works with the isalnum thing. But you could also use
     is_absolute_path.

  4. You should be able to insert full shell snippets if you really want
     to. This is handy for testing, and I could even see somebody doing
     something like:

       git config credential.helper '
       f() {
         case "`uname -s`" in
         Linux) git credential-gnome "$@" ;;
         Darwin) git credential-osx "$@" ;;
         esac
       }
       f'

     if they have a multi-platform config file (or they could check
     $DISPLAY, or `hostname`, or any of a zillion other things).  You
     could put it in a shell script, of course, but sometimes it is
     nice to carry little snippets like that in the config file.

     You could do something like "prepend ! to execute via the shell",
     like we do for aliases. But that is perhaps a little confusing, in
     that we are _always_ executing via the shell. It is just that
     sometimes we prepend some magic to the command name. I dunno.

So one possible rule would be:

  1. If it starts with "!", clip off the "!" and hand it to the shell.

  2. Otherwise, if is_absolute_path(), hand it to the shell directly.

  3. Otherwise, prepend "git credential-" and hand it to the shell.

I think that is slightly less confusing than the "first word is alnum"
thing.

> Funnily enough, 'f<TAB>() { do_whatever; }; f' would qualify as the first
> word having a non alphanumeric.

Yeah, arguably a bug in my code. ;)

> > +The details of the credential will be provided on the helper's stdin
> > +stream. The credential is split into a set of named attributes.
> > +Attributes are provided to the helper, one per line. Each attribute is
> > +specified by a key-value pair, separated by an `=` (equals) sign,
> > +followed by a newline. The key may contain any bytes except `=` or
> > +newline. The value may contain any bytes except a newline.  In both
> > +cases, all bytes are treated as-is (i.e., there is no quoting, and one
> > +cannot transmit a value with newline in it).
> 
> Can k or v contain a NUL? The literal reading of the above implies they
> could, but I do not think you meant to.

No, they cannot. I'll make that more explicit in the next version.

How do you feel about the "values cannot contain a newline" requirement?
It feels wrong to me to design a protocol with no escape hatch for
quoting. But I really didn't want helper implementations to have to deal
with unquoting or other parsing headaches. And terminating with NUL
instead of newline makes things annoying in some languages (e.g.,
shell). So I considered it "good enough", but I'd be curious to hear
other opinions.

> > +int credential_read(struct credential *c, FILE *fp)
> > +{
> > ...
> > +			c->host = xstrdup(value);
> > +		}
> > +		else if (!strcmp(key, "path")) {
> > ...
> > +		/* ignore other lines; we don't know what they mean, but
> > +		 * this future-proofs us when later versions of git do
> > +		 * learn new lines, and the helpers are updated to match */
> 
> Two style nits.

I'm supposed to guess? ;P

I know you like blank lines at the top and bottom of multi-line
comments; I often forget that, as they are not part of my usual style (I
find them no easier to read).

I'm guessing the other is an uncuddled else? I can never remember which
we prefer, as we are horribly inconsistent in the current code.

-Peff
