X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Avoid accessing a slow working copy during diffcore operations.
Date: Fri, 15 Dec 2006 22:03:21 -0800
Message-ID: <7vpsakl6mu.fsf@assigned-by-dhcp.cox.net>
References: <20061214111557.GA24297@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 06:03:31 +0000 (UTC)
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061214111557.GA24297@spearce.org> (Shawn O. Pearce's message
	of "Thu, 14 Dec 2006 06:15:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34590>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvSds-0005BT-EN for gcvg-git@gmane.org; Sat, 16 Dec
 2006 07:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965331AbWLPGDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 01:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965338AbWLPGDZ
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 01:03:25 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:35806 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965331AbWLPGDY (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 01:03:24 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216060322.ECZM4226.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Sat, 16
 Dec 2006 01:03:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id zJ2i1V0041kojtg0000000; Sat, 16 Dec 2006
 01:02:42 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If Git is compiled with NO_FAST_WORKING_DIRECTORY set then we will
> avoid looking at the working directory when the blob in question
> is available within a packfile and the caller doesn't need the data
> unpacked into a temporary file.

I'd take the patch as is, but...

> -static int work_tree_matches(const char *name, const unsigned char *sha1)
> +static int work_tree_matches(const char *name, const unsigned char *sha1, int want_file)

this feels wrong.  It is not about "work tree matches" anymore.
reuse_worktree_copy(), perhaps.

> @@ -1193,6 +1193,20 @@ static int work_tree_matches(const char *name, const unsigned char *sha1)
>  	if (!active_cache)
>  		return 0;
>  
> +#ifdef NO_FAST_WORKING_DIRECTORY
> +	/* We want to avoid the working directory if our caller
> +	 * doesn't need the data in a normal file, this system
> +	 * is rather slow with its stat/open/mmap/close syscalls,
> +	 * and the object is contained in a pack file.  The pack
> +	 * is probably already open and will be faster to obtain
> +	 * the data through than the working directory.  Loose
> +	 * objects however would tend to be slower as they need
> +	 * to be individually opened and inflated.
> +	 */
> +	if (!want_file && has_sha1_pack(sha1, NULL))
> +		return 0;
> +#endif
> +

Also I'd prefer doing this without #ifdef;

        if (defined(NO_FAST_WORKING_DIRECTORY) &&
        	!want_file && has_sha1_pack(sha1, NULL))
		return 0;
