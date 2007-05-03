From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make xstrndup common
Date: Wed, 02 May 2007 21:08:21 -0700
Message-ID: <7vzm4m35xm.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705022248040.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 03 06:08:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjScE-000254-6p
	for gcvg-git@gmane.org; Thu, 03 May 2007 06:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767363AbXECEIX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 00:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767364AbXECEIX
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 00:08:23 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:39421 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767363AbXECEIW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 00:08:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070503040822.PYBP1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 3 May 2007 00:08:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id uU8M1W00Z1kojtg0000000; Thu, 03 May 2007 00:08:22 -0400
In-Reply-To: <Pine.LNX.4.64.0705022248040.28708@iabervon.org> (Daniel
	Barkalow's message of "Wed, 2 May 2007 22:49:41 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46060>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This also improves the implementation to match how strndup is
> specified (by GNU): if the length given is longer than the string,
> only the string's length is allocated and copied, but the string need
> not be null-terminated if it is at least as long as the given length.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> Haven't got the rest of my series updated for comments, but I'd like to 
> get this change, which is logically unrelated aside from being a 
> dependancy, in now.
>
>  commit.c          |    8 --------
>  git-compat-util.h |   12 ++++++++++++
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index f1ba972..aa7059c 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -718,14 +718,6 @@ static char *logmsg_reencode(const struct commit *commit,
>  	return out;
>  }
>  
> -static char *xstrndup(const char *text, int len)
> -{
> -	char *result = xmalloc(len + 1);
> -	memcpy(result, text, len);
> -	result[len] = '\0';
> -	return result;
> -}
> -
>  static void fill_person(struct interp *table, const char *msg, int len)
>  {
>  	int start, end, tz = 0;
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 2c84016..0dcd4e2 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -197,6 +197,18 @@ static inline void *xmalloc(size_t size)
>  	return ret;
>  }
>  
> +static inline char *xstrndup(const char *str, int len)
> +{
> +	char *ret;
> +	int i;
> +	for (i = 0; i < len && str[i]; i++)
> +		;
> +	ret = xmalloc(i + 1);
> +	strncpy(ret, str, i);

Why strncpy() not memcpy()?

> +	ret[i] = '\0';
> +	return ret;
> +}
> +
>  static inline void *xrealloc(void *ptr, size_t size)
>  {
>  	void *ret = realloc(ptr, size);
> -- 
> 1.5.1.2.255.g6ead4-dirty
