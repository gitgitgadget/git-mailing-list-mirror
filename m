From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Git segmentation faults if submodule path is empty.
Date: Fri, 16 Aug 2013 16:52:47 -0400
Message-ID: <20130816205246.GA6487@sigill.intra.peff.net>
References: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
 <520DCB4B.6090309@web.de>
 <20130816130957.GB20138@sigill.intra.peff.net>
 <20130816131406.GC20138@sigill.intra.peff.net>
 <AFCBD71A-21CB-45CC-8386-C65173B6D173@eyesopen.com>
 <0C422E09-EE33-4C3F-91D3-F6007F743A38@eyesopen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jharrod LaFon <jlafon@eyesopen.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 02:11:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAU7N-0006E5-1d
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 02:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757024Ab3HQALA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 20:11:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:60203 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756612Ab3HPWjc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 18:39:32 -0400
Received: (qmail 16835 invoked by uid 102); 16 Aug 2013 20:52:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Aug 2013 15:52:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Aug 2013 16:52:47 -0400
Content-Disposition: inline
In-Reply-To: <0C422E09-EE33-4C3F-91D3-F6007F743A38@eyesopen.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232447>

On Fri, Aug 16, 2013 at 10:59:35AM -0700, Jharrod LaFon wrote:

> Here is an updated patch with a test.

Bits like this that should not be part of the commit message should
either go after the "---" lines near the diffstat, or should come before
a scissors line, like:

  Here is my new patch.

  -- >8 --
  Git segmentation faults etc...

That way git-am can do the right thing, and the maintainer does not have
to fix up your patch by hand.

> diff --git a/submodule.c b/submodule.c
> index 1821a5b..1e4acfd 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -134,6 +134,9 @@ int parse_submodule_config_option(const char *var, const char *value)
>  		return 0;
>  
>  	if (!strcmp(key, "path")) {
> +        if (!value)
> +            return config_error_nonbool(var);

Your indentation looks like two spaces here, which does not match the
rest of the block. It should be one tab.

> @@ -151,6 +154,9 @@ int parse_submodule_config_option(const char *var, const char *value)
>  	} else if (!strcmp(key, "ignore")) {
>  		char *name_cstr;
>  
> +        if (!value)
> +            return config_error_nonbool(var);
> +

Ditto here.

> diff --git a/t/t1307-null-submodule-path.sh b/t/t1307-null-submodule-path.sh
> new file mode 100644
> index 0000000..eeda2cb
> --- /dev/null
> +++ b/t/t1307-null-submodule-path.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +
> +test_description='test empty submodule path'
> +. ./test-lib.sh
> +
> +setup() {
> +    (printf "[submodule \"test\"]\n" && 
> +    printf "  path\n" &&
> +    printf "  url") >.gitmodules
> +}

You can use single-quotes to avoid having to backslash the embedded
double-quotes. And I do not see any reason to use printf rather than the
more readable echo, which can drop the "\n".

And is there any point in having the "url" field?  The presence of a
valueless bool "path" should be enough, no? It may be easier to see what
it is we are testing without the extraneous parameter.

With those changes, you could even put it all on one line:

  echo '[submodule "test"] path' >.gitmodules

-Peff
