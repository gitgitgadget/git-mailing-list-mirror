From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] Provide pessimistic defaults for cross compilation
	tests.
Date: Tue, 20 Jan 2009 08:04:52 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20090120070451.GD5561@ins.uni-bonn.de>
References: <loom.20090115T123123-915@post.gmane.org> <20090116094110.GD25275@ins.uni-bonn.de> <20090119203400.GA3539@ins.uni-bonn.de> <7v63kampwz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julius Naperkowski <j.nap@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 08:06:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPAgx-0007Lj-Ib
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 08:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbZATHEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 02:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133AbZATHEz
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 02:04:55 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:43648 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbZATHEy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 02:04:54 -0500
Received: from localhost.localdomain (xdsl-87-78-160-12.netcologne.de [87.78.160.12])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 1C23A400045C6;
	Tue, 20 Jan 2009 08:04:53 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1LPAfM-0001dp-7g; Tue, 20 Jan 2009 08:04:52 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Julius Naperkowski <j.nap@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v63kampwz.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106450>

* Junio C Hamano wrote on Tue, Jan 20, 2009 at 07:50:52AM CET:
> Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:
> > --- a/configure.ac
> > +++ b/configure.ac

> > +	[ac_cv_c_c99_format=no],

> >  if test $ac_cv_c_c99_format = no; then
> 
> This one probably is Ok, but...
> 
> > @@ -380,6 +381,7 @@ AC_RUN_IFELSE(
> >  		FILE *f = fopen(".", "r");
> >  		return f && fread(&c, 1, 1, f)]])],
> >  	[ac_cv_fread_reads_directories=no],
> > +	[ac_cv_fread_reads_directories=yes],
> >  	[ac_cv_fread_reads_directories=yes])
> >  ])
> >  if test $ac_cv_fread_reads_directories = yes; then
> 
> I am not quite sure if this is an improvement ...
> 
> > @@ -414,6 +416,7 @@ AC_RUN_IFELSE(
> >  		  if (snprintf(buf, 3, "%s", "12345") != 5
> >  		      || strcmp(buf, "12")) return 1]])],
> >  	[ac_cv_snprintf_returns_bogus=no],
> > +	[ac_cv_snprintf_returns_bogus=yes],
> >  	[ac_cv_snprintf_returns_bogus=yes])
> >  ])
> >  if test $ac_cv_snprintf_returns_bogus = yes; then
> 
> ... nor this one.

I can see why you're cautious here, but AFAICS the actual code that will
be enabled by these defaults is portable to systems that have no bogus
snprintf and whose fread does not read directories.  IOW, all you lose
is a bit of performance at most.

> Is there a way to say something like "I'll autodetect as much as I can
> without running tests, but please tell me these characteristics of the
> target system manually" and leave the resulting config.mak.autogen in a
> shape that will guarantee compilation failure until the missing ones are
> supplied by config.mak?

Well, without my patch, each of these three tests will get configure to
error out.  Instead of setting a variable, these added arguments can
also output a more helpful error, in the sense of
  "please find out whether the return value of snprintf is ok,
   and set $ac_cv_snprintf_returns_bogus accordingly when rerunning
   configure"

> The thing is, I am not convinced that it is desirable to be able to build
> a possibly suboptimal binary in a cross compilation environment, without
> being told in what aspect of the resulting binary is suboptimal.  I'd
> rather see a build system that honestly tells me what information it needs
> but couldn't find, so that I would know I have a chance to help it.

Sure.

> Of course, suggesting a pessimistic default that can result in suboptimal
> but correct result would be a good thing to help the user help the build.
> I just think it is a good idea to tell the user we are giving such hint a
> bit more loudly to draw attention.

Agreed, too.  Would you prefer a hard erroring out of configure, for
each of the tests, or would it suffice to see a warning fly by?

Thanks,
Ralf
