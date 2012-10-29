From: Jeff King <peff@peff.net>
Subject: Re: gitweb
Date: Mon, 29 Oct 2012 01:28:15 -0400
Message-ID: <20121029052815.GA30186@sigill.intra.peff.net>
References: <20121028165647.b79fe3fcb6784c4ae547439e@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: rh <richard_hubbe11@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 06:28:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TShtn-0003bF-IA
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 06:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab2J2F2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 01:28:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41776 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719Ab2J2F2T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 01:28:19 -0400
Received: (qmail 15267 invoked by uid 107); 29 Oct 2012 05:29:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 01:29:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 01:28:15 -0400
Content-Disposition: inline
In-Reply-To: <20121028165647.b79fe3fcb6784c4ae547439e@lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208583>

On Sun, Oct 28, 2012 at 04:56:47PM -0700, rh wrote:

> I'm not using gitweb I was thinking about using it and was looking at the 
> cgi and saw this in this file:
> https://github.com/git/git/blob/master/gitweb/gitweb.perl
> 
> I think I understand the intention but the outcome is wrong.
> 
> our %highlight_ext = (
> 	# main extensions, defining name of syntax;
> 	# see files in /usr/share/highlight/langDefs/ directory
> 	map { $_ => $_ }
> 	qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl sql make),
> 	# alternate extensions, see /etc/highlight/filetypes.conf
> 	'h' => 'c',
> 	map { $_ => 'sh' } qw(bash zsh ksh),
> 	map { $_ => 'cpp' } qw(cxx c++ cc),
> 	map { $_ => 'php' } qw(php3 php4 php5 phps),
> 	map { $_ => 'pl' } qw(perl pm), # perhaps also 'cgi'
> 	map { $_ => 'make'} qw(mak mk),
> 	map { $_ => 'xml' } qw(xhtml html htm),
> );

Yeah, this is wrong. The first map will eat the rest of the list, and
you will get "h => h", "cxx => cxx", and so forth. I do not know this
chunk of code, but that does not seem like it is the likely intent.

You could fix it with extra parentheses:

  our %he = (
    (map { $_ => $_ } qw(py c cpp ...)),
    'h' => 'c',
    (map { $_ => 'sh' } qw(bash zsh ksh)),
    ... etc ...
  );

> I think the intent is better met with this, (the print is for show)
> 
> our %he = ();
> $he{'h'} = 'c';
> $he{$_} = $_     for (qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl sql make));
> $he{$_} = 'cpp'  for (qw(cxx c++ cc));
> $he{$_} = 'php'  for (qw(php3 php4 php5 phps));
> $he{$_} = 'pl'   for (qw(cgi perl pm));
> $he{$_} = 'make' for (qw(mak mk));
> $he{$_} = 'xml'  for (qw(xhtml html htm));
> $he{$_} = 'sh'   for (qw(bash zsh ksh));

That is more readable to me (though it does lose the obviousness that it
is a variable initialization).

Looks like this was broken since 592ea41 (gitweb: Refactor syntax
highlighting support, 2010-04-27). I do not use gitweb (nor highlight)
at all, but I'd guess the user-visible impact is that "*.h" files are
not correctly highlighted (unless highlight does this extension mapping
itself, but then why are we doing it here?).

Jakub, can you confirm the intent and a fix like the one above makes
things better?

-Peff
