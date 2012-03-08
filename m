From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] tcp: unify ipv4 and ipv6 code paths
Date: Thu, 8 Mar 2012 15:10:08 -0600
Message-ID: <20120308211008.GA9497@burratino>
References: <20120308124857.GA7666@burratino>
 <20120308130913.GD9426@burratino>
 <CABPQNSYfv19cVQoAoUyXVaF1TpLXTYDRFnHE4vr=X42W771tbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 22:10:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5kbR-0007EK-A3
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 22:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535Ab2CHVKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 16:10:22 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43247 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592Ab2CHVKT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 16:10:19 -0500
Received: by ghrr11 with SMTP id r11so540788ghr.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 13:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=csQ5kNOcXx4okOdJxR/4SUod/4zSSi7RKL5hclU9vv8=;
        b=xptp5vDvAwJlTUUhy2pt6KL9ezzqXixYN7HTQGELn2jnTX9P7rgNUwIxCW/ZD/RzTY
         n+y8e337UpGspnUq2BpvB3YvB894f5WM3W6cBeHuFUDBgRjl7U1/0usrZq/hbjSK6qYQ
         vGAemGB4BNFavtWJSjQfd4Ggfl5wxCA60UTYATmBjlO4hD7DvXSUNe9bP6UrhruOoBmf
         0d1dIXIqGDzGDdS/fEiDkKj5HInxBmTcnTzqMQl8u48GqD709154yuI3Zjv5aProDWQL
         LFEYMjAlUVPVPEC84WB+OTjx81uk9Dfbps0NTLpWqhqCSiWimEqMprPtNj4CrqkocBMd
         WRPA==
Received: by 10.60.12.72 with SMTP id w8mr3106383oeb.31.1331241018580;
        Thu, 08 Mar 2012 13:10:18 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 8sm4104036obv.19.2012.03.08.13.10.16
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 13:10:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CABPQNSYfv19cVQoAoUyXVaF1TpLXTYDRFnHE4vr=X42W771tbA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192650>

Erik Faye-Lund wrote:

> I'm not entirely sure I understand the motivation here. We already had
> well-tested, implementations of IPv4 and IPv6 tcp-socket setup. Here
> you unify the code by adding abstraction, but it ends up amounting to
> more lines of code, with the details scattered around in different
> source files.

Thanks.  It's true: I didn't convey the motivation well at all.

Before this patch, git_tcp_connect_sock() looks roughly like this:

	#ifndef NO_IPV6

	static int git_tcp_connect_sock(char *host, int flags)
	{
		get_host_and_port(&host, &port);
		memcpy(&hints, tcp_stream_hints, sizeof(hints));
		gai = getaddrinfo(host, port, &hints, &ai);
		for (ai0 = ai; ai; ai = ai->ai_next, cnt++) {
			... socket(), connect(), etc ...
		}
		freeaddrinfo(ai0);
		enable_keepalive(sockfd);
		return sockfd;
	}

	#else

	static int git_tcp_connect_sock(char *host, int flags)
	{
		get_host_and_port(&host, &port);
		he = gethostbyname(host);
		for (ap = he->h_addr_list; *ap; ap++, cnt++) {
			... socket(), connect(), etc ...
		}
		enable_keepalive(sockfd);
		return sockfd;
	}

	#endif

Any change to this procedure has to be made in both places, and in the
past, that has caused some minor bugs that were unnoticed for a while,
but no big deal --- it's not that complicated, so the code duplication
is tolerable.

After this patch and the next two, it looks like so:

	static int git_tcp_connect_sock(char *host, int flags)
	{
		get_host_and_port(&host, &port);
		gai = dns_resolve(host, port, 0, &ai);
		for_each_address(i, ai) {
			... socket(), connect(), etc ...
		}
		dns_free(ai0);
		enable_keepalive(sockfd);
		return sockfd;
	}

That is, it is almost identical to the getaddrinfo version.

So it is not about making the code shorter, but about not repeating
ourselves.

I did this for my sanity while implementing the SRV code: if my
changes work with the gethostbyname API, this way it is much more
likely this way that they will still work with getaddrinfo, too.  So
basically, the point is that I did not want to have to think about the
!NO_IPV6 codepath while writing patches (and others might not want to
have to think about the NO_IPV6 codepath at all --- the same
advantages apply for them, too).

	API dictionary in the !NO_IPV6 case
	(see dns-ipv6.h and dns-ipv6.c for details):

	resolver_result = struct addrinfo *
	resolved_address = const struct addrinfo *
	dns_resolve = getaddrinfo
	dns_name = getnameinfo, use in error messages
	dns_ip_address = getnameinfo, git-daemon uses for %IP substitution
	for_each_address = for (ai0 = ai; ai; ai = ai->ai_next)

	dns_family = ->ai_family
	dns_socktype = ->ai_socktype
	etc

	dns_strerror = gai_strerror
	dns_free = freeaddrinfo

The dns_name()/dns_ip_address() pair is a little silly.  The former
returns its result in a static buffer and the latter uses malloc.
Improvements welcome.

Of course, git_tcp_connect_sock() is not the only function that uses
host resolution facilities.  The benefit scales as more functions get
converted.

Hope that helps,
Jonathan
