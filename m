From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Remove various dead assignments and dead increments
 found  by the clang static analyzer
Date: Sat, 26 Sep 2009 16:46:04 -0400
Message-ID: <20090926204604.GA2960@coredump.intra.peff.net>
References: <87ab0hepcn.fsf@master.homenet>
 <alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>
 <871vltefdj.fsf@master.homenet>
 <fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
 <87ske9cya9.fsf@master.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Giuseppe Scrivano <gscrivano@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 22:48:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MreCC-0004ll-17
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 22:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbZIZUqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 16:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbZIZUqD
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 16:46:03 -0400
Received: from peff.net ([208.65.91.99]:52091 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbZIZUqD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 16:46:03 -0400
Received: (qmail 16908 invoked by uid 107); 26 Sep 2009 20:49:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 26 Sep 2009 16:49:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Sep 2009 16:46:04 -0400
Content-Disposition: inline
In-Reply-To: <87ske9cya9.fsf@master.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129178>

On Sat, Sep 26, 2009 at 09:15:58PM +0200, Giuseppe Scrivano wrote:

> Here is a cleaned patch.  I think these assignments can be removed
> without any problem.

I don't agree. For example:

> --- a/builtin-fetch--tool.c
> +++ b/builtin-fetch--tool.c
> @@ -169,7 +169,7 @@ static int append_fetch_head(FILE *fp,
>  			note_len += sprintf(note + note_len, "%s ", kind);
>  		note_len += sprintf(note + note_len, "'%s' of ", what);
>  	}
> -	note_len += sprintf(note + note_len, "%.*s", remote_len, remote);
> +	sprintf(note + note_len, "%.*s", remote_len, remote);

This is a very particular C idiom: you are building a string over
several statements using a function that adds to the string and tells
you how much it added. The implicit invariant of the note_len variable
is that it _always_ contains the current length, so each statement uses
it as input and pushes it forward on output.

Any experienced C programmer should look at that and be able to see
exactly what's going on. And people adding more lines don't need to
munge the existing lines; the invariant property of note_len means they
just need to add more, similar lines.

But your patch destroys that invariant. It makes it harder to see what's
going on, because it breaks the idiom. And it makes it more likely for
somebody adding a line further on to make a mistake (and certainly it
makes their patch harder to read and review, as they have to munge
unrelated lines).

So no, while there is no code _now_ that is relying on the invariant
being kept after the last statement (which is what the static analyzer
is finding out), the point is not for the compiler to realize that, but
for human programmers to see it.

So I think your version is less readable and maintainable. And it
doesn't even introduce any efficiency; any decent compiler should be
able to optimize out the addition.

> --- a/builtin-fetch-pack.c
> +++ b/builtin-fetch-pack.c
> @@ -555,7 +555,7 @@ static int get_pack(int xd[2], char **pack_lockfile)
>  	}
>  	if (*hdr_arg)
>  		*av++ = hdr_arg;
> -	*av++ = NULL;
> +	*av = NULL;

I would argue a similar same idiom exists here, though given that NULL
by definition is ending the av list it is somewhat less strong (i.e.,
there is already something to that statement that indicates that it
_must_ be the last one).

> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -2307,7 +2307,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	 */
>  
>  	if (!pack_to_stdout)
> -		base_name = argv[i++];
> +		base_name = argv[i];

And again here. Maintaining the invariant on 'i' is important to
readability and maintainability.

> --- a/builtin-receive-pack.c
> +++ b/builtin-receive-pack.c
> @@ -368,7 +368,7 @@ static char update_post_hook[] = "hooks/post-update";
>  static void run_update_post_hook(struct command *cmd)
>  {
>  	struct command *cmd_p;
> -	int argc, status;
> +	int argc;
>  	const char **argv;
>  
>  	for (argc = 0, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
> @@ -391,7 +391,7 @@ static void run_update_post_hook(struct command *cmd)
>  		argc++;
>  	}
>  	argv[argc] = NULL;
> -	status = run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
> +	run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
>  			| RUN_COMMAND_STDOUT_TO_STDERR);
>  }

Now this is one that I do think is sensible. The variable isn't used, so
don't even bother declaring it.

> @@ -506,7 +506,7 @@ static const char *unpack(void)
>  		if (receive_fsck_objects)
>  			unpacker[i++] = "--strict";
>  		unpacker[i++] = hdr_arg;
> -		unpacker[i++] = NULL;
> +		unpacker[i] = NULL;
>  		code = run_command_v_opt(unpacker, RUN_GIT_CMD);
>  		if (!code)
>  			return NULL;

Another invariant on 'i', though it has the NULL argument as above.

> @@ -528,7 +528,7 @@ static const char *unpack(void)
>  		keeper[i++] = "--fix-thin";
>  		keeper[i++] = hdr_arg;
>  		keeper[i++] = keep_arg;
> -		keeper[i++] = NULL;
> +		keeper[i] = NULL;
>  		memset(&ip, 0, sizeof(ip));
>  		ip.argv = keeper;
>  		ip.out = -1;

Ditto.

> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> index 37e528e..5afd542 100644
> --- a/builtin-send-pack.c
> +++ b/builtin-send-pack.c
> @@ -55,7 +55,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
>  	if (args->use_ofs_delta)
>  		argv[i++] = "--delta-base-offset";
>  	if (args->quiet)
> -		argv[i++] = "-q";
> +		argv[i] = "-q";
>  	memset(&po, 0, sizeof(po));
>  	po.argv = argv;
>  	po.in = -1;

Invariant on 'i'.

> diff --git a/builtin-show-branch.c b/builtin-show-branch.c
> index 3510a86..e567eb5 100644
> --- a/builtin-show-branch.c
> +++ b/builtin-show-branch.c
> @@ -191,9 +191,9 @@ static void name_commits(struct commit_list *list,
>  					break;
>  				}
>  				if (nth == 1)
> -					en += sprintf(en, "^");
> +					sprintf(en, "^");
>  				else
> -					en += sprintf(en, "^%d", nth);
> +					sprintf(en, "^%d", nth);

Building up string, invariant on 'en'.


And there are more examples of each. I'm not going to bother labeling
them all. But I really think any time you're removing an increment that
is meant to keep an invariant for future code, we should leave it as-is.

-Peff
