From: Jeff King <peff@peff.net>
Subject: Re: Corner case bug caused by shell dependent behavior
Date: Thu, 13 Mar 2014 22:28:46 -0400
Message-ID: <20140314022845.GA19757@sigill.intra.peff.net>
References: <20140314000213.GA3739@ibr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Uwe Storbeck <uwe@ibr.ch>
X-From: git-owner@vger.kernel.org Fri Mar 14 03:29:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOHs8-0008EC-O1
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 03:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055AbaCNC2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 22:28:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:39170 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753563AbaCNC2s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 22:28:48 -0400
Received: (qmail 27194 invoked by uid 102); 14 Mar 2014 02:28:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Mar 2014 21:28:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2014 22:28:46 -0400
Content-Disposition: inline
In-Reply-To: <20140314000213.GA3739@ibr.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244070>

On Fri, Mar 14, 2014 at 01:02:13AM +0100, Uwe Storbeck wrote:

> When your system shell (/bin/sh) is a dash control sequences in
> strings get interpreted by the echo command. A commit message
> which ends with the string '\n' may result in a garbage line in
> the todo list of an interactive rebase which causes the rebase
> to fail.
> 
> To reproduce the behavior (with dash as /bin/sh):
> 
>   mkdir test && cd test && git init
>   echo 1 >foo && git add foo
>   git commit -m"this commit message ends with '\n'"
>   echo 2 >foo && git commit -a --fixup HEAD
>   git rebase -i --autosquash --root

Hmph. We ran into this before and fixed all of the sites (e.g., d1c3b10
and 938791c). This one appears to have been added a few months later
(by 68d5d03).

> Maybe there are more places where it would be more robust to use
> printf instead of echo.

FWIW, I just looked through the other uses of "echo" in git-rebase*.sh,
and I think this is the only problematic case.

> -			echo "$sha1 $action $prefix $rest"
> +			printf "%s %s %s %s\n" "$sha1" "$action" "$prefix" "$rest"

Looks obviously correct. The echo just below here does not need the same
treatment, as "$rest" is the problematic bit ("$prefix" is always
"fixup" or "squash").

-Peff
