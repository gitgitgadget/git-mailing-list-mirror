From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Function stripspace now gets a buffer instead file
 descriptors.
Date: Wed, 11 Jul 2007 20:17:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707112010560.4516@racer.site>
References: <4695267A.7080202@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 21:17:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8hgY-0005VO-5m
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 21:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757716AbXGKTRL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 15:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757463AbXGKTRK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 15:17:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:59979 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757205AbXGKTRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 15:17:09 -0400
Received: (qmail invoked by alias); 11 Jul 2007 19:17:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 11 Jul 2007 21:17:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+31kxpbja3bi3W6VRHKsDpqebvHMBBteVO6MttqD
	TGEOCQ6wsWcxGV
X-X-Sender: gene099@racer.site
In-Reply-To: <4695267A.7080202@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52190>

Hi,

On Wed, 11 Jul 2007, Carlos Rica wrote:

> @@ -28,52 +26,67 @@ static int cleanup(char *line, int len)
>   * Remove empty lines from the beginning and end
>   * and also trailing spaces from every line.
>   *
> + * Note that the buffer will not be null-terminated.
> + *
>   * Turn multiple consecutive empty lines between paragraphs
>   * into just one empty line.
>   *
>   * If the input has only empty lines and spaces,
>   * no output will be produced.
>   *
> + * If last line has a newline at the end, it will be removed.
> + *

Please let me comment about the rationale for both changes: The 
stripspace() function (which this hunk is about) is more useful if it does 
not allocate a new buffer, but works in-place.

And since it knows the new length already, it can just as well return the 
length, and _not_ NUL terminate (which would mean that we have to 
reallocate if we used read_pipe() to get the buffer).

The reason for the missing newline at the end is the same: since we accept 
buffers with a missing newline at the end, we would have to reallocate in 
that case.

So for the sake of simplicity, we neither NUL-terminate, nor \n terminate 
the buffer, and leave that to the callers.

Ciao,
Dscho
