From: Jeff King <peff@peff.net>
Subject: Re: Two potential bugs in aliases that expand to shell commands
Date: Thu, 4 Apr 2013 02:40:07 -0400
Message-ID: <20130404064007.GA8278@sigill.intra.peff.net>
References: <CACE=nd1dwhCyrKdzFq7O4UgD1TH8-c5R+4L2rH0NGW-jWqLr_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Han <laughinghan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 08:40:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNdqr-0003re-TG
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 08:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763733Ab3DDGkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 02:40:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54249 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763729Ab3DDGkN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 02:40:13 -0400
Received: (qmail 30871 invoked by uid 107); 4 Apr 2013 06:42:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 02:42:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 02:40:07 -0400
Content-Disposition: inline
In-Reply-To: <CACE=nd1dwhCyrKdzFq7O4UgD1TH8-c5R+4L2rH0NGW-jWqLr_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219987>

On Wed, Apr 03, 2013 at 07:05:33PM -0700, Han wrote:

> There appears to be another case string values need to be enclosed in
> quotes, which is a shell command where you want to preserve quote
> characters (not leading or trailing); a minimal example is
> 
>   shortcut = !cd "" && pwd

Yes. You must escape any double-quotes that are not the beginning or
end of a quoted string.

>   shortcut = !"cd \"\" && pwd"

This is fine. Technically so is:

  shortcut = !cd \"\" && pwd

but I think it is more readable to put such shell snippets inside a
double-quoted string, to make it more clear what is going on.

Documentation patches welcome.

> The other bug I'm much more confused by. If you have an alias like
> 
>   shortcut = !"echo -n lol; echo wut"
> 
> it will, in fact, print
> 
> -n lol
> wut
> 
> which is, uh, not what bash prints. Is git special-casing echo?

No, git does not special-case echo. But it runs shell commands with
/bin/sh, which may or may not be bash on your system (and "-n" is not
necessarily portable to other POSIX shells).

If you really want to use bash, do:

  shortcut = "!bash -c 'echo -n lol; echo wut'"

or just use printf, which is a portable way to spell "echo -n".

-Peff
