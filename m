From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] Clean stale environment pointer in
 finish_command()
Date: Mon, 10 Nov 2014 22:11:09 -0500
Message-ID: <20141111031109.GD21328@peff.net>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
 <cover.1415630072.git.johannes.schindelin@gmx.de>
 <df1b16208e443416f7185c8c8c110e637ea97ac4.1415630072.git.johannes.schindelin@gmx.de>
 <xmqqbnoe91dz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 04:11:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xo1rP-0006NE-Mf
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 04:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbaKKDLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 22:11:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:38968 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751365AbaKKDLL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 22:11:11 -0500
Received: (qmail 7904 invoked by uid 102); 11 Nov 2014 03:11:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 21:11:11 -0600
Received: (qmail 14324 invoked by uid 107); 11 Nov 2014 03:11:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 22:11:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 22:11:09 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbnoe91dz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 10, 2014 at 01:44:24PM -0800, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > In start_command(), unset "env" fields are initialized via "env_array". In
> > finish_command(), the "env_array" is cleared, therefore the "env" field
> > will point to free()d data.
> >
> > However, start_command() will set "env" to env_array.argv only if "env"
> > was unset to begin with, and if it was already set, the caller will need
> > the original value. Therefore, we need to be very careful only to reset
> > "env" in finish_command() when it has been initialized in start_command().
> 
> Hmph.  Does the same observation apply to cmd->argv that is
> initialied to point to cmd->args.argv only when it is unset?

Yes, they behave exactly the same (I think Dscho just doesn't hit it in
his patch because he assigns argv manually).

I don't have a real problem with going in this direction as a safety
measure, but I am not sure that it is safe to reuse a child_process
after finish_command in general, without an intervening
child_process_init. For instance, calling start_command will convert a
"child_process.in" value of "-1" instead a pipe, and overwrite that "-1"
with the descriptor of the pipe. A subsequent use of the same
child_process struct will ask the second child to use that pipe (the
write-half of the pipe, mind you) as its stdin, which is nonsensical.

So I think you are much better off just using two child_process structs
(or a single one and reinitializing in between calls).

-Peff
