From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] bundle: plug resource leak
Date: Wed, 2 Mar 2016 03:54:32 -0500
Message-ID: <20160302085432.GB30295@sigill.intra.peff.net>
References: <xmqqvb556abd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 09:54:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab2YJ-00015Z-9x
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 09:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbcCBIyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 03:54:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:53084 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751144AbcCBIyf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 03:54:35 -0500
Received: (qmail 11764 invoked by uid 102); 2 Mar 2016 08:54:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 03:54:35 -0500
Received: (qmail 21832 invoked by uid 107); 2 Mar 2016 08:54:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 03:54:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2016 03:54:32 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvb556abd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288111>

On Tue, Mar 01, 2016 at 03:35:34PM -0800, Junio C Hamano wrote:

> The bundle header structure holds two lists of refs and object
> names, which should be released when the user is done with it.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  bundle.c    | 12 ++++++++++++
>  bundle.h    |  1 +
>  transport.c |  1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/bundle.c b/bundle.c
> index 506ac49..9c5a6f0 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -102,6 +102,18 @@ int is_bundle(const char *path, int quiet)
>  	return (fd >= 0);
>  }
>  
> +void release_bundle_header(struct bundle_header *header)
> +{
> +	int i;
> +
> +	for (i = 0; i < header->prerequisites.nr; i++)
> +		free(header->prerequisites.list[i].name);
> +	free(header->prerequisites.list);
> +	for (i = 0; i < header->references.nr; i++)
> +		free(header->references.list[i].name);
> +	free(header->references.list);
> +}

Looks good. It's probably not worth adding a release_ref_list() to
handle the repeated data structures.

I do find it hard to believe that the bundle code had to invent its own
ref storage data structure, and couldn't just use "struct ref" like all
of the other code. It doesn't look like we ever sort it or do
non-sequential access. The linked-list "struct ref" probably would have
been fine.

Not a problem you are introducing, of course, but if you are touching
this code a lot, it might be worth seeing how painful it is.

-Peff
