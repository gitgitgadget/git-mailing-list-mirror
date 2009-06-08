From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: Fix solaris portability issues.
Date: Mon, 08 Jun 2009 00:42:28 -0700
Message-ID: <7v3aab6ujf.fsf@alter.siamese.dyndns.org>
References: <1244444557-21685-1-git-send-email-thomas.moulard@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Moulard <thomas.moulard@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 09:42:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDZV9-0006Cr-2F
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 09:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbZFHHm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 03:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbZFHHm2
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 03:42:28 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49916 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbZFHHm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 03:42:27 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608074229.LLDK18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Mon, 8 Jun 2009 03:42:29 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 1KiU1c0084aMwMQ04KiUcR; Mon, 08 Jun 2009 03:42:28 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=nViOFsLHAZEA:10 a=WoVUFPU4x1cA:10
 a=pGLkceISAAAA:8 a=qQswN1x0eNh7u_aSsrwA:9 a=v75MwN7J6qcKRd0YyUkA:7
 a=l0SDHmlUsPa-gYy5eNj-bCgyeZ8A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1244444557-21685-1-git-send-email-thomas.moulard@gmail.com> (Thomas Moulard's message of "Mon\,  8 Jun 2009 16\:02\:37 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121045>

Thomas Moulard <thomas.moulard@gmail.com> writes:

> This patch solves some issues I had on a Solaris system:
> $ showrev -c /bin/sh | grep version
> Command version: SunOS 5.10 Generic 121005-03 Oct 2006
>
> 1. Replace $(...) by backquotes.
> 2. Replace shell substitution ${var##word} by echo + sed
> 3. Replace grep -F by fgrep.

Thanks for trying to be helpful, but regrettably I have to say no.

Earlier we already declared that any Bourne variant that does not
understand $() is unfit to use with git as a general rule, but that
particular general rule was really meant to exclude broken /bin/sh on
Solaris.  We recommend using either ksh or /usr/xpg4/bin/sh on that
platform.

Perhaps SunOS 5.10 has a better /bin/sh than what people tried earlier,
and with this patch everything start to magically work well on the
platform.  I however somehow doubt it.

There are tons of "$()" construct in our scripted Porcelain commands, and
I think there are even nested ones that you cannot replace with "``"
without introducing new variables and contaminating the namespace.

Even though I am a traditionist, I personally would not want to see a
patch to rewrite them back to ``, because that will force me to verify
that de-nesting of $(foo $(bar baz)) is done properly, that interaction
between `` and double quotes are handled correctly, and that namespace
contamination does not have any ill effects, etc. etc.

> @@ -118,12 +118,12 @@ generate_email()
>  		refs/tags/*,commit)
>  			# un-annotated tag
>  			refname_type="tag"
> -			short_refname=${refname##refs/tags/}
> +			short_refname=`echo "$refname" | sed 's|refs/tags/||'`

I think we used to write

	sed -e 's|^refs/tags/||'

all over the place, but they were later replaced with "${var#word}".

In any case, this particular rewrite is wrong; you need to anchor the
pattern at the left end (so are other uses of 's|refs/xxx/||' in your
patch).
