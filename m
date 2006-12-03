X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Some advanced index playing
Date: Sun, 3 Dec 2006 12:40:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612031236560.3476@woody.osdl.org>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
 <Pine.LNX.4.64.0612031008360.3476@woody.osdl.org> <200612032011.25922.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 3 Dec 2006 20:41:11 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612032011.25922.alan@chandlerfamily.org.uk>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33141>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqy96-0004kc-1z for gcvg-git@gmane.org; Sun, 03 Dec
 2006 21:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760080AbWLCUlF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 15:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760081AbWLCUlF
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 15:41:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51844 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1760080AbWLCUlC (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 15:41:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB3KesjQ001732
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 3
 Dec 2006 12:40:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB3KereH029077; Sun, 3 Dec
 2006 12:40:53 -0800
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org



On Sun, 3 Dec 2006, Alan Chandler wrote:
> >
> > 	git ls-tree HEAD -- that-file | git update-index --index-info
> > 	git commit that-file
> 
> I don't quite understand this - maybe it should be
> 
> git ls-tree HEAD -- that-file | git update-index --index-info
> git commit
> git commit -a

Sure. It depends on which file you want to commit first.

If you want to commit "that-file" first, you do my sequence.

If you want to commit everything _but_ "that-file", you do the second 
sequence (which basically removes the changes to "that-file" from the 
index, then commits the index, and then with "git commit -a" commits the 
remaining dirty state, which is obviously those changes to "that-file" 
that you still had in the working tree).

> either I want to ONLY commit that file at the working tree state (and index 
> before these commands), or I want to commit ALL except this file (so I can 
> later come and commit just that file)

Right. If you do

	git ls-tree HEAD -- that-file | git update-index --index-info
	git commit that-file

you basically ONLY commit "that-file". You first reset it (in the index) 
to the old state, but that's just so that "git commit that-file" will now 
happily commit the current state (in the working tree) of "that-file".

So "git commit that-file" will basically _ignore_ your current index. 
Because you told "git commit" (by naming "that-file") that you _only_ 
wanted to commit "that-file". So whatever state you had in your current 
index doesn't matter at all - it will only look at the HEAD tree _and_ 
that single file that you specified.

