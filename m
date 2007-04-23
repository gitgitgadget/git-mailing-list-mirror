From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] add get_sha1_with_mode
Date: Sun, 22 Apr 2007 19:33:24 -0700
Message-ID: <7vmz0zkeff.fsf@assigned-by-dhcp.cox.net>
References: <1177260240326-git-send-email-mkoegler@auto.tuwien.ac.at>
	<11772602402479-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Apr 23 04:33:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfoMr-0005vO-O8
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 04:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030959AbXDWCd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 22:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030966AbXDWCd0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 22:33:26 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46475 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030959AbXDWCd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 22:33:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423023325.ZBJC1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 22:33:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qSZR1W00A1kojtg0000000; Sun, 22 Apr 2007 22:33:25 -0400
In-Reply-To: <11772602402479-git-send-email-mkoegler@auto.tuwien.ac.at>
	(Martin Koegler's message of "Sun, 22 Apr 2007 18:43:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45297>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> get_sha1_with_mode basically behaves as get_sha1. It has an additional
> parameter for storing the mode of the object. This parameter may be NULL.
> If the mode can not be determinded, it stores S_IFINVALID.
>
> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> ---
>  cache.h     |    1 +
>  sha1_name.c |   11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index d425c26..a9ae3f8 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -320,6 +320,7 @@ static inline unsigned int hexval(unsigned int c)
>  #define DEFAULT_ABBREV 7
>  
>  extern int get_sha1(const char *str, unsigned char *sha1);
> +extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
>  extern int get_sha1_hex(const char *hex, unsigned char *sha1);
>  extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
>  extern int read_ref(const char *filename, unsigned char *sha1);
> diff --git a/sha1_name.c b/sha1_name.c
> index 267ea3f..1349c0a 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -643,11 +643,18 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
>   */
>  int get_sha1(const char *name, unsigned char *sha1)
>  {
> +	return get_sha1_with_mode(name, sha1, NULL);
> +}
> +
> +int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned* mode)

Style.  Asterisk "*" is next to variable, not type in our code,
like "unsigned *mode".

> +{
>  	int ret, bracket_depth;
>  	unsigned unused;
>  	int namelen = strlen(name);
>  	const char *cp;
>  
> +	if (mode)
> +		*mode = S_IFINVALID;
>  	prepare_alt_odb();
>  	ret = get_sha1_1(name, namelen, sha1);
>  	if (!ret)
> @@ -685,6 +692,8 @@ int get_sha1(const char *name, unsigned char *sha1)
>  				break;
>  			if (ce_stage(ce) == stage) {
>  				hashcpy(sha1, ce->sha1);
> +				if (mode)
> +					*mode = ntohl(ce->ce_mode);
>  				return 0;
>  			}
>  			pos++;
> @@ -703,7 +712,7 @@ int get_sha1(const char *name, unsigned char *sha1)
>  		unsigned char tree_sha1[20];
>  		if (!get_sha1_1(name, cp-name, tree_sha1))
>  			return get_tree_entry(tree_sha1, cp+1, sha1,
> -					      &unused);
> +					      mode ? mode : &unused);
>  	}
>  	return ret;
>  }

Hmmmm.  I'm not sure if it is worth to have "store only of mode
pointer is not NULL" check in many places.  Wouldn't it make
more sense to require callers of _with_mode() variant to always
send in a valid pointer (after all, it is the caller who chose
to call the _with_mode() variant), and make get_sha1() like
this?

	int get_sha1(const char *name, unsigned char *sha1)
	{
        	unsigned discard;
                return get_sha1_with_mode(name, sha1, &discard);
	}
