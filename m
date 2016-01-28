From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pass transport verbosity down to git_connect
Date: Thu, 28 Jan 2016 18:53:40 -0500
Message-ID: <20160128235339.GB10308@sigill.intra.peff.net>
References: <20160128225123.GA20045@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 00:53:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOwNn-0003pj-0H
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 00:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbcA1Xxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 18:53:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:34056 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750832AbcA1Xxn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 18:53:43 -0500
Received: (qmail 29661 invoked by uid 102); 28 Jan 2016 23:53:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jan 2016 18:53:42 -0500
Received: (qmail 26100 invoked by uid 107); 28 Jan 2016 23:54:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jan 2016 18:54:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jan 2016 18:53:40 -0500
Content-Disposition: inline
In-Reply-To: <20160128225123.GA20045@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285048>

On Thu, Jan 28, 2016 at 10:51:23PM +0000, Eric Wong wrote:

> While working in connect.c to perform non-blocking connections,
> I noticed calling "git fetch -v" was not causing the progress
> messages inside git_tcp_connect_sock to be emitted as I
> expected.
> 
> Looking at history, it seems connect_setup has never been called
> with the verbose parameter.  Since transport already has a
> "verbose" field, use that field instead of another parameter
> in connect_setup.

That makes sense, but...

> -static int connect_setup(struct transport *transport, int for_push, int verbose)
> +static int connect_setup(struct transport *transport, int for_push)
>  {
>  	struct git_transport_data *data = transport->data;
> +	int flags = transport->verbose > 0 ? CONNECT_VERBOSE : 0;

Do we want to trigger this only for "transport->verbose > 1"?

Right now, "git fetch -v" gives us a verbose status table (i.e.,
includes up-to-date refs), but no more debugging than that. Should we
reserve more debug-ish information like for "git fetch -vv"?

-Peff
