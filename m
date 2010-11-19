From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] http-push: check path length before using it
Date: Fri, 19 Nov 2010 12:33:39 -0600
Message-ID: <20101119183339.GB26187@burratino>
References: <1290170790-2200-1-git-send-email-rctay89@gmail.com>
 <1290170790-2200-2-git-send-email-rctay89@gmail.com>
 <1290170790-2200-3-git-send-email-rctay89@gmail.com>
 <1290170790-2200-4-git-send-email-rctay89@gmail.com>
 <1290170790-2200-5-git-send-email-rctay89@gmail.com>
 <1290170790-2200-6-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 19:40:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJVtE-0000Gy-Kl
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 19:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756205Ab0KSSks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 13:40:48 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44592 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab0KSSkr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 13:40:47 -0500
Received: by qyk33 with SMTP id 33so184432qyk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 10:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VsfnxlPDQHQXZ2TEVi+nyIQ6FTtwTh7tBhVOywPLB08=;
        b=v+S0ngVK55O7QFO20xA51q3F6jiy6CtVTNSA+Emq6fUJannYWoirDIdQyO97miOW8G
         rxl5lBDOTIqx+TSExer/PDjXOYWSGN1H7PQNPe2FqELm8CZdpq68rzfZKYR7NWj1GCiH
         Z41zR9nUnywwFBgA0ngFLH1gWS+i/Nwipq0H4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NsuRo+0paF1gNFMuubJcocAH3GEBdVNjkGC3o9oA/13IetS3DzGXKrsKv6s/iFWHSZ
         jBeaiRaPKzUi7JeCqogNBksEJPaK6hy5j8PulvoXWgK2Wxvi7aI7OXxy7/SpvTdRiXGo
         Dz1U9VRt3aKWsdIzK4J/m4RPIZlO4MILnEn9I=
Received: by 10.224.2.141 with SMTP id 13mr1169389qaj.282.1290191666977;
        Fri, 19 Nov 2010 10:34:26 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id nb14sm1140280qcb.36.2010.11.19.10.34.24
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 10:34:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290170790-2200-6-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161775>

Tay Ray Chuan wrote:

> We use path_len to skip the base url/path, but we do not know for sure
> if path does indeed contain the base url/path. Check if this is so.
[...]
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1116,8 +1116,14 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
>  				}
>  			}
>  			if (path) {
> -				path += repo->path_len;
> -				ls->dentry_name = xstrdup(path);
> +				if (strncmp(path,
> +					    (repo->path ? repo->path : repo->url),
> +					    repo->path_len) == 0) {

Nits: the usual idiom is

 if (!strncmp(path, ...

to make it is obvious from looking at the left side that this is a
test for equality.  The parentheses around the second parameter are
not needed here...


> +					path += repo->path_len;
> +					ls->dentry_name = xstrdup(path);
> +				} else
> +					error("Parsed path '%s' does not match url: '%s'\n",
> +					      path, (repo->path ? repo->path : repo->url));

... or here.  So perhaps:

			if (path) {
				const char *url = repo->path;
				if (!url)
					url = repo->url;
				if (strncmp(path, url, repo->path_len)) {
					error("Parsed path '%s' does not match url: '%s'\n",
						path, url);
				} else {
					path += ...

By the way, is the error behavior correct?  This prints a message with
"error: " and then continues anyway.
