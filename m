From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH] WIP: begin to translate git with gettext
Date: Tue, 18 May 2010 11:40:02 -0500
Message-ID: <20100518164002.GC20842@unpythonic.net>
References: <20100517160503.GA12717@unpythonic.net> <4BF24467.7000204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	Thomas Rast <trast@student.ethz.ch>,
	Marc Weber <marco-oweber@gmx.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 18 18:40:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEPq2-0005NR-8k
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 18:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723Ab0ERQkG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 May 2010 12:40:06 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:48915 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751529Ab0ERQkF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 12:40:05 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 6399911469D; Tue, 18 May 2010 11:40:02 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <4BF24467.7000204@drmicha.warpmail.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147288>

On Tue, May 18, 2010 at 09:40:23AM +0200, Michael J Gruber wrote:
> > -		color_fprintf(s->fp, c, "unmerged:   %s", one);
> > +		color_fprintf(s->fp, c, _("unmerged:   %s"), one);
>=20
> I have no experience whatsover with gettext, but it looks quite
> dangerous to me to have printf format specifiers as part of the
> localized text. It means that our programs can crash depending on the
> LANG setting at run time if localisers mess up. We'll never catch thi=
s
> unless we run all tests in all languages!

This is exactly how gettext works.  Yes, you can get crashes if the
translated string does not have the right arguments--and I would not be
at all surprised to hear of at least one privilege escalation bug
due to a bad message catalog, since printf format errors can be used in
such interesting ways.

Anyway, for printf-style formats, 'msgfmt' can be directed to check for
this situation:
    $ cat bad.po
    msgid ""
    msgstr "Content-Type: text/plain; charset=3DUTF-8\n"

    #,c-format
    msgid "foo %s %d"
    msgstr "f=F6=F6 %d %d"

    $ msgfmt --check-format bad.po
    bad.po:6: format specifications in 'msgid' and 'msgstr' for argumen=
t 1 are not the same
    msgfmt: found 1 fatal error
=20
> Also, the basic structure of the output should probably be independen=
t
> of the language, preferring consistent structure across languages ove=
r
> linguistically consistent structure  within a language.

No, the ability of gettext+printf to use the right structure of the
user's language is a strength.  For instance, consider the translation
into Yoda's locale of the following sentence:

    printf("The %s is %s.\n", "Future", "Clouded");

The proper localized message is

    Clouded the Future is.

Anything else will range from confusing to unintelligible to the
native speaker.  You get that with gettext by writing

    printf(_("The %s is %s.\n"), _("Future"), _("Clouded"));

together with the message catalog entry
    msgid "The %s is %s.\n"
    msgfmt "%2$s the %1$s is.\n"

> >  	if (extra.len) {
> > -		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "%s", extra.buf=
);
> > +		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), _("%s"), extra.=
buf);
>=20
> Seriously?

No, that one's a mistake.  I did not take care when choosing which
strings to mark, because I was mostly interested in showing a
proof-of-concept for using gettext to translate core parts of git.

The amount of work to mark all the source files and then to keep the
marks up to date should not be underestimated--and that's just the work
to enable translators to localize the software.  It is important to
gauge the interest in the git community in actually doing this work.

As my own primary language is English, I have only a theoretical
interest in this feature.  However, the existence of translations for
gitk and git-gui indicates to me that the community probably does desir=
e
this.

Jeff
