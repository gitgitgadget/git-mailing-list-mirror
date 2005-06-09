From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 8 Jun 2005 21:54:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506082145160.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
 <7vis0o30sc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
 <7voeag1j9y.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506081757170.2286@ppc970.osdl.org>
 <7vll5kxolo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506081936370.2286@ppc970.osdl.org>
 <7vfyvsuoz3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 06:49:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgEye-00087u-6Z
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 06:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVFIExM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 00:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVFIExM
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 00:53:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8906 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262266AbVFIEww (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 00:52:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j594qjjA027548
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 21:52:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j594qitl015558;
	Wed, 8 Jun 2005 21:52:44 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyvsuoz3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 8 Jun 2005, Junio C Hamano wrote:
> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> LT> Yeah, ok, so the fact that we allow missing things in the
> LT> index (which was debatable to start with) makes for
> LT> exceptions.
> 
> Not just that.  Another big difference is that we allow _extra_
> things in the index in two-tree case (i.e. local additions).
> But I do not think these exceptions are necessarily bad.

Well, they'd be bad in a three-way merge.

The reason they aren't bad in a two-way merge is that you don't commit the 
result - the commits have been done already. 

That's really the big conceptual difference between two-way and three-way:  
never mind the merge algorithm itself.

(In fact, in many ways, two-way merges are really just the same as a 
one-way merge, except it now knows where it came from, so it can do sanity 
checking).

As to working tree changes:

> which means we are exactly in the same situation as "merge I and
> M pivoting on H" three-way merge, with a dirty work tree.  Any
> solution and help we would give to the end-user for the
> three-way case would automatically help this two-way case,
> wouldn't it?

Yes.

In fact, there's a fairly simple solution, which is to remove the current 
check for "verify_uptodate()" and instead replace it with the "update" 
phase not just writing the file, but actually doing a three-way merge on 
it.

NOTE! This would not affect the resulting _tree_ in any way at all. It 
would literally only affect how we write out the working directory. Right 
now we just fail when the working file isn't up-to-date, and that could be 
replaced with instead doing a

	merge W I M

where "W" is the working file, "I" is the index file, and "M" is the merge 
result that we currently just write out directly.

In the special case of I == M, we already do _exactly_ this: we know that
since I=M, the merge will be W, so we don't do the update at all.

So in fact, doing a 3-way merge is really a generalization of what we
already do, and removes a failure case.

NOTE! This 3way merge is fundamentally _different_ from the 3-way merge
that is done by "git-merge-one-file-script" that we already do. _That_
3-way merge is done not on the working files, but on the results in the
trees, while this new 3way merge would be done purely in the working
directory (ie it wouldn't make sense without the "-u" flag).

If we do this, I'd personally suggest it be another flag, possibly "-u3" 
instead of just plain "-u".

		Linus
