From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v2 3/8] Support taking over transports
Date: Fri, 4 Dec 2009 10:27:53 -0800
Message-ID: <20091204182753.GD1483@spearce.org>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi> <1259942168-24869-6-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Dec 04 19:28:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGcst-0003C7-AD
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 19:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbZLDS1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 13:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbZLDS1v
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 13:27:51 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:64785 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbZLDS1u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 13:27:50 -0500
Received: by yxe17 with SMTP id 17so2322554yxe.33
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 10:27:57 -0800 (PST)
Received: by 10.100.244.2 with SMTP id r2mr4438760anh.17.1259951276679;
        Fri, 04 Dec 2009 10:27:56 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm1640551yxe.18.2009.12.04.10.27.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 10:27:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1259942168-24869-6-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134563>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> Add support for taking over transports that turn out to be smart.

I really don't like this disown strategy and its magic ref return
value from fetch.
 
> @@ -1020,7 +1089,13 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
>  			heads[nr_heads++] = rm;
>  	}
>  
> +retry:
>  	rc = transport->fetch(transport, nr_heads, heads);
> +	if(rc == TRANSPORT_LAYER6_READY) {
> +		git_take_over_transport(transport);
> +		goto retry;
> +	}

Why can't you expose git_take_over_transport as a public function
and then the transport-helper.c code can instead do:

	... setup connect with helper ...
	transport_takeover(transport, child);
	return transport->fetch(....);

Would this make the code simpler?

-- 
Shawn.
