From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] launch_editor: propagate SIGINT from editor to git
Date: Fri, 30 Nov 2012 15:24:35 -0500
Message-ID: <20121130202435.GA7933@sigill.intra.peff.net>
References: <20121111163100.GB13188@sigill.intra.peff.net>
 <20121111165706.GE19850@sigill.intra.peff.net>
 <50A00116.8060604@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kalle Olavi Niemitalo <kon@iki.fi>,
	Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 21:24:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeX8o-0001EF-8h
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 21:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226Ab2K3UYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 15:24:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47876 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753909Ab2K3UYi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 15:24:38 -0500
Received: (qmail 6118 invoked by uid 107); 30 Nov 2012 20:25:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Nov 2012 15:25:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2012 15:24:35 -0500
Content-Disposition: inline
In-Reply-To: <50A00116.8060604@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210944>

On Sun, Nov 11, 2012 at 08:48:38PM +0100, Johannes Sixt wrote:

> Am 11.11.2012 17:57, schrieb Jeff King:
> > @@ -51,6 +51,8 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
> >  		sigchain_push(SIGINT, SIG_IGN);
> >  		ret = finish_command(&p);
> >  		sigchain_pop(SIGINT);
> > +		if (WIFSIGNALED(ret) && WTERMSIG(ret) == SIGINT)
> > +			raise(SIGINT);
> 
> The return value of finish_command() is already a digested version of
> waitpid's status value. According to
> Documentation/technical/api-run-command.txt:
> 
> . If the program terminated due to a signal, then the return value is
> the signal number - 128, ...
> 
> the correct condition would be
> 
> 		if (ret == SIGINT - 128)

Yeah, that is the same thing as WTERMSIG (which uses "ret & 0x7f") for
the range of -127..-1. I do not mind changing it to match run-command's
stated output, but I am curious whether there are systems where WTERMSIG
is not defined in the same way, and the code would break.

-Peff
