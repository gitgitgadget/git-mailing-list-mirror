From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Allow update hooks to update refs on their own
Date: Wed, 28 Nov 2007 18:03:55 -0500
Message-ID: <20071128230355.GB13964@coredump.intra.peff.net>
References: <C1321BD5-8F6B-47F9-9BDB-C2BF819D6F17@midwinter.com> <20071128221403.GA3256@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:04:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVx5-0004Xr-6d
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755143AbXK1XD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755055AbXK1XD6
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:03:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4294 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754825AbXK1XD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 18:03:57 -0500
Received: (qmail 15038 invoked by uid 111); 28 Nov 2007 23:03:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 18:03:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 18:03:55 -0500
Content-Disposition: inline
In-Reply-To: <20071128221403.GA3256@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66455>

On Wed, Nov 28, 2007 at 02:14:03PM -0800, Steven Grimm wrote:

> @@ -177,7 +179,16 @@ static int receive_status(int in, struct ref *refs)
>  
>  		line[strlen(line)-1] = '\0';
>  		refname = line + 3;
> -		msg = strchr(refname, ' ');
> +		newsha1_hex = strchr(refname, ' ');
> +		if (newsha1_hex) {
> +			*newsha1_hex++ = '\0';
> +			if (get_sha1_hex(newsha1_hex, newsha1)) {
> +				fprintf(stderr, "protocol error: bad sha1 %s\n",
> +					newsha1_hex);
> +				newsha1_hex = NULL;
> +			}
> +		}
> +		msg = strchr(newsha1_hex, ' ');
>  		if (msg)
>  			*msg++ = '\0';

Doesn't this always put the first "word" of a response into newsha1_hex?
We want to do this only for 'ok' responses; 'ng' responses are already
using that space as part of the error message.

-Peff
