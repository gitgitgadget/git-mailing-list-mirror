From: Jeff King <peff@peff.net>
Subject: Re: Repository data loss in fast-export with a merge of a deleted
 submodule
Date: Wed, 30 Nov 2011 02:15:19 -0500
Message-ID: <20111130071519.GF5317@sigill.intra.peff.net>
References: <4EA9B0B5.6060005@workspacewhiz.com>
 <4EB2BBB5.3030908@workspacewhiz.com>
 <4EC12E8B.3050909@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 08:15:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVeO7-0003gc-Td
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 08:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab1K3HPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 02:15:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56033
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415Ab1K3HPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 02:15:22 -0500
Received: (qmail 8126 invoked by uid 107); 30 Nov 2011 07:21:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Nov 2011 02:21:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2011 02:15:19 -0500
Content-Disposition: inline
In-Reply-To: <4EC12E8B.3050909@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186112>

On Mon, Nov 14, 2011 at 08:06:51AM -0700, Joshua Jensen wrote:

> __This is a genuine data loss problem in Git.__
> 
> I'm confused at the lack of response to this.  I first posted about
> the issue **2-1/2 weeks ago**, and there have been no responses  Does
> no one care?

Still not much response.

I think the keywords "submodule" and "fast-export" in the subject line
hit a lot of people's do-not-care filters.

I read your original two messages. It does seem like a simple ordering
problem from your description. I suspect you would get more response to
actually post your patch with a commit message explaining the problem,
and an accompanying test. And then at the very least, one outcome could
be Junio picking up the patch. :)

I think you have all of those components spread across your messages,
and just need to polish them and put them in one place.

Regarding your patch itself, your explanation make sense to me and the
goal of your patch looks reasonable. Bearing in mind that I know
virtually nothing about the innards fast-import/fast-export.

But for the patch text itself:

> @@ -161,6 +161,14 @@ static int depth_first(const void *a_, const void *b_)
>                name_a = a->one ? a->one->path : a->two->path;
>                name_b = b->one ? b->one->path : b->two->path;
> +             /*
> +             * Move 'D'elete entries first.
> +             */
> +             if (a->status == 'D')
> +                             return -1;
> +             else if (b->status == 'D')
> +                             return 1;
> +
>                len_a = strlen(name_a);
>                len_b = strlen(name_b);
>                len = (len_a < len_b) ? len_a : len_b;

If you have multiple deleted entries, doesn't this leave them in a
random order at the beginning of the list? Does that matter? If they are
both 'D', should they be compared as usual? I.e.:

  if (a->status != b->status) {
          if (a->status == 'D')
                  return -1;
          if (b->status == 'D')
                  return 1;
  }

  /* and now we do the rest of the function as usual... */

-Peff
