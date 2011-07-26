From: Jeff King <peff@peff.net>
Subject: Re: feature request: git add--interactive --patch on regex-matched
 hunks only
Date: Mon, 25 Jul 2011 23:03:04 -0600
Message-ID: <20110726050304.GA25046@sigill.intra.peff.net>
References: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
 <20110725215553.GA23145@sigill.intra.peff.net>
 <7vbowiq62m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 07:03:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlZnd-0006yk-L5
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 07:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844Ab1GZFDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 01:03:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51509
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab1GZFDH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 01:03:07 -0400
Received: (qmail 16823 invoked by uid 107); 26 Jul 2011 05:03:36 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Jul 2011 01:03:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jul 2011 23:03:04 -0600
Content-Disposition: inline
In-Reply-To: <7vbowiq62m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177840>

On Mon, Jul 25, 2011 at 04:44:01PM -0700, Junio C Hamano wrote:

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 8f0839d..0b6f8a6 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1257,7 +1257,7 @@ sub display_hunks {
>  
>  sub patch_update_file {
>  	my $quit = 0;
> -	my ($ix, $num);
> +	my ($ix, $num, $last_search_string);
>  	my $path = shift;
>  	my ($head, @hunk) = parse_diff($path);
>  	($head, my $mode, my $deletion) = parse_diff_header($head);
> @@ -1395,11 +1395,12 @@ sub patch_update_file {
>  			}
>  			elsif ($line =~ m|^/(.*)|) {
>  				my $regex = $1;
> -				if ($1 eq "") {
> -					print colored $prompt_color, "search for regex? ";
> -					$regex = <STDIN>;
> -					if (defined $regex) {
> -						chomp $regex;
> +				if ($regex eq "") {
> +					if ($last_search_string) {
> +						$regex = $last_search_string;
> +					} else {
> +						error_msg "Need a regexp to search\n";
> +						next;

How does this interact with single-key mode? I imagine we just get the
"/" at that point and have to read the rest of the regex manually. Which
is probably why this code was here in the first place.

So I think we might have to do something like:

  my $regex = $1;
  if ($use_readkey) {
    print colored $prompt_color, "search for regex?";
    $regex = <STDIN>;
    chomp $regex;
  }
  if ($regex eq "") {
    ...
  }

And then that would give single-key people an opportunity to input a new
regex, or to hit enter to just use the last one.

-Peff
