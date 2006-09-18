From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-pack-refs --prune
Date: Mon, 18 Sep 2006 09:47:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609180934360.4388@g5.osdl.org>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
 <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org> <7vy7shr5zw.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 18:47:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPMHX-0006F5-Mr
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 18:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbWIRQrj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 12:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWIRQrj
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 12:47:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751838AbWIRQrj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 12:47:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8IGlYnW032750
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Sep 2006 09:47:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8IGlX5D013284;
	Mon, 18 Sep 2006 09:47:33 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7shr5zw.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-1.007 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27250>



On Mon, 18 Sep 2006, Junio C Hamano wrote:
> 
> I am not sure I got the locking right, hence this RFC.

It looks correct (the important part to check is that the SHA1 of the ref 
you remove still matches the SHA1 of the object you packed).

That said, we should fix it up a bit, notably

 - we should _not_ prune refs that are indirect.

   Right now, if we have a symbolic link, we _incorrectly_ pack it as 
   unlinked. The packed format doesn't have any "link" format.

   This isn't a problem in practice, because the only link we ever use is 
   the HEAD link, but it's incorrect. As long as we don't prune, it wasn't 
   an issue - a unpacked head will always override a packed one, so 
   packing the thing didn't really matter.

 - we should probably avoid even trying to prune stuff that was already 
   packed.

The way to fix both these problems at once would be to add a flag to the 
"for_each_ref()", which says whether it followed a link, or whether it was 
already packed, so that we wouldn't pack symlinks at all, and we wouldn't 
add already-packed refs to the "keeprefs" list.

But that requires a sligh semantic extension to "do_for_each_ref()" (and 
"struct ref_list" needs a flag to say whether it was looked up through a 
symlink).

I was thinking that the easy way to solve it is to just _pack_ everything 
(the way we do now - incorrectly for symrefs), but never prune a symref.

		Linus
