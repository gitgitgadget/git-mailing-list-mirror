From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Clean up connection correctly if object fetch wasn't
 done
Date: Sat, 26 Jan 2008 22:06:26 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801262205130.23907@racer.site>
References: <alpine.LNX.1.00.0801261647310.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jan 26 23:07:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JItBB-0005HH-Td
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 23:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbYAZWGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 17:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754495AbYAZWGn
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 17:06:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:45994 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754396AbYAZWGn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 17:06:43 -0500
Received: (qmail invoked by alias); 26 Jan 2008 22:06:41 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp039) with SMTP; 26 Jan 2008 23:06:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1881NE/RNQ8iMFo6RawlHMs7EicCC7LAmqNVVcMIf
	tcxWvlBMsKVvi0
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0801261647310.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71792>

Hi,

On Sat, 26 Jan 2008, Daniel Barkalow wrote:

> Further optimization allowed the fetch_objs call to be skipped if it 
> isn't necessary. However, this leaves the connection in need of cleaning 
> up to avoid getting an error message from the remote end when ssh is 
> used. Fix this.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> This fixes the "fatal: The remote end hung up unexpectedly" message in the 
> case I reproduced. It should probably get squashed into the other 
> single-connect commit, but I'm sending it separately for easier testing 
> for now.

Yeah, that fixes it.  Thanks.

> diff --git a/transport.c b/transport.c
> index 53fb2ec..199e9e6 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -677,7 +677,15 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
>  
>  static int disconnect_git(struct transport *transport)
>  {
> -	free(transport->data);
> +	struct git_transport_data *data = transport->data;
> +	if (data->conn) {
> +		packet_flush(data->fd[1]);
> +		close(data->fd[0]);
> +		close(data->fd[1]);
> +		finish_connect(data->conn);
> +	}
> +
> +	free(data);
>  	return 0;
>  }

Should this not set transport->data = NULL, just to be sure?

Ciao,
Dscho
