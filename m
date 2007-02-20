From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 20 Feb 2007 08:41:24 +0000
Message-ID: <200702200841.26578.andyparkins@gmail.com>
References: <200702191839.05784.andyparkins@gmail.com> <7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 09:41:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJQZ5-0000Yc-MN
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 09:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965317AbXBTIld (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 03:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbXBTIld
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 03:41:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:12850 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965317AbXBTIlc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 03:41:32 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2676095nfa
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 00:41:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aGcKr8EWOC1MHqs/1EhhGv4joxmzYdhXM8CRmxjuoedc28o9YN4HVq0oSwxoSxbdPHA2NlA5LzjO3nZqVoYLmSnX1UIsINpYaBkufPKaDmF/btT8Tk+6mRGvAvTJmvSrSFmRA7UgF6AG5vb4varuAkbjZwhlYCkqBYV903fak0g=
Received: by 10.49.94.18 with SMTP id w18mr6547014nfl.1171960891024;
        Tue, 20 Feb 2007 00:41:31 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id c28sm2754982nfb.2007.02.20.00.41.28;
        Tue, 20 Feb 2007 00:41:29 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40212>

On Monday 2007 February 19 20:07, Junio C Hamano wrote:

> >  - len = strlen(refs[i]) + 11;
> >  + len = strlen(refs[i]) + STRLEN_PATH_REFS_TAGS + 1;
>
> shows that you've carefully looked at what the code does,
> instead of mindlessly replacing, which is a very good sign, but
> how much testing has this seen, I wonder.

Not huge quantities.  The patch is so wide-spread, that I've checked it 
compiles, and I've run with it for a bit.  However, I could not swear to 
having checked every path...


> > diff --git a/builtin-describe.c b/builtin-describe.c
> > index bcc6456..0f78363 100644
> > --- a/builtin-describe.c
> > +++ b/builtin-describe.c
> > @@ -52,7 +52,7 @@ static int get_name(const char *path, const unsigned
> > char *sha1, int flag, void * If --tags, then any tags are used.
> >  	 * Otherwise only annotated tags are used.
> >  	 */
> > -	if (!strncmp(path, "refs/tags/", 10)) {
> > +	if (!strncmp(path, PATH_TAGS, STRLEN_PATH_TAGS)) {
> >  		if (object->type == OBJ_TAG)
> >  			prio = 2;
> >  		else
>
> This is PATH_REFS_TAGS isn't it?

<shame> Yes.

> I mildly mind this one, as it hurts grep-ability.  I know this is one
> of the the only two places in git that 'master' branch is treated
> specially (and I think we would like to keep it that way --- that's

The output of 
 $ git-grep "master" -- '*.c' '*.h'
Is not that big, so those special treatments can be easily found irrespective 
of my patch.

> why I want to be able to grep for "refs/heads/master" and see very few
> hits), so introducing PATH_REFS_HEADS_MASTER is probably not very
> productive either, but...  hmmmm.

As I've said before, I'm against /any/ special treatment of master other than 
as a default branch name in a newly initialised repository.  
PATH_REFS_HEADS_MASTER is closer to master not being special than without so 
I'd be in favour of that.

> These repeated strncmp(p, X, STRLEN_X) almost makes me wonder if we
> want to introduce:
>
> 	inline int prefixcmp(a, b)
>         {
>         	return (strncmp(a, b, strlen(b));
>         }
>
> with clever preprocessor optimization to have compiler do strlen()
> when b is a string literal.

Wow; that would be clever - regardless of whether this patch is acceptable or 
not.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
