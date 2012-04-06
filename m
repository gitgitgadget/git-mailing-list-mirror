From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v3 4/8] gitweb: Extract print_sidebyside_diff_lines()
Date: Fri, 6 Apr 2012 10:36:03 +0200
Message-ID: <20120406103603.1f1ee90d@mkiedrowicz.ivo.pl>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
	<201204050047.10357.jnareb@gmail.com>
	<20120405080633.3836f49b@mkiedrowicz.ivo.pl>
	<201204060057.34138.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 10:36:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG4eh-0008EW-8j
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 10:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287Ab2DFIgW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 04:36:22 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35361 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab2DFIgV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 04:36:21 -0400
Received: by bkcik5 with SMTP id ik5so1989489bkc.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=HwyKsTTcgLKW0FRFWwAjSqZwmdmWnmWzdRoCwTSgzEk=;
        b=oG5xWU9HbPxGHws3b4zyr9ThaiiCwOZe1k+vyHWf58rrinKa50jwcADO6I65aicqZB
         Cg8btWJ67GXcR8HmpQawVK9PfxBleI5o0Y2yLQ+hj27NYN39StPjrwcxfNCk+H2TFXLB
         L7ULv1AxKA2yVnStPxinTMgexN0nMclNZxwPQt1UPzn7MnBMIrS1R8PXg25eCe2Qm+EX
         ESxRrTH3z4W7SPXJ4t70H+DG/3cbqCfFjuFnJ0FiRF8+1NCAtgKiA0rN+uk5+2lcy74Y
         lIoVTFL13z9jugvRPoXemoHVM11aDIHkMUk6Oxx0yurjZal5soFh4Sqfb4ejJwC7ks1z
         jWfw==
Received: by 10.204.128.201 with SMTP id l9mr2682193bks.90.1333701380249;
        Fri, 06 Apr 2012 01:36:20 -0700 (PDT)
Received: from mkiedrowicz.ivo.pl (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id iv11sm9039796bkc.16.2012.04.06.01.36.18
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Apr 2012 01:36:19 -0700 (PDT)
In-Reply-To: <201204060057.34138.jnareb@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194861>

Jakub Narebski <jnareb@gmail.com> wrote:

> Michal Kiedrowicz wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
> >> Junio C Hamano wrote:
> >>> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> >>>> -		# empty add/rem block on start context block, or
> >>>> end of chunk
> >>>> -		if ((@rem || @add) && (!$class || $class eq
> >>>> 'ctx')) { -...
> >>>> +		## print from accumulator when have some add/rem
> >>>> lines or end
> >>>> +		# of chunk (flush context lines)
> >>>> +		if (((@rem || @add) && $class eq 'ctx')
> >>>> || !$class) {
> >>>=20
> >>> This seems to change the condition.  Earlier, it held true if
> >>> (there is anything to show), and (class is unset or equal to ctx)=
=2E
> >>> The new code says something different.
> >>=20
> >> Yes it does, as described in the commit message:
> >>=20
> >>                                                     [...] It shoul=
d
> >>   not change the gitweb output, but it **slightly changes its
> >> behavior**. Before this commit, context is printed on the class
> >> change. Now,  it's printed just before printing added and removed
> >> lines, and at the end of chunk.
> >>=20
> >> The difference is that context lines are also printed accumulated
> >> now. Though why this change is required for refactoring could have
> >> been described in more detail...
> >=20
> > I changed that because I wanted to squash both conditions (the one
> > that checks if @ctx should be printed and the one that prints
> > @add/@rem lines) and have just one call to
> > print_sidebyside_diff_lines().  Later, this function is changed to
> > print_diff_lines() and controls whether 'inline' or 'side-by-side'
> > diff should be printed.  Having two conditions and two
> > calls/functions would make the code redundant.  Then I thought that
> > instead of calling twice print_sidebyside_diff_lines() (for @ctx
> > and @add/@rem lines, like the code from pre-image prints these
> > lines separatedly), I can just call it once.
> >=20
> > I can revert this change to previous behavior but I think that woul=
d
> > make the condition more complicated.
>=20
> No, I think that this change is good idea if it simplifies code flow.
> But it really should be described in commit message, not only "what"
> (which you did describe), but also "whys".
>=20

Sure, I'll try to put my explanation to the commit message.
