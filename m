From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Automerge fix
Date: Mon, 18 Apr 2005 19:48:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181945400.15725@ppc970.osdl.org>
References: <20050419010242.GS5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 04:43:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNihY-00076a-Dv
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 04:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVDSCqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 22:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVDSCqq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 22:46:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:54667 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261300AbVDSCqS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 22:46:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3J2kCs4025703
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 19:46:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3J2kBDs019915;
	Mon, 18 Apr 2005 19:46:11 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419010242.GS5554@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Petr Baudis wrote:
> 
> this patch fixes git-merge-one-file-script's automerge.

Nope, it doesn't. The original may not have worked, but neither does your 
vesion either: the reason for the exit 1 is that the _script_ should exit, 
but when you put it in a sub-shell with (..), now only the subshell exits 
with an error code, and we'll happily continue to do the following line 
which we should not do (since the merge failed).

> Signed-off-by: Petr Baudis <pasky@ucw.cz>
> 
> git-merge-one-file-script: 7ebf5dac4c69043cd2ff89bf7ee552152802f8d1
> --- a/git-merge-one-file-script
> +++ b/git-merge-one-file-script
> @@ -43,7 +43,7 @@ case "${1:-.}${2:-.}${3:-.}" in
>  	orig=$(unpack-file $1)
>  	src1=$(unpack-file $2)
>  	src2=$(unpack-file $3)
> -	merge "$src2" "$orig" "$src1" || echo Leaving conflict merge in $src2 && exit 1
> +	merge "$src2" "$orig" "$src1" || (echo Leaving conflict merge in $src2 && exit 1)
>  	cp "$src2" "$4" && update-cache --add -- "$4" && exit 0

What's the right way?

Maybe

	if merge "$src2" "$orig" "$src1"
	then 
		cp "$src2" "$4" && update-cache --add -- "$4" && exit 0
	fi
	echo Leaving conflict merge in $src2
	exit 1

would work?

		Linus
