From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] git-credential-store: support XDG config dir
Date: Wed, 4 Mar 2015 04:45:06 -0500
Message-ID: <20150304094505.GA15593@peff.net>
References: <1425414299-24000-1-git-send-email-pyokagan@gmail.com>
 <1425414299-24000-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 10:45:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT5rk-0001aH-6i
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 10:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760759AbbCDJpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 04:45:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:56151 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759085AbbCDJpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 04:45:08 -0500
Received: (qmail 31342 invoked by uid 102); 4 Mar 2015 09:45:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 03:45:09 -0600
Received: (qmail 29000 invoked by uid 107); 4 Mar 2015 09:45:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 04:45:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2015 04:45:06 -0500
Content-Disposition: inline
In-Reply-To: <1425414299-24000-2-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264740>

On Wed, Mar 04, 2015 at 04:24:58AM +0800, Paul Tan wrote:

> @@ -111,8 +114,7 @@ static void remove_credential(const char *fn, struct credential *c)
>  
>  static int lookup_credential(const char *fn, struct credential *c)
>  {
> -	parse_credential_file(fn, c, print_entry, NULL);
> -	return c->username && c->password;
> +	return parse_credential_file(fn, c, print_entry, NULL);
>  }

I wondered if we were losing something here, as the return value from
parse_credential_file is not the same as "did we find both a username
and a password". But then I realized that the existing "return" line is
nonsensical. The "c" variable here is our template of what to look for,
not the return.

I think this is leftover from an earlier iteration, where our callback
filled in the values, rather than directly printing them. Nobody noticed
because we didn't actually look at the return value of lookup_credential
at all.

So I think regardless of the end goal, it is nice to see this oddity
cleaned up.

> +	if (!strcmp(op, "get")) {
> +		if (file) {
> +			lookup_credential(file, &c);
> +		} else {
> +			if (xdg_file && access_or_warn(xdg_file, R_OK, 0) == 0)
> +				ret = lookup_credential(xdg_file, &c);
> +			if (!ret && home_file && access_or_warn(home_file, R_OK, 0) == 0)
> +				lookup_credential(home_file, &c);
> +		}
> +	} else if (!strcmp(op, "erase")) {
> +		if (file) {
> +			remove_credential(file, &c);
> +		} else {
> +			if (xdg_file && access(xdg_file, F_OK) == 0)
> +				remove_credential(xdg_file, &c);
> +			if (home_file && access(home_file, F_OK) == 0)
> +				remove_credential(home_file, &c);
> +		}

The lookup rules here all look sane. Thanks for paying such attention
to the details. Like Matthieu, I was unclear on the inconsistent use of
access_or_warn.

If we can use the same access variant everywhere, I wonder if it would
be more readable to hoist it into a function like:

  int has_config_file(const char *file)
  {
	return file && access_or_warn(file, F_OK) == 0;
  }

It's a tiny function, but then your repetitious "if" statements drop
some of the noise:

  if (has_config_file(xdg_file))
	ret = lookup_credential(xdg_file, &c);
  if (!ret && has_config_file(home_file))
	lookup_credential(home_file, &c);

> +	} else if (!strcmp(op, "store")) {
> +		if (file) {
> +			store_credential(file, &c);
> +		} else if (xdg_file && access(xdg_file, F_OK) == 0) {
> +			store_credential(xdg_file, &c);
> +			if (home_file && access(home_file, F_OK) == 0 &&
> +			    c.protocol && (c.host || c.path) && c.username
> +			    && c.password)
> +				remove_credential(home_file, &c);

I like that you take care not to lose information during the migration,
but I really don't like that we have to replicate the "is this a
fully-formed credential" logic. I think I'd rather just store the
credential in the xdg_file, and leave it be in home_file. The lookup
will prefer the xdg version, and if we ever issue an "erase" (e.g.,
because the credential changes), it should remove both of them.

-Peff
