From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 04:12:06 -0400
Message-ID: <20071013081205.GB27533@coredump.intra.peff.net>
References: <471045DA.5050902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	"Johannes Schindelin <Johannes.Schindelin@gmx.de>Wincent Colaiuta" 
	<win@wincent.com>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 10:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igc6k-0007Yz-DK
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 10:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbXJMIMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 04:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXJMIMN
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 04:12:13 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1405 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbXJMIMK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 04:12:10 -0400
Received: (qmail 22624 invoked by uid 111); 13 Oct 2007 08:12:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 13 Oct 2007 04:12:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Oct 2007 04:12:06 -0400
Content-Disposition: inline
In-Reply-To: <471045DA.5050902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60727>

On Fri, Oct 12, 2007 at 11:13:14PM -0500, Dan Zwell wrote:

> Recently there was some talk of color for git-add--interactive, but the 
> person who said he already had a patch didn't produce it.

Neat, thanks for working on this.

> There is one problem--a block is commented out, because adding the "--color" 
> option to git-diff-files somehow breaks git-add--interactive, and I would 

I believe it's because add--interactive parses the output of
git-diff-files, so it expects unadorned diffs. I think you may be stuck
re-coloring the diffs yourself, which is a little ugly.

> tabs. Feel free to replace the colors that I chose with something that 
> better conforms to the "git style", if there is such a thing.

Two suggestions:
  - every color should be configurable (e.g., see diff color options)
  - where possible, use existing color config (e.g., for diffs)

You will never come up with a color scheme that satisfies everyone
(e.g., white text on black background versus black text on white
background), so configurability is a good idea (not to mention that
nobody will ever agree on what looks "good").

> +if ($color_config=~"true" || -t STDOUT && $color_config=~"auto") {

Shouldn't these just be 'eq' instead of a regex?

> +			print_ansi_color "bold";
>  			print "$opts->{HEADER}\n";
> +			print_ansi_color "clear";

ISTR some terminals had issues with leaving ANSI attributes set across a
newline. That was the reason for the color_fprintf_ln business in
color.[ch]. You might replace this with something like:

  print_color_ln 'bold', $opts->{HEADER};

where "print_color_ln" turns off the attribute before the newline.

> +	# FIXME: the following breaks git, and I'm not sure why. When
> +	# the following is uncommented, git no longer asks whether we
> +	# want to add given hunks.
> +	#my @diff;
> +	#if ($use_color) {
> +	#    #@diff = run_cmd_pipe(qw(git diff-files --color -p --), $path);
> +	#}
> +	#else {
> +	#    #@diff = run_cmd_pipe(qw(git diff-files -p --), $path);
> +	#}
>  	my @diff = run_cmd_pipe(qw(git diff-files -p --), $path);

See how we are pulling the diff into lines? Look a few lines below and
you will see that we start parsing without regard to the color.

Unfortunately, that parsed form ends up being output to the user, so we
will have to do colorization at that point (fortunately, diff
colorization with regexes isn't _that_ hard).

> +	print_ansi_color "blue";
>  	print <<\EOF ;
>  y - stage this hunk
>  n - do not stage this hunk
> @@ -555,6 +582,7 @@ k - leave this hunk undecided, see previous undecided 
> hunk
>  K - leave this hunk undecided, see previous hunk
>  s - split the current hunk into smaller hunks
>  EOF
> +	print_ansi_color "clear";

Hrm, splitting this with print_color_ln as I mentioned above would be a
little painful. Maybe something like this (totally untested):

# Turn on ansi attributes at the beginning of the string and at
# the beginning of each line, but then turn them off before each
# newline. This should give the effect of covering the whole string
# with the attribute, but not have attributes cross newline boundaries.
sub color_print {
  my $attr = shift;
  local $_ = shift;
  if ($use_color) {
    s/^/Term::ANSIColor::color($attr)/mge;
    s/\n/Term::ANSIColor::color('reset') . $&/ge;
  }
  print $_;
}

-Peff
