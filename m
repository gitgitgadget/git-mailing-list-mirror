From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] added possibility to supply more than one --listen
 argument to git-daemon
Date: Mon, 23 Aug 2010 12:56:06 -0700
Message-ID: <7v4oel14tl.fsf@alter.siamese.dyndns.org>
References: <1282582475-3545-1-git-send-email-alexander@sulfrian.net>
 <1282582475-3545-2-git-send-email-alexander@sulfrian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Sulfrian <alexander@sulfrian.net>
X-From: git-owner@vger.kernel.org Mon Aug 23 21:56:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ond86-0002hy-U2
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 21:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554Ab0HWT4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 15:56:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400Ab0HWT4P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 15:56:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D854CF1F8;
	Mon, 23 Aug 2010 15:56:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VhgSQ8ohEn7S7G5stGgdHlawDD0=; b=xZYZro
	CG33LapS0vnnNphElrtmPFjD8A7Bo4yMwTY3vPdQy7sNghkHuuad6z7h1bDPBho1
	qNsXp9KCnfcCCPJPIIVxPr/pRPd0PC66iyIvwD5H7fm+uWPntqnuxCNfdjbKKQTa
	I2cBzZe2F2bnHY6eIZCbRAlrPp8Q5NNK25H74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=stNiqc4cyUWhJQ6v8rsiw7qers7Jmb08
	6vSe/1iT9f8ZYU/c8bX7OUAmP90d/0vQK+S3MSopxSEQU+llBRqSv3hbq7iNUR/T
	zc8xUoSgUHIgABCCminRDb2Oxj0ai23dMpmBdP+q7k8k0/9rgWQdygDqlH4ymkqf
	QIHznRZdjDw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A1ECCF1F0;
	Mon, 23 Aug 2010 15:56:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DE2DCF1E9; Mon, 23 Aug
 2010 15:56:08 -0400 (EDT)
