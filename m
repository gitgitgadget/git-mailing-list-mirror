Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A203113B293
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608537; cv=none; b=IQMhCj1fGjqG0b8lkZ5+nR773rz+UGF5vOgkIAxQfLiVaKl9DaVjGruazu7LjoKfXP1OTJlPUptkSvrNZkNE0gUEY90J8Oyl+lICDLhFfHquaIIlHP7iiuiWTq0Yf4zAntAz1QnPtNgjI/86Wk0SHVYf0UcHxNr1TDeHu5dA7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608537; c=relaxed/simple;
	bh=lYF5UIzImsJKawLoqu6wknbXlvn6fw1ZkTHwuijST4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPbW51Xj2eypb8PO6GKs5iQfU/giuvA3snj2vT9ITcrun4JD4SCr5ymtQMz0NCTXMaUShjH6SN2wRh5o1PYtHch95IUqJIjJxMz8VnsAuljiKWQmNesWfDwpDX6RZEZ5UUb4ssfLvTifp1DzPUPz93O8kbl49Fj3+pZZ+pA38Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MCB95Q85; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MCB95Q85"
Received: (qmail 149171 invoked by uid 106); 16 Jun 2026 11:15:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=lYF5UIzImsJKawLoqu6wknbXlvn6fw1ZkTHwuijST4o=; b=MCB95Q85VeS3mSm4VcvOW90ZIFPpTPd0shd8q8uJoqmFLZWwbiRaY1wCSqevhqGUgR73xCTiGaZOZGpyjZu+LHWTEmO1SmkUny4xQU1y8p2wAYSnyxCpn5SLixmlmCARyQ+Hzx+7wZiC/dz9JMbgg4iru3GjA3c+/zmKPXdGrupVGlESWj9AsonRkyaO2tgl32FrtrSh+sjDV0e3z30EA7MkzQZhWhRP8hABEK3RjrdhcIRw3tcStyXpFkqpvtDiyihINH9V/ryf3LUW37N8jFbmifCnxjCMngOukcvkXlm3aN/cReepAtawawJL8Vf5TB1xIKtMohTqazMAmLlu+g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2026 11:15:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 407763 invoked by uid 111); 16 Jun 2026 11:15:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2026 07:15:34 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Jun 2026 07:15:34 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] cat-file: speed up default format
Message-ID: <20260616111534.GB687438@coredump.intra.peff.net>
References: <5a7ed929-6fe0-496c-83bd-65dee57c2241@web.de>
 <20260615165326.GA91269@coredump.intra.peff.net>
 <df933ffa-1be2-4401-a4ac-9d72c9c4cdcc@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df933ffa-1be2-4401-a4ac-9d72c9c4cdcc@web.de>

On Mon, Jun 15, 2026 at 11:53:10PM +0200, René Scharfe wrote:

> >  	} else if (is_atom("rest", atom, len)) {
> > -		if (data->mark_query)
> > -			data->split_on_whitespace = 1;
> > -		else if (data->rest)
> 
> This removes support for rest being NULL, breaking t1006.381.

Yup. I did say "only lightly tested". ;)

The fix is obviously just:

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9cc7ec7a6f..370ca6d771 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -363,7 +363,8 @@ static void objectsize_disk_add(struct format_item *item UNUSED,
 static void rest_add(struct format_item *item UNUSED,
 		     struct strbuf *sb, struct expand_data *data)
 {
-	strbuf_addstr(sb, data->rest);
+	if (data->rest)
+		strbuf_addstr(sb, data->rest);
 }
 
 static void deltabase_add(struct format_item *item UNUSED,

I think perhaps this error shows that the mark_query thing in the
existing code obfuscates the logic a bit.

-Peff
