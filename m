X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 14:51:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org>
 <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org>
 <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 21 Nov 2006 22:53:43 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32050>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmeUY-0006OF-BU for gcvg-git@gmane.org; Tue, 21 Nov
 2006 23:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031292AbWKUWwS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 17:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031290AbWKUWwQ
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 17:52:16 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37096 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1031275AbWKUWwH (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 17:52:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kALMpvix007178
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 21
 Nov 2006 14:51:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kALMpu8d012237; Tue, 21 Nov
 2006 14:51:57 -0800
To: Yann Dirson <ydirson@altern.org>
Sender: git-owner@vger.kernel.org



On Tue, 21 Nov 2006, Yann Dirson wrote:
> 
> I'm not sure I get the reason why the submodule should not be recorded
> on "commit level".

Because that would be STUPID.

What does the submodules have to do with the commit level? Nothing. Nada. 
Zero.

Submodules are _directories_. They can be anywhere in the directory tree. 
If you try to encode that in a commit message, you're going to totally 
break the whole notion of trying to "diff" two trees. 

All of git is designed around the notion that a tree is the directory 
structure. If you put directory structure somewhere else, you totally 
screw all abstractions.

Now, if that weren't enough, let me enumerate _another_ reason why it's 
idiotic and wrong, namely the fact that a "commit" is fundamnetally the 
wrong place to add something like that _anyway_. Quite apart from the fact 
that we describe directory trees with (wait for it): "tree objects", the 
thing is, a commit is about a totally different _dimension_ altogether. 

The only and _whole_ point of a "commit" is to describe the "time 
dimension". Something that doesn't always change in time should not be in 
a commit object, because it is by definition not what a commit is all 
about. A commit should describe the relationship of itself to other 
commits, ie it's a "how did this change".

And a sub-project simply doesn't even _do_ that. Much of the time, a 
subproject stays constant, and is not something that comes and goes on an 
individual commit basis. 

I don't understand why people are so fixated with putting things in the 
wrong object. WHY do people want to put crap in the "commit" object? 
People have wanted to put "rename" information there (which is stupid for 
all the same reasons: renames _remain_. They aren't a one-time event. If 
something was renamed in commit X, it will _remain_ renamed in commit X+1, 
so it's clearly not really a "commit X" thing)

Think of it this way:

 - if something _only_ makes sense on an _individual commit_ level, it 
   goes into the "commit object". But if it makes sense for "git diff",
   then it MUST NOT be in a commit object, because you do "git diff" over
   a big _range_ of commit objects.

Think "git show". The "author" of a commit is only associated with a 
_single_ commit. It thus goes into the commit object, and nowhere else. 
Same goes for time, and commit message. A commit message is fundamentally 
a "this explains this _one_ commit".

But anything that you expect to have in a "range" of commits MUST NOT be 
in a "commit object". If I do "git diff v2.6.13..v2.6.14", and I expect 
the behaviour you want to encode to show up (and dammit, subprojects very 
much fall under that heading - exactly the same way renames must have 
meaning _outside_ of a single commit) then clearly it is NOT something 
that is associated with any individual commits. It's something that is 
associated with the _state_ of the project.

And the _state_ of the project is the "tree". Not the commit. The commit 
is about the _history_ of the project.

So please understand this: "commit" is about the time-dimension 
("history"). "tree" is about the space-dimension ("state"). The two are 
_related_, but they are also very much different concepts, and "related" 
does not mean "you can mix them up".

Sub-projects are clearly not about "time". They are about "state".

