From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/v3] bundle.c: added --stdin option to git-bundle
Date: Sat, 05 Jul 2008 11:15:06 -0700
Message-ID: <7vod5crydx.fsf@gitster.siamese.dyndns.org>
References: <c376da900807050930i6d1da898s624be58adc6f1751@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Mark Levedahl" <mdl123@verizon.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Adam Brewster" <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 20:16:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFCJ4-00051F-PN
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 20:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbYGESPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 14:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbYGESPU
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 14:15:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbYGESPS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 14:15:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6D92322533;
	Sat,  5 Jul 2008 14:15:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7D9E722530; Sat,  5 Jul 2008 14:15:10 -0400 (EDT)
In-Reply-To: <c376da900807050930i6d1da898s624be58adc6f1751@mail.gmail.com>
 (Adam Brewster's message of "Sat, 5 Jul 2008 12:30:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5233D06C-4ABE-11DD-9D7A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87456>

"Adam Brewster" <adambrewster@gmail.com> writes:

> Subject: Re: [PATCH/v3] bundle.c: added --stdin option to git-bundle

When the change is not about implementation detail (in which case you do
want to name the source file and perhaps even a function name), but about
a new feature that is visible to the end-users of a command, we'd want the
message talk in terms of what the new feature does, not how the new
feature is invoked nor where it is implemented.  In other words, something
like these are preferred:

	git-bundle: add --stdin
        Teach git-bundle to read tips and basis from standard input

and don't say "You did" in past tense --- say things in imperative mood
instead, as if you are commanding the person who applies the patch to make
it happen.  Older log entries in our history (e.g. "git log -n 20 v0.99")
may give you a better feel.

And give a few lines of obvious justfication in the body of the commit log
message, e.g.

	This patch allows the caller to feed the revision parameters to
	git-bundle from its standard input.  This way, a script do not
	have to worry about limitation of the length of command line.

to explain why this is good.  In order to explain that you may have to
talk about other things (like what it does and how it does it), but keep
in mind that the primary thing you should talk about is _why_.

> ... because it already implies that this option is available.

If that is the case, please mention in the commit log message something
like "Even though the documentation said "bundle --stdin" is accepted it
didn't.  This patch teaches the option to the command".

But I do not think there is no such implication.  "bundle create" may take
list of positive and negative refs as arguments or --branches, but it does
not take (and it shouldn't -- I do not think it should take --bisect
option, for example) artibrary options that rev-list command accepts.

>  bundle.c |   22 ++++++++++++++++++++--
>  1 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index 0ba5df1..b44a4af 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -227,8 +227,26 @@ int create_bundle(struct bundle_header *header,
> const char *path,

Wrapped.

>         /* write references */
>         argc = setup_revisions(argc, argv, &revs, NULL);
> -       if (argc > 1)
> -               return error("unrecognized argument: %s'", argv[1]);
> +
> +       for (i = 1; i < argc; i++) {
> +               if ( !strcmp(argv[i], "--stdin") ) {

Style.

> +                       char line[1000];
> +                               while (fgets(line, sizeof(line),
> stdin) != NULL) {

Too deep indentation.  Wrapped.

> +                               int len = strlen(line);
> +                               if (len && line[len - 1] == '\n')
> +                                       line[--len] = '\0';
> +                               if (!len)
> +                                       break;
> +                               if (line[0] == '-')
> +                                       die("options not supported in
> --stdin mode");
> +                               if (handle_revision_arg(line, &revs, 0, 1))
> +                                       die("bad revision '%s'", line);
> +                       }
> +                       continue;
> +               }
> +
> +               return error("unrecognized argument: %s'", argv[i]);
> +       }

Having said that, I think copying and pasting read_revisions_from_stdin()
in bundle.c is a wrong approach to take.  Probably the function can easily
be split out of builtin-rev-list.c and moved to revision.c or somewhere
(which will be the first patch), and then a separate patch can add a few
lines to call it from bundle.c.
