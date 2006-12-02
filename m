X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 11:41:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <457061A7.2000102@b-i-t.de>
  <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org> 
 <200612012306.41410.Josef.Weidendorfer@gmx.de>  <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>
  <4570AF8F.1000801@stephan-feder.de>  <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
  <4570BFA4.8070903@stephan-feder.de> <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 2 Dec 2006 19:42:11 +0000 (UTC)
Cc: sf-gmane@stephan-feder.de, sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33033>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqakK-0005ef-6q for gcvg-git@gmane.org; Sat, 02 Dec
 2006 20:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758505AbWLBTl5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 14:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759466AbWLBTl5
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 14:41:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44194 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1758505AbWLBTl4 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 14:41:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB2JfdjQ019955
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 2
 Dec 2006 11:41:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB2JfcW6027098; Sat, 2 Dec
 2006 11:41:38 -0800
To: Torgil Svensson <torgil.svensson@gmail.com>
Sender: git-owner@vger.kernel.org



On Sat, 2 Dec 2006, Torgil Svensson wrote:
> 
> Here's an real-world example that doesn't contradict:

And I'll add the note that people who do things like submodules aren't 
generally even _used_ to them being "seamless", and most of the time 
probably don't even want complete seamlessness.

As the example that Torgil points to shows, people are quite used to 
actually even naming the submodules separately, and things like having the 
"default" set of submodules not equal the "complete" set. 

In other words, I don't think people expect or want something hugely more 
complicated than the CVS/modules kind of file. 

What people _do_ want (and that CVS in general is horribly bad at, and 
this is not a module-specific issue) is to have the _versioning_ work 
well. When you check out a specific version of a module, you want any 
_linked_ modules to follow along too.

This is the same reason why CVS users use tags a lot: because even 
_within_ a single project (no modules, no nothing), it's often hard to 
re-create the exact state of a version any other way. So you tag every 
single file and do insane things like that, because CVS just isn't very 
good at guaranteeing consistency across the whole project.

The exact same thing is true about subprojects. I don't think that people 
who have used CVS subprojects a lot really mind the CVS/modules file 
itself (but hey, maybe I'm wrong - I've seen _other_ people maintain 
modules in CVS, but I've never done it myself), but they do mind the fact 
that it's hard as hell to do something as simple as "get all modules back 
to version X" without lots and lots of careful crud (ie tagging every 
singl emodule, things like that).

Now, I'm not exactly sure who wants to use git modules, so this is the 
time to ask: did you hate the CVS/modules file? Or was it something you 
set up once, and then basically forgot about? People clearly use the 
ability to mark certain modules as depending on each other, and aliases to 
say "if you ask for this module, you actually get a set of _these_ 
modules".

_I_ suspect that that isn't the problem people had, and isn't what they 
have any problems with. What CVS didn't do very well (or at all, afaik) is 
to say "I want supermodule version XYZ", and then got all the submodules 
automatically to that (reliable) state. And THAT is something I think is 
really important for submodules, and it's why I think the most important 
part isn't actually all the veneer to make "git clone" and "git pull" work 
(which is really about the CVS/modules kind of wrapper parsing), but 
actually about the supermodule "tree" object pointing to a very specific 
version, so that you get the exact same "atomic snapshotting" of multiple 
trees that you get within a single git tree.

In other words, I _suspect_ that that is really what module users are all 
about. They want the ability to specify an arbitrary collection of these 
atomic snapshots (for releases etc), and just want a way to copy and move 
those things around, and are less interested in making everything else 
very seamless (because most people are happy to do the actual 
_development_ entirely within the submodules, so the "development" part 
is actually not that important for the supermodule, the supermodule is 
mostly for aggregation and snapshots, and tying different versions of 
different submodules together).

So that's where I come from. And maybe I'm totally wrong. I'd like to hear 
what people who actually _use_ submodules think.

