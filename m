From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] grep: add option -p/--show-function
Date: Wed, 01 Jul 2009 19:35:34 -0700
Message-ID: <7vbpo3errd.fsf@alter.siamese.dyndns.org>
References: <4A4BDC65.80504@lsrfire.ath.cx> <4A4BDDEA.3030005@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jul 02 04:35:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMC9P-0001Mh-SO
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 04:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbZGBCfd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jul 2009 22:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbZGBCfc
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 22:35:32 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52251 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbZGBCfc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 22:35:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090702023534.XETS20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Jul 2009 22:35:34 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id Aqba1c00D4aMwMQ04qbaoP; Wed, 01 Jul 2009 22:35:35 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=hgzHMRyroUkA:10 a=Y7lF8q3RYwyWbttx1m8A:9
 a=tFQmKaye991rhwlEHrGKmPpk-mEA:4
X-CM-Score: 0.00
In-Reply-To: <4A4BDDEA.3030005@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Thu\, 02 Jul 2009 00\:06\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122616>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The new option -p instructs git grep to print the previous function
> definition as a context line, similar to diff -p.  Such context lines
> are marked with an equal sign instead of a dash.  This option
> complements the existing context options -A, -B, -C.

I have to say that I am a bit confused with these '=3D=3D' markers.

    $ ./git-grep -p -n -e pre_context -- '*.c'
    builtin-grep.c=3D238=3Dstatic int flush_grep(struct grep_opt *opt,
    builtin-grep.c:288:	if (opt->pre_context || opt->post_context ||...
    =3D=3D
    builtin-grep.c=3D328=3Dstatic int external_grep(struct grep_opt *op=
t, co...
    builtin-grep.c:363:	if (opt->post_context || opt->pre_context) {
    builtin-grep.c:364:		if (opt->post_context !=3D opt->pre_co...
    builtin-grep.c:365:			if (opt->pre_context) {
    builtin-grep.c:368:						"%u"...
    =3D=3D
    builtin-grep.c=3D586=3Dstatic int context_callback(const struct opt=
ion *...

Am I correct to say that '=3D=3D' tells us that it has been showing the=
 hits
in the previous function shown on the =3D$lineno=3D line, but now it wi=
ll show
hits from a different function?

When used with -[ABC], it gets even confusing.

    $ ./git-grep -C1 -p -n -e pre_context -- '*.c'
    builtin-grep.c=3D238=3Dstatic int flush_grep(struct grep_opt *opt,
    --
    builtin-grep.c-287-
    builtin-grep.c:288:	if (opt->pre_context || opt->post_context ||...
    builtin-grep.c-289-		/*
    =3D=3D
    builtin-grep.c=3D328=3Dstatic int external_grep(struct grep_opt *op=
t, co...
    --
    builtin-grep.c-362-		push_arg("-c");
    builtin-grep.c:363:	if (opt->post_context || opt->pre_context) {
    builtin-grep.c:364:		if (opt->post_context !=3D opt->pre_co...
    builtin-grep.c:365:			if (opt->pre_context) {
    builtin-grep.c-366-				push_arg("-B");
    builtin-grep.c-367-				len +=3D snprintf(argp...
    builtin-grep.c:368:						"%u"...
    builtin-grep.c-369-				if (sizeof(randarg) ...
    =3D=3D
    builtin-grep.c=3D586=3Dstatic int context_callback(const struct opt=
ion *...
    --

What do "--" lines tell us in these cases?  For example, does the first
one tells us that the -p output shown, which was from line 238, is outs=
ide
of the context of the hit it will show at line 288?

I am in no way complaining.  My eyes are just not yet used to the outpu=
t
format and are having hard time getting used to them and/or appreciatin=
g
how the separation these dividing lines give us is helpful.
