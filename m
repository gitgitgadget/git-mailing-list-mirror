From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/3] path: add a find_basename() portability function
Date: Sat, 30 May 2009 10:05:19 -0400
Message-ID: <20090530140519.GA22905@sigill.intra.peff.net>
References: <1243649890-4522-1-git-send-email-davvid@gmail.com> <1243649890-4522-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 16:05:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAPBf-0006Ex-Jx
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 16:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbZE3OFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 10:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbZE3OFT
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 10:05:19 -0400
Received: from peff.net ([208.65.91.99]:49436 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758725AbZE3OFT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 10:05:19 -0400
Received: (qmail 356 invoked by uid 107); 30 May 2009 14:05:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 30 May 2009 10:05:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 May 2009 10:05:19 -0400
Content-Disposition: inline
In-Reply-To: <1243649890-4522-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120353>

On Fri, May 29, 2009 at 07:18:09PM -0700, David Aguilar wrote:

> +/* return the basename of a path */
> +const char *find_basename(const char *path)
> +{
> +	const char *basename = path + strlen(path) - 1;
> +	while(*basename && basename > path) {
> +		basename--;
> +		if (is_dir_sep(*basename)) {
> +			basename++;
> +			break;
> +		}
> +	}
> +	return basename;
> +}

Hmm. Is there any point to the *basename condition in the loop? By using
strlen, you are not going to go past any NULs, and you are already
checking that you don't go past the beginning of the string.

Speaking of which, how does this handle an input of ""? It seems that it
would return a pointer to one character before the string. Given your
loop, you need to special-case when *path is NUL.

Also, how should trailing dir_seps be handled? basename() will actually
return "" if given "foo/". Your implementation, when given "/foo/bar/"
will return "bar/" (and it must keep the trailing bit since we are
neither reallocating nor munging the input string). But given
"/foo/bar//", it will return simply "/". I could see an argument for
either "bar//" or "", but I think behaving differently for trailing "/"
versus trailing "//" doesn't make sense.

-Peff
