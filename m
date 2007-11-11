From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subject: [PATCH 2/3] Let git-add--interactive read colors from .gitconfig
Date: Sun, 11 Nov 2007 01:53:25 -0800
Message-ID: <7vve89f6qy.fsf@gitster.siamese.dyndns.org>
References: <47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
	<20071110202351.7b4544aa@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 10:53:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir9Vu-0003F4-JM
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 10:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbXKKJxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 04:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753986AbXKKJxk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 04:53:40 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:42218 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbXKKJxi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 04:53:38 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7B0282F2;
	Sun, 11 Nov 2007 04:53:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 531E79385A;
	Sun, 11 Nov 2007 04:53:49 -0500 (EST)
In-Reply-To: <20071110202351.7b4544aa@paradox.zwell.net> (Dan Zwell's message
	of "Sat, 10 Nov 2007 20:23:51 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64438>

Dan Zwell <dzwell@zwell.net> writes:

> @@ -8,12 +9,18 @@ if ($color_config=~/true|always/ || -t STDOUT && $color_config=~/auto/) {
>  	eval { require Term::ANSIColor; };
>  	if (!$@) {
>  		$use_color = 1;
> +		# Set interactive colors:
> +
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

Makes me wonder if you are better off with two new helper
functions defined in Git.pm, as in:

	$prompt_color = $repo->config_color("interactive.prompt") || "bold blue")
	$normal_color = Git::color_to_ansi_code("normal");

> +sub color_to_ansi_code {
> +	my ($git_string) = @_;
> +	my @ansi_words;
> +	my %attrib_mappings = (
> +		"bold"    => "bold",
> +		"ul"      => "underline",
> +		"blink"   => "blink",
> +		# not supported:
> +		#"dim"     => "",
> +		"reverse" => "reverse"
> +	);

I do not like a hash variable name that says it is a "mapping".
It being a hash is enough indication that it is a mapping.

You are better off naming such a mapping as if it is a function
that takes one parameter (in this case, git name) and returns a
single value (perl name).  So I'd probably say:

	my %perl_attrib = ( ... );

(or "git_attrib_to_perl").  A use site of such a hash would look
like this:

	push @perl_words, $perl_attrib{'ul'};
        push @perl_names, $git_attrib_to_perl{'blink'};

Maybe it is just me, but aren't these easier to read?

> +	my ($fg_done, $word);
> +
> +	foreach $word (split /\s+/, $git_string) {
> +		if ($word =~ /normal/) {

	$word eq 'normal' ?

> +			$fg_done = "true";
> +		}
> +		elsif ($word =~ /black|red|green|yellow/ ||
> +			   $word =~ /blue|magenta|cyan|white/) {

	exists $color_name{$word}

with

	my %color_name = map { $_ => 1 } qw(black red ... white);

at the beginning?

> +			# is a color.
> +			if ($fg_done) {
> +				# this is the background
> +				push @ansi_words, "on_" . $word;
> +			}
> +			else {
> +				# this is foreground
> +				$fg_done = "true";
> +				push @ansi_words, $word;
> +			}
> +		}
> +		else {
> +			# this is an attribute, not a color.
> +			if ($attrib_mappings{$word}) {

	exists $git_attrib_to_perl{$word}

?
