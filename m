X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 16:12:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <4570AF8F.1000801@stephan-feder.de>
 <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org> <200612020036.08826.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 2 Dec 2006 00:12:50 +0000 (UTC)
Cc: sf <sf-gmane@stephan-feder.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612020036.08826.Josef.Weidendorfer@gmx.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32993>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqIUo-0003rw-T8 for gcvg-git@gmane.org; Sat, 02 Dec
 2006 01:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161857AbWLBAMn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 19:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161834AbWLBAMn
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 19:12:43 -0500
Received: from smtp.osdl.org ([65.172.181.25]:63960 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1161841AbWLBAMm (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 19:12:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB20CFjQ018645
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 1
 Dec 2006 16:12:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB20CA6A000813; Fri, 1 Dec
 2006 16:12:12 -0800
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org



On Sat, 2 Dec 2006, Josef Weidendorfer wrote:
> 
> So you are for a global submodule namespace in supermodule repositories,
> do I understand correctly?
> 
> Otherwise, how would you specify the submodules at clone time given the
> ability that submodule roots can have relative path changed arbitrarily
> between commits?

The only _true_ namespace would be the SHA1 of the commit (and maybe allow 
a pointer to a tag too, but the namespace ends up being the same).

How to _find_ a repository that contains that SHA1 must be left to higher 
levels. After all, repositories move around, and the place you found them 
originally is not a stable name.

So within the supermodule, on a "git object" level, a submodule should 
just be named by the SHA1 that was it's HEAD when it was committed within 
the supermodule. So in the "tree object", you'd see something like the 
following when you go "git ls-tree HEAD" on the superproject:

	...
	100644 blob 08602f522183dc43787616f37cba9b8af4e3dade	xdiff-interface.c
	100644 blob 1346908bea31319aabeabdfd955e2ea9aab37456	xdiff-interface.h
	040000 tree 959dd5d97e665998eb26c764d3a889ae7903d9c2	xdiff
	050000 link 0215ffb08ce99e2bb59eca114a99499a4d06e704	xyzzy

where that 050000 is the new magic type (I picked one out of my *ss: it's 
not a valid type for a file mode, so it's a godo choice, but it could be 
anythign that cannot conflict with a real file), which just specifies the 
"link" part. The SHA1 is the SHA1 of the commit, and the "xyzzy" is 
obviously just the name within the directory of the submodule.

That's all that is actually required for a lot of git commands that 
already expect all objects to be available (ie "git checkout", "git diff" 
etc).

It only gets interesting for commands that fetch new objects, ie do a 
"pull/fetch" op, and you'd need to know where/how to fetch new objects for 
the xyzzy subproject, so that's a "naming" issue. You have a few choices:

 - get all the objects directly from the subproject as if it was one big 
   project.

   I actually think this sucks. Why? Because it puts an insane load on the 
   server side, which basically needs to traverse the object list of the 
   _sum_ of all projects. An initial clone (or a really big pull, which 
   comes to the same thing) would be absolutely horrendous

So I'd strongly argue against that approach, for scalability reasons. So 
instead, you should really try to do pulls etc one git repo at a time:

 - take the "list of subprojects" from the supermodule, and pull them all 
   one by one.

   This again makes subprojects "less seamless", and makes each subproject 
   more of a separate thing, with the project list gotten from the 
   superproject and parsed separately. But it means you have none of the 
   scalability problems, since you never see things as one huge project 
   with millions of files and even more objects.

The second approach also means that you can see the "supermodule" support 
in git as less of a "plumbing" thing, and it's largely just a thin veneer 
around the core plumbing that really doesn't understand about multiple 
repositories at all (apart from the single "link" extension in the tree 
object), and it's really just scripting to get the subprojects to "look" 
like one thing, when they really are pretty much independent.

