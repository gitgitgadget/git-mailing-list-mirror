From: Jeff King <peff@peff.net>
Subject: Re: Parallel make failed in perl/perl.mak
Date: Mon, 17 Sep 2012 15:46:40 -0400
Message-ID: <20120917194640.GA24888@sigill.intra.peff.net>
References: <CALxABCbzr653R4aCc_YOXNZYo8Zeu8WiU72OmyyMyz5WR+p6gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Michael G. Schwern" <schwern@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 21:47:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDhHR-0005vp-0C
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 21:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699Ab2IQTqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 15:46:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46751 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375Ab2IQTqn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 15:46:43 -0400
Received: (qmail 11774 invoked by uid 107); 17 Sep 2012 19:47:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Sep 2012 15:47:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2012 15:46:40 -0400
Content-Disposition: inline
In-Reply-To: <CALxABCbzr653R4aCc_YOXNZYo8Zeu8WiU72OmyyMyz5WR+p6gw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205731>

On Mon, Sep 17, 2012 at 08:13:35PM +0200, Alex Riesen wrote:

> mv: cannot stat `perl.mak': No such file or directory
> mv: cannot move `perl.mak' to `perl.mak.old': No such file or directory
> [...]
> I wasn't able to reproduce it, so this message is the only thing I have.
> It was the first compilation after I merged the current master
> (v1.7.12-464-g83379df).

This is probably the same bug that we've been hunting for years:

  April 2009:
  http://article.gmane.org/gmane.comp.version-control.git/117710

  October 2010:
  http://article.gmane.org/gmane.comp.version-control.git/158251

  March 2011:
  http://article.gmane.org/gmane.comp.version-control.git/170153

I proposed a patch in the middle one, but of course we have no idea if
it works or not, since the problem is so hard to reproduce.

> Probably the old perl.mak is the problem, and the only thing I can think
> for reasons why it wasn't regenerated is this:
> 
> diff --git a/perl/Makefile b/perl/Makefile
> index 15d96fc..766d02a 100644
> --- a/perl/Makefile
> +++ b/perl/Makefile
> @@ -79,7 +79,7 @@ $(makfile): ../GIT-CFLAGS Makefile
>  	echo instlibdir: >> $@
>  	echo '	echo $(instdir_SQ)' >> $@
>  else
> -$(makfile): Makefile.PL ../GIT-CFLAGS
> +$(makfile): Makefile.PL ../GIT-CFLAGS Makefile
>  	$(PERL_PATH) $< PREFIX='$(prefix_SQ)' INSTALL_BASE=''
> --localedir='$(localedir_SQ)'
>  endif
> 
> Could someone please take a look at it?

That only takes effect if NO_PERL_MAKEMAKER is set, and I think we see
the bug even when it is not set. Also, I'm not clear on what part of
Makefile that command would depend on (the GIT-CFLAGS dependency should
cover the directory parameters).

-Peff
