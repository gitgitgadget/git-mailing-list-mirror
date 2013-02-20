From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 08/19] write_or_die: raise SIGPIPE when we get EPIPE
Date: Wed, 20 Feb 2013 13:51:11 -0800
Message-ID: <20130220215043.GA24236@google.com>
References: <20130220195147.GA25332@sigill.intra.peff.net>
 <20130220200136.GH25647@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 20 22:51:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8HZo-0004HY-U2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 22:51:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739Ab3BTVvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 16:51:20 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:50043 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab3BTVvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 16:51:19 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so4248292pad.25
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=5VuXgyPeY/CpxzXWjRbeXZJHJzBcsefhb76ImDDd7vo=;
        b=s004PTmofd/nhYGqNPZ9bP42pW6T+XGU02acM0DTAS71hD5sdrc5+u8HAHqjUipT8F
         1/OAJZP9OBXOnqAsxtQ1AGotgfFXB1EWDnUQxmIrsZX2DJV49uDz11skn0yEiRgAcy8P
         2oh0TDh8StQYu5a0xTh0dI+V3vzlqfAQwKLiOM0IOsKdd5yUCQ4/IJa8gTb5xtSzySLm
         jZyeFMPzncH8q5BEIy9Pg6IITyDAglmCy70U8S8FEueVN5jgrvNGYKp36k6bTUovn7VR
         nNkC2W050N9ZEYybPcibMBIa/UIy3vqETYEHLuSp+P3g52xHBHQ2ZHsBqRuDVEmNROJ6
         +5Jg==
X-Received: by 10.68.211.69 with SMTP id na5mr50849439pbc.71.1361397079237;
        Wed, 20 Feb 2013 13:51:19 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id gf6sm22849025pbc.24.2013.02.20.13.51.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Feb 2013 13:51:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130220200136.GH25647@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216737>

Jeff King wrote:

> The write_or_die function will always die on an error,
> including EPIPE. However, it currently treats EPIPE
> specially by suppressing any error message, and by exiting
> with exit code 0.
>
> Suppressing the error message makes some sense; a pipe death
> may just be a sign that the other side is not interested in
> what we have to say. However, exiting with a successful
> error code is not a good idea, as write_or_die is frequently
> used in cases where we want to be careful about having
> written all of the output, and we may need to signal to our
> caller that we have done so (e.g., you would not want a push
> whose other end has hung up to report success).
>
> This distinction doesn't typically matter in git, because we
> do not ignore SIGPIPE in the first place. Which means that
> we will not get EPIPE, but instead will just die when we get
> a SIGPIPE. But it's possible for a default handler to be set
> by a parent process,

Not so much "default" as "insane inherited", as in the example
of old versions of Python's subprocess.Popen.

I suspect this used exit(0) instead of raise(SIGPIPE) in the first
place to work around a bash bug (too much verbosity about SIGPIPE).
If any programs still have that kind of bug, I'd rather put pressure
on them to fix it by *not* working around it.  So the basic idea here
looks good to me.

[...]
> --- a/write_or_die.c
> +++ b/write_or_die.c
> @@ -1,5 +1,15 @@
>  #include "cache.h"
>  
> +static void check_pipe(int err)
> +{
> +	if (err == EPIPE) {
> +		signal(SIGPIPE, SIG_DFL);
> +		raise(SIGPIPE);
> +		/* Should never happen, but just in case... */
> +		exit(141);

How about

		die("BUG: another thread changed SIGPIPE handling behind my back!");

to make it easier to find and fix such problems?

Thanks,
Jonathan
