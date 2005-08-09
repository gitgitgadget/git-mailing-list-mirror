From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Make git-rev-tree obsolete
Date: Mon, 8 Aug 2005 19:09:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508081858120.3258@g5.osdl.org>
References: <Pine.LNX.4.63.0508090222190.4076@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 09 04:10:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2JZO-0004hF-R1
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 04:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVHICKQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 22:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbVHICKQ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 22:10:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61123 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932408AbVHICKP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 22:10:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7929ejA002572
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 Aug 2005 19:09:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7929cxM012353;
	Mon, 8 Aug 2005 19:09:39 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.63.0508090222190.4076@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.41__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 9 Aug 2005, Johannes Schindelin wrote:
> 
> Junio remarked that Jeff's git-changes-script still uses git-rev-tree, and 
> therefore it should not be removed. This patch changes git-changes-script 
> over to git-rev-list:

It really should be totally rewritten, to take advantage of git-rev-list 
being able to terminate early. As it is, your conversion may work, and it 
may give the right results, but it will suck performance-wise for all the 
same reasons that git-rev-tree sucked: it will walk all the way down to 
the root of the tree(s).

> --- git-changes-script.orig	Tue Aug  9 02:21:36 2005
> +++ git-changes-script	Tue Aug  9 02:20:53 2005
> @@ -85,14 +85,14 @@
>  	base=$(cat .git/HEAD) || exit 1
>  fi
>  
> -git-rev-tree $base | sort -rn  > ${tmpfile}.base
> +git-rev-list $base > ${tmpfile}.base
>  if [ -n "$remote" ]; then
>  	[ -d $remote/.git ] || exit 1
>  	if [ -z "$tobase" ]; then
>  		tobase=$(cat $remote/.git/HEAD) || exit 1
>  	fi
>  	pushd $remote > /dev/null
> -	git-rev-tree $tobase | sort -rn > ${tmpfile}.remote
> +	git-rev-list $tobase > ${tmpfile}.remote
>  	diff -u ${tmpfile}.base ${tmpfile}.remote | grep "^${diffsearch}[^${diffsearch}]" | cut -c 1- > ${tmpfile}.diff
>  	rm -f ${tmpfile}.base ${tmpfile}.remote
>  	mv ${tmpfile}.diff ${tmpfile}.base

It really should do something like

	#
	# Make sure we see objects in the remote directory
	#
	export GIT_ALTERNATE_OBJECT_DIRECTORIES=$remote/.git/objects

	#
	# Get the local SHA1
	#
	local_ref=$(git-rev-parse --verify $base^0) || exit

	#
	# Get the remote SHA1
	#
	remote_ref=$(GIT_DIR="$remote/.git" git-rev-parse --verify $tobase^0) || exit

	#
	# Ok, let it rip..
	#
	git log $remote_ref..$local_ref

to do a proper search of objects that are in $local but not in $remote, 
without having to traverse all the way down to the root for both.

		Linus
