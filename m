From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] (preview) Renaming push.
Date: Wed, 3 Aug 2005 16:48:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508031641270.3258@g5.osdl.org>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
 <Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de>
 <200508031908.22562.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.58.0508031102590.3258@g5.osdl.org>
 <7vek9a8uy9.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 01:48:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0SyU-0004Pq-FQ
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 01:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVHCXsW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 19:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVHCXsW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 19:48:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261648AbVHCXsU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 19:48:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j73NmEjA001510
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 Aug 2005 16:48:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j73NmDdM016990;
	Wed, 3 Aug 2005 16:48:14 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek9a8uy9.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 3 Aug 2005, Junio C Hamano wrote:
>
> This allows git-send-pack to push local refs to a destination
> repository under different names.

Looks good, except I was almost hoping for one modification:

> Here is the name mapping rules for refs.
> 
> * If there is no ref mapping on the command line:
> 
>  - if '--all' is specified, it is equivalent to specifying
>    <local> ":" <local> for all the existing local refs on the
>    command line
>  - otherwise, it is equivalent to specifying <ref> ":" <ref> for
>    all the refs that exist on both sides.
> 
> * <name> is just a shorthand for <name> ":" <name>
> 
> * <src> ":" <dst>
> 
>   push ref that matches <src> to ref that matches <dst>.

In this format, "src" makes sense as a generic sha1_name, and _not_ 
necessarily limited to a ref-name.

IOW, there's really no reason to not allow

	git-send-pack .. dest .. <sha1>:dst-ref

where "<sha1>" may be something else than a ref (but a ref obviously ends 
up being one such thing).

For example, let's say that I've got stuff at the HEAD of my tree that I'm
not quite ready to push out yet, but I _do_ want to push out the parent of
the current head. I'd love to be able to just do

	git-send-pack parent $(git-rev-parse HEAD^):master

and there's no real reason why that syntax shouldn't just work: it's 
entirely logical to say "I want to push out the parent of my HEAD as 
'master' on the other end", and that's _exactly_ what the above says.

So:

>   - It is an error if <src> does not match exactly one of local
>     refs.

I think "src" should just be seen as any random SHA1 name, and we should 
use "get_sha()" to convert it to a SHA1.

In contrast, "dst" is obviously a real ref name, and as such:

>   - It is an error if <dst> matches more than one remote refs.

makes sense.

That makes your next rule a bit iffy, though:

>   - If <dst> does not match any remote refs, either
> 
>     - it has to start with "refs/"; <dst> is used as the
>       destination literally in this case.
> 
>     - <src> == <dst> and the ref that matched the <src> must not
>       exist in the set of remote refs; the ref matched <src>
>       locally is used as the name of the destination.

since "src" from a local standpoint isn't really a ref-name at all.

But hey, your current patch looks fine already. It doesn't _quite_ do what 
I had in mind, but it gets very very close.

		Linus
