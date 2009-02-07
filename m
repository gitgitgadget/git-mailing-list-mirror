From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] use lock token in non-URI form in start_put
Date: Sat, 7 Feb 2009 21:20:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902072114360.10279@pacific.mpi-cbg.de>
References: <498DE0B9.6080603@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 21:21:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVtgO-0001Jh-Uq
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 21:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbZBGUUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 15:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbZBGUUQ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 15:20:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:37407 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753129AbZBGUUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 15:20:15 -0500
Received: (qmail invoked by alias); 07 Feb 2009 20:20:12 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 07 Feb 2009 21:20:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xZaxoC8Zxme1wBNOYWGoOlatYeGmt6+AJ0dxVM7
	TXOC/L4IxBAKZu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <498DE0B9.6080603@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108878>

Hi,

On Sun, 8 Feb 2009, Tay Ray Chuan wrote:

> After 753bc91 ("Remove the requirement opaquelocktoken uri scheme"),
> lock tokens are in the URI forms in which they are received from the
> server, eg. 'opaquelocktoken:', 'uuid:'
>
> However, "start_put" (and consequently "start_move"), which attempts to
> create a unique temporary file using the UUID of the lock token,
> inadvertently uses the lock token in its URI form. These file
> operations on the server may not be successful (specifically, in
> Windows), due to the colon ':' character from the URI form of the lock
> token in the file path.

If it is a prefix that happens to be part of the URI, but must not be used 
by the client code as a lock token, would it not be better to store the 
token in lock->token to begin with?

> To do this, the "start_put" gets the position of ':', which is used to
> separate the URI scheme from the part, eg. "<scheme>:". In addition,
> start_put uses the last position of ':', since URIs with component
> URIs are possible, eg. "urn:uuid:" One can be sure that the lock token
> will always contain the UUID and be in URI form, due to RFC 2518, or
> its successor RFC 4918 (see
> http://www.webdav.org/specs/rfc4918.html#ELEMENT_locktoken).
> 
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> 
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  http-push.c          |    2 +-
>  t/t5540-http-push.sh |    7 +++++++
>  2 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/http-push.c b/http-push.c
> index eefd64c..bd8f372 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -558,7 +558,7 @@ static void start_put(struct transfer_request *request)
> 
>  	append_remote_object_url(&buf, remote->url, hex, 0);
>  	strbuf_addstr(&buf, "_");
> -	strbuf_addstr(&buf, request->lock->token);
> +	strbuf_addstr(&buf, strrchr(request->lock->token, ':') + 1);

This is unsafe.  What if lock->token does not contain a colon?  Even if it 
happens to be the case now, in your setup, it might change, or there might 
be mistakes in the server code.  We should always play it safe if we 
cannot control the other side's code.

Ciao,
Dscho
