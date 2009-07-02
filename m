From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 5/6] grep: add option -p/--show-function
Date: Thu, 02 Jul 2009 06:38:43 +0200
Message-ID: <4A4C39D3.1020401@lsrfire.ath.cx>
References: <4A4BDC65.80504@lsrfire.ath.cx> <4A4BDDEA.3030005@lsrfire.ath.cx> <7vbpo3errd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 06:38:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MME4V-0004r6-0s
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 06:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbZGBEin convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 00:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbZGBEim
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 00:38:42 -0400
Received: from india601.server4you.de ([85.25.151.105]:60104 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbZGBEil (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 00:38:41 -0400
Received: from [10.0.1.101] (p57B7FA76.dip.t-dialin.net [87.183.250.118])
	by india601.server4you.de (Postfix) with ESMTPSA id 4588D2F8068;
	Thu,  2 Jul 2009 06:38:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <7vbpo3errd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122618>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> The new option -p instructs git grep to print the previous function
>> definition as a context line, similar to diff -p.  Such context line=
s
>> are marked with an equal sign instead of a dash.  This option
>> complements the existing context options -A, -B, -C.
>=20
> I have to say that I am a bit confused with these '=3D=3D' markers.

You may be glad to hear that initial versions of this patch followed
even stranger rules for showing these markers. ;-)

>     $ ./git-grep -p -n -e pre_context -- '*.c'
>     builtin-grep.c=3D238=3Dstatic int flush_grep(struct grep_opt *opt=
,
>     builtin-grep.c:288:	if (opt->pre_context || opt->post_context ||.=
=2E.
>     =3D=3D
>     builtin-grep.c=3D328=3Dstatic int external_grep(struct grep_opt *=
opt, co...
>     builtin-grep.c:363:	if (opt->post_context || opt->pre_context) {
>     builtin-grep.c:364:		if (opt->post_context !=3D opt->pre_co...
>     builtin-grep.c:365:			if (opt->pre_context) {
>     builtin-grep.c:368:						"%u"...
>     =3D=3D
>     builtin-grep.c=3D586=3Dstatic int context_callback(const struct o=
ption *...
>=20
> Am I correct to say that '=3D=3D' tells us that it has been showing t=
he hits
> in the previous function shown on the =3D$lineno=3D line, but now it =
will show
> hits from a different function?

With -p, the previous function of a hit is marked with an "=3D" (or
"=3D$lineno=3D" with -n).  "=3D=3D" is printed immediately before such =
a line,
to separate it from other functions, yes.

"--" could be printed between lines 238 and 288, between lines 328 and
363 (after the function lines), and between lines 365 and 368, but that
would bloat the output for no gain, IMHO.  It would mean "here we've
skipped over a few lines", which is correct, but it's also common and
expected.  So I left out print of "--" markers completely if -p is used
without -[ABC].

> When used with -[ABC], it gets even confusing.
>=20
>     $ ./git-grep -C1 -p -n -e pre_context -- '*.c'
>     builtin-grep.c=3D238=3Dstatic int flush_grep(struct grep_opt *opt=
,
>     --
>     builtin-grep.c-287-
>     builtin-grep.c:288:	if (opt->pre_context || opt->post_context ||.=
=2E.
>     builtin-grep.c-289-		/*
>     =3D=3D
>     builtin-grep.c=3D328=3Dstatic int external_grep(struct grep_opt *=
opt, co...
>     --
>     builtin-grep.c-362-		push_arg("-c");
>     builtin-grep.c:363:	if (opt->post_context || opt->pre_context) {
>     builtin-grep.c:364:		if (opt->post_context !=3D opt->pre_co...
>     builtin-grep.c:365:			if (opt->pre_context) {
>     builtin-grep.c-366-				push_arg("-B");
>     builtin-grep.c-367-				len +=3D snprintf(argp...
>     builtin-grep.c:368:						"%u"...
>     builtin-grep.c-369-				if (sizeof(randarg) ...
>     =3D=3D
>     builtin-grep.c=3D586=3Dstatic int context_callback(const struct o=
ption *...
>     --
>=20
> What do "--" lines tell us in these cases?  For example, does the fir=
st
> one tells us that the -p output shown, which was from line 238, is ou=
tside
> of the context of the hit it will show at line 288?
>
> I am in no way complaining.  My eyes are just not yet used to the out=
put
> format and are having hard time getting used to them and/or appreciat=
ing
> how the separation these dividing lines give us is helpful.

Here's another example, which is potentially even more confusing:

	$ git grep -p -n markers grep.c
	grep.c=3D748=3Dstatic void clr_hit_marker(struct grep_expr *x)
	grep.c:750:	/* All-hit markers are meaningful only at...
	=3D=3D
	grep.c=3D762=3Dstatic int chk_hit_marker(struct grep_expr *x)
	grep.c:764:	/* Top level nodes have hit markers.  See...
	=3D=3D
	grep.c=3D774=3Dint grep_buffer(struct grep_opt *opt, const ch...
	grep.c:784:	 * We first clear hit markers from them.


	$ git grep -p -n -B3 markers grep.c
	grep.c-747-
	grep.c=3D748=3Dstatic void clr_hit_marker(struct grep_expr *x)
	grep.c-749-{
	grep.c:750:	/* All-hit markers are meaningful only at...
	--
	grep.c-761-
	grep.c=3D762=3Dstatic int chk_hit_marker(struct grep_expr *x)
	grep.c-763-{
	grep.c:764:	/* Top level nodes have hit markers.  See...
	=3D=3D
	grep.c=3D774=3Dint grep_buffer(struct grep_opt *opt, const ch...
	--
	grep.c-781-		return grep_buffer_1(opt, name, b...
	grep.c-782-
	grep.c-783-	/* Otherwise the toplevel "or" terms hit ...
	grep.c:784:	 * We first clear hit markers from them.

The "=3D=3D" after line 750 is changed to a "--" with -B3 or more.


I'm not so sure about the usefulness of these markers myself, but the
rules to generate them are quite simple.  The "=3D=3D" markers exist on=
ly
because I wanted the output of -p alone to be as compact as possible,
but without changing the meaning of the "--" markers.

So the meaning of the "--" markers is the same as before: "lines have
been skipped".  "=3D=3D" means the same, but also "the next line is a
function line".  And -p alone only shows these specialized markers, for
brevity.

Hmm, even shorter would be to leave out these "=3D=3D" things entirely:

	# mock-up
	$ git grep -p -n markers grep.c
	grep.c=3D746=3Dstatic void clr_hit_marker(struct grep_expr *x)
	grep.c:748:     /* All-hit markers are meaningful only at...
	grep.c=3D760=3Dstatic int chk_hit_marker(struct grep_expr *x)
	grep.c:762:     /* Top level nodes have hit markers.  See...
	grep.c=3D772=3Dint grep_buffer(struct grep_opt *opt, const ch...
	grep.c:782:      * We first clear hit markers from them.

Is that still readable?
