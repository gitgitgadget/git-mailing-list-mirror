From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Support for packs in HTTP
Date: Mon, 11 Jul 2005 10:44:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507111040251.17536@g5.osdl.org>
References: <Pine.LNX.4.21.0507102337160.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 19:49:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds2Pd-0002Gq-Fv
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 19:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVGKRrg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 13:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVGKRpK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 13:45:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261818AbVGKRo4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 13:44:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6BHibjA005254
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 10:44:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6BHiXx5020148;
	Mon, 11 Jul 2005 10:44:35 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0507102337160.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Daniel Barkalow wrote:
> On Sun, 10 Jul 2005, Linus Torvalds wrote:
> 
> > 
> > You really _mustn't_ try to create the pack directly to the
> > $GIT_DIR/objects/pack subdirectory - that would make git itself start
> > possibly using that pack before the index is all done, and that would be
> > just wrong and nasty.
> >
> > So you really should _always_ generate the pack somewhere else, and then 
> > move it (pack file first, index file second).
> 
> It's currently fine ignoring index files without corresponding
> pack files (sha1_file.c, line 470).

That doesn't help.

Redgardless of which order you write them (and you _will_ write the 
pack-file first), you'll find that at some point you have both files, but 
one or the other isn't fully written, ie they are unusable.

And yes, you can handle that by always checking the SHA1 of the files when 
you open them, but the fact is, you shouldn't need to, just to use it. 
Checking the SHA1 of the pack-file in particular is very expensive (since 
it's potentially a huge file, and you don't even want to read all of it).

So you could have rules like: pack-file must get populated first, and 
index file must be SHA1-checked by all users.

Or, you could just have a saner rule: create the pack-files somewhere 
else, and move them atomically to the right place. Problem solved.

So that's what I decided the rule is: never ever have a partial file, and 
thus you can by definition use them immediately when you see both files.

But that requires that you write them under another name than the final 
one. And since you want that _anyway_ for other uses, you don't hide that 
inside "git-pack-objects", but you make it an exported interface.

		Linus
