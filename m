From: Jeff King <peff@peff.net>
Subject: Re: [PATCH_v1] add 'git credential' plumbing command
Date: Sun, 10 Jun 2012 07:56:19 -0400
Message-ID: <20120610115619.GA6453@sigill.intra.peff.net>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Sun Jun 10 13:56:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdglI-0000bA-8J
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 13:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab2FJL43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 07:56:29 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:48978
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab2FJL41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 07:56:27 -0400
Received: (qmail 22356 invoked by uid 107); 10 Jun 2012 11:56:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 10 Jun 2012 07:56:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Jun 2012 07:56:19 -0400
Content-Disposition: inline
In-Reply-To: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199591>

On Sat, Jun 09, 2012 at 08:45:02PM +0200, Javier.Roucher-Iglesias@ensimag.imag.fr wrote:

> +DESCRIPTION
> +-----------
> +
> +Git-credential permits to the user of the script to save:
> +username, password, host, path and protocol. When the user of script
> +invoke git-credential, the script can ask for a password, using the command
> +'git credential fill'.

I wonder if this description starts off a bit too literal, and should
start with the big picture. Tell people what it is generally, how it
fits into git, and in what circumstances they would want to run it.

Like:

  Git has an internal interface for storing and retrieving credentials
  from system-specific helpers, as well as prompting the user for
  usernames and passwords. The git-credential command exposes this
  interface to scripts which may want to retrieve, store, or prompt for
  credentials in the same manner as git. The design of this scriptable
  interface models the internal C API; see
  link:technical/api-credentials.txt[the git credential API] for more
  background on the concepts.

> +Taking data from the standard input, the program treats each line as a
> +separate data item, and the end of series of data item is signalled by a 
> +blank line.
> +
> +		username=admin\n 
> +		protocol=[http|https]\n
> +		host=localhost\n
> +		path=/dir\n\n

It's nice to have an example like this, but there's much detail missing
in how the format is specified. However, this format is already
documented in the "helpers" section of api-credentials.txt, so it
probably makes sense to refer to that document.

> +-If git-credential system have the password already stored
> +git-credential will answer with by STDOUT:
> +	
> +		username=admin
> +		password=*****
> +
> +-If it is not stored, the user will be prompt for a password:
> +		
> +		> Password for '[http|https]admin@localhost':

I'd rather see this broken up into a reference specification and
separate examples. Then the reference part can be very specific about
what happens and the behavior in each case. For example:

  git-credential takes an "action" option on the command-line (one of
  "fill", "approve", or "reject") and reads a credential description
  on stdin. The format of the description is the same as that given to
  credential helpers; see link:technical/api-credential.txt[the git
  credential API] for a specification.

  If the action is "fill", git-credential will attempt to add "username"
  and "password" fields to the description by reading config files, by
  contacting any configured credential helpers, or by prompting the
  user. The username and password fields of the credential description
  are then printed to stdout.

  If the action is "approve", git-credential will send the description
  to any configured credential helpers, which may store the credential
  for later use. 

  If the action is "reject", git-credential will send the description to
  any configured credential helpers, which may erase any stored
  credential matching the description.

And now that we've introduced the actions and said what they've done, we
can go on to describe the expected workflow, which is a good place to
put examples:

  An application using git-credential will typically follow this
  workflow:

    1. Generate a credential description based on the context.

       For example, if we want a password for
       `https://example.com/foo.git`, we might generate the following
       credential description:

           protocol=https
           host=example.com
           path=foo.git

    2. Ask git-credential to give us a username and password for this
       description. This is done by running `git credential fill`,
       feeding the description from step (1) to its stdin. The username
       and password will be produced on stdout, like:

           username=bob
           password=secr3t

    3. Try to use the credential (e.g., by accessing the URL with the
       username and password from step (2)).

    4. Report on the success or failure of the password. If the
       credential allowed the operation to complete successfully, then
       it can be marked with an "approve" action. If the credential was
       rejected during the operation, use the "reject" action. In either
       case, `git credential` should be fed with the credential
       description from step (1) concatenated with the attempted
       credential (i.e., the output you got in step (2)).

Note in the above proposed documentation I was trying to describe the
behavior of the command in your patch. It does not reflect changes which
I will propose to the command's behavior below. :)

> diff --git a/builtin/credential.c b/builtin/credential.c
> new file mode 100644
> index 0000000..9f00885
> --- /dev/null
> +++ b/builtin/credential.c
> @@ -0,0 +1,40 @@
> +#include <stdio.h>
> +#include "cache.h"
> +#include "credential.h"
> +#include "string-list.h"
> +
> +static const char usage_msg[] =
> +"credential <fill|approve|reject>";
> +
> +void cmd_credential (int argc, char **argv, const char *prefix){
> +	const char *op;
> +	struct credential c = CREDENTIAL_INIT;
> +	int i;
> +
> +	op = argv[1];
> +	if (!op)
> +		usage(usage_msg);
> +
> +	for (i = 2; i < argc; i++)
> +		string_list_append(&c.helpers, argv[i]);

So arguments past the first one become helpers that we try, regardless
of the credential.helper config settings. Is there a reason for this to
be in the user-facing command?

I assume this got copied by looking at test-credential. I'd be OK with
including this feature in git-credential (and converting our test
scripts to use it, so we can drop test-credential entirely). But
probably it should not soak up all of the command-line arguments, and
instead should be a hidden option like:

  git credential --helper=cache fill

That will give us more flexibility later down the road.

> +	if (credential_read(&c, stdin) < 0)
> +		die("unable to read credential from stdin");

I think we want to provide a straight credential-reader like this,
because it is the most flexible form of describing a credential. But I
suspect many callers will have a URL, and we are creating extra work for
them to break it down into components themselves.

Perhaps it would be simpler to accept a URL on the command line, and
also provide a --stdin option for callers that want to feed it directly.
So:

  git credential fill https://example.com/foo.git

would be identical to:

  git credential --stdin fill <<\EOF
  protocol=https
  host=example.com
  path=foo.git
  EOF

> +	if (!strcmp(op, "fill")) {
> +		credential_fill(&c);
> +		if (c.username)
> +			printf("username=%s\n", c.username);
> +		if (c.password)
> +			printf("password=%s\n", c.password);
> +	}

I am tempted to suggest that this actually output the _whole_
credential, not just the username and password. Coupled with the above
behavior, you would get:

  $ git credential fill https://example.com/foo.git
  protocol=https
  host=example.com
  path=foo.git
  username=bob
  password=secr3t

which happens to be exactly what you want to feed back to the "approve"
and "reject" actions (and it is not really any harder to parse).

We _could_ get by with allowing:

  git credential --stdin approve https://example.com/foo.git <<\EOF
  username=bob
  password=secr3t
  EOF

and having it combine the URL on the command-line with the entries on
stdin (and indeed, I think that is the only sane thing to do when
--stdin and a URL are both given).

But that implies that there will never be any extra attributes that are
relevant to the approve/reject that are not in the URL (e.g., elsewhere
there has been talk about helpers being able to add arbitrary fields to
the descriptions in order to communicate with each other). So it may be
that we want to encourage callers to save the result of "fill" and feed
it back to "approve" or "reject" verbatim.

-Peff
