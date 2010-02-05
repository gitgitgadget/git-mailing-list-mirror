From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 3/3] make git push --dry-run --porcelain exit with
 status 0 even if updates will be rejected
Date: Sat, 6 Feb 2010 07:50:25 +0800
Message-ID: <20100206075025.c1fe6b5a.rctay89@gmail.com>
References: <cover.1265402797.git.larry@elder-gods.org>
	<cea7001d626116d76d885e24152d68cf41eca4dd.1265402797.git.larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:50:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXwi-00062o-HA
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934003Ab0BEXuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:50:40 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:43960 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933483Ab0BEXuj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:50:39 -0500
Received: by ewy28 with SMTP id 28so627458ewy.28
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 15:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=OrZa1KXlNlzD+XiZu+V/E0GmEtM/JIMsCq+P1zeIusI=;
        b=oUOom+GxCCc6fsySyS4EMZsIPLqvescjYPRZg+WcJH47lECy7CIJaUNrtyVtxvCjH9
         SIzXxEwYNhhRFpPSaK17WUXFx2tx3e5srAWnlmYErIcNPpKWvFmBBEnfiK4QErmCZ++p
         m2vzCx07iosthy9T4YKqVJ9tNkzogcIdLGPU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=saNVU7KTO5W9pGjWnBlsqx04+nqI6euLXMTXz1zIctFFMA3htv2xukaU9WMzNhkOZ5
         GLrB7BVIsS/kiapGMuJ++YOW0ri70sLrDqjiiT8hDxE+U+a8YoUQDq1FZzlmAYueUXug
         yxeRFpeY5FTF8yzrr6Saz4tIETpwAvIjx8tV8=
Received: by 10.213.96.227 with SMTP id i35mr2916616ebn.35.1265413836569;
        Fri, 05 Feb 2010 15:50:36 -0800 (PST)
Received: from your-cukc5e3z5n (cm31.zeta153.maxonline.com.sg [116.87.153.31])
        by mx.google.com with ESMTPS id 14sm1354501ewy.3.2010.02.05.15.50.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Feb 2010 15:50:35 -0800 (PST)
In-Reply-To: <cea7001d626116d76d885e24152d68cf41eca4dd.1265402797.git.larry@elder-gods.org>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139125>

Hi,

instead of:

> diff --git a/transport.c b/transport.c
> index 00d986c..b41e1dc 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -558,8 +558,10 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	return (refs ? 0 : -1);
>  }
>  
> -static int push_had_errors(struct ref *ref)
> +static int push_had_errors(struct ref *ref, int flags)
>  {
> +	if (flags & TRANSPORT_PUSH_DRY_RUN && flags & TRANSPORT_PUSH_PORCELAIN)
> +		return 0;
>  	for (; ref; ref = ref->next) {
>  		switch (ref->status) {
>  		case REF_STATUS_NONE:

and:

> @@ -1052,7 +1055,7 @@ int transport_push(struct transport *transport,
>  			flags & TRANSPORT_PUSH_FORCE);
>  
>  		ret = transport->push_refs(transport, remote_refs, flags);
> -		err = push_had_errors(remote_refs);
> +		err = push_had_errors(remote_refs, flags);
>  
>  		ret |= err;
>  

why not:

-->8--
@@ -1049,7 +1052,7 @@ int transport_push(struct transport *transport,
			flags & TRANSPORT_PUSH_FORCE);

		ret = transport->push_refs(transport, remote_refs, flags);
-		err = push_had_errors(remote_refs);
+		err = (pretend && porcelain) ? 0 : push_had_errors(remote_refs);

		ret |= err;

-->8--

-- 
Cheers,
Ray Chuan
