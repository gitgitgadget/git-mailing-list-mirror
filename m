From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: My git repo is broken, how to fix it ?
Date: Thu, 22 Mar 2007 09:48:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703220931120.6730@woody.linux-foundation.org>
References: <200702281036.30539.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org>
 <200703210956.50018.litvinov2004@gmail.com> <200703211024.04740.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703220858400.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703220924590.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Alexander Litvinov <litvinov2004@gmail.com>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 17:48:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUQSu-0005cv-5H
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 17:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934117AbXCVQsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 12:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934118AbXCVQsg
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 12:48:36 -0400
Received: from smtp.osdl.org ([65.172.181.24]:39152 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934117AbXCVQsg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 12:48:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2MGmWG9010134
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Mar 2007 09:48:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2MGmVhk024860;
	Thu, 22 Mar 2007 09:48:31 -0700
In-Reply-To: <Pine.LNX.4.64.0703220924590.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.47 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42866>



On Thu, 22 Mar 2007, Linus Torvalds wrote:
> 
> Yeehaa! I think I'm on the right trail.

.. and the reason only Alexander sees it, and nobody else does, is that 
this one is a bug in the CR/LF creation. 

Junio: I think it's your git-apply commit 67160271.

In "try_create_file()", we do:

	...
        if (convert_to_working_tree(path, &nbuf, &nsize)) {
                free((char *) buf);
                buf = nbuf;
                size = nsize;
        }
	...

but the thing is, the *caller* still uses the old "buf/nsize", so when you 
free it, the caller will now use the free'd data structure, and if it gets 
re-used by - for example - the zlib deflate() buffers, you'll get a 
corrupt object (if it gets re-used *before*, you'll get the *wrong* 
object!). Exactly Alexander's patterns.

Alexander - sorry for all the trouble, this was definitely our bad.

I think the easy temporary fix is to just remove that "free()" and leak a 
bit of memory. That gets it through that test with efence for me.

Does that fix it for you, Alexander?

I can't really say whether there are other problems too - electric fence 
has a few bugs in that it considers zero-length allocations to be 
"probably a bug" and aborts. This makes some of the tests fail with 
efence, when re_compile_internal wants to allocate a zero-length object.

(It also writes crap to stderr, which could make others fail, I didn't 
check).

		Linus
