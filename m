From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v3 4/8] gitweb: Extract print_sidebyside_diff_lines()
Date: Thu, 5 Apr 2012 08:06:33 +0200
Message-ID: <20120405080633.3836f49b@mkiedrowicz.ivo.pl>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1333569433-3245-5-git-send-email-michal.kiedrowicz@gmail.com>
	<7vsjgj6ufi.fsf@alter.siamese.dyndns.org>
	<201204050047.10357.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 08:06:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFfqR-00044p-Eg
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 08:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025Ab2DEGGr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 02:06:47 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:47052 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab2DEGGp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 02:06:45 -0400
Received: by wgbds11 with SMTP id ds11so1076296wgb.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 23:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=a1h9kvekn42L1IgiFWM1xehx0/EsRQn2Kjok7/8S9ec=;
        b=bLHTc7+LnNxRcIGwxE2YIzBcx9eKi6XwdnIOuIaVFRjY4soWsQ3WsZSE3CBfizHAyW
         q2+ewyTlNaQj7edHorPRG7qHaKNx6mRt+bCKsCrUsZ/Q2rBXEszEIcjZj2aofvQ5E4nq
         uD/5wdg17rAPPBQY+EUr9JmYGwdb1koVxm+SFDgxmNVIc/xs96JLZXGWwAlP1UGcRNJf
         aH7lVyl4OeRoatmAaJLTgrKMl/99lRt5y/t7VHRc4DfjtqC8K1nmsRBGeAAVJcT3ORwS
         W3LcrUsdiQ4yosyrwSkOhVDWlVVDkwbtRt6XJsEEQ7FPSFcRZVeHf9nlpkKT0zxWsm1Q
         WQZg==
Received: by 10.180.101.8 with SMTP id fc8mr1668770wib.12.1333606004521;
        Wed, 04 Apr 2012 23:06:44 -0700 (PDT)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id ff9sm10890539wib.2.2012.04.04.23.06.43
        (version=SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 23:06:43 -0700 (PDT)
In-Reply-To: <201204050047.10357.jnareb@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194761>

Jakub Narebski <jnareb@gmail.com> wrote:

> Junio C Hamano wrote:
> > Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
> >=20
> > > +	if (!@$add) {
> > > +		# pure removal
> > > +...
> > > +	} elsif (!@$rem) {
> > > +		# pure addition
> > > +...
> > > +	} else {
> > > +		# assume that it is change
> > > +		print join '',
> >=20
> > I know this is not a new problem, but if your patch hunk has both
> > '-' and '+' lines, what's there to "assume" that it is a change?
> > Isn't it always?
>=20
> What I meant here when I was writing it that they are lines that
> changed between two versions, like '!' in original (not unified)
> context format.
>=20
> We can omit this comment.

OK.

>=20
> > > -		# empty add/rem block on start context block, or
> > > end of chunk
> > > -		if ((@rem || @add) && (!$class || $class eq
> > > 'ctx')) { -...
> > > +		## print from accumulator when have some add/rem
> > > lines or end
> > > +		# of chunk (flush context lines)
> > > +		if (((@rem || @add) && $class eq 'ctx')
> > > || !$class) {
> >=20
> > This seems to change the condition.  Earlier, it held true if
> > (there is anything to show), and (class is unset or equal to ctx).
> > The new code says something different.
>=20
> Yes it does, as described in the commit message:
>=20
>                                                     [...] It should
>   not change the gitweb output, but it **slightly changes its
> behavior**. Before this commit, context is printed on the class
> change. Now,  it's printed just before printing added and removed
> lines, and at the end of chunk.
>=20
> The difference is that context lines are also printed accumulated now=
=2E
> Though why this change is required for refactoring could have been
> described in more detail...

I changed that because I wanted to squash both conditions (the one that
checks if @ctx should be printed and the one that prints @add/@rem
lines) and have just one call to print_sidebyside_diff_lines().  Later,
this function is changed to print_diff_lines() and controls whether
'inline' or 'side-by-side' diff should be printed.  Having two
conditions and two calls/functions would make the code redundant.  Then
I thought that instead of calling twice print_sidebyside_diff_lines()
(for @ctx and @add/@rem lines, like the code from pre-image prints
these lines separatedly), I can just call it once.

I can revert this change to previous behavior but I think that would
make the condition more complicated.

>=20
> >                             Also can $class be undef, and if so,
> > doesn't it trigger comparison between undef and 'ctx' by
> > having !$class check at the end of || chain?
>=20
> Thanks for noticing this (I wonder why testsuite didn't caught it).
> It should be
>=20
>  +		## print from accumulator when have some add/rem
> lines or end
>  +		# of chunk (flush context lines)
>  +		if (!$class || ((@rem || @add) && $class eq 'ctx'))
> {
>=20

OK, I'll fix that.
