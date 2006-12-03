X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Some advanced index playing
Date: Sun, 3 Dec 2006 10:34:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 3 Dec 2006 18:34:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612031701.15594.alan@chandlerfamily.org.uk>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33126>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqwAv-0001wz-4q for gcvg-git@gmane.org; Sun, 03 Dec
 2006 19:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758482AbWLCSes (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 13:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758892AbWLCSes
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 13:34:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:31946 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1758482AbWLCSer (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 13:34:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB3IYejQ028502
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 3
 Dec 2006 10:34:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB3IYeSo026474; Sun, 3 Dec
 2006 10:34:40 -0800
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org



On Sun, 3 Dec 2006, Alan Chandler wrote:
> 
> c) Revert the entire index back to the state it was at the last commit so I 
> can selectively add back in the files that I have editted.
> 
> The command to do that seems to be
> 
> git-read-tree HEAD 

A side note on this..

It definitely works, but it's not really the right thing to do for a few 
reasons:

 - it isn't even what you wanted. You didn't want to reset _all_ the index 
   values, you only really wanted to reset a few of them. So as mentioned 
   in the previous email, the command sequence you'd wanted for that 
   operation is

	git ls-tree <tree> -- <path pattern list> |
		git update-index --index-info

But, that said, if you actually want to reset the whole index, 
"git-read-tree HEAD" works, but is not what you should do:

 - you really want to keep the index "stat()" cache valid, and 
   git-read-tree will throw that all out. So you would need to do a

	git update-index --refresh

   after you've reset the index ("git status" will do it for you, and if 
   you don't do either "git status" or the above,  

 - instead of re-reading the index 100% and then having to refresh it back 
   to mostly the same stat() into it already had, you can _merge_ the old 
   index with the information in HEAD, by using

	git read-tree -m HEAD

   which basically does a merge from the old index and the HEAD tree.

 - However, that actually fails if the old index wasn't just dirty, but 
   had unmerged paths etc, because then a "merge" would throw away that 
   unmerged information. So what you _really_ want to do is

	git read-tree --reset HEAD

   which (as the flag implies) will _reset_ the index to the tree in HEAD, 
   and this will do exactly what you were looking for: keep the "stat()" 
   information alone, but reset the actual index contents.

 - HOWEVER. This is exactly what "git reset" does.

So in short, you should just have done "git reset", and you'd have reset 
your index back to the state of your last commit.

So "git reset" is generally your friend whenever something goes wrong. If 
you also want to reset your checked-out files (which you did NOT want to 
do in this case, of course), you would have added the "--hard" flag to git 
reset.

And that (finally) concludes this particularly boring "git usage 101" 
session.

