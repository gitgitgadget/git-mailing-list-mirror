From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/13] transport-helper: check status code of
 finish_command
Date: Sun, 29 Aug 2010 16:52:24 -0500
Message-ID: <20100829215223.GF1890@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-5-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 23:54:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpppS-0005ut-Op
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 23:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab0H2VyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 17:54:14 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43924 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab0H2VyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 17:54:13 -0400
Received: by gwj17 with SMTP id 17so1776542gwj.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=q3J5e5LxUY+wuCxmnB+cjchNXeBCSwqhrSwh4By7F4U=;
        b=bBMOySgrK4xOy5xb5KclQV0Yicq4LkHiDMvbwYgOSJZAERx1NYg4Ux61UHQK+4Nj2o
         zMimc2paBqn8LXufKyfcvu7pBmb0lAh/+o+wUQxevt3XLbbB6GN9TPzg/1zc+N0M0Zn7
         u3McZ6KeSkIA1/+n6nMGq8hfh+w6Td9FSPZcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AgWBAjPZvuq1RSE+D9x2jjZ9mGpUp3RsHD1BfojX0TBlQPKQ85LQMzmRWFXkLE48rI
         9bwb8y6iCWmY159mSfGCMZGtkOe0wg9l3ljCUPc/wA+LTCZu3c2z1QzrBHnGnjPRVhq3
         Ci7PeZQ92RvPp5KsTDhe9MQr+zBLSo7/0DfP0=
Received: by 10.101.155.15 with SMTP id h15mr3588202ano.162.1283118853042;
        Sun, 29 Aug 2010 14:54:13 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t30sm11296168ann.7.2010.08.29.14.54.12
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 14:54:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283053540-27042-5-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154723>

Sverre Rabbelier wrote:

> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -410,8 +412,11 @@ static int fetch_with_import(struct transport *transport,
>  		sendline(data, &buf);
>  		strbuf_reset(&buf);
>  	}
> -	disconnect_helper(transport);
> -	finish_command(&fastimport);
> +	if(disconnect_helper(transport))
> +		die("Error while disconnecting helper");
> +	if (finish_command(&fastimport))
> +		die("Error while running fast-import");

Nit: missing space after "if".

> +
>  	free(fastimport.argv);
>  	fastimport.argv = NULL;
>  
> @@ -751,8 +756,10 @@ static int push_refs_with_export(struct transport *transport,
>  		die("Couldn't run fast-export");
>  
>  	data->no_disconnect_req = 1;
> -	finish_command(&exporter);
> -	disconnect_helper(transport);
> +	if(finish_command(&exporter))
> +		die("Error while running fast-export");
> +	if(disconnect_helper(transport))

Likewise.

Thanks for this.  A test would be nice if someone has time to write
one.
