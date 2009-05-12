From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix type-punning issues
Date: Tue, 12 May 2009 00:57:42 -0700
Message-ID: <7vy6t292ix.fsf@alter.siamese.dyndns.org>
References: <1242091058-25197-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 09:57:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3ms5-000750-Vo
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 09:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499AbZELH5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 03:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754741AbZELH5n
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 03:57:43 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:47266 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbZELH5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 03:57:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090512075744.MHHL20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 May 2009 03:57:44 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id qXxi1b0074aMwMQ03XxiwP; Tue, 12 May 2009 03:57:43 -0400
X-Authority-Analysis: v=1.0 c=1 a=pGLkceISAAAA:8 a=faXARV-m5mM91K6CHcEA:9
 a=Z2d1SgFZH3RL82DWcDUA:7 a=R0ATNZerhSF1sTPFGoFkeN-QPkgA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1242091058-25197-1-git-send-email-dpmcgee@gmail.com> (Dan McGee's message of "Mon\, 11 May 2009 20\:17\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118879>

Dan McGee <dpmcgee@gmail.com> writes:

> In these two places we are casting part of our unsigned char sha1 array into
> an unsigned int, which violates GCCs strict-aliasing rules (and probably
> other compilers).

Yay.

>  static unsigned int hash_obj(const struct object *obj, unsigned int n)
>  {
> -	unsigned int hash = *(unsigned int *)obj->sha1;
> +	unsigned int hash;
> +	memcpy(&hash, obj->sha1, sizeof(unsigned int));
>  	return hash % n;
>  }

I noticed this breakage when I borrowed a friend's FC11 preview (as I
still do not have a replacement machine X-<), but didn't manage to spend
enough time to fix it myself.  I was hoping a way to tell the compiler
that this particular pointer usage is Ok in a less hacky way that does not
upset older compilers, without resorting to low-level memcpy.  But your
version to use memcpy() is a literal translation of what the code does,
and I think it is an acceptable solution.

> @@ -16,7 +17,7 @@ static void *insert_decoration(struct decoration *n, const struct object *base,
>  {
>  	int size = n->size;
>  	struct object_decoration *hash = n->hash;
> -	int j = hash_obj(base, size);
> +	unsigned int j = hash_obj(base, size);

These type changes should be Ok, but I would have preferred them to be a
separate patch.  From the context, you cannot see if the function in
places outside the patch context uses "j" for purposes other than holding
the return value of hash_obj() that requires it to be able to hold a
netagive value to make sure that this conversion is correct; on the other
hand, we know n->size is a sane small value that unsigned vs signed int
does not matter, so in that sense making this change in the same patch
makes it not about fixing pointer aliasing warning.

But the code here is correct (I read outside the context).

> @@ -68,7 +69,7 @@ void *add_decoration(struct decoration *n, const struct object *obj,
>  /* Lookup a decoration pointer */
>  void *lookup_decoration(struct decoration *n, const struct object *obj)
>  {
> -	int j;
> +	unsigned int j;

Same here.

> diff --git a/object.c b/object.c
> index 7e6a92c..96ef32d 100644
> --- a/object.c
> +++ b/object.c
> @@ -43,15 +43,16 @@ int type_from_string(const char *str)
>  	die("invalid object type \"%s\"", str);
>  }
>  
> -static unsigned int hash_obj(struct object *obj, unsigned int n)
> +static unsigned int hash_char(const unsigned char *sha1, unsigned int n)
>  {
> -	unsigned int hash = *(unsigned int *)obj->sha1;
> -	return hash % n;
> +	unsigned int i;
> +	memcpy(&i, sha1, sizeof(unsigned int));
> +	return (int)(i % n);

Huh?  The original looks the same as the one in decorate.c but why is the
conversion different?  I am not talking about the difference between hash
and i, but am wondering about the cast to int (and then back to unsigned
int by the function signature).

It might make more sense to have one canonical

	unsigned int hash_obj(const struct object *obj, unsigned int n)

here, export it to object.h, and remove the one in decorate.c.

Or am I missing something?
