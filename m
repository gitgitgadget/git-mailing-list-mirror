X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Mon, 27 Nov 2006 08:20:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611270748300.30076@woody.osdl.org>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611261652520.30076@woody.osdl.org> <7vac2dr6ua.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611261836250.30076@woody.osdl.org> <7vbqmtmlkv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 27 Nov 2006 16:22:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vbqmtmlkv.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.160 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32425>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GojEr-0004wP-EE for gcvg-git@gmane.org; Mon, 27 Nov
 2006 17:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754075AbWK0QVM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 11:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756834AbWK0QVM
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 11:21:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:14800 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1754075AbWK0QVK (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 11:21:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kARGKgix000860
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 27
 Nov 2006 08:20:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kARGKfac004114; Mon, 27 Nov
 2006 08:20:41 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Sun, 26 Nov 2006, Junio C Hamano wrote:
> 
> I think "networking" vs "packet filtering" largely depends on
> how the networking subsystem you pull from is managed.  If
> netfilter comes as e-mailed patches to DaveM and are applied
> onto the trunk of networking subsystem, we will face exactly the
> same problem as we have with Andrew's patchbomb to your trunk.

Most of the subsystems end up using patches - they're simply better ways 
to move things around and have people comment on them than saying "please 
pull on this tree to see my suggestion".  I do it myself: even when I 
_generate_ the diff in my tree, I will often just do a 

	git diff > ~/diff

and then import the thing into my mailer, and say "Maybe something like 
this?".

So I think patches are fundamentally the core way to get things in the 
periphery into just about any system. Maybe we do it more than most just 
because we're so _used_ to them, but I actually think that if the kernel 
does it more than most (and I'm not sure it does), it's simply because the 
thing about patches is that they really _work_.

So yes, the network subsystem tends to be entirely linear by the time it 
hits me. That's true of a lot of other subsystems too (SCSI etc). There's 
a _few_ subsystems that actually have real topic branches: ACPI and 
network driver development comes to mind, but it seems to actually be the 
exception rather than the rule.

(I think that a lot of people work like I occasionally do: they do have 
their own local branches for some stuff, but they end up re-linearizing 
and keeping them active with "git rebase", so the branches really are 
purely local, rather than something that is visible in the end result).

But the REAL reason I'd love to see a smarter "data-mining" git log 
(whether it does things by bayesian clustering or any other kind of 
grouping technology) is that this is actually something that people ask 
for: when I make my "git shortlog" for major releases, the thing is often 
thousands of lines long, and it would be _beautiful_ if that could be 
data-mined somewhat more intelligently.

So, for example, do a simple

	git shortlog v2.6.17..v2.6.18

(with the shortlog in "next" that can do this - btw, why doesn't it 
default to using PAGER like "git log" does?), and realize that it's about 
8500 lines of stuff, and nobody can really be expected to read it. It's 
not a "shortlog" in other words.

So what would a _nice_ "shortlog" do? I'd _love_ to see ways to make it 
more concise, more "short" for something like this. Look at the output as 
a _non_kernel_ person, and what does it tell you? Not a lot. It's just too 
big.

Examples of what I think would be _really_ useful (much more so than 
going by "topic branches", even if they existed):

 - Clustering.

   The author-based clustering does work, but it would be even better to 
   cluster by other methods ("subsystem" - either by subdirectory, or by 
   noticing filename patters, or even patterns in the patches: there's a 
   lot of academic work on clustering human text, perhaps not as much on 
   clustering patches).

 - Shortening

   The "shortlog" often isn't. It's wonderful for small things as-is, but 
   once it reaches a hundred lines or more, it's less so. It would often 
   be nice to be able to say "only show the 100 biggest patches" (or 
   preferably something smarter like "the 25 biggest clusters, with a 
   short 4-line clustering explanation", but even just the "biggest 
   patches" is useful in itself and much simpler)

 - External annotations (eventually)

   One of the things that people like LWN editor Jonathan Corbet would 
   want is a way to say which patches are "important". But the thing is, 
   "importance" is (a) fleeting and (b) not necessarily as obvious when 
   the commit is made as it is afterwards. So you cannot (and must not) 
   mark things "important" at commit-time, and it thus can't really be 
   part of the repo itself, but at the same time, this is definitely 
   something that _could_ be somehow logged/annotated externally.

Now, I realize that these are all pipe-dreams, but so was my old "a better 
annotate than annotate" a year or two ago. So I'm not saying that people 
should work on this, I'm just saying that it's worth perhaps thinking 
about, because I think the git model does actually give us the power to 
_do_ things like this. Eventually.

And the reason? Performance! Git is fast enough that we really _can_ 
afford to do things like "generate diffs for every single commit in the 
range v2.6.17..v2.6.18" and it takes me just 20 seconds to do on a 
reasonable machine with "git log -p". So good performance means that we 
can _afford_ to do a diffstat for everything (or, just raw diffs to make 
it even cheaper - quite often you care more about _which_ files and how 
many files something touched than the actual size of the diff in those 
files itself), and using that diffstat to some day generate shortlogs that 
are more useful for people like Jonathan Corbet and others that just want 
to get an overview of "what happened"?

