From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Added basic color support to git add --interactive
Date: Sat, 03 Nov 2007 22:36:00 -0700
Message-ID: <7v640ivagv.fsf@gitster.siamese.dyndns.org>
References: <20071013172745.GA2624@coredump.intra.peff.net>
	<20071013175127.GA3183@coredump.intra.peff.net>
	<47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@zwell.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 06:36:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoY9u-00066W-AZ
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 06:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbXKDFgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 01:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbXKDFgN
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 01:36:13 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:55588 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbXKDFgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 01:36:12 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DBAB22EF;
	Sun,  4 Nov 2007 01:36:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2436A900B6;
	Sun,  4 Nov 2007 01:36:24 -0400 (EDT)
In-Reply-To: <20071104045735.GA12359@segfault.peff.net> (Jeff King's message
	of "Sun, 4 Nov 2007 00:57:35 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63351>

Jeff King <peff@peff.net> writes:

> On Fri, Nov 02, 2007 at 10:41:00PM -0500, Dan Zwell wrote:
>
>> +sub print_colored {
>> +	my $color = shift;
>> +	my $string = join("", @_);
>> +
>> +	if ($use_color) {
>> +		# Put a color code at the beginning of each line, a reset at the end
>> +		# color after newlines that are not at the end of the string
>> +		$string =~ s/(\n+)(.)/$1$color$2/g;
>> +		# reset before newlines
>> +		$string =~ s/(\n+)/$normal_color$1/g;
>> +		# codes at beginning and end (if necessary):
>> +		$string =~ s/^/$color/;
>> +		$string =~ s/$/$normal_color/ unless $string =~ /\n$/;
>> +	}
>> +	print $string;
>> +}
>
> This would probably be a bit more readable by marking the regex as
> multline using /m. Something like:
>
>   $string =~ s/^/$color/mg;
>   $string =~ s/.$/$&$normal_color/mg;
>
> which covers both the "start/end of line" and "start/end" of string
> cases.

I think you would end up spitting out:

        COLOR something RESET LF COLOR RESET LF

instead of:

	COLOR something RESET LF LF

when you get "something\n\n" if you did that.  Not a big deal,
though, as at this point we would be human I/O bound.

> Also, if there is to be pager support for showing diffs, perhaps
> print_colored needs to take a filehandle argument (or, even simpler,
> change "print_colored(...)" to "print color(...), so the caller can use
> print as usual).

Making it take a FH would be useful.  With that, my
proof-of-concept patch to add print_diff_hunk would become:

	sub print_diff_hunk {
        	my ($text) = @_;
		my $pager;

                if ($use_pager) {
	                open($pager, "| less");
		} else {
                	$pager = \*STDOUT;
		}
                for (@$text) {
			print_colored $pager $color ...
		}
                close($pager);
	}
