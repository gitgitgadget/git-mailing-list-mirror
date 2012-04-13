From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] fetch: Only call a new ref a "branch" if it's under
 refs/heads/.
Date: Fri, 13 Apr 2012 17:13:50 -0400
Message-ID: <20120413211350.GD7919@sigill.intra.peff.net>
References: <1334336904-18649-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Fri Apr 13 23:14:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SInod-0003GH-TQ
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 23:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219Ab2DMVNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 17:13:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33510
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403Ab2DMVNy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 17:13:54 -0400
Received: (qmail 13034 invoked by uid 107); 13 Apr 2012 21:13:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 17:13:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 17:13:50 -0400
Content-Disposition: inline
In-Reply-To: <1334336904-18649-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195446>

On Fri, Apr 13, 2012 at 01:08:24PM -0400, marcnarc@xiplink.com wrote:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index cfb43df..b6f737e 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -293,14 +293,18 @@ static int update_local_ref(struct ref *ref,
>  		const char *msg;
>  		const char *what;
>  		int r;
> -		if (!strncmp(ref->name, "refs/tags/", 10)) {
> +		if (!prefixcmp(ref->name, "refs/tags/")) {
>  			msg = "storing tag";
>  			what = _("[new tag]");
>  		}
> -		else {
> +		else if (!prefixcmp(ref->name, "refs/heads/")) {
>  			msg = "storing head";
>  			what = _("[new branch]");
>  		}
> +		else {
> +			msg = "storing ref";
> +			what = _("[new ref]");
> +		}

Hmm. The ref->name we are comparing here is the local side. So if I am
fetching a new branch "foo" from the remote into a local
"refs/remotes/origin/foo" tracking ref, it used to say:

    From ../parent
     * [new branch]      master     -> origin/master

Now it says:

    From ../parent
     * [new ref]         master     -> origin/master

while refs/remotes/* are not technically branches in our side, I think
from the user's perspective, it is true that we have fetched a branch.
Should we be calling refs/remotes/* branches, too? Should we be checking
the remote's name for the item instead of the local one?

-Peff
