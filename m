From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Added basic color support to git add --interactive
Date: Sun, 4 Nov 2007 00:57:35 -0400
Message-ID: <20071104045735.GA12359@segfault.peff.net>
References: <20071013172745.GA2624@coredump.intra.peff.net> <20071013175127.GA3183@coredump.intra.peff.net> <47112491.8070309@gmail.com> <20071015034338.GA4844@coredump.intra.peff.net> <20071016194709.3c1cb3a8@danzwell.com> <20071017015152.GN13801@spearce.org> <20071022164048.71a3dceb@danzwell.com> <20071023042702.GB28312@coredump.intra.peff.net> <20071023035221.66ea537f@danzwell.com> <20071102224100.71665182@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 05:57:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoXYW-0001jH-9V
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 05:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbXKDE5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 00:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbXKDE5h
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 00:57:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4542 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbXKDE5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 00:57:37 -0400
Received: (qmail 12366 invoked by uid 1000); 4 Nov 2007 04:57:35 -0000
Content-Disposition: inline
In-Reply-To: <20071102224100.71665182@paradox.zwell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63347>

On Fri, Nov 02, 2007 at 10:41:00PM -0500, Dan Zwell wrote:

> +sub print_colored {
> +	my $color = shift;
> +	my $string = join("", @_);
> +
> +	if ($use_color) {
> +		# Put a color code at the beginning of each line, a reset at the end
> +		# color after newlines that are not at the end of the string
> +		$string =~ s/(\n+)(.)/$1$color$2/g;
> +		# reset before newlines
> +		$string =~ s/(\n+)/$normal_color$1/g;
> +		# codes at beginning and end (if necessary):
> +		$string =~ s/^/$color/;
> +		$string =~ s/$/$normal_color/ unless $string =~ /\n$/;
> +	}
> +	print $string;
> +}

This would probably be a bit more readable by marking the regex as
multline using /m. Something like:

  $string =~ s/^/$color/mg;
  $string =~ s/.$/$&$normal_color/mg;

which covers both the "start/end of line" and "start/end" of string
cases.

Also, if there is to be pager support for showing diffs, perhaps
print_colored needs to take a filehandle argument (or, even simpler,
change "print_colored(...)" to "print color(...), so the caller can use
print as usual).

-Peff
