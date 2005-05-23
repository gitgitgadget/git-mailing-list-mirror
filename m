From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make sure diff-helper can tell rename/copy in the new
 diff-raw format.
Date: Mon, 23 May 2005 07:49:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 16:47:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaECE-0007NF-SM
	for gcvg-git@gmane.org; Mon, 23 May 2005 16:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVEWOrn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 10:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVEWOrn
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 10:47:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:8377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261886AbVEWOrE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 10:47:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4NEkujA022071
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 07:46:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4NEkuDe001095;
	Mon, 23 May 2005 07:46:56 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfywe769d.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, Junio C Hamano wrote:
>
> This adds tests to make sure that diff-helper can tell renames
> from copies using the same "everything but the last one are
> copies and the last one is either rename or stay" logic.

Btw, I still disagree with this notion that the order of the use of the 
names makes a difference.

I think that when we generate a diff, we should always have the _option_
to make sure that we generate it in a format where you can apply it
"incrementally". But I disagree with the notion that it's something
fundamental, and in fact, I even think that it's not necessarily a good
default.

For example, let's say that you have modified "fileA" _and_ you have 
created a "fileB" that is a copy of the original "fileA" with some _other_ 
slight modifications. We'll call the SHA1's involved "sha_A", "sha_A'" and 
"sha_B"

I think it's perfectly valid to say

	:100644 100644 <sha_A> <sha_A'> M	fileA	fileA
	:100644 100644 <sha_A> <sha_B> C89	fileA	fileB

which says "fileA" was modified from orig-A to new-A, and "fileB" is a 
copy based on orig-A.

(I've used a new syntax just to confuse the issue, with the extra field 
for "what happened", aka "M" for "modify", "C89" for "copy a 89% similar 
file").

Now, when the above is turned into a "diff", that diff is no longer
something you can apply "incrementally" - you have to apply it as if
you're applying all differences to the "original tree". But the thing is,
that's actually what I _want_, because I was planning on writing a tool
that applies patches that applies them all-or-nothing.

Also, it turns out that this kind of "non-incremental" diff is the kind
that I personally want to see as a _human_, because quite frankly, my
brain-capacity is that of a demented ocelot, and I can't _remember_ what
happened in other parts of the diff. I much prefer the stateless "oh, this
file X is in that relation Y to the previous version of file Z".

I do that partly because I actually routinely edit patches. If you have 
the incremental format, that's practically impossible, while the stateless 
version is fine.

See?

So I think all the clever "don't re-use files we have modified" etc is 
actually wrong. If you want to make a traditional diff that can be applied 
with normal "patch", you just don't use the -M or -C flags.

		Linus
