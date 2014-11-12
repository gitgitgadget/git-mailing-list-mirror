From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] Clean stale environment pointer in
 finish_command()
Date: Wed, 12 Nov 2014 05:52:29 -0500
Message-ID: <20141112105229.GA29101@peff.net>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
 <cover.1415630072.git.johannes.schindelin@gmx.de>
 <df1b16208e443416f7185c8c8c110e637ea97ac4.1415630072.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.1411101539091.13845@s15462909.onlinehome-server.info>
 <20141111031636.GE21328@peff.net>
 <xmqqr3x97mv4.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1411121142480.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 12 11:52:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoVXQ-0005bX-7H
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 11:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbaKLKwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 05:52:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:39455 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752698AbaKLKwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 05:52:31 -0500
Received: (qmail 2235 invoked by uid 102); 12 Nov 2014 10:52:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Nov 2014 04:52:31 -0600
Received: (qmail 5944 invoked by uid 107); 12 Nov 2014 10:52:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Nov 2014 05:52:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2014 05:52:29 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1411121142480.13845@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 12, 2014 at 11:45:19AM +0100, Johannes Schindelin wrote:

> Okay, I have to say that I was led to believe that reusing the
> child_process struct is okay because argv_array_clear() explicitly
> reinitializes the env_array field, something that is useless churn unless
> you plan to reuse the memory.

The argv_array code prepares its data structure for reuse after freeing.
But child_process which uses it does not make any such promises. If
there were an argv_array_free(), child_process could use it. But there
is only argv_array_clear().

I don't have a problem with finish_command leaving its child_process in
a known usable state (e.g., by calling child_process_init). But I also
don't see much benefit.

> However, my personal taste says that reusing the same memory is more
> elegant than to waste extra memory unnecessarily, so I will go with the
> child_process_init() solution.

I do not mind much either way. But I doubt that a single extra struct on
the stack will break the bank, compared to the fact that we are forking
and execing a new program. I'd also not be surprised if a smart compiler
could notice that the variables are used exclusively in non-overlapping
bits of the code, and just reuse the stack space.

-Peff
