From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] daemon.c:handle: Remove unneeded check for null
 pointer.
Date: Sun, 14 Jul 2013 14:48:12 -0700
Message-ID: <20130714214812.GA13444@google.com>
References: <1373837749-14402-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 23:48:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyU9i-00010X-QI
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 23:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab3GNVsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 17:48:21 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:36192 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab3GNVsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 17:48:20 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so10685528pbc.15
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aKIwEtmdAFWhv7gnm1DnM7+OWFB0KY5HaiNP9XqbNr8=;
        b=pdI8AnHQM35cWEwAgpQE6Lp1Pl7d9eEN5RfpqoJUH5bFyzOxyi2ZOcsjJWaxG6YzH5
         k/QRp4OQpz9L2CweaBttk/NAa8Z45W295U0h7+3LzGKt148MLUPQwLcVc26BKxHQg0pK
         Ib0k+4iaXuF7PipvVv4c398v9vS7BkOxkBP5Q6wTqNBr8iNsXZJzqyCAVYC3gcN6n0Rm
         FDzy/3vLIyipWyqmNSoyatJoOOf+xdyqTIo9lM4S0ly4Ps9rrBVcXYw8d9gj9Jw1s0s5
         X+GznhsfCaHToTgrZ2ta0YBDNc3AXzbaEslydrh3ZDgRBeDEeL+dmRqhnzuXx7mwNxi3
         qKSw==
X-Received: by 10.68.34.165 with SMTP id a5mr50535851pbj.156.1373838499745;
        Sun, 14 Jul 2013 14:48:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id eg3sm60605523pac.1.2013.07.14.14.48.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 14:48:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373837749-14402-1-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230397>

Hi,

Stefan Beller wrote:

> addr doesn't need to be checked at that line as it it already accessed
> 7 lines before in the if (addr->sa_family).

Good catch.  This asymmetry has been present since the lines were first
introduced (all guarded by "if (addr)") in v1.4.1-rc1~3^2~4 (Log peer
address when git-daemon called from inetd, 2006-06-20).

> --- a/daemon.c
> +++ b/daemon.c
> @@ -754,19 +754,19 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>  	}
>  
>  	if (addr->sa_family == AF_INET) {
>  		struct sockaddr_in *sin_addr = (void *) addr;
>  		inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf + 12,
>  		    sizeof(addrbuf) - 12);
>  		snprintf(portbuf, sizeof(portbuf), "REMOTE_PORT=%d",
>  		    ntohs(sin_addr->sin_port));
>  #ifndef NO_IPV6
> -	} else if (addr && addr->sa_family == AF_INET6) {
> +	} else if (addr->sa_family == AF_INET6) {

At this point 'addr' is &ss.sa from service_loop, so it really cannot
be NULL.

So fwiw, I like this patch.
