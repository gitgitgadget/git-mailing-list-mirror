From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] git-remote-fd
Date: Thu, 30 Sep 2010 08:14:40 -0500
Message-ID: <20100930131440.GE4850@burratino>
References: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1285847579-21954-3-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Sep 30 15:17:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1J1F-00086U-Iy
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755976Ab0I3NRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 09:17:46 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49971 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392Ab0I3NRq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:17:46 -0400
Received: by yxp4 with SMTP id 4so745142yxp.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ciaoB1py5hINkj/VuhJaY5o3w409PWK7xpzUF4uqvC8=;
        b=dNCH1X1ZFV0f9o1WRHOfTtYX1VixKzeOlc2DIEIjrVjY4QDGbSIQaDvG+ySK0qM+22
         zPlzLMS0KOY/e9dBozZRmpl2qBCGgpoenhJ1rQKioHC7EKEw3cnUlizF6PPQB/EqsRWk
         v/e1idBxOClDQ3z+GstP8q1NSQOUORNDmKyX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mKfLJFT+V5gKH5aFCL9ChtJWvIwof9LAIsuaYIO/LykU6HZEyZycMomiX3AkIbho+r
         sFAOA45pJW8NvFV+OkQOtJ+xH38vzo7K7JLRmtBgCL5Fa2fT6boKMavV3ipNgs4Nr9Qk
         d9sIZWZ1jV+0Qzoaid6UjDtHkzHFOwZMKIO2s=
Received: by 10.224.60.133 with SMTP id p5mr2486045qah.323.1285852665207;
        Thu, 30 Sep 2010 06:17:45 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t1sm10900593qcs.9.2010.09.30.06.17.43
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:17:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285847579-21954-3-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157649>

Hi Ilari,

Ilari Liusvaara wrote:

> This remote helper reflects raw smart remote transport stream back to the
> calling program. This is useful for example if some UI wants to handle
> ssh itself and not use hacks via GIT_SSH.

Do you ever use this directly, or is it a "because we can" sort of thing?
Whenever I try to come up with an example, ext:: seems to be easier.

An example (ideally a test) would be nice.

> +++ b/Documentation/git-remote-fd.txt
> @@ -0,0 +1,57 @@
[...]
> +"fd::<fd>[/<anything>]" or "fd::<infd>,<outfd>[/<anything>]" (as URL)
[...]
> +<anything> can be any string. It is ignored. It is meant for provoding
> +information to user in form of "URL".

Is this meant for future expansion?  Why not just use a comment in
.git/config?

> @@ -0,0 +1,57 @@
> +ENVIRONMENT VARIABLES:
> +----------------------
> +
> +$GIT_TRANSLOOP_DEBUG (passed to git)::
> +	If set, prints debugging information about various reads/writes.

For the curious: introduced by patch 1.

> +EXAMPLES:
> +---------
> +"fd::17"::
> +	Connect using socket in file descriptor #17.

Maybe with more context?

	socat ... "git push fd::3 HEAD" ...

> +Documentation
> +--------------
> +Documentation by Ilari Liusvaara.

I think one tends to write "Documentation by <person> and the git list
<git@vger.kernel.org>" these days.

Why is this section needed at all?  Doesn't the changelog already
record the relevant information?

> --- /dev/null
> +++ b/builtin/remote-fd.c
> @@ -0,0 +1,88 @@
> +#include "git-compat-util.h"
> +#include "transport.h"
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <unistd.h>

Doesn't git-compat-util.h imply these?

> + * The data output to <outfd>/<inoutfd> should be passed unmolested to
> + * git-receive-pack/git-upload-pack/git-upload-archive and output of
> + * git-receive-pack/git-upload-pack/git-upload-archive should be passed
> + * unmolested to <infd>/<inoutfd>.

Maybe worth mentioning in the manual?

> +static int command_loop()

Simple, I like it. :)

> +int cmd_remote_fd(int argc, const char **argv, const char *prefix)
> +{
> +	char* end;
> +	unsigned long r;
> +
> +	if (argc < 3) {
> +		fprintf(stderr, "Error: URL missing");
> +		exit(1);

Why not use usage() or die()?  (Just curious.)
