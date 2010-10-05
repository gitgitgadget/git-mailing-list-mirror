From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] Allow more than one keepfile in the transport
Date: Mon, 4 Oct 2010 21:11:33 -0500
Message-ID: <20101005021133.GB10818@burratino>
References: <4CA86A12.6080905@dbservice.com>
 <1286108511-55876-2-git-send-email-tom@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 04:14:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2x3R-0007Wo-62
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 04:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab0JECOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 22:14:51 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53874 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab0JECOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 22:14:51 -0400
Received: by qyk29 with SMTP id 29so1142379qyk.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 19:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QW/KTotIWlfcT9gA1BUdqhDX11ogO3e2mXOo+40cEyY=;
        b=CF3Xy4dstQXkgtExihKFpqCF8WAvhBeI9WN5VGCkZj0ipSZ7FzPaqLu+3cCSsQa0Nq
         swj4EUW//oqrWd1TT632eA5GAaIl8pqm9iTbHRy7IRi/lspAypfFjki5bOd0SHV/iwJk
         cKZRhfijv5iJxL1yLNpjQcDSIyynq758ExKKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mKmV2QRmuGzZrJnX3SOjtfWB17Tf/hfqJSo90mM0M5NYYlnutfQNtPVeXffezgU4MB
         JqUJZzg/pMXTOW3rfXyGneVSbVAP1NffI18lpDtPr3jcSJC6LLtymHcZNjwuXg87AY7o
         jkciptltOWUpH+deRfi5JFqzIrtD/MX6Kvhnk=
Received: by 10.224.62.199 with SMTP id y7mr7455489qah.293.1286244890543;
        Mon, 04 Oct 2010 19:14:50 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id j13sm1499281vcr.17.2010.10.04.19.14.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 19:14:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286108511-55876-2-git-send-email-tom@dbservice.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158158>

Tomas Carnecky wrote:

> Use an array to keep track of the pack lockfiles.

Should probably use a string_list (which is the same thing :)) to
save some code.

> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -362,10 +362,7 @@ static int fetch_with_fetch(struct transport *transport,
>  
>  		if (!prefixcmp(buf.buf, "lock ")) {
>  			const char *name = buf.buf + 5;
> -			if (transport->pack_lockfile)
> -				warning("%s also locked %s", data->name, name);
> -			else
> -				transport->pack_lockfile = xstrdup(name);
> +			transport_keep(transport, name);

Won't buf.buf be released before the lockfile needs to be read?

So I suspect the strdup is necessary.
