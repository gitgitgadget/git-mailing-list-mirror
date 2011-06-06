From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] tcp: unify ipv4 and ipv6 code paths
Date: Mon, 6 Jun 2011 05:01:47 -0500
Message-ID: <20110606100147.GN8015@elie>
References: <20110524202249.GA5889@elie>
 <20110524230900.GA9440@radis.liafa.jussieu.fr>
 <20110606093019.GD8015@elie>
 <20110606094128.GJ8015@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Julien Cristau <jcristau@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 12:02:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTWdE-0003si-Gd
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 12:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249Ab1FFKBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 06:01:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45632 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756192Ab1FFKBv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 06:01:51 -0400
Received: by iwn34 with SMTP id 34so2981903iwn.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=D+IVsrZ6aVE8/pgJmFej/hjlD2aYGGWL9UrSnqeoVU4=;
        b=dGK2z56V0Dyk7FpCId5uotJ3II32BPo8HXGaalI7H0jg+TyTqdVaX3Tv4xYEfuCxbt
         IFnqudEOiXbq5Ezm1L83VeRbYMPuaz7dFe5TrjHo/p6+4V13KPp20CCRMM/+TO8cs13l
         Nw8oRqZFPjE1Dav2BafOGbCdaw31G8iAenamQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yB1lFNIrouzrKR7SkJpu9QTnXfKo2UjYLhoLPnmiTHEnNtYWW2AJiRjWHt5Nq5Phpl
         xHSVhrdsyauLA7ICUG5Ee7Y5VcjhlIvCEc/yyzXFJ3ZFnNP6/Lf/jjmUGfyJR57aMGlm
         n9mb8xt0fBnjP+yr0U3pNF3HfmaXQLrQcA6r0=
Received: by 10.231.69.198 with SMTP id a6mr8043676ibj.181.1307354511193;
        Mon, 06 Jun 2011 03:01:51 -0700 (PDT)
Received: from elie (adsl-68-255-97-40.dsl.chcgil.sbcglobal.net [68.255.97.40])
        by mx.google.com with ESMTPS id v15sm1619368ibh.45.2011.06.06.03.01.49
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 03:01:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110606094128.GJ8015@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175114>

Jonathan Nieder wrote:

>                  tells getaddrinfo to restrict attention to TCP
> services after this patch.  That should make a difference because the
> service parameter is NULL.

Sorry, the last sentence should say "That should _not_ make a
difference".  You would be able to tell the difference between the
before and after with "strace git daemon" because of the ai_socktype
and ai_protocol settings:

[...]
> +int dns_resolve(const char *host, const char *port, int flags,
> +		resolver_result *res)
> +{
> +	struct addrinfo hints;
> +	int gai;
> +
> +	memset(&hints, 0, sizeof(hints));
> +	if (flags & RESOLVE_CANONNAME)
> +		hints.ai_flags = AI_CANONNAME;
> +	hints.ai_socktype = SOCK_STREAM;
> +	hints.ai_protocol = IPPROTO_TCP;
> +
> +	gai = getaddrinfo(host, port, &hints, res);

but I don't think the effect is any different --- the ai_socktype and
protocol hints are for getservbyname functionality and the code that
cares about it was already passing those hints.
