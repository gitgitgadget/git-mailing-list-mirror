From: Jeff King <peff@peff.net>
Subject: Re: How to handle terminal detection in a daemon calling git?
Date: Sat, 2 Jun 2012 12:51:32 -0400
Message-ID: <20120602165132.GE15017@sigill.intra.peff.net>
References: <1338412607.9452.140661082904349.02F677C3@webmail.messagingengine.com>
 <20120531012908.GD5488@sigill.intra.peff.net>
 <7vaa0o98e5.fsf@alter.siamese.dyndns.org>
 <1338471582.12573.140661083191693.32060E78@webmail.messagingengine.com>
 <20120601095333.GF32340@sigill.intra.peff.net>
 <827737B4-F5EE-4FD3-9B1A-710047836080@castle.fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Travis <git@castle.fastmail.fm>
X-From: git-owner@vger.kernel.org Sat Jun 02 18:52:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SarYg-0007jU-PT
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 18:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460Ab2FBQvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 12:51:43 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41165
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759618Ab2FBQve (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 12:51:34 -0400
Received: (qmail 14181 invoked by uid 107); 2 Jun 2012 16:51:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jun 2012 12:51:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jun 2012 12:51:32 -0400
Content-Disposition: inline
In-Reply-To: <827737B4-F5EE-4FD3-9B1A-710047836080@castle.fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199050>

On Fri, Jun 01, 2012 at 08:52:04AM -0500, Travis wrote:

> With that in mind, I'm still seeing strange behavior when I do this,
> where it looks to me like I'm closing and then immediately assigning
> STDIN:
> 
>  my $null_in_fh;
>  open($null_in_fh, '<', '/dev/null') or die;
>  close *STDIN;  # this appears to mess things up, even with the
> following assignment
>  *STDIN = $null_in_fh;

Keep in mind that STDIN is a perl filehandle, not a file descriptor.
When you close it, you close the filehandle and its underlying
descriptor. Then you assign another filehandle to STDIN, which has its
own descriptor.

Try this:

  strace perl -e '
    open($null, "</dev/null");
    close *STDIN;
    *STDIN = $null;
    <STDIN>;
  '

you'll see that it is doing something like:

  open("/dev/null", O_RDONLY)             = 3
  close(0)                                = 0
  read(3, "", 8192)                       = 0

The final read comes from the new descriptor, and we never re-opened
descriptor 0. You are basically just pointing the name STDIN to a new
handle, not doing anything with the underlying descriptor.

> Because, if I just do this
>   open(STDIN, '<', '/dev/null') or die;
> even after the close and/or assignment, then all appears okay.

Yeah, this is the right way to re-open a descriptor in perl, because
open() does the magic to dup2 the newly opened descriptor onto STDIN's
descriptor.

> Thanks for your comments.

No problem. Glad it is working now.

-Peff
