From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Adding colors to git-add--interactive
Date: Sun, 11 Nov 2007 02:54:47 -0500
Message-ID: <20071111075446.GA26985@sigill.intra.peff.net>
References: <20071016194709.3c1cb3a8@danzwell.com> <20071017015152.GN13801@spearce.org> <20071022164048.71a3dceb@danzwell.com> <20071023042702.GB28312@coredump.intra.peff.net> <20071023035221.66ea537f@danzwell.com> <20071102224100.71665182@paradox.zwell.net> <20071104045735.GA12359@segfault.peff.net> <7v640ivagv.fsf@gitster.siamese.dyndns.org> <20071104054305.GA13929@sigill.intra.peff.net> <20071110180109.34febc3f@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 08:55:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir7ev-00070r-HR
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 08:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbXKKHyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 02:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbXKKHyw
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 02:54:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3679 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbXKKHyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 02:54:52 -0500
Received: (qmail 29849 invoked by uid 111); 11 Nov 2007 07:54:50 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 11 Nov 2007 02:54:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2007 02:54:48 -0500
Content-Disposition: inline
In-Reply-To: <20071110180109.34febc3f@paradox.zwell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64421>

On Sat, Nov 10, 2007 at 06:01:09PM -0600, Dan Zwell wrote:

> A bit of a recap--this feature was requested by a user a few weeks

Thanks for the recap; there have been enough iterations of this series
that at least I forgot what was going on. The patches look reasonable,
but I have a few comments (hopefully you have enough "umph" for one more
iteration). I'll just inline them here.

[patch 1/3]:
> +my ($use_color, $prompt_color, $header_color, $help_color, $normal_color);
> +my $color_config = qx(git config --get color.interactive);

Why call git config here manually, but Git::config later (I think the
answer is "because we don't call Git::config until a later patch", but it
is probably best to remain consistent).

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

This also seems like a candidate for lib-ification in Git.pm, alongside
color_to_ansi_code.

> -			print "$opts->{HEADER}\n";
> +			print colored $header_color, "$opts->{HEADER}\n";

I don't know if we have a style policy on calling

  user_defined_function $foo, $bar;

rather than

  user_defined_function($foo, $bar);

In fact, I don't know that we have much perl style policy at all. But I
tend to shy away from the former because then the syntax requires that
"colored" is always defined before the calling spot.

[patch 2/3]:
> +		# Grab the 3 main colors in git color string format, with sane
> +		# (visible) defaults:
> +		my $repo = Git->repository();
> +		$prompt_color = Git::color_to_ansi_code(
> +			Git::config($repo, "color.interactive.prompt") || "bold blue");
> +		$header_color = Git::color_to_ansi_code(
> +			Git::config($repo, "color.interactive.header") || "bold");
> +		$help_color = Git::color_to_ansi_code(
> +			Git::config($repo, "color.interactive.help") || "red bold");
> +		$normal_color = Git::color_to_ansi_code("normal");

It is much more common (and proper OO, in the face of inheritance) to
use

   $repo->config("color.interactive.prompt")

> +=item color_to_ansi_code ( COLOR )
> +
> +Converts a git-style color string, like "underline blue white" to
> +an ANSI color code. The code is generated by Term::ANSIColor,
> +after the string is parsed into the format that is accepted by
> +that module. Used as follows:
> +
> +	print color_to_ansi_code("underline blue white");
> +	print "some text";
> +	print color_to_ansi_code("normal");

Yay, documentation!  It would also be nice to have a test script that
runs this through a few more complex git color specs.

> +	my %attrib_mappings = (
> +		"bold"    => "bold",
> +		"ul"      => "underline",
> +		"blink"   => "blink",
> +		# not supported:
> +		#"dim"     => "",

Why not? I don't especially care about "dim" support, but if there is a
good reason, then you should note it.

> +	foreach $word (split /\s+/, $git_string) {
> +		if ($word =~ /normal/) {
> +			$fg_done = "true";
> +		}

Why a regex instead of 'eq'? Also, should this be case insensitive?

> +		elsif ($word =~ /black|red|green|yellow/ ||
> +			   $word =~ /blue|magenta|cyan|white/) {

It looks like you are doing two regexes here just to meet whitespace
guidelines. Look into the '/x' modifier to make your regex prettier (but
again, consider 'eq').

> +	return Term::ANSIColor::color(join(" ", @ansi_words)||"reset");

Style: whitespace around ||

[patch 3/3]:
> +			# Not implemented:
> +			#$whitespace_color = Git::color_to_ansi_code(
> +				#Git::config($repo, "color.diff.whitespace") || "normal red");

Personally I would have just excluded the parsing, since it isn't
implemented, but I don't think it matters.

> +sub colored_diff_hunk {

Perhaps this should also go in Git.pm? Though right now I don't know
which other perl scripts would actually want to colorize a diff, so I
don't think it matters.

> -	system(qw(git diff-index -p --cached HEAD --),
> -	       map { $_->{VALUE} } @them);
> +	system(qw(git diff -p --cached HEAD --), map { $_->{VALUE} } @them);

Now this was a surprise after reading the commit message.

-Peff