In-Reply-To: <1282582475-3545-2-git-send-email-alexander@sulfrian.net>
 (Alexander Sulfrian's message of "Mon\, 23 Aug 2010 18\:54\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7A5DCDAC-AEF0-11DF-B656-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154248>

Alexander Sulfrian <alexander@sulfrian.net> writes:

> --listen arguments are gathered in a string_list
> serve and socksetup get listen_addr as string_list
> socketsetup creates a listen socket for each host in that string_list
>
> Signed-off-by: Alexander Sulfrian <alexander@sulfrian.net>
> ---

Thanks for a resend/reminder.  I've been meaning to look at this patch
after somebody who actually runs the daemon commented on it.

A few administravia:

 - Please begin the subject line with affected-area and a colon;

 - Please place more stress on what problem the patch tries to solve and
   less on how the patch solves it, because the latter can be read from
   the patch text itself, when writing a proposed log message;

 - We tend to write the log message in imperative mood, to order either the
   person who applies the patch or the codebase what new things to do.

 - We need to also update the documentation (e.g. just add "Can be given
   more than one times" before "Incompatible with '--inetd' option." in
   Documentation/git-daemon.txt).

So...

    Subject: [PATCH] daemon: allow more than one host addresses given via --listen

    When the host has more than one interfaces, daemon can listen to all
    of them by not giving any --listen option, or listen to only one.
    Teach it to accept more than one --listen options.

    Signed-off-by: ...

>  daemon.c |  183 ++++++++++++++++++++++++++++++++++++--------------------------
>  1 files changed, 107 insertions(+), 76 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index e22a2b7..f4492fe 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -3,6 +3,7 @@
>  #include "exec_cmd.h"
>  #include "run-command.h"
>  #include "strbuf.h"
> +#include "string-list.h"
>  
>  #include <syslog.h>
>  
> @@ -736,7 +737,7 @@ static int set_reuse_addr(int sockfd)
>  
>  #ifndef NO_IPV6
>  
> -static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
> +static int socksetup(struct string_list *listen_addr, int listen_port, int **socklist_p)
>  {
>  	int socknum = 0, *socklist = NULL;
>  	int maxfd = -1;
> @@ -744,6 +745,7 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
>  	struct addrinfo hints, *ai0, *ai;
>  	int gai;
>  	long flags;
> +	int i;
>  
>  	sprintf(pbuf, "%d", listen_port);
>  	memset(&hints, 0, sizeof(hints));
> @@ -752,57 +754,69 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
>  	hints.ai_protocol = IPPROTO_TCP;
>  	hints.ai_flags = AI_PASSIVE;
>  
> -	gai = getaddrinfo(listen_addr, pbuf, &hints, &ai0);
> -	if (gai)
> -		die("getaddrinfo() failed: %s", gai_strerror(gai));
> +	i = 0;
> +	do {
> +		if (listen_addr->nr > 0) {
> +			gai = getaddrinfo(listen_addr->items[i].string, pbuf,
> +					  &hints, &ai0);
> +		}
> +		else {
> +			gai = getaddrinfo(NULL, pbuf, &hints, &ai0);
> +		}

Style: neither of these if/else body need braces around it.

But more importantly, wouldn't it make the patch and the result easier to
read if you split the part of the code that now is one iteration of the
loop over listen_addr list into a separate helper function?

Then socksetup would look something like:

        static int socksetup(...)
        {
		...
		if (!listen_addr_list->nr)
		    	setup_named_sock(NULL, listen_port, socklist_p);
		else {
			int i;
			for (i = 0; i < listen_addr_list->nr; i++)
                        	setup_named_sock(listen_addr_list->items[i].string,
                                	listen_port, socklist_p);
                }
		...
    	}

If such a refactoring results in more readable code (I haven't tried doing
the refactoring myself, so I don't know if it is worth it), then I would
suggest making this into a two-patch series, one that creates the helper
function, and then another that adds multiple-listen support on top.

> @@ -946,14 +970,14 @@ static void store_pid(const char *path)
>  		die_errno("failed to write pid file '%s'", path);
>  }
>  
> -static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
> +static int serve(struct string_list *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
>  {
>  	int socknum, *socklist;
>  
>  	socknum = socksetup(listen_addr, listen_port, &socklist);
>  	if (socknum == 0)
> -		die("unable to allocate any listen sockets on host %s port %u",
> -		    listen_addr, listen_port);
> +		die("unable to allocate any listen sockets on port %u",
> +		    listen_port);

Here we are losing "host" information; does it matter?

Earlier socksetup() died only when getaddrinfo died, as in that case we
know there won't be any socket prepared.  You removed that die (which is
sensible---as you may have one unavailable and another available interface
and dying only when there is no socket listening has been the design of
the program, and you are not changing that with this patch).

Also I have to wonder what would have happened in the original code if
there were no --listen given (presumably we got NULL in the argument in
that case).

My gut feeling is that this change is Ok, as this die() would trigger only
when no interface out of either all interface or the ones specified on the
command line with --listen options, can be listened to at the port, either
given by --listen_port option or the default 9418; and the user does know
which "host" was asked anyway.  But the change needs to be mentioned in
the proposed log message.

It might be an improvement if we reported addresses that cannot be
listened to (you can use listen_addr_list->items[i].util for that--- when
setup_named_sock() helper finds that no new socket was added by the loop
over the list resulting from getaddrinfo, it can mark the item's util
field, and then instead of dying the caller of socksetup() can warn on
such names.  If we were to do so, however, that should be done as a
separate patch on top of this change.

> @@ -966,14 +990,17 @@ static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t
>  int main(int argc, char **argv)
>  {
>  	int listen_port = 0;
> -	char *listen_addr = NULL;
>  	int inetd_mode = 0;
> +	struct string_list listen_addr;
>  	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
>  	int detach = 0;
>  	struct passwd *pass = NULL;
>  	struct group *group;
>  	gid_t gid = 0;
>  	int i;
> +	int return_value;
> +
> +	memset(&listen_addr, 0, sizeof(struct string_list));

Don't we have STRING_LIST_INIT macro these days?

I also have to wonder if we eventually want to take --listen=host:port so
that you can listen only to two interfaces out of three avaiable on your
host, but on different ports.  Again, if we were to do so, however, that
should be done as a separate patch on top of this change.

Thanks.
