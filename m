From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] push: introduce new push.default mode "simple"
Date: Thu, 19 Apr 2012 16:46:09 -0700
Message-ID: <20120419234609.GA6020@sigill.intra.peff.net>
References: <vpqaa27bgon.fsf@bauges.imag.fr>
 <1334876234-20077-1-git-send-email-Matthieu.Moy@imag.fr>
 <1334876234-20077-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Apr 20 01:46:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SL13N-0005X7-Gm
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 01:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab2DSXqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 19:46:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38754
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860Ab2DSXqP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 19:46:15 -0400
Received: (qmail 2237 invoked by uid 107); 19 Apr 2012 23:46:22 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Apr 2012 19:46:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Apr 2012 16:46:09 -0700
Content-Disposition: inline
In-Reply-To: <1334876234-20077-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195978>

On Fri, Apr 20, 2012 at 12:57:12AM +0200, Matthieu Moy wrote:

> diff --git a/builtin/push.c b/builtin/push.c
> index d315475..4602cd8 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -65,7 +65,17 @@ static void set_refspecs(const char **refs, int nr)
>  	}
>  }
>  
> -static void setup_push_upstream(struct remote *remote)
> +static int push_url_of_remote(struct remote *remote, const char ***url_p)
> +{
> +	if (remote->pushurl_nr) {
> +		*url_p = remote->pushurl;
> +		return remote->pushurl_nr;
> +	}
> +	*url_p = remote->url;
> +	return remote->url_nr;
> +}
> +

Eh, what's this? This wasn't part of my patch. It was part of Junio's
patch which mine was based on (and it provokes a "defined but not used"
warning when your patch is applied on top of master).

> @@ -87,6 +97,35 @@ static void setup_push_upstream(struct remote *remote)
>  	if (branch->merge_nr != 1)
>  		die(_("The current branch %s has multiple upstream branches, "
>  		    "refusing to push."), branch->name);
> +	if (strcmp(branch->remote_name, remote->name))
> +		die(_("You are pushing to remote '%s', which is not the upstream of\n"
> +		      "your current branch '%s', without telling me what to push\n"
> +		      "to update which remote branch."),
> +		    remote->name, branch->name);

And this was from Junio's patch, which is really a separate topic (that
"git push foo" should not respect an upstream branch name when the
upstream remote is not "foo").

So I think your rebase turned out a little funny. We probably want to
pull in Junio's patch from the tip of jc/push-upstream-sanity (135dade).
Though even that can be pared down a little. The push_url_of_remote
refactoring was part of an early iteration and does not have to be part
of the final version (though I think it is a fine refactoring on its
own).

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index b5417cc..f4f9d06 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh

135dade creates a new t5528 for testing push.default settings, so tests
could go there.

-Peff
