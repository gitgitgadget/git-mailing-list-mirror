From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 4/5] tree-walk: unroll get_mode since loop boundaries
 are well-known
Date: Mon, 04 Apr 2011 14:30:17 +0200
Message-ID: <4D99B9D9.1020101@op5.se>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com> <1301535481-1085-4-git-send-email-dpmcgee@gmail.com> <BANLkTi=dF7p9K5c8SYFJjZ7uognwizuuaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 04 14:30:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6ivQ-0002bX-Hp
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 14:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707Ab1DDMaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 08:30:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39799 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab1DDMaW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 08:30:22 -0400
Received: by fxm17 with SMTP id 17so3849715fxm.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 05:30:21 -0700 (PDT)
Received: by 10.223.97.196 with SMTP id m4mr1162851fan.105.1301920221110;
        Mon, 04 Apr 2011 05:30:21 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id 21sm1701484fav.41.2011.04.04.05.30.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 05:30:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9 ThunderGit/0.1a
In-Reply-To: <BANLkTi=dF7p9K5c8SYFJjZ7uognwizuuaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170807>

On 04/04/2011 12:29 PM, Erik Faye-Lund wrote:
> 
> Wouldn't this part be cleaner as a constant-length loop? Any
> optimizing compiler should end up unrolling this, and we don't get as
> much code-duplication...
> 

It would.

> Oddly enough, this change gave me a drastic (>  20%) performance
> increase in my test (isolating get_mode in a separate compilation
> unit, and calling it in a loop):
> 
> diff --git a/tree-walk.c b/tree-walk.c
> index b8d504b..114ad63 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -7,42 +7,30 @@
>   static const char *get_mode(const char *str, unsigned int *modep)
>   {
>   	unsigned char c;
> -	unsigned int mode = 0;
> +	unsigned int mode = 0, i;
> 
>   	/*
> -	 * Unroll what looks like a loop since the bounds are
> +	 * Allow the compiler to unroll the loop since the bounds are
>   	 * well-known. There should be at least 5 and at most 6
>   	 * characters available in any valid mode, as '40000' is the
>   	 * shortest while '160000' (S_IFGITLINK) is the longest.
>   	 */
> -	/* char 1 */
> -	c = *str++;
> -	if (c<  '0' || c>  '7') return NULL;
> -	mode = (mode<<  3) + (c - '0');
> -	/* char 2 */
> -	c = *str++;
> -	if (c<  '0' || c>  '7') return NULL;
> -	mode = (mode<<  3) + (c - '0');
> -	/* char 3 */
> -	c = *str++;
> -	if (c<  '0' || c>  '7') return NULL;
> -	mode = (mode<<  3) + (c - '0');
> -	/* char 4 */
> -	c = *str++;
> -	if (c<  '0' || c>  '7') return NULL;
> -	mode = (mode<<  3) + (c - '0');
> -	/* char 5 */
> -	c = *str++;
> -	if (c<  '0' || c>  '7') return NULL;
> -	mode = (mode<<  3) + (c - '0');
> +	for (i = 0; i<  5; ++i) {

s/i< 5/i < 5/ (nitpicking, yes)

> +		c = *str++;
> +		if (c<  '0' || c>  '7')
> +			return NULL;
> +		mode = (mode<<  3) + (c - '0');

This could be (micro-)optimized further as:

--%<--%<--
for (i = 0; i < 5; i++) {
	int c = *str++ - '0';
	if (c & ~7) {
		/* 5 chars is ok, so long as *str is now a space */
		if (i == 5 && c == ' ') {
			*modep = mode;
			return str;
		}
		return NULL;
	}
	mode = (mode << 3) + c;
}

/* this should be a space, or we've got a malformed entry */
if (*str != ' ')
	return NULL;

return str + 1;
--%<--%<--

This should be slightly faster since there's now only one comparison
inside the loop and since one branch contains a second branch fork-point
and an inevitable early return the branch prediction machinery in gcc
will favor the most common case properly, but pre-computations on 'mode'
have to be undone in one case of hitting the early return, it might be
faster to play pickup after a loop to 5 is done.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
