From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Color support for "git-add -i"
Date: Thu, 6 Dec 2007 00:40:56 -0500
Message-ID: <20071206054056.GG5499@coredump.intra.peff.net>
References: <475697BC.2090701@viscovery.net> <1196906706-11170-1-git-send-email-gitster@pobox.com> <1196906706-11170-2-git-send-email-gitster@pobox.com> <1196906706-11170-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 06:41:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J09U8-00045q-Py
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 06:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbXLFFk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 00:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbXLFFk7
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 00:40:59 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2751 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbXLFFk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 00:40:59 -0500
Received: (qmail 28054 invoked by uid 111); 6 Dec 2007 05:40:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Dec 2007 00:40:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2007 00:40:56 -0500
Content-Disposition: inline
In-Reply-To: <1196906706-11170-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67245>

On Wed, Dec 05, 2007 at 06:05:05PM -0800, Junio C Hamano wrote:

> This is mostly lifted from earlier series by Dan Zwell, but updated to
> use "git config --get-color" and "git config --get-colorbool" to make it
> simpler and more consistent with commands written in C.

Looks mostly sane, except for the colorbool issues I mentioned in
response to 2/3.

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 335c2c6..1019a72 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> [...]
> +	# Do we also set diff colors?
> +	$diff_use_color = $repo->get_colorbool('color.diff');
> +	if ($diff_use_color) {
> +		$new_color = $repo->get_color("color.diff.new", "green");
> +		$old_color = $repo->get_color("color.diff.old", "red");
> +		$fraginfo_color = $repo->get_color("color.diff.frag", "cyan");
> +		$metainfo_color = $repo->get_color("color.diff.meta", "bold");
> +		$whitespace_color = $repo->get_color("color.diff.whitespace", "normal red");

diff.color support?

BTW, I am nagging about this because we never resolved what should
happen. I am fine with the answer being "we are dropping support now."

> +sub colored {
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
> +	return $string;
> +}

I still think this should go into Git.pm; I believe git-svn could make
use of it.

>  sub highlight_prefix {
>  	my $prefix = shift;
>  	my $remainder = shift;
> -	return $remainder unless defined $prefix;
> -	return is_valid_prefix($prefix) ?
> -	    "[$prefix]$remainder" :
> -	    "$prefix$remainder";
> +
> +	if (!defined $prefix) {
> +		return $remainder;
> +	}
> +
> +	if (!is_valid_prefix($prefix)) {
> +		return "$prefix$remainder";
> +	}
> +
> +	if (!$use_color) {
> +		return "[$prefix]$remainder";
> +	}
> +
> +	return "$prompt_color$prefix$normal_color$remainder";

Honestly, I find this blue+white coloring of the prefixes a bit ugly,
but that is not your fault. :)

-Peff
