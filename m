From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Added get sendmail from .mailrc
Date: Mon, 27 Jan 2014 20:15:12 -0500
Message-ID: <20140128011512.GB17945@sigill.intra.peff.net>
References: <1390643210-5748-1-git-send-email-brilliantov@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
X-From: git-owner@vger.kernel.org Tue Jan 28 02:15:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7xHF-00071o-1b
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 02:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbaA1BPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 20:15:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:40011 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752812AbaA1BPO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 20:15:14 -0500
Received: (qmail 31343 invoked by uid 102); 28 Jan 2014 01:15:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Jan 2014 19:15:14 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jan 2014 20:15:12 -0500
Content-Disposition: inline
In-Reply-To: <1390643210-5748-1-git-send-email-brilliantov@inbox.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241175>

On Sat, Jan 25, 2014 at 01:46:50PM +0400, Brilliantov Kirill Vladimirovich wrote:

> +	if (!defined $smtp_server) {
> +		my $mailrc = File::HomeDir->my_home . "/.mailrc";

The new module dependency has been discussed elsewhere in the thread.

> +		if (-e $mailrc) {
> +			open FILE, $mailrc or die "Failed open $mailrc: $!";

Please use the three-argument of 'open', and use a regular scalar
instead of a glob. Both are safer, and we assume a modern enough perl to
support both. I.e.:

  open(my $file, '<', $mailrc)
          or die "failed to open $mailrc: $!";

> +			while (<FILE>) {
> +			    chomp;
> +			    if (/set sendmail=.*/) {
> +				my @data = split '"';
> +				$smtp_server = $data[1];
> +				last;
> +			    }

Your split is a rather unusual way to do the parsing, and it took me a
minute to figure it out. It might be more obvious as:

  if (/set sendmail="(.*)"/) {
          $smtp_server = $1;
          last;
  }

I do not know anything about the mailrc format, nor does it seem to be
well documented. Are the double-quotes required? If not, then the above
regex can easily make them optional. I also wonder if any whitespace is
allowed. E.g., this might be more forgiving:

  /set sendmail\s*=\s*"?(.*?)"?/

but I am just guessing at what the format allows.

-Peff
