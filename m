From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Implement git commit as a builtin command.
Date: Fri, 02 Nov 2007 11:31:01 -0400
Message-ID: <1194017461.25288.13.camel@hinata.boston.redhat.com>
References: <1193944163-22892-1-git-send-email-krh@redhat.com>
	 <7vr6j97ce6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:31:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InyUn-0002RN-Tz
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbXKBPb1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 11:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbXKBPb1
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:31:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56932 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270AbXKBPb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:31:26 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA2FV82K006984;
	Fri, 2 Nov 2007 11:31:08 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA2FV79Z017705;
	Fri, 2 Nov 2007 11:31:07 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA2FV6NA026486;
	Fri, 2 Nov 2007 11:31:06 -0400
In-Reply-To: <7vr6j97ce6.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63131>

On Thu, 2007-11-01 at 16:51 -0700, Junio C Hamano wrote:

Hi Junio,

Thanks for the review (again).  I've split the patch up in a couple of
test suite patches (a patch to accept ':' as a no-op editor, fixing
hard-coding of editor, and a test case for the commit --amend --author
case), exporting launch_editor() and a reworked version of the commit
patch that addresses your comments.

> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > @@ -364,7 +365,6 @@ BUILTIN_OBJS =3D \
> >  	builtin-rev-parse.o \
> >  	builtin-revert.o \
> >  	builtin-rm.o \
> > -	builtin-runstatus.o \
> >  	builtin-shortlog.o \
> >  	builtin-show-branch.o \
> >  	builtin-stripspace.o \
>=20
> I did not read in the commit log that runstatus is gone...

True, that should be documented.  Added in the following patch.

> > diff --git a/builtin-commit.c b/builtin-commit.c
> > new file mode 100644
> > index 0000000..56c7427
> > --- /dev/null
> > +++ b/builtin-commit.c
> > @@ -0,0 +1,608 @@
> > +/*
> > + * Builtin "git commit"
> > + *
> > + * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
> > + * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
> > + */
> > +
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <unistd.h>
> > +
> > +#include "cache.h"
>=20
>=20
> The system header files on some systems have a nasty habit of
> changing the behaviour depending on the order they are included.
> Since 85023577a8f4b540aa64aa37f6f44578c0c305a3 (simplify
> inclusion of system header files) in late 2006, we have a few
> rules for system-header inclusion to avoid the portability
> issues:
>=20
>  (1) sources under compat/, platform sha-1 implementations, and
>      xdelta code are exempt from the following rules;
>=20
>  (2) the first #include must be "git-compat-util.h" or one of
>      our own header file that includes it first (e.g. config.h,
>      builtin.h, pkt-line.h);
>=20
>  (3) system headers that are included in "git-compat-util.h"
>      need not be included in individual C source files.
>=20
>  (4) "git-compat-util.h" does not have to include subsystem
>      specific header files (e.g. expat.h).

Ah, yes, this has been pointed out to me before, sorry.  Patch updated.

> > +static void determine_author_info(struct strbuf *sb)
> > +{
> > +	char *p, *eol;
> > +	char *name =3D NULL, *email =3D NULL;
> > +
> > +	if (use_message) {
> > +		p =3D strstr(use_message_buffer, "\nauthor");
> > +		if (!p)
> > +			die("invalid commit: %s\n", use_message);
> > +		p++;
> > +		eol =3D strchr(p, '\n');
> > +		if (!eol)
> > +			die("invalid commit: %s\n", use_message);
> > +
> > +		strbuf_add(sb, p, eol + 1 - p);
> > +	} else if (force_author) {
> > +		const char *eoname =3D strstr(force_author, " <");
> > +		const char *eomail =3D strchr(force_author, '>');
>=20
> Doesn't this break:
>=20
>     $ git commit --amend --author=3D'A U Thor <author@example.com>'
>=20
> to fix a misattribution?

Dang, good catch.  I've fixed it by swapping the (use_message) and
(force_author) clauses and the new patch adds a test case for this.

> > +static int parse_and_validate_options(int argc, const char *argv[]=
)
> > +{
> > ...
> > +	if (use_message) {
> > +		unsigned char sha1[20];
> > +		static char utf8[] =3D "UTF-8";
> > +		const char *out_enc;
> > +		char *enc, *end;
> > +		struct commit *commit;
> > +
> > +		if (get_sha1(use_message, sha1))
> > +			die("could not lookup commit %s", use_message);
> > +		commit =3D lookup_commit(sha1);
> > +		if (!commit || parse_commit(commit))
> > +			die("could not parse commit %s", use_message);
> > +
> > +		enc =3D strstr(commit->buffer, "\nencoding");
> > +		if (enc) {
> > +			end =3D strchr(enc + 10, '\n');
> > +			enc =3D xstrndup(enc + 10, end - (enc + 10));
> > +		} else {
> > +			enc =3D utf8;
> > +		}
> > +		out_enc =3D git_commit_encoding ? git_commit_encoding : utf8;
> > +
> > +		use_message_buffer =3D
> > +			reencode_string(commit->buffer, out_enc, enc);
> > +		if (enc !=3D utf8)
> > +			free(enc);
>=20
> A few issues.
>=20
>  * When use_message is set because of --amend that wanted to
>    amend a commit message that was recorded in a corrupt
>    encoding, and iconv() in reencode_string() fails, saying "I
>    cannot convert that completely", most of the message can
>    still be salvageable.  This part should allow looser
>    reencoding if the message will be eyeballed and edited by the
>    user.

So in this case we just want to copy the old message byte for byte,
right?  That's what I have in the updated patch.

>  * We would want to avoid reencoding when !strcmp(out_enc, enc).
>    Both builtin-mailinfo.c and commit.c skip the call to the
>    function at the calling site, but it might make sense to
>    teach reencode_string() about such an optimization.

Right.  I just added the call-site optimization for builtin-commit for
now, but I would expect iconv() to be smart in case input and output
encodings are the same.

cheers,
Kristian
