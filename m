From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Force listingblocks to be monospaced in manpages
Date: Wed, 18 Jul 2007 16:56:02 -0700
Message-ID: <7vr6n55krx.fsf@assigned-by-dhcp.cox.net>
References: <m3k5sxiiib.fsf@pc7.dolda2000.com>
	<20070718213725.31383.50523.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 19 01:56:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBJNN-00060G-70
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 01:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759464AbXGRX4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 19:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758260AbXGRX4H
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 19:56:07 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:52450 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757615AbXGRX4F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 19:56:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070718235602.IFKT1358.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Jul 2007 19:56:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RBw21X00P1kojtg0000000; Wed, 18 Jul 2007 19:56:03 -0400
In-Reply-To: <20070718213725.31383.50523.julian@quantumfyre.co.uk> (Julian
	Phillips's message of "Wed, 18 Jul 2007 22:33:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52914>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> For the html output we can use a stylesheet to make sure that the
> listingblocks are presented in a monospaced font.  For the manpages do
> it manually by inserting a ".ft C" before and ".ft" after the block in
> question.
>
> In order for these roff commands to get through to the manpage they
> have to be element encoded to prevent quoting.
>
> Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
> ...
> How about this?
>
> Seems to work for me - but I'm not an asciidoc/docbook/roff expert ...
>
>  Documentation/asciidoc.conf |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
> index 6b6220d..d54fe29 100644
> --- a/Documentation/asciidoc.conf
> +++ b/Documentation/asciidoc.conf
> @@ -27,7 +27,13 @@ ifdef::backend-docbook[]
>  [listingblock]
>  <example><title>{title}</title>
>  <literallayout>
> +ifdef::doctype-manpage[]
> +&#10;&#x2302;ft C&#10;
> +endif::doctype-manpage[]
>  |
> +ifdef::doctype-manpage[]
> +&#10;&#x2302;ft&#10;
> +endif::doctype-manpage[]
>  </literallayout>
>  {title#}</example>
>  endif::backend-docbook[]
> -- 

I tried with your patch, both with asciidoc7 and asciidoc8.  Did
you really mean "&#x2302;" above?  Replacing them with "."  gave
me a series of these changes (diff between output before and
after your patch with the "s/\&#x2302;/./g" fixup):

        @@ -83,10 +83,13 @@
         .sp
         .RS 3n
         .nf
        +.ft C
             *** Commands ***
               1: status       2: update       3: revert       4: add untracked
               5: patch        6: diff         7: quit         8: help
             What now> 1
        +.ft
        +
         .fi
         .RE
         You also could say "s" or "sta" or "status" above as long as the choice is unique.

which seems reasonable, but I did not render them through roff.
WIth "&#x2302;" I was getting:

        @@ -83,10 +83,14 @@
         .sp
         .RS 3n
         .nf
        +
        +	ft C
             *** Commands ***
               1: status       2: update       3: revert       4: add untracked
               5: patch        6: diff         7: quit         8: help
             What now> 1
        +	ft
        +
         .fi
         .RE
         You also could say "s" or "sta" or "status" above as long as the choice is unique.

whatever that 2302 is...
