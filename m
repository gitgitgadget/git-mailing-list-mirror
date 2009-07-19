From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [test failure] Re: t4114 binary file becomes symlink
Date: Sun, 19 Jul 2009 13:01:15 +0200
Message-ID: <200907191301.15533.j6t@kdbg.org>
References: <20090718134551.GC16708@vidovic> <200907182106.06776.j6t@kdbg.org> <20090718222947.GA31147@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 19 13:01:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSU9E-0000wM-S4
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 13:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbZGSLBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 07:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753080AbZGSLBW
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 07:01:22 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:8894 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbZGSLBW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 07:01:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 65A89CDF82;
	Sun, 19 Jul 2009 13:01:16 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id F39CD42764;
	Sun, 19 Jul 2009 13:01:15 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090718222947.GA31147@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123549>

On Sonntag, 19. Juli 2009, Jeff King wrote:
> Look at compat/snprintf.c. In git_vsnprintf, we are passed a "va_list
> ap", which we then repeatedly call vsnprintf on, checking the return to
> make sure we have enough space. But using a va_list repeatedly without a
> va_end and va_start in the middle invokes undefined behavior. So we need
> to va_copy it and use the copy.
>
> A patch is below, which fixes the problem for me. However, va_copy is
> C99, so we would generally try to avoid it. But I don't think there is a
> portable way of writing this function without it. And most systems
> shouldn't need to use our snprintf at all, so maybe it is portable
> enough. I dunno.

Problem is, snprintf was made for very old systems, which typically do not 
have va_copy. (E.g. Windows, but there the situation *might* have changed 
with the switch to gcc 4.)

The rationale not to use va_copy is that this function is to be used *only* if 
necessary, i.e. portability is already lacking, and if it can be verified 
that this function works as is. Portability and correct-by-the-law C code are 
*not* a goal here. If the function does not work as is, don't use it.

-- Hannes
