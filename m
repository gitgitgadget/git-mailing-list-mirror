From: Jeff King <peff@peff.net>
Subject: Re: Different diff strategies in add --interactive
Date: Mon, 10 Jun 2013 17:56:56 -0400
Message-ID: <20130610215656.GA28345@sigill.intra.peff.net>
References: <20130610142825.GI22905@serenity.lan>
 <7v38sphiiw.fsf@alter.siamese.dyndns.org>
 <20130610211140.GD13333@sigill.intra.peff.net>
 <20130610214638.GK22905@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jun 10 23:57:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmA5L-0006BB-GE
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 23:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801Ab3FJV5C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 17:57:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:48582 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752907Ab3FJV5B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 17:57:01 -0400
Received: (qmail 2780 invoked by uid 102); 10 Jun 2013 21:57:51 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 16:57:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 17:56:56 -0400
Content-Disposition: inline
In-Reply-To: <20130610214638.GK22905@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227394>

On Mon, Jun 10, 2013 at 10:46:38PM +0100, John Keeping wrote:

> > Overall, I think respecting diff.algorithm in add--interactive is a very
> > sane thing to do. I would even be tempted to say we should allow a few
> > other select diff options (e.g., fewer or more context lines). If you
> > allowed diff options like this:
> > 
> >   git add --patch="--patience -U5"
> > 
> > that is very flexible, but I would not want to think about what the code
> > does when you pass --patch="--raw" or equal nonsense.
> 
> An alternative would be to permit them to be set from within the
> interactive UI.  I'd find it quite useful to experiment with various
> diff options when I encounter a hunk that isn't as easy to pick as I'd
> like.  I expect it would be very hard to do that on a per-hunk basis,
> although per-file doesn't seem like it would be too hard.

That's an interesting idea, for a subset of options (e.g., "increase
context for this hunk"). I suspect implementing it would be painful,
though, as you would have to re-run diff, and you have no guarantee of
getting the same set of hunks (e.g., the hunk might end up coalesced
with another).

> I don't intend to investigate that though - respecting diff.algorithm is
> good enough for my usage.

I don't blame you. :)

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index d2c4ce6..0b0fac2 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -44,6 +44,8 @@ my ($diff_new_color) =
>  
>  my $normal_color = $repo->get_color("", "reset");
>  
> +my $diff_algorithm = ($repo->config('diff.algorithm') or 'default');
> +
>  my $use_readkey = 0;
>  my $use_termcap = 0;
>  my %term_escapes;
> @@ -731,6 +733,9 @@ sub run_git_apply {
>  sub parse_diff {
>  	my ($path) = @_;
>  	my @diff_cmd = split(" ", $patch_mode_flavour{DIFF});
> +	if ($diff_algorithm ne "default") {
> +		push @diff_cmd, "--diff-algorithm=${diff_algorithm}";
> +	}
>  	if (defined $patch_mode_revision) {
>  		push @diff_cmd, $patch_mode_revision;

Yeah, that looks like the sane way to do it to me. As a perl style
thing, I think the usual way of spelling 'default' is 'undef'. I.e.:

  my $diff_algorithm = $repo->config('diff.algorithm');
  ...
  if (defined $diff_algorithm) {
          push @diff_cmd, "--diff-algorithm=$diff_algorithm";
  }

-Peff
