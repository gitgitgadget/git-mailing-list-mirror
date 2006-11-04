X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: If I were redoing git from scratch...
Date: Sat, 4 Nov 2006 08:44:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611040829040.25218@g5.osdl.org>
References: <7vpsc3xx65.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 4 Nov 2006 16:44:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vpsc3xx65.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30929>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgOcx-00032v-Lx for gcvg-git@gmane.org; Sat, 04 Nov
 2006 17:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965545AbWKDQoK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 11:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965548AbWKDQoK
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 11:44:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43909 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S965545AbWKDQoI (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 11:44:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA4Gi4oZ025461
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 4
 Nov 2006 08:44:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA4Gi39S026384; Sat, 4 Nov
 2006 08:44:04 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Sat, 4 Nov 2006, Junio C Hamano wrote:
> 
> The biggest one is that we use too many static (worse, function
> scope static) variables that live for the life of the process,
> which makes many things very nice and easy ("run-once and let
> exit clean up the mess" mentality), but because of this it
> becomes awkward to do certain things.  Examples are:
> 
>  - Multiple invocations of merge-bases (needs clearing the
>    marks left on commit objects by earlier traversal),

Well, quite frankly, I dare anybody to do it differently, yet have good 
performance with millions of objects.

The fact is, I don't think it _can_ be done. I would seriously suggest 
re-visiting this in five years, just because CPU's and memory will by then 
hopefully have gotten an order of magnitude faster/bigger.

The thing is, the object database when we read it in really needs to be 
pretty compact-sized, and we need to remember objects we've seen earlier 
(exactly _because_ we depend on the flags). So there's exactly two 
alternatives:
 - global life-time allocations of objects like we do now
 - magic memory management with unknown lifetimes and keeping track of all 
   pointers.

And I'd like to point out that the memory management right now is simply 
not realistic:

 - it's too damn hard. A simple garbage collector based on the approach we 
   have now would simply not be able to do anything, since all objects are 
   _by_definition_ reachable from the hash chains, so there's nothing to 
   collect. The lifetime of an object fundamentally _is_ the whole process 
   lifetime, exactly because we expect the objects (and the object flags 
   in particular) to be meaningful.

 - pretty much all garbage collection schemes tend to have a memory 
   footprint that is about twice what a static footprint is under any 
   normal load. Think about what we already do with "git pack-objects" for 
   something like the mozilla repository: I worked quite a lot on getting 
   the memory footprint down, and it's _still_ several hundred MB. 

In other words, I can pretty much guarantee that some kind of "smarter" 
memory management would be a huge step backwards. Yes, we now have to do 
some things explicitly, but exactly because we do them explicitly we can 
_afford_ to have the stupid and simple and VERY EFFICIENT memory 
management ("lack of memory management") that we have now.

The memory use of git had an very real correlation with performance when I 
was doing the memory shrinking a few months back (back in June). I realize 
that it's perhaps awkward, but I would really want people to realize that 
it's a huge performance issue. It was a clear performance issue for me 
(and I use machines with 2GB of RAM, so I was never swapping), it would be 
an even bigger one for anybody where the size meant that you needed to 
start doing paging.

So I would seriously ask you not to even consider changing the object 
model. Maybe add a few more helper routines to clear all object flags or 
something, but the "every object is global and will never be de-allocated" 
is really a major deal.

Five years from now, or for somebody who re-implements git in Java (where 
performance isn't going to be the major issue anyway, and you probably do 
"small" things like "commit" and "diff", and never do full-database things 
like "git repack"), _then_ you can happily look at having something 
fancier. Right now, it's too easy to just look at cumbersome interfaces, 
and forget about the fact that those interfaces is sometimes what allows 
us to practically do some things in the first place.

