From: Jeff King <peff@peff.net>
Subject: Re: [PATCH resend 3/3] transport.c::transport_push(): make ref
 status affect return value
Date: Fri, 4 Dec 2009 05:20:39 -0500
Message-ID: <20091204102039.GB27495@coredump.intra.peff.net>
References: <20091204145755.4d793b0b.rctay89@gmail.com>
 <20091204145643.296ec414.rctay89@gmail.com>
 <20091204145437.1a9910db.rctay89@gmail.com>
 <20091204145842.57c3c51c.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 11:21:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGVHa-0003wG-3g
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 11:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569AbZLDKUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 05:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755568AbZLDKUf
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 05:20:35 -0500
Received: from peff.net ([208.65.91.99]:33054 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755545AbZLDKUe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 05:20:34 -0500
Received: (qmail 18690 invoked by uid 107); 4 Dec 2009 10:25:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 04 Dec 2009 05:25:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Dec 2009 05:20:39 -0500
Content-Disposition: inline
In-Reply-To: <20091204145842.57c3c51c.rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134504>

On Fri, Dec 04, 2009 at 02:58:42PM +0800, Tay Ray Chuan wrote:

> -		if (!quiet || push_had_errors(remote_refs))
> -			print_push_status(transport->url, remote_refs,
> -					verbose | porcelain, porcelain,
> -					nonfastforward);
> +		if (!quiet)
> +			if (push_had_errors(remote_refs)) {
> +				ret = -1;
> +				print_push_status(transport->url, remote_refs,
> +						verbose | porcelain, porcelain,
> +						nonfastforward);
> +			}

Er, this doesn't seem right. It will no longer print anything under
non-quiet mode unless there are errors, and it will only set a return
value in non-quiet mode.

I think you want:

  if (push_had_errors(remote_refs)) {
          ret = -1;
          if (!quiet)
                  print_push_status(...)
  }
  else if (!quiet)
          print_push_status(...)

Actually, it may simply be more readable by storing the error result:

  int err = push_had_errors(remote_refs);
  if (err)
    ret = -1;
  if (!quiet || err)
    print_push_status(...);

-Peff
