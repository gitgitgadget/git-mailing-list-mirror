From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] add--interactive: respect diff.algorithm
Date: Sun, 23 Jun 2013 20:50:18 +0100
Message-ID: <20130623195017.GI4676@serenity.lan>
References: <20130610142825.GI22905@serenity.lan>
 <7v38sphiiw.fsf@alter.siamese.dyndns.org>
 <20130610211140.GD13333@sigill.intra.peff.net>
 <20130610214638.GK22905@serenity.lan>
 <20130610215656.GA28345@sigill.intra.peff.net>
 <20130612184410.GB23890@serenity.lan>
 <7v8v20fxee.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 21:50:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqqIx-000399-7i
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 21:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191Ab3FWTu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 15:50:27 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:51590 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab3FWTu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 15:50:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 689026064E7;
	Sun, 23 Jun 2013 20:50:26 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0NHlt2bi4WdQ; Sun, 23 Jun 2013 20:50:25 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 98F2F6064FF;
	Sun, 23 Jun 2013 20:50:25 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 7B76D161E362;
	Sun, 23 Jun 2013 20:50:25 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ws-0pKVIftOn; Sun, 23 Jun 2013 20:50:24 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 71526161E3F1;
	Sun, 23 Jun 2013 20:50:20 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v8v20fxee.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228758>

On Sun, Jun 23, 2013 at 12:19:05PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> >> > +my $diff_algorithm = ($repo->config('diff.algorithm') or 'default');
> >> > +
> >> >  my $use_readkey = 0;
> >> >  my $use_termcap = 0;
> >> >  my %term_escapes;
> >> > @@ -731,6 +733,9 @@ sub run_git_apply {
> >> >  sub parse_diff {
> >> >  	my ($path) = @_;
> >> >  	my @diff_cmd = split(" ", $patch_mode_flavour{DIFF});
> >> > +	if ($diff_algorithm ne "default") {
> >> > +		push @diff_cmd, "--diff-algorithm=${diff_algorithm}";
> >> > +	}
> 
> This is not exactly sanitary for "stash -p", whose DIFF element is
> defined like so:
> 
> 	'stash' => {
> 		DIFF => 'diff-index -p HEAD',
> 
> and you will end up appending an option after a non-option argument,
> 
> It may happen to be accepted by the command line parser which is
> overly lax, but we would want to tighten it in the longer term.
> 
> As a band-aid, we could do something like the attached patch, but
> for the longer term, we might need to rethink the way the tweaking
> of the command line is done by $patch_mode_revision.

I originally used splice here then for some reason decided that just
appending the option was okay (I think I thought we were already
appending an option with $patch_mode_revision).

The patch below involves deeper Perl magic than I fully grok, but
wouldn't it be simpler to simply use the fact that the string is
"command --options..." and use:

    splice @diff_cmd 1, 0, "--diff-algorithm=${diff_algorithm}";

> -- >8 --
> Subject: add -i: add extra options at the right place in "diff" command line
> 
> Appending "--diff-algorithm=histogram" at the end of canned command
> line for various modes of "diff" is correct for most of them but not
> for "stash" that has a non-option already wired in, like so:
> 
> 	'stash' => {
> 		DIFF => 'diff-index -p HEAD',
> 
> Appending an extra option after non-option may happen to work due to
> overly lax command line parser, but that is not something we should
> rely on.  Instead, splice in the extra argument immediately after a
> '-p' option, which is an option to ask for textual diff output that
> has to be in all variants.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  git-add--interactive.perl | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 5310959..b50551a 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -730,11 +730,23 @@ sub run_git_apply {
>  	return close $fh;
>  }
>  
> +# The command array must have a single "-p" to ask for output in the
> +# patch form.  Splice additional options immediately after it; we
> +# should not be randomly appending them, as some of the canned command.
> +# has non-option argument like HEAD already on it.
> +
> +sub splice_diff_options {
> +	my $diff_cmd = shift;
> +	@$diff_cmd = map {
> +		($_ eq '-p') ? ($_, @_) : $_;		
> +	} @$diff_cmd;
> +}
> +
>  sub parse_diff {
>  	my ($path) = @_;
>  	my @diff_cmd = split(" ", $patch_mode_flavour{DIFF});
>  	if (defined $diff_algorithm) {
> -		push @diff_cmd, "--diff-algorithm=${diff_algorithm}";
> +		splice_diff_options(\@diff_cmd, "--diff-algorithm=${diff_algorithm}");
>  	}
>  	if (defined $patch_mode_revision) {
>  		push @diff_cmd, $patch_mode_revision;
