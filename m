From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFD PATCH 0/3] Use "object index" rather than pointers in the
 object hashing
Date: Mon, 16 Apr 2007 22:06:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704162200420.5473@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704162041290.5473@woody.linux-foundation.org>
 <7vfy6zskb4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 07:07:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdfuG-0003fS-W8
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 07:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbXDQFG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 01:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753990AbXDQFG6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 01:06:58 -0400
Received: from smtp.osdl.org ([65.172.181.24]:35926 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753975AbXDQFG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 01:06:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3H56sIs018108
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 22:06:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3H56rpH020810;
	Mon, 16 Apr 2007 22:06:53 -0700
In-Reply-To: <7vfy6zskb4.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44728>



On Mon, 16 Apr 2007, Junio C Hamano wrote:
> 
> I was thinking about revamping that "keeping track of all
> objects" stuff for some time, too, but in a different direction.
> Glad I have not touched that area ;-).

Well, I obviously shouldn't have touched it either. I introduced a bug in 
the first patch of the series (and the bug got removed by the third patch, 
but since the third patch was not worth applying yet, it means that 
patches 1 and 2 shouldn't be applied either, because of the bug).

The bug was that when I modified the generic object allocator framework to 
work with "union any_object", it would still do

	static struct name *block;		/* where "name" was "object" */
	...
	return block++;

so while we *allocated* a block of "union any_objects", the patch would 
then end up doling them out as "struct object" (which is *wrong* - we 
don't know which kind of object it is yet, so we need to allocate the 
maximum size!).

So it *should* have been

	static type *block;
	...
	return block++;

but it actually turns out that my timings seem to say that it's better to 
do the memset of the object just before returning it, so I changed it to 
use "xmalloc()" instead of "xcalloc()" for the block allocation, and then 
use

	static type *block;
	void *ret;
	...
	ret = block++;
	memset(ret, 0, sizeof(type));
	return ret;

instead.

> I think this makes sense, although the numbers are somewhat
> dissapointing.

Well, with just patches 1&2, the numbers don't go down, and the code looks 
cleaner (and it removes more lines than it adds). So let me re-send the 
series, and while I will re-send the final patch#3, only #1/#2 are 
actually meant to be considered for actual inclusion at this point.

		Linus
