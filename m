From: Jeff King <peff@peff.net>
Subject: Re: [RFC] How to pass Git config command line instructions to
 Submodule commands?
Date: Thu, 28 Apr 2016 07:25:11 -0400
Message-ID: <20160428112511.GA11522@sigill.intra.peff.net>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com>
 <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com>
 <CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com>
 <20160425212449.GA7636@sigill.intra.peff.net>
 <017AA7DB-5224-49C3-A4A6-6C93005BF006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 13:25:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avk4X-000129-Lu
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 13:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbcD1LZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 07:25:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:58180 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752149AbcD1LZP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 07:25:15 -0400
Received: (qmail 18563 invoked by uid 102); 28 Apr 2016 11:25:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 07:25:14 -0400
Received: (qmail 8418 invoked by uid 107); 28 Apr 2016 11:25:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 07:25:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 07:25:11 -0400
Content-Disposition: inline
In-Reply-To: <017AA7DB-5224-49C3-A4A6-6C93005BF006@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292864>

On Thu, Apr 28, 2016 at 01:06:45PM +0200, Lars Schneider wrote:

> I got my Git-LFS use case working with the patch below. 
> For me it was necessary to export GIT_CONFIG_PARAMETERS
> to make it available to the Git process if the process is 
> invoked as follows [2]: 
> 
> (sanitize_submodule_env; cd "$sm_path" && git <something>")

Hrm. I'm not sure why you need to export. Or perhaps, I am not sure why
it ever works in the first place in git-submodule.sh. In this code:

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2a84d7e..b02f5b9 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -199,7 +199,7 @@ sanitize_submodule_env()
>  {
>  	sanitized_config=$(git submodule--helper sanitize-config)
>  	clear_local_git_env
> -	GIT_CONFIG_PARAMETERS=$sanitized_config
> +	export GIT_CONFIG_PARAMETERS=$sanitized_config
>  }

If you already have $GIT_CONFIG_PARAMETERS exported when we enter the
function, then we should not need to re-export it when changing the
value in the final line (the export bit is retained by the shell). But
if you don't have it set already, then $sanitized_config must by
definition be empty.

So it should do the right thing without the export.

At the same time, clear_local_git_env() will call "unset" on
GIT_CONFIG_PARAMETERS. Which would clear the export bit, meaning the
final line doesn't ever have any impact on sub-programs, and the whole
thing is totally broken. But then, why does the test in t5550 pass?

Confused...

-Peff
