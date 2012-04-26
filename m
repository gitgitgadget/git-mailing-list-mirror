From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] t5570: fix forwarding of git-daemon messages via cat
Date: Thu, 26 Apr 2012 23:10:26 +0200
Message-ID: <4F99B9C2.7090805@in.waw.pl>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl> <20120414121358.GA26372@ecki> <20120414122127.GA31220@ecki> <4F8C3E0F.2040300@in.waw.pl> <20120416174230.GA19226@sigill.intra.peff.net> <20120416224424.GA10314@ecki> <20120419060326.GA13982@sigill.intra.peff.net> <4F8FB779.60004@viscovery.net> <20120426130129.GA27785@sigill.intra.peff.net> <4F999105.200@kdbg.org> <20120426195503.GA29526@ecki> <4F99B777.4020103@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 23:11:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNVxy-0004ie-Rk
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 23:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041Ab2DZVKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 17:10:54 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35574 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754910Ab2DZVKx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 17:10:53 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SNVxh-0003S8-3G; Thu, 26 Apr 2012 23:10:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <4F99B777.4020103@kdbg.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196415>

On 04/26/2012 11:00 PM, Johannes Sixt wrote:
> The shell function that starts git-daemon wants to read the first line of
> the daemon's stderr to ensure that it started correctly. Subsequent daemon
> errors should be redirected to fd 4 (which is the terminal in verbose mode
> or /dev/null in quiet mode). To that end the shell script used 'read' to
> get the first line of output, and then 'cat &' to forward everything else
> in a background process.
> 
> The problem is, that 'cat >&4 &' does not produce any output because the
> shell redirects a background process's stdin to /dev/null. To have this
> command invocation do anything useful, we have to redirect its stdin
> explicitly (which overrides the /dev/null redirection).
> 
> The shell function connects the daemon's stderr to its consumers via a
> FIFO. We cannot just do this:
> 
>    read line <git_daemon_output
>    cat <git_daemon_output >&4 &
> 
> because after the first redirection the pipe is closed and the daemon
> could receive SIGPIPE if it writes at the wrong moment. Therefore, we open
> the readable end of the FIFO only once on fd 7 in the shell and dup from
> there to the stdin of the two consumers.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Beautiful explanation. Thanks!
I can confirm that this fix works for me.

-
Zbyszek
