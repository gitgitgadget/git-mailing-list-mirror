From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] walk $PATH to generate list of commands for "help -a"
Date: Sat, 27 Oct 2007 23:18:02 -0700
Message-ID: <7vsl3vzrs5.fsf@gitster.siamese.dyndns.org>
References: <1193474215-6728-1-git-send-email-srp@srparish.net>
	<1193474215-6728-2-git-send-email-srp@srparish.net>
	<1193474215-6728-3-git-send-email-srp@srparish.net>
	<1193474215-6728-4-git-send-email-srp@srparish.net>
	<1193474215-6728-5-git-send-email-srp@srparish.net>
	<1193474215-6728-6-git-send-email-srp@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 07:18:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im1Tu-0003uU-S5
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 07:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbXJ1GSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 02:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbXJ1GSJ
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 02:18:09 -0400
Received: from rune.pobox.com ([208.210.124.79]:45685 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbXJ1GSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 02:18:08 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 0198A15149A;
	Sun, 28 Oct 2007 02:18:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3E820151499;
	Sun, 28 Oct 2007 02:18:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62524>

Scott R Parish <srp@srparish.net> writes:

> Git had previously been using the $PATH for scripts--a previous
> patch moved exec'ed commands to also use the $PATH. For consistancy
> "help -a" should also use the $PATH.

s/consistancy/consistency/

> We walk all the paths in $PATH collecting the names of "git-*"
> commands. To help distinguish between the main git commands
> and commands picked up elsewhere (probably extensions) we
> print them seperately. The main commands are the ones that
> are found in the first directory in $PATH that contains the
> "git" binary.

This is not right.  $(gitexecdir) in Makefile is designed to
allow distros to move git-* commands out of the primary user
$PATH directories and install only "git" wrapper in /usr/bin.
"Use the directory 'git' is in" rule breaks this.

The "main commands" should be the first of argv_exec_path,
EXEC_PATH_ENVIRONMENT or builtin_exec_path.

> diff --git a/help.c b/help.c
> index ce3d795..ee4fce0 100644
> --- a/help.c
> +++ b/help.c
> @@ -64,7 +69,42 @@ static int cmdname_compare(const void *a_, const void *b_)
> ...
> +static void subtract_cmds(struct cmdnames *a, struct cmdnames *b) {
> +	int ai, aj, bi;
> +
> +	ai = aj = bi = 0;
> +	while (ai < a->cnt && bi < b->cnt) {
> +		if (0 > strcmp(a->names[ai]->name, b->names[bi]->name))
> +			a->names[aj++] = a->names[ai++];
> +		else if (0 > strcmp(a->names[ai]->name, b->names[bi]->name))
> +			bi++;
> +		else
> +			ai++, bi++;

In general, xxxcmp(a, b) is designed to return the same sign as
"a - b" (subtract b from a, using an appropriate definition of
"subtract" in the domain of a and b).  It is a good habit to
write:

	strcmp(a, b) < 0	strcmp(a, b) > 0

because these give the same sign as

	a < b			a > b

and makes your program easier to read.

> @@ -122,18 +168,66 @@ static void list_commands(const char *exec_path)
>  		if (has_extension(de->d_name, ".exe"))
>  			entlen -= 4;
>  
> +		if (has_extension(de->d_name, ".perl") ||
> +		    has_extension(de->d_name, ".sh"))
> +			continue;
> +

This needs a good justification.

If you have "." on PATH, and you run ./git in a freshly built
source directory, "git relink.perl" would try to run
./git-relink.perl.

I do not think excluding these is necessary nor is a good idea.

> +static void list_commands()
> +{

ANSI.  "static void list_commands(void)".

> +	path = paths = xstrdup(env_path);
> +	while ((char *)1 != path) {
> +		if ((colon = strchr(path, ':')))
> +			*colon = 0;
> +
> +		len = list_commands_in_dir(path);
> +		longest = MAX(longest, len);
> +
> +		path = colon + 1;
> +	}

I know that on modern architectures bit representation of
(char*) NULL is the same as integer 0 of the same size as a
pointer, and adding 1 to it would yield (char *)1, but the above
feels _dirty_.

	while (1) {
        	...
                if (!colon)
	                break;
		path = colon + 1;
	}
