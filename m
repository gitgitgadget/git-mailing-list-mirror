From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/25] prune-safety
Date: Sat, 18 Oct 2014 08:31:06 -0400
Message-ID: <20141018123106.GA5494@peff.net>
References: <20141015223244.GA25368@peff.net>
 <xmqqsiinsoyk.fsf@gitster.dls.corp.google.com>
 <20141016212112.GA16054@peff.net>
 <20141016213918.GA29397@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 14:31:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfTAK-0006Da-KL
	for gcvg-git-2@plane.gmane.org; Sat, 18 Oct 2014 14:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbaJRMbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2014 08:31:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:59803 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750976AbaJRMbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2014 08:31:09 -0400
Received: (qmail 29939 invoked by uid 102); 18 Oct 2014 12:31:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 18 Oct 2014 07:31:08 -0500
Received: (qmail 14947 invoked by uid 107); 18 Oct 2014 12:31:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 18 Oct 2014 08:31:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Oct 2014 08:31:06 -0400
Content-Disposition: inline
In-Reply-To: <20141016213918.GA29397@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 16, 2014 at 05:39:18PM -0400, Jeff King wrote:

> @@ -301,6 +297,14 @@ static struct commit *handle_commit(struct rev_info *revs,
>  			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
>  		}
>  		object->flags |= flags;
> +		/*
> +		 * We'll handle the tagged object by looping or dropping
> +		 * through to the non-tag handlers below. Do not
> +		 * propagate data from the tag's pending entry.
> +		 */
> +		name = NULL;
> +		path = NULL;
> +		mode = 0;

Hmm. On second thought (and after seeing a warning from Coverity), this
should be:

diff --git a/revision.c b/revision.c
index 8030fc8..ebe3e93 100644
--- a/revision.c
+++ b/revision.c
@@ -302,7 +302,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 		 * through to the non-tag handlers below. Do not
 		 * propagate data from the tag's pending entry.
 		 */
-		name = NULL;
+		name = "";
 		path = NULL;
 		mode = 0;
 	}

The rest of the function assumes that name is not NULL (which I'm not
sure is entirely safe, as add_pending_object can take a NULL; presumably
every "add" uses the empty string instead of NULL. But either way,
setting it to NULL here is definite wrong).

The "path" field is explicitly OK to be NULL.

-Peff
