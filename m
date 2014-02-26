From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit.c: use the generic "sha1_pos" function for lookup
 sha1
Date: Wed, 26 Feb 2014 05:41:51 -0500
Message-ID: <20140226104150.GD25711@sigill.intra.peff.net>
References: <530DBCF3.9060801@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Feb 26 11:42:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIbwG-00036D-1u
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 11:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbaBZKmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 05:42:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:57255 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750774AbaBZKmC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 05:42:02 -0500
Received: (qmail 9335 invoked by uid 102); 26 Feb 2014 10:42:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Feb 2014 04:42:01 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Feb 2014 05:41:51 -0500
Content-Disposition: inline
In-Reply-To: <530DBCF3.9060801@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242711>

On Wed, Feb 26, 2014 at 02:07:47PM +0400, Dmitry S. Dolzhenko wrote:

> Refactor binary search in "commit_graft_pos" function: use
> generic "sha1_pos" function.

Sounds sensible.

A few administrative points for your patch:

  - we usually try to send patches inline, rather than as attachments.
    It almost looks like your mailer or a server on the path converted
    your mail to a multipart/mixed and stuck a useless empty attachment
    on the end.

  - Your patch did not apply for me, nor to the blobs mentioned in its
    header. Did you modify it after it was generated? I think this part
    in particular looks suspicious:


> diff --git a/commit.c b/commit.c
> index 6bf4fe0..8edaeb7 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -10,6 +10,7 @@
>  #include "mergesort.h"
>  #include "commit-slab.h"
>  #include "prio-queue.h"
> +#include "sha1-lookup.h"
>   static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);

There are 3 context lines above, but only one below?

>  @@ -114,23 +115,16 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
>  static struct commit_graft **commit_graft;
>  static int commit_graft_alloc, commit_graft_nr;
>  +static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
> +{
> +	struct commit_graft **commit_graft_table = table;
> +	return commit_graft_table[index]->sha1;
> +}
> +

And here we have only two context lines, and the first addition line is
indented (making it look like a context line).

>  static int commit_graft_pos(const unsigned char *sha1)
>  {
> -	int lo, hi;
> -	lo = 0;
> -	hi = commit_graft_nr;
> -	while (lo < hi) {
> -		int mi = (lo + hi) / 2;
> -		struct commit_graft *graft = commit_graft[mi];
> -		int cmp = hashcmp(sha1, graft->sha1);
> -		if (!cmp)
> -			return mi;
> -		if (cmp < 0)
> -			hi = mi;
> -		else
> -			lo = mi + 1;
> -	}
> -	return -lo - 1;
> +	return sha1_pos(sha1, commit_graft, commit_graft_nr,
> +			   commit_graft_sha1_access);

The patch itself looks correct.

-Peff
