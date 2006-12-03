X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Some advanced index playing
Date: Sun, 3 Dec 2006 10:24:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612031008360.3476@woody.osdl.org>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 3 Dec 2006 18:24:40 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612031701.15594.alan@chandlerfamily.org.uk>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33123>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqw0s-00015l-48 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 19:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758751AbWLCSY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 13:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758892AbWLCSY1
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 13:24:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:32712 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1758751AbWLCSY0 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 13:24:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB3IOCjQ028091
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 3
 Dec 2006 10:24:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB3IOBuJ026243; Sun, 3 Dec
 2006 10:24:12 -0800
To: Alan Chandler <alan@chandlerfamily.org.uk>, Junio C Hamano
 <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Sun, 3 Dec 2006, Alan Chandler wrote:
>
> With all the discussion about the index file in the last few days I would have 
> thought that this issue would have come up.  But I don't think it has.
> 
> I have been editing a set of files to make a commit, and after editing each 
> one had done a git update-index.
> 
> At this point I am just about to commit when I realise that one of the files 
> has changes in it that really ought to be a separate commit. 
> 
> So effectively, I want to do one of three things
> 
> a) git-commit <that-file>
> 
> Except I can't because there is a safety valve that prevents this and there is 
> no force option.

I think that is actually a misfeature. 

This _should_ just work. It's the easy and logical way to do it, and it's 
the one that matches all the other behaviours of "git commit" these days.

The reason for the safety valve is actually not really "safety" any more, 
it's purely "historical behaviour". Ie the sanity check is not there 
because you would be doing anything unsafe, but simply because the 
behaviour in this area _changed_, so the semantics are different from what 
they were originally.

But those "original" semantics are now so old and so uninteresting that 
the safety feature has gone from being a safety feature to just being 
annoying, and hindering you from doing what you want to do.

Side note: you -can- do what you want to do, but it's insanely stupid. 
Here's what you'd do:

	git ls-tree HEAD -- that-file | git update-index --index-info
	git commit that-file

but there is no way in hell I will claim that this is a _good_ thing.

[ That said, the whole

	git ls-tree <treeish> -- <file-list> | git update-index --index-info

  is a useful pattern to know. You can basically insert _any_ part of old 
  historical state into the index with this, which can be useful if you 
  want to play games without changing the _other_ parts of the index. ]

So anyway, I would suggest that we just get rid of that partial commit 
"safety check" in "git commit" for now. It still makes sense for when 
you're in the middle of a _merge_, but the "verify that index matches" is 
not worth it.

Or at _least_ there should be a flag to force it.

Junio?

