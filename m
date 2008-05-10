From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Optimize common pattern of alloc_ref from string
Date: Sat, 10 May 2008 19:39:19 -0400
Message-ID: <20080510233918.GA315@sigill.intra.peff.net>
References: <1210462018-47060-1-git-send-email-kkowalczyk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: kkowalczyk@gmail.com
X-From: git-owner@vger.kernel.org Sun May 11 01:40:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juyg8-0001H1-Gj
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 01:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbYEJXjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 19:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754090AbYEJXjR
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 19:39:17 -0400
Received: from peff.net ([208.65.91.99]:4159 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454AbYEJXjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 19:39:16 -0400
Received: (qmail 27268 invoked by uid 111); 10 May 2008 23:39:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 10 May 2008 19:39:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 May 2008 19:39:19 -0400
Content-Disposition: inline
In-Reply-To: <1210462018-47060-1-git-send-email-kkowalczyk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81716>

On Sat, May 10, 2008 at 04:26:58PM -0700, kkowalczyk@gmail.com wrote:

> As a byproduct, fixes one place where string wasn't properly terminated.

Great. Does this fix a user-visible bug? It would be nice to mention in
the commit log _which_ place (though after reading the patch carefully,
it looks like the one interpret_target) so that people looking at the
commit later can understand exactly what was fixed.

> -	ref = alloc_ref(strlen(refname) + 1);
> -	strcpy(ref->name, refname);
> +	ref = alloc_ref_from_str(refname);

So this turns a 2-line construct into a 1-line construct...

> +struct ref *alloc_ref_from_str(const char* str)
> +{
> +	struct ref *ret;
> +	unsigned len = strlen(str) + 1;
> +	char *tmp = xmalloc(sizeof(struct ref) + len);
> +	ret = (struct ref*)tmp;
> +	memset(tmp, 0, sizeof(struct ref));
> +	tmp += sizeof(struct ref);
> +	memcpy(tmp, str, len);
> +	return ret;
> +}

But why do we need an 8-line function to do it?

The only difference I can see over

  struct ref *alloc_ref_from_str(const char *str)
  {
    unsigned len = strlen(str) + 1;
    struct ref *ret = alloc_ref(len);
    memcpy(ret->name, str, len);
    return ret;
  }

is that we avoid memsetting the name portion of the struct to 0 before
copying to it. It seems like an unproven micro-optimization that makes
it a bit harder to read.

-Peff
