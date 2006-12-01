X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: selective git-update-index per diff(1) chunks
Date: Fri, 1 Dec 2006 08:06:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612010740160.3695@woody.osdl.org>
References: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 16:08:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32940>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqAuS-0006Pw-GR for gcvg-git@gmane.org; Fri, 01 Dec
 2006 17:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967665AbWLAQGi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 11:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967668AbWLAQGi
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 11:06:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:143 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S967665AbWLAQGi (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 11:06:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB1G6XjQ015501
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 1
 Dec 2006 08:06:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB1G6WoV017735; Fri, 1 Dec
 2006 08:06:33 -0800
To: Alexey Dobriyan <adobriyan@gmail.com>
Sender: git-owner@vger.kernel.org



On Fri, 1 Dec 2006, Alexey Dobriyan wrote:
> 
> Has anyone thought about aggregating this into git-update-index or
> somewhere?
> 
>    git-update-index -C1,3    #chunks 1, 3
>    git commit

You can already do it, but it's called something else.

Instead of updating a certain hunk (which is fundamentally wrong, since it 
depends on "diff" even working on that file), you can tell 
git-update-index to update a certain _state_ for an arbitrary number of 
files. Namely:

	git-update-index [--cacheinfo <mode> <object> <file>]*

However, that obviously is very much a _plumbing_ command, and you need to 
have some higher-level GUI on top of it to actually pick out the chunks 
(if that is what you want) and generate the object(s) associated with the 
file(s) with only those chunks and then do the above "install this state 
into the index/staging area/whatever".

In other words, git already supports this on a _technical_ level, but does 
not have the high-level interfaces for it, and quite frankly 
"git-update-index" _shouldn't_ have the high-level interfaces for it. It's 
designed to be the low-level technology, not the actual interface.

I think it's more appropriate for a GUI front-end, frankly, but you could 
script it fairly easily with whatever your favourite patch editing tool:

 (a) Generate the "result" file you want in /tmp or something, using patch 
     editing tools to extract a partial patch and apply it to the original 
     file.

 (b) Use "git-hash-object" to create the backing store object, and get the 
     SHA1 for that file.

 (c) Use "git-update-index --cacheinfo <mode> <sha1> <filename>" to 
     populate that new entry of yours into the index.

 (d) Do (a)-(c) as many times as you like to handle all the files you 
     want to commit, and then just call "git commit"

iow, it's not hard, but no, git on its own is _not_ a patch-based system, 
and doesn't do things hunk-for-hunk. You need that "hunk selector" 
interface on top of it.

