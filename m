From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Careful object writing..
Date: Tue, 3 May 2005 12:47:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031242330.26698@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
 <20050503192753.GA6435@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 21:40:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3F9-0005zB-O1
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVECTpq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 15:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVECTpq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 15:45:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:11656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261643AbVECTpi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 15:45:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43Jjas4012931
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 12:45:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43JjYjL012012;
	Tue, 3 May 2005 12:45:35 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20050503192753.GA6435@taniwha.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 May 2005, Chris Wedgwood wrote:
> 
> how is this better than a single rename?  i take it there is something
> fundamental from clue.101 i slept though here?

A rename will overwrite any old object, which means that you cannot do any 
collision checks. In contrast, a "link()" will return EEXIST if somebody 
else raced with you and created a new object, and you can do collision 
checks instead of overwriting another persons object.

> also, if you are *really* paranoid you want to fsync *before* you do
> the link/unklink or rename --- which is what MTAs do[1]

Me, I refuse to slow down my habits for old filesystems. You can either 
fsck, or use a logging filesystem. 

I don't see anybody not using logging filesystems these days, so..

> also, shouldn't HEAD (and similar)[2] be updated with a temporary and
> a rename too?

Maybe. Much less important, though.

> > NOTE NOTE NOTE! I have _not_ updated all the helper stuff that also
> > write objects.
> 
> i thought this was all common code?  if it's not maybe now is the time
> to change that?

It is all common code, except:
 - things like "fetch from another host" will use rsync/wget/xxx to 
   actually get the files. To those programs, we're not talking about git 
   objects, we're just talking "regular files"
 - rpull.c has a special different routine to write its objects. I don't 
   use it, so..

Anyway, it should be reasonably easily fixable.

		Linus
