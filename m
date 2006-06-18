From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix git to be (more) ANSI C99 compliant.
Date: Sun, 18 Jun 2006 09:50:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606180946090.5498@g5.osdl.org>
References: <1150609831500-git-send-email-octo@verplant.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 18:50:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs0U3-0007ZO-FF
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 18:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWFRQuo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 12:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWFRQuo
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 12:50:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932252AbWFRQun (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 12:50:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5IGobgt023387
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Jun 2006 09:50:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5IGobFi030964;
	Sun, 18 Jun 2006 09:50:37 -0700
To: Florian Forster <octo@verplant.org>
In-Reply-To: <1150609831500-git-send-email-octo@verplant.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22093>



On Sun, 18 Jun 2006, Florian Forster wrote:
>
> Using this patch I was able to build git with
> $ make CFLAGS="-Wall -Werror -ansi -pedantic -std=c99 -D_XOPEN_SOURCE=500 -D_BSD_SOURCE"

"-ansi -pedantic" is really not useful.

> While most of this patch fixes void-pointer arithmetic

This one I disagree with. Doing arithmetic on "void *" is _really_ useful, 
and I think most compilers end up supporting it either to be compatible 
with gcc, or just because it's hard to not do it.

It makes code a _lot_ cleaner.

In general, explicit casts are a sign of bad programming, and "void *" is 
there exactly to avoid it. And doing arithmetic on pointers is useful and 
fairly common, and if you accept void-pointer arithmetic, it avoids a lot 
of ugly and useless casts.

> @@ -301,9 +301,9 @@ static void fill_line_map(struct commit 
>  				if (DEBUG)
>  					printf("map: i1: %d %d %p i2: %d %d %p\n",
>  					       i1, map[i1],
> -					       i1 != -1 ? blame_lines[map[i1]] : NULL,
> +					       (void *) (i1 != -1 ? blame_lines[map[i1]] : NULL),
>  					       i2, map2[i2],
> -					       i2 != -1 ? blame_lines[map2[i2]] : NULL);
> +					       (void *) (i2 != -1 ? blame_lines[map2[i2]] : NULL));

Gaah. This is another case of casting that I'm sure is technically 
correct, but that I wonder whether there is any machine that actually 
cares..

But at least in that case I suspect the cast _may_ be required due to 
different pointer representations.

		Linus
