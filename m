From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement git commit as a builtin command.
Date: Thu, 01 Nov 2007 16:51:29 -0700
Message-ID: <7vr6j97ce6.fsf@gitster.siamese.dyndns.org>
References: <1193944163-22892-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 00:51:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InjpJ-0003ZV-8i
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 00:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbXKAXvk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Nov 2007 19:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbXKAXvj
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 19:51:39 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:42590 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbXKAXvj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2007 19:51:39 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 517752F9;
	Thu,  1 Nov 2007 19:51:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 96B1B91095;
	Thu,  1 Nov 2007 19:51:53 -0400 (EDT)
In-Reply-To: <1193944163-22892-1-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Thu, 1 Nov 2007 15:09:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63036>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> @@ -364,7 +365,6 @@ BUILTIN_OBJS =3D \
>  	builtin-rev-parse.o \
>  	builtin-revert.o \
>  	builtin-rm.o \
> -	builtin-runstatus.o \
>  	builtin-shortlog.o \
>  	builtin-show-branch.o \
>  	builtin-stripspace.o \

I did not read in the commit log that runstatus is gone...

> diff --git a/builtin-commit.c b/builtin-commit.c
> new file mode 100644
> index 0000000..56c7427
> --- /dev/null
> +++ b/builtin-commit.c
> @@ -0,0 +1,608 @@
> +/*
> + * Builtin "git commit"
> + *
> + * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
> + * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
> + */
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +#include "cache.h"


The system header files on some systems have a nasty habit of
changing the behaviour depending on the order they are included.
Since 85023577a8f4b540aa64aa37f6f44578c0c305a3 (simplify
inclusion of system header files) in late 2006, we have a few
rules for system-header inclusion to avoid the portability
issues:

 (1) sources under compat/, platform sha-1 implementations, and
     xdelta code are exempt from the following rules;

 (2) the first #include must be "git-compat-util.h" or one of
     our own header file that includes it first (e.g. config.h,
     builtin.h, pkt-line.h);

 (3) system headers that are included in "git-compat-util.h"
     need not be included in individual C source files.

 (4) "git-compat-util.h" does not have to include subsystem
     specific header files (e.g. expat.h).

> +static void determine_author_info(struct strbuf *sb)
> +{
> +	char *p, *eol;
> +	char *name =3D NULL, *email =3D NULL;
> +
> +	if (use_message) {
> +		p =3D strstr(use_message_buffer, "\nauthor");
> +		if (!p)
> +			die("invalid commit: %s\n", use_message);
> +		p++;
> +		eol =3D strchr(p, '\n');
> +		if (!eol)
> +			die("invalid commit: %s\n", use_message);
> +
> +		strbuf_add(sb, p, eol + 1 - p);
> +	} else if (force_author) {
> +		const char *eoname =3D strstr(force_author, " <");
> +		const char *eomail =3D strchr(force_author, '>');

Doesn't this break:

    $ git commit --amend --author=3D'A U Thor <author@example.com>'

to fix a misattribution?

> +static int parse_and_validate_options(int argc, const char *argv[])
> +{
> ...
> +	if (use_message) {
> +		unsigned char sha1[20];
> +		static char utf8[] =3D "UTF-8";
> +		const char *out_enc;
> +		char *enc, *end;
> +		struct commit *commit;
> +
> +		if (get_sha1(use_message, sha1))
> +			die("could not lookup commit %s", use_message);
> +		commit =3D lookup_commit(sha1);
> +		if (!commit || parse_commit(commit))
> +			die("could not parse commit %s", use_message);
> +
> +		enc =3D strstr(commit->buffer, "\nencoding");
> +		if (enc) {
> +			end =3D strchr(enc + 10, '\n');
> +			enc =3D xstrndup(enc + 10, end - (enc + 10));
> +		} else {
> +			enc =3D utf8;
> +		}
> +		out_enc =3D git_commit_encoding ? git_commit_encoding : utf8;
> +
> +		use_message_buffer =3D
> +			reencode_string(commit->buffer, out_enc, enc);
> +		if (enc !=3D utf8)
> +			free(enc);

A few issues.

 * When use_message is set because of --amend that wanted to
   amend a commit message that was recorded in a corrupt
   encoding, and iconv() in reencode_string() fails, saying "I
   cannot convert that completely", most of the message can
   still be salvageable.  This part should allow looser
   reencoding if the message will be eyeballed and edited by the
   user.

 * We would want to avoid reencoding when !strcmp(out_enc, enc).
   Both builtin-mailinfo.c and commit.c skip the call to the
   function at the calling site, but it might make sense to
   teach reencode_string() about such an optimization.
