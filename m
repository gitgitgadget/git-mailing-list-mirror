From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: fix textconv error zombies
Date: Tue, 30 Mar 2010 18:56:29 -0400
Message-ID: <20100330225628.GB608@coredump.intra.peff.net>
References: <20100328145301.GA26213@coredump.intra.peff.net>
 <201003301936.03394.j6t@kdbg.org>
 <7vk4stv5y5.fsf@alter.siamese.dyndns.org>
 <201003310017.24979.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 00:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwkMd-0002Cm-89
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 00:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab0C3W4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 18:56:42 -0400
Received: from peff.net ([208.65.91.99]:52025 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab0C3W4l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 18:56:41 -0400
Received: (qmail 26908 invoked by uid 107); 30 Mar 2010 22:57:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 30 Mar 2010 18:57:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Mar 2010 18:56:29 -0400
Content-Disposition: inline
In-Reply-To: <201003310017.24979.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143616>

On Wed, Mar 31, 2010 at 12:17:24AM +0200, Johannes Sixt wrote:

> This could deadlock in the theoretical case that the read() in the parent 
> returns an error even though the child is still writing data; the child would 
> hang while waiting for the pipe being drained by the parent; but the parent 
> would wait for the child to exit, which never happens. Doing the close() 
> before finish_command() avoids this situation because the child dies of 
> SIGPIPE.

Yeah, I actually thought about that while writing the error case for
strbuf_read (I do close(child.out) before finish_command). But I didn't
consider it in the success case. I don't think it matters here because
we will already have gotten EOF from child.out, which should mean the
child is no longer writing and will not block.

So I am not sure there is any deadlock, but I am fine with your version
of the patch.

-Peff
