From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 28/32] config: read ref storage config on startup
Date: Fri, 26 Feb 2016 22:56:34 -0500
Message-ID: <20160227035634.GA10829@sigill.intra.peff.net>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
 <1456354744-8022-29-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 04:56:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZVzr-00075V-Mx
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 04:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862AbcB0D4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 22:56:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:50521 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755553AbcB0D4h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 22:56:37 -0500
Received: (qmail 21661 invoked by uid 102); 27 Feb 2016 03:56:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 22:56:37 -0500
Received: (qmail 10131 invoked by uid 107); 27 Feb 2016 03:56:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 22:56:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 22:56:34 -0500
Content-Disposition: inline
In-Reply-To: <1456354744-8022-29-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287655>

On Wed, Feb 24, 2016 at 05:59:00PM -0500, David Turner wrote:

> @@ -1207,6 +1208,29 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  	}
>  
>  	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
> +		char *storage = NULL;
> +
> +		/*
> +		 * make sure we always read the ref storage config
> +		 * from the extensions section on startup
> +		 */
> +		ret += git_config_from_file(ref_storage_backend_config,
> +					    repo_config, &storage);
> +
> +		register_ref_storage_backends();
> +		if (!storage)
> +			storage = xstrdup("");
> +
> +		if (!*storage ||
> +		    !strcmp(storage, "files")) {
> +			/* default backend, nothing to do */
> +			free(storage);
> +		} else {
> +			if (set_ref_storage_backend(ref_storage_backend))
> +				die(_("Unknown ref storage backend %s"),
> +				    ref_storage_backend);
> +		}
> +

Coverity complains that "storage" leaks here, and I think it does in the
case that we non-default storage, and we successfully set up the
backend. That's a pretty minor point.

However, after looking at this code, I'm rather confused about a few
things.

One is that we read the config and use ref_storage_backend_config[1] to
store the string value in "storage", and then we check whether that is
non-default, and if it is, I'd expect us to feed it to
set_ref_storage_backend. But we don't; we feed ref_storage_backend
instead!

What is that value? It looks like it is the string we set in
check_repo_format when we load the extensions list there. So why
are we re-reading the config here at all? Couldn't we just use
ref_storage_backend in the first place?

My second confusion is why this is happening in git_config_early(). That
function is called during the setup of check_repository_format_gently(),
which is why I think you wanted to put the code here. But it's _also_
called as part of a regular git_config(). Which means we're parsing the
repo config and setting the ref backend all over again, every time we
look at config for other reasons.

So I think this setup probably should be in
check_repository_format_gently(), and should be able to trigger off of
the existing ref_storage_backend string we've already saved (and we
should bail immediately there if we don't know about the backend, as it
means we _don't_ match the repo's extensions and cannot proceed).

-Peff

[1] The ref_storage_backend_config function uses xstrdup(), which I
    think will segfault for a value-less boolean config, like:

      [extensions]
      # notice no "=" sign!
      refstorage

    The same bug is in check_repo_format, where we assigned
    ref_storage_backend. The normal way to do this is to use:

      return git_config_string(var, value, &ref_backend_storage);

    which checks for the boolean case and complains.
