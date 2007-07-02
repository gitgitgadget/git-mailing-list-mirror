From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bug: segfault during git-prune
Date: Mon, 2 Jul 2007 04:45:27 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707020441460.3323@woody.linux-foundation.org>
References: <200706281134.58453.andyparkins@gmail.com>
 <200706282321.44244.andyparkins@gmail.com>
 <alpine.LFD.0.98.0706281525460.8675@woody.linux-foundation.org>
 <200707021100.16610.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 13:45:41 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5KLc-0007lj-Hm
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 13:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbXGBLpg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 07:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbXGBLpg
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 07:45:36 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43648 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753590AbXGBLpf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jul 2007 07:45:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l62BjXu4016816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Jul 2007 04:45:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l62BjRC4016258;
	Mon, 2 Jul 2007 04:45:27 -0700
In-Reply-To: <200707021100.16610.andyparkins@gmail.com>
X-Spam-Status: No, hits=-2.646 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51358>



On Mon, 2 Jul 2007, Andy Parkins wrote:
> 
> Looking at your patch: is it possible that S_ISDIR() is true for gitlinks as 
> well as S_ISGITLINK()?  S_ISDIR() is from unistd.h; and is presumably 
> something like:
>  
>  S_ISDIR() { return mode & S_IFDIR; }

No, it's going to be something like "(mode & S_IFMASK) == S_IFDIR", so 
that part should be ok.

BUT:

> Given the hints you gave me in your previous reply, I've looked at the 
> backtrace again and understood more what's happening.
> 
>  - mark_reachable_objects() calls add_cache_refs()
>  - which uses lookup_blob() to mark every hash in the index as an OBJ_BLOB 
>    type of hash; including the GITLINK entries.

Yes, this sounds like the real issue (or the remaining issue, at least).

> I think the fault is in add_cache_refs() which assumes that every hash in the 
> index is an OBJ_BLOB.  I think that add_cache_refs() shouldn't be calling 
> lookup_blob() for S_ISGITLINK() index entries.  Therefore I think this patch 
> is the right one; what do you reckon?

Looks good to me.

> +       /*
> +        * The index can contain blobs and GITLINKs, GITLINKs are hashes
> +        * that don't actually point to objects in the repository, it's
> +        * almost guaranteed that they are NOT blobs, so we don't call
> +        * lookup_blob() on them, to avoid populating the hash table
> +        * with invalid information
> +        */
> +       if (S_ISGITLINK(ntohl(active_cache[i]->ce_mode)))
> +           continue;

Just for clarity, I'd use "process_gitlink()" here (and it would probably 
be a good idea to use process_blob() on the blob we look up too), and the 
proper tab indentation, but yes, I think you're otherwise exactly right.

		Linus
