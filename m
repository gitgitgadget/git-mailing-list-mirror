From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document smart http
Date: Tue, 20 Aug 2013 10:16:30 -0400
Message-ID: <20130820141630.GB32370@sigill.intra.peff.net>
References: <1376975288-17079-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 16:16:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBmjf-0000Jr-CY
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 16:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261Ab3HTOQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 10:16:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:37652 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006Ab3HTOQe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 10:16:34 -0400
Received: (qmail 20952 invoked by uid 102); 20 Aug 2013 14:16:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 09:16:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 10:16:30 -0400
Content-Disposition: inline
In-Reply-To: <1376975288-17079-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232598>

On Tue, Aug 20, 2013 at 12:08:08PM +0700, Nguyen Thai Ngoc Duy wrote:

> This may provide some clues for those who want to modify smart http
> code as smart http is pretty much undocumented. Smart http "document"
> so far is a few commit messages and the source code.

There was also this:

  http://article.gmane.org/gmane.comp.version-control.git/129734

which seems to have never gotten updated enough to be applied along with
the code. But with some updates to make sure it matches the current
behavior, it is probably a more comprehensive description.

But if you don't feel like spending more time on this on top of what
you've already done, I think the patch I'm responding to is better than
what we have now (i.e., nothing).

> +Reference Discovery
> +-------------------
> +
> +The server end always sends the list of references in both push and
> +fetch cases. This ref list is retrieved by the client's sending HTTP
> +GET request to a smart http url ending with
> +"/info/refs?service=<service>" where <service> could be either
> +git-upload-pack or git-receive-pack for fetching or pushing
> +respectively. The output is in pkt-line format.
> +
> +----
> +  advertised-refs  =  service
> +		      flush-pkt
> +		      (no-refs / list-of-refs)
> +		      flush-pkt
> +
> +  service          =  PKT-LINE("# service=" service-name)
> +  service-name     =  ("git-upload-pack" / "git-receive-pack")
> +
> +  no-refs          =  PKT-LINE(zero-id SP "capabilities^{}"
> +		      NUL capability-list LF)
> +
> +  list-of-refs     =  first-ref *other-ref
> +  first-ref        =  PKT-LINE(obj-id SP refname
> +		      NUL capability-list LF)
> +
> +  other-ref        =  PKT-LINE(other-tip / other-peeled)
> +  other-tip        =  obj-id SP refname LF
> +  other-peeled     =  obj-id SP refname "^{}" LF
> +
> +  capability-list  =  capability *(SP capability)
> +  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_")
> +  LC_ALPHA         =  %x61-7A
> +----

Most of this is a repeat of what is in the earlier sections. I don't
think the protocol is changing much and these are not likely to get out of
date with each other, but I wonder if it is easier on the reader to
simply describe the output in terms of what is added on top of the
regular ref advertisement (i.e., the service line). Something like:

  stateless-advertised-refs =  service
                               advertised-refs

  service                   =  PKT-LINE("# service=" service-name)
  service-name              =  ("git-upload-pack" / "git-receive-pack")

where advertised-refs is defined in the earlier BNF. You may also want
to note:

  Servers may respond to a smart request with a regular `advertised-refs`
  response rather than a `stateless-advertised-refs` response. In this
  case, the client MUST assume that the server does not understand smart
  HTTP and either abort or proceed with the non-smart protocol.

-Peff
