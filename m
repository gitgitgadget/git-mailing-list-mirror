From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/14] advice: Introduce error_resolve_conflict
Date: Wed, 6 Jul 2011 03:35:12 -0500
Message-ID: <20110706083512.GA15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 10:35:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeNZy-00061Q-3b
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 10:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab1GFIfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 04:35:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62986 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab1GFIfU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 04:35:20 -0400
Received: by iwn6 with SMTP id 6so5892039iwn.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 01:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X9j8IYlJaZVOn71KxkastbMEhbqh81JGq/OqpKooxzU=;
        b=cl+VoXfelCIdT0xL9LZHkJz86inS4NHbiVZ70aKee9X1Q2hRAyJ0UE+cDnv2voBpwG
         iB4DWdGYs7FY4O4QWYbgKlAOwzjEBoNU42uCG6d3pqWloeUVUjqW5On9uFNW9Kq0fYX4
         K4+Nln+b95hhRECh70U4gPaAwN6mrA9ouNgtM=
Received: by 10.42.161.3 with SMTP id r3mr9344525icx.186.1309941319622;
        Wed, 06 Jul 2011 01:35:19 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.ameritech.net [69.209.76.243])
        by mx.google.com with ESMTPS id j1sm4740004ibg.38.2011.07.06.01.35.17
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 01:35:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309938868-2028-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176663>

Ramkumar Ramachandra wrote:

> Enable future callers to report a conflict and not die immediately by
> introducing a new function called error_resolve_conflict.
> Re-implement die_resolve_conflict as a call to error_resolve_conflict
> followed by a call to die.  Consequently, the message printed by
> die_resolve_conflict changes from
>
> fatal: 'commit' is not possible because you have unmerged files.
>        Please, fix them up in the work tree ...
>        ...
>
> to
>
> error: 'commit' is not possible because you have unmerged files.
> hint: Please, fix them up in the work tree ...
> hint: ...
> fatal: Exiting because of an unresolved conflict.

Thanks!  Personally, I like it (since the tags on the left make it a
little clearer to the reader what is happening).

> --- a/advice.c
> +++ b/advice.c
> @@ -19,6 +19,15 @@ static struct {
>  	{ "detachedhead", &advice_detached_head },
>  };
> 
> +static void advise(const char *advice, ...)
> +{
> +	va_list params;
> +
> +	va_start(params, advice);
> +	vreportf("hint: ", advice, params);
> +	va_end(params);
> +}

Rather than copy+pasting this code verbatim, wouldn't it make sense to
move it and expose it through advice.h so the old call site can use
the same code?

For what it's worth, with that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
