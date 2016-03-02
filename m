From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] bundle: keep a copy of bundle file name in the
 in-core bundle header
Date: Wed, 2 Mar 2016 04:01:29 -0500
Message-ID: <20160302090129.GC30295@sigill.intra.peff.net>
References: <xmqqvb556abd.fsf@gitster.mtv.corp.google.com>
 <xmqqr3ft6a9x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 10:01:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab2f2-0004V5-AY
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 10:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbcCBJBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 04:01:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:53094 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751085AbcCBJBc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 04:01:32 -0500
Received: (qmail 12064 invoked by uid 102); 2 Mar 2016 09:01:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 04:01:31 -0500
Received: (qmail 21937 invoked by uid 107); 2 Mar 2016 09:01:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 04:01:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2016 04:01:29 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3ft6a9x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288113>

On Tue, Mar 01, 2016 at 03:36:26PM -0800, Junio C Hamano wrote:

> This will be necessary when we start reading from a split bundle
> where the header and the thin-pack data live in different files.
> 
> The in-core bundle header will read from a file that has the header,
> and will record the path to that file.  We would find the name of
> the file that hosts the thin-pack data from the header, and we would
> take that name as relative to the file we read the header from.

Neat. I'm hoping this means you're working on split bundles. :)

> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index 4883a43..e63388d 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -36,8 +36,9 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	memset(&header, 0, sizeof(header));
> -	if (strcmp(cmd, "create") && (bundle_fd =
> -				read_bundle_header(bundle_file, &header)) < 0)
> +	header.bundle_file = bundle_file;

What are the memory ownership rules for header.bundle_file?

Here you assign from either an argv parameter or a stack buffer, and
here...

> @@ -112,6 +111,8 @@ void release_bundle_header(struct bundle_header *header)
>  	for (i = 0; i < header->references.nr; i++)
>  		free(header->references.list[i].name);
>  	free(header->references.list);
> +
> +	free((void *)header->bundle_file);
>  }

You free it.

The call in get_refs_from_bundle does do an xstrdup().

Should we have:

  void init_bundle_header(struct bundle_header *header, const char *file)
  {
	memset(header, 0, sizeof(*header));
	header.bundle_file = xstrdup(file);
  }

to abstract the whole procedure?

-Peff
