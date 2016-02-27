From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 28/32] config: read ref storage config on startup
Date: Fri, 26 Feb 2016 23:14:17 -0500
Message-ID: <20160227041416.GA11604@sigill.intra.peff.net>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
 <1456354744-8022-29-git-send-email-dturner@twopensource.com>
 <20160227035634.GA10829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 05:14:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZWGu-0007rg-RT
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 05:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984AbcB0EOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 23:14:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:50540 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755533AbcB0EOT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 23:14:19 -0500
Received: (qmail 22432 invoked by uid 102); 27 Feb 2016 04:14:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 23:14:19 -0500
Received: (qmail 10294 invoked by uid 107); 27 Feb 2016 04:14:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 23:14:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 23:14:17 -0500
Content-Disposition: inline
In-Reply-To: <20160227035634.GA10829@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287657>

On Fri, Feb 26, 2016 at 10:56:34PM -0500, Jeff King wrote:

> My second confusion is why this is happening in git_config_early(). That
> function is called during the setup of check_repository_format_gently(),
> which is why I think you wanted to put the code here. But it's _also_
> called as part of a regular git_config(). Which means we're parsing the
> repo config and setting the ref backend all over again, every time we
> look at config for other reasons.
> 
> So I think this setup probably should be in
> check_repository_format_gently(), and should be able to trigger off of
> the existing ref_storage_backend string we've already saved (and we
> should bail immediately there if we don't know about the backend, as it
> means we _don't_ match the repo's extensions and cannot proceed).

By the way, I notice that the default value for the_refs_backend is
"&refs_be_files". It might be safer to make this NULL (or some
&refs_be_null that fills the vtable, but just returns an error for each
call).

Then in check_repository_format_gently(), do:

  if (!ref_storage_backend || !*ref_storage_backend)
	refs_backend_storage = "files";
  set_ref_storage_backend(ref_storage_backend);

That way you could be sure that the backend has been initialized from
the config, and never blindly falls back to the "files" backend.  If
there is any code path where we try to access refs but the_refs_backend
is null, that's a bug that needs fixing. But it's a lot easier to find
such bugs if we die loudly in that case rather than silently using
"files".

-Peff
