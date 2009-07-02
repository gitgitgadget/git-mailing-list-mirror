From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git apply: option to ignore whitespace differences
Date: Thu, 02 Jul 2009 09:46:45 -0700
Message-ID: <7vws6r822y.fsf@alter.siamese.dyndns.org>
References: <1246539137-24754-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1246539137-24754-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 18:46:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMPR1-0003Zy-61
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 18:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbZGBQqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 12:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbZGBQqo
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 12:46:44 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36861 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbZGBQqn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 12:46:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090702164647.NPKS17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Jul 2009 12:46:47 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id B4mm1c0074aMwMQ034mmJr; Thu, 02 Jul 2009 12:46:46 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=RzdjjvD8XIkA:10 a=fh7huV5zw2NYd11lWa0A:9
 a=KkkIflc6Kk7UmLLI6NYA:7 a=2EBdGLB2__-xDeM_XlLrdsflce4A:4
 a=qpU7hWoNisHR5kKx:21 a=s3RJLVacHdnkOZyR:21
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122653>

> diff --git a/builtin-apply.c b/builtin-apply.c
> index dc0ff5e..86860d6 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -39,6 +39,7 @@ static int diffstat;
>  static int numstat;
>  static int summary;
>  static int check;
> +static int ignore_whitespace = 0;

s/ = 0//;

> +/*
> + * Compare two memory areas ignoring whitespace differences
> + */
> +static int memcmp_ignore_whitespace(const char *s1, const char *s2, size_t n)
> +{

Don't you think this function signature is bogus?

You are going to use this function to compare a line that is in the target
buffer (i.e. the contents of the current blob) with a line read from the
patch context when the user says they might match if you ignore whitespace
differences.

How on earth can you do that with only a single length parameter "n"?
Length of which side are you talking about?

Remember that git-apply is designed to be able to handle a patch that has
NUL in it (generated with "diff --text"), so strlen() is not an acceptable
answer.

> +static int memcmp_switch(const char *s1, const char *s2, size_t n)
> +{
> +	if (ignore_whitespace)
> +		return memcmp_ignore_whitespace(s1, s2, n);
> +	else
> +		return memcmp(s1, s2, n);
> +}
> +

This function signature shares the same bogosity with the previous one.

In addition, it's name and semantics is bogus.

The original implementation had encapsulated the notion that it is
comparing two lines entirely in match_fragment().  Its use of memcmp() was
an implementation detail of a half of the open-coded logic to compare two
lines (the other half being the comparison of lengths), and direct use of
memcmp() made perfect sense.  It checked the length matched.  Now it
wanted to make sure they matched byte-for-byte.

If you are separating that "compare two lines" logic into a helper
function, I would expect its name actually reflect its purpose, whose
behaviour may change depending on --ignore-whitespace.  The traditional
codepath would say "do they have the same length and match byte-for-byte?"
while the new loosened codepath would say "we do not care about the
whitespaces; do they match if we disregard ws differences?"

I also suspect that you might be able to optimize the existing "allow
whitespace-fixed match" a bit by "fix"ing the target buffer only once,
instead of doing so line-by-line for every offset that find_pos() checks
by calling match_fragment().  It is an independent issue, but it appears
to me that the change this patch wants to do to match_fragment() might
become cleaner if we did that conversion first, as match_fragment() itself
won't have to have two cases (early return for exact match, and match with
whitespace-fixed target).
