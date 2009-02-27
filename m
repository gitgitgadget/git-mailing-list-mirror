From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/2] clone: do not ignore --no-hardlinks
Date: Fri, 27 Feb 2009 11:54:01 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902271146060.19665@iabervon.org>
References: <alpine.DEB.1.00.0902262352380.10279@pacific.mpi-cbg.de> <da2c9173f403c4fb509609fb823b6be0728d94f3.1235690903u.git.johannes.schindelin@gmx.de> <20090227025829.GA22060@coredump.intra.peff.net> <7vy6vsmjeo.fsf@gitster.siamese.dyndns.org>
 <7vr61kmht9.fsf@gitster.siamese.dyndns.org> <7vmyc8mh56.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1603798776-1235753633=:19665"
Cc: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 17:55:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld5zt-0001ev-E9
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 17:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbZB0QyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 11:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756006AbZB0QyH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 11:54:07 -0500
Received: from iabervon.org ([66.92.72.58]:58043 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755983AbZB0QyG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 11:54:06 -0500
Received: (qmail 11953 invoked by uid 1000); 27 Feb 2009 16:54:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2009 16:54:01 -0000
In-Reply-To: <7vmyc8mh56.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Content-ID: <alpine.LNX.1.00.0902271153570.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111682>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1603798776-1235753633=:19665
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.1.00.0902271153571.19665@iabervon.org>

On Fri, 27 Feb 2009, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > It triggers this codepath in get_value():
> >
> > 	case OPTION_BOOLEAN:
> > 		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
> > 		return 0;
> >
> > and ends up incrementing it to zero.
> >
> > I wonder what would break if we simply change this to:
> >
> > 	case OPTION_BOOLEAN:
> > 		*(int *)opt->value = !unset;
> > 		return 0;
> >
> > Damn it, it is called BOOLEAN, and naïvely I would think --option would
> > set it to 1, --no-option would set it to 0, and not having --option nor
> > --no-option would leave the associated variable alone, but apparently that
> > is not what is happening.
> >
> > Pierre, do you remember why this code is implemented this way?  The
> > "increment if we have --option" semantics seems to date back to 4a59fd1
> > (Add a simple option parser., 2007-10-15) which is the day one of the
> > history of parse-options.
> 
> I think that this came from a misguided attempt to do:
> 
> 	-v
>         -v -v
>         -v -v -v
> 
> to cumulatively record the desired verbosity levels.
> 
> Originally we did not have OPT__VERBOSITY() nor OPT_VERBOSE() so it is
> understandable that OPT_VERBOSE() was implemented in terms of this
> OPT_BOOLEAN() construct.
> 
> I think all parse_options() users that do support the verbosity level is
> either using OPT__VERBOSE() or OPT_VERBOSITY() these days, and we could
> probably fix this by doing something like:
> 
>  (1) Introduce OPTION_CUMULATIVE_LEVEL whose behaviour is "--no-option to
>      reset to zero, --option to raise by one", and fix OPTION_BOOLEAN to
>      "--no-option to zero, --option to one":
> 
> 	case OPTION_BOOLEAN:
>  		*(int *)opt->value = !unset;
> 		return 0;
> 	case OPTION_CUMULATIVE_LEVEL:
>  		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
>  		return 0;
> 
>  (2) Use OPT_CUMULATIVE_LEVEL() instead of OPT_BOOLEAN() to implement
>      OPT__VERBOSE() and OPT__QUIET().

I think there are a few other options that work like that, such as -C for 
diff and the like; I don't know if there are any others that go through 
parse_options, but I wouldn't count on there not being any. So I think the 
conversion of OPT_BOOLEAN needs to go with an audit of current users.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1603798776-1235753633=:19665--
