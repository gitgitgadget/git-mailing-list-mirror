From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch --all: pass --tags/--no-tags through to each remote
Date: Sat, 1 Sep 2012 07:22:52 -0400
Message-ID: <20120901112251.GA11445@sigill.intra.peff.net>
References: <7vr4qmn8va.fsf@alter.siamese.dyndns.org>
 <1346473533-24175-1-git-send-email-ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <ossi@kde.org>
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 13:23:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7lnm-0002Zi-Lj
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 13:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721Ab2IALW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 07:22:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50809 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504Ab2IALW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 07:22:57 -0400
Received: (qmail 27021 invoked by uid 107); 1 Sep 2012 11:23:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Sep 2012 07:23:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Sep 2012 07:22:52 -0400
Content-Disposition: inline
In-Reply-To: <1346473533-24175-1-git-send-email-ComputerDruid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204624>

On Sat, Sep 01, 2012 at 12:25:33AM -0400, Dan Johnson wrote:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index bb9a074..c6bcbdc 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -857,6 +857,10 @@ static void add_options_to_argv(int *argc, const char **argv)
>  		argv[(*argc)++] = "--recurse-submodules";
>  	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
>  		argv[(*argc)++] = "--recurse-submodules=on-demand";
> +	if (tags == TAGS_SET)
> +		argv[(*argc)++] = "--tags";
> +	else if (tags == TAGS_UNSET)
> +		argv[(*argc)++] = "--no-tags";
>  	if (verbosity >= 2)
>  		argv[(*argc)++] = "-v";
>  	if (verbosity >= 1)

Hmm. We allocate argv in fetch_multiple like this:

  const char *argv[12] = { "fetch", "--append" };

and then add a bunch of options to it, along with the name of the
remote. By my count, the current code can hit exactly 12 (including the
terminating NULL) if all options are set. Your patch would make it
possible to overflow. Of course, I may be miscounting since it is
extremely error-prone to figure out the right number by tracing each
possible conditional.

Maybe we should switch it to a dynamic argv_array? Like this:

  [1/2]: argv-array: add pop function
  [2/2]: fetch: use argv_array instead of hand-building arrays

-Peff
