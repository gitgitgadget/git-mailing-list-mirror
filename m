From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 1/1] status: Allow for short-form via config option
Date: Mon, 12 Nov 2012 16:17:42 -0500
Message-ID: <20121112211742.GJ4623@sigill.intra.peff.net>
References: <1352674383-23654-1-git-send-email-thomas@xteddy.org>
 <1352674383-23654-2-git-send-email-thomas@xteddy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:18:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY1OK-0006X7-DO
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 22:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab2KLVRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 16:17:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45043 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753265Ab2KLVRq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 16:17:46 -0500
Received: (qmail 14219 invoked by uid 107); 12 Nov 2012 21:18:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 16:18:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 16:17:42 -0500
Content-Disposition: inline
In-Reply-To: <1352674383-23654-2-git-send-email-thomas@xteddy.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209527>

On Sun, Nov 11, 2012 at 10:53:03PM +0000, Thomas Adam wrote:

> It is currently not possible to use the short-form output of git status
> without declaring an alias to do so.
> 
> This isn't always desirable therfore, define a git config option which can
> be set to display the short-form:  status.shortwithbranch

We usually try to avoid booleans for selection among options, even if
there is currently only one useful option. That way, it makes it easier
to extend later when another option presents itself.  So having
"status.format" that you could set to "short", "long", or "porcelain"
would make more sense (although "short" is likely to be the only useful
one currently).

And then we can have a separate boolean like "status.branch" to show the
branch by default when showing short format. That would would naturally
extend to more booleans as other options are added (Phil Hord's recent
"show tree state" patches come to mind).

We also need to consider the impact of options on scripts. I think
status.format should be OK, since any script calling "git status" would
have to explicitly pass "--porcelain" already, which would override this
option. But we would want to make sure that "status.branch" would not
affect the porcelain.

> ---
>  builtin/commit.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

It would need documentation, and tests would be good both to make sure
the feature works, but also to demonstrate that it does not break
--porcelain.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index a17a5df..552a9f1 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1142,6 +1142,18 @@ static int git_status_config(const char *k, const char *v, void *cb)
>  			return error(_("Invalid untracked files mode '%s'"), v);
>  		return 0;
>  	}
> +
> +	if (!strcmp(k, "status.shortwithbranch")) {
> +		if (git_config_bool(k, v)) {
> +			if (!v)
> +				return config_error_nonbool(k);
> +			else if(!strcmp(v, "true")) {
> +				status_format = STATUS_FORMAT_SHORT;
> +				s->show_branch = 1;
> +			}
> +			return 0;
> +		}
> +	}

I'm not sure what is going on with the extra nonbool and "true" check.
Shouldn't it just be:

  if (git_config_bool(k, v)) {
          status_format = STATUS_FORMAT_SHORT;
          s->show_branch = 1;
  }
  else {
          /* what do we do when it is false? */
  }
  return 0;

If we follow my suggestions above, then it would be more like:

  if (!strcmp(k, "status.format")) {
          if (!v)
                  return config_error_nonbool(k);
          return parse_status_format(v, &status_format);
  }
  if (!strcmp(k, "status.branch")) {
          s->show_branch = git_config_bool(k, v);
          return 0;
  }

but that would still have to resolve the setting of show_branch when
--porcelain is in use. I think you would need to store the
config-derived value separately, and then only fill it into
s->show_branch if no value was given on the command-line _and_ we are
not showing the porcelain format.

-Peff
