From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] remove unnecessary test and dead diagnostic
Date: Thu, 26 May 2011 16:37:10 +0200
Message-ID: <87hb8h5y09.fsf@rho.meyering.net>
References: <87tych5zrh.fsf@rho.meyering.net>
	<20110526141130.GB18520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 16:37:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPbgo-0005bU-92
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 16:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758036Ab1EZOhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 10:37:21 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:35318 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757511Ab1EZOhS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 10:37:18 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id EE895940133
	for <git@vger.kernel.org>; Thu, 26 May 2011 16:37:11 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id B9E4C601E2; Thu, 26 May 2011 16:37:10 +0200 (CEST)
In-Reply-To: <20110526141130.GB18520@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 May 2011 10:11:30 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174516>

Jeff King wrote:
...
>   $ sed -n '/read_in_full/,/^}/p' wrapper.c
>   ssize_t read_in_full(int fd, void *buf, size_t count)
>   {
>           char *p = buf;
>           ssize_t total = 0;
>
>           while (count > 0) {
>                   ssize_t loaded = xread(fd, p, count);
>                   if (loaded <= 0)
>                           return total ? total : loaded;
>                   count -= loaded;
>                   p += loaded;
>                   total += loaded;
>           }
>
>           return total;
>   }
>
> It looks like if we get -1 on the _first_ read, we will then return -1.
> Subsequent errors are then ignored, and we return the (possibly
> truncated) result.
>
> Which, to be honest, seems kind of insane to me. I'd think:
>
>   while (count > 0) {
>           ssize_t loaded = xread(fd, p, count);
>           if (loaded < 0)
>                   return loaded;
>           if (loaded == 0)
>                   return total;
>           ...
>   }
>
> would be much more sensible semantics.

That looks better to me, too.
