From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git to be (more) ANSI C99 compliant.
Date: Sun, 18 Jun 2006 01:29:53 -0700
Message-ID: <7vac8a50ji.fsf@assigned-by-dhcp.cox.net>
References: <1150609831500-git-send-email-octo@verplant.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 10:29:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrsfO-0007Zl-Tn
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 10:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWFRI34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 04:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWFRI34
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 04:29:56 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:44687 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750715AbWFRI3z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 04:29:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060618082954.BXBE27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Jun 2006 04:29:54 -0400
To: Florian Forster <octo@verplant.org>
In-Reply-To: <1150609831500-git-send-email-octo@verplant.org> (Florian
	Forster's message of "Sun, 18 Jun 2006 07:50:31 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22059>

Florian Forster <octo@verplant.org> writes:

> While most of this patch fixes void-pointer arithmetic and is therefore
> trivial, I had to change the use of a struct with FAMs in `diff-lib.c'. Since
> this is the first time I encountered FAMs it'd probably be a good idea if
> someone who knows would take a look at that.

Thanks.  I am very tempted to apply it, but I started to wonder
that in some places it might make sense to convert void* to
char* instead of casting.  Undecided.

> diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
> index f6310b9..646322d 100644
> --- a/builtin-tar-tree.c
> +++ b/builtin-tar-tree.c
> @@ -34,7 +34,7 @@ static void reliable_write(void *buf, un
>  			die("git-tar-tree: disk full?");
>  		}
>  		size -= ret;
> -		buf += ret;
> +		buf   = (char *) buf + ret;

Please do not add the extra whitespace to align "=".

> @@ -244,14 +244,14 @@ static void convert_date(void *buffer, u
>  	// "tree <sha1>\n"
>  	memcpy(new + newlen, buffer, 46);
>  	newlen += 46;
> -	buffer += 46;
> +	buffer = (char *) buffer + 46;
>  	size -= 46;
>  
>  	// "parent <sha1>\n"
>  	while (!memcmp(buffer, "parent ", 7)) {
>  		memcpy(new + newlen, buffer, 48);
>  		newlen += 48;
> -		buffer += 48;
> +		buffer = (char *) buffer + 48;
>  		size -= 48;
>  	}
>  
> @@ -275,11 +275,11 @@ static void convert_commit(void *buffer,
>  
>  	if (memcmp(buffer, "tree ", 5))
>  		die("Bad commit '%s'", (char*) buffer);
> -	convert_ascii_sha1(buffer+5);
> -	buffer += 46;    /* "tree " + "hex sha1" + "\n" */
> +	convert_ascii_sha1((char *) buffer + 5);
> +	buffer = (char *) buffer + 46;    /* "tree " + "hex sha1" + "\n" */
>  	while (!memcmp(buffer, "parent ", 7)) {
> -		convert_ascii_sha1(buffer+7);
> -		buffer += 48;
> +		convert_ascii_sha1((char *) buffer + 7);
> +		buffer = (char *) buffer + 48;
>  	}
>  	convert_date(orig_buffer, orig_size, result_sha1);
>  }

Hmmmmmmm.  Now I start to wonder if changing the type of "void *buffer"
to "char *buffer" is cleaner.

> diff --git a/diff-delta.c b/diff-delta.c
> index 25a798d..8b9172a 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -22,6 +22,7 @@ #include <stdlib.h>
>  #include <string.h>
>  #include "delta.h"
>  
> +#include "git-compat-util.h"
>  
>  /* maximum hash entry list for the same hash bucket */
>  #define HASH_LIMIT 64
> @@ -131,7 +132,7 @@ struct delta_index {
>  	const void *src_buf;
>  	unsigned long src_size;
>  	unsigned int hash_mask;
> -	struct index_entry *hash[0];
> +	struct index_entry *hash[FLEX_ARRAY];
>  };

Good -- I missed this when we did FLEX_ARRAY.  Thanks.

> diff --git a/diff-lib.c b/diff-lib.c
> index 2183b41..fdc1173 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -34,21 +34,23 @@ int run_diff_files(struct rev_info *revs
>  			continue;
>  
>  		if (ce_stage(ce)) {
> -			struct {
> -				struct combine_diff_path p;
> -				struct combine_diff_parent filler[5];
> -			} combine;

I admit this part was ugly.  The new code does not do any extra
allocations and matches the other use of "struct combine_diff_path"
more closely.  Good change.

> @@ -1136,13 +1136,14 @@ int fetch(unsigned char *sha1)
>  
>  static inline int needs_quote(int ch)
>  {
> -	switch (ch) {
> -	case '/': case '-': case '.':
> -	case 'A'...'Z':	case 'a'...'z':	case '0'...'9':
> +	if (((ch >= 'A') && (ch <= 'Z'))
> +			|| ((ch >= 'a') && (ch <= 'z'))
> +			|| ((ch >= '0') && (ch <= '9'))
> +			|| (ch == '/')
> +			|| (ch == '-')
> +			|| (ch == '.'))
>  		return 0;
> -	default:
> -		return 1;
> -	}
> +	return 1;
>  }

Ugh.  Delight of standard compliance X-<.

> diff --git a/http-push.c b/http-push.c
> index 2d9441e..0684e46 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1077,13 +1077,14 @@ static int fetch_indices(void)
>  
>  static inline int needs_quote(int ch)

Hmph.  Thanks for noticing the duplicated code; maybe move it to
cache.h perhaps?
