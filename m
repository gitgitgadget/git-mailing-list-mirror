From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] dir: do all size checks before seeking back and fix file
 closing
Date: Sat, 26 Aug 2006 15:13:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608261509290.11811@g5.osdl.org>
References: <20060826141709.GC11601@diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 00:13:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH6P4-0003Qj-8j
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 00:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWHZWNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 18:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWHZWNJ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 18:13:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52681 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751219AbWHZWNG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 18:13:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7QMD1nW014782
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 26 Aug 2006 15:13:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7QMD0T0001353;
	Sat, 26 Aug 2006 15:13:00 -0700
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060826141709.GC11601@diku.dk>
X-Spam-Status: No, hits=-2.425 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26072>



On Sat, 26 Aug 2006, Jonas Fonseca wrote:
> 
> diff --git a/dir.c b/dir.c
> index d53d48f..ff8a2fb 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -122,11 +122,11 @@ static int add_excludes_from_file_1(cons
>  	size = lseek(fd, 0, SEEK_END);
>  	if (size < 0)
>  		goto err;
> -	lseek(fd, 0, SEEK_SET);
>  	if (size == 0) {
>  		close(fd);
>  		return 0;
>  	}
> +	lseek(fd, 0, SEEK_SET);

I really think you'd be better off rewriting that to use "fstat()" 
instead. I don't know why it uses two lseek's, but it's wrong, and looks 
like some bad habit Junio picked up at some point.

> @@ -146,7 +146,7 @@ static int add_excludes_from_file_1(cons
>  	return 0;
>  
>   err:
> -	if (0 <= fd)
> +	if (0 >= fd)
>  		close(fd);

That's wrong. 

Now, admittedly it's wrong because another bad habit Junio picked up 
(doing comparisons with constants in the wrong order), so please write it 
as

	if (fd >= 0)
		close(fd);

instead.

Junio: I realize that you claim that you learnt that syntax from an 
authorative source, but he was _wrong_. Doing the constant first is more 
likely to cause bugs, rather than less. Compilers will warn about the

	if (x = 0)
		..

kind of bug, and putting the constant first just confuses humans.

It's more important to _not_ confuse humans than it is to try to avoid an 
uncommon error that compilers can and do warn about anyway.

			Linus
