X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Markus Schiltknecht <markus@bluegap.ch>
Subject: Re: Some tips for doing a CVS importer
Date: Mon, 27 Nov 2006 12:51:19 +0100
Message-ID: <456AD137.8060209@bluegap.ch>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com> <456ACAF3.1050608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 11:51:53 +0000 (UTC)
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	dev@cvs2svn.tigris.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Icedove 1.5.0.8 (X11/20061121)
In-Reply-To: <456ACAF3.1050608@alum.mit.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32412>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gof1K-0000nY-Fc for gcvg-git@gmane.org; Mon, 27 Nov
 2006 12:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758056AbWK0Lvb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 06:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758073AbWK0Lvb
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 06:51:31 -0500
Received: from ns1.bugaboo.mu ([213.133.111.57]:10687 "EHLO bugaboo.mu") by
 vger.kernel.org with ESMTP id S1758056AbWK0Lva (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 06:51:30 -0500
Received: from [192.168.0.237] (berlin.programmfabrik.de
 [::ffff:213.221.101.147]) (AUTH: CRAM-MD5 markus@bluegap.ch) by bugaboo.mu
 with esmtp; Mon, 27 Nov 2006 12:51:23 +0100 id 02234D86.456AD13B.00003FFD
To: Michael Haggerty <mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org

Hi,

Michael Haggerty wrote:
> I am currently the main (and pretty much the only) cvs2svn maintainer.
> Development has been proceeding more slowly lately because (1) I'm very
> busy with my day job, and (2) nobody has stepped forward to help.

I understand very well. Same for me here with monotone's cvs_import vs. 
my day job... and then I also have a life ;-)

> Jon, I wish you wouldn't portray as obstinacy what is simply a lack of
> resources.  I would like very much to support other cvs2svn output
> formats.  I think it would be great if other projects could benefit from
> our work.  Most of the work I've been doing on cvs2svn lately has been
> towards supporting other output SCMs.

Really? Hm. I'm somehow sorry for not joining cvs2svn but running my own 
thing with monotone. But I really think it took me less time. OTOH, I'm 
far from finished, yet...

Anyway, I've made an attempt at solving the 'picking better sources for
symbols'-problem:

During parsing of all the *,v files, where I'm collecting events 
(commits, branching and tagging) into blobs, I do also remember 
'possible parent branches' for all the symbols (tag and branch events).

After that and *before* the blob sorting, I check all blobs and try to 
find one single parent branch for them. In the best case, those symbol 
blobs do have exactly one possible parent branch, then I just pick that 
one. If there are multiple possible parents, I try to pick the deepest. 
As branches are symbols themselves, I have to run that multiple times 
until all symbols are resolved.

An example: having branches ROOT -> A -> B -> C (branched in that order) 
plus a branch D derived from branch A.

The symbol blob for branch A: has only one possible parent: ROOT. Thus I 
assign A->parent_branch = ROOT.

Next comes the blob for branch C: it has two possible parents: branch B 
and branch A. At that point we know that A is derived from ROOT, but we 
don't have assigned a parent to B, yet. Thus we can not resolve C this time.

Then comes branch B: one parent: A. Mark it.

Next round, we process C again: this time, we know B is branched from A. 
Thus we can remove the possible parent A. Leaving only one possible 
parent branch: B.

Now, say we have a tag 'X', which ended up in a blob having A, B, C and 
D as possible parent branches. I currently remove A and B, as they are 
parents of C. But C and D still remain and conflict. I'm unable to 
resolve that symbol. I'm thinking about leaving such conflicts to the 
user to resolve.

I've not yet tested this algorithm extensively. Most larger repositories 
seem to fail somewhere, but not necessarily because of that symbol 
resolving algorithm... :-(

Any comments? Questions? Ideas? I hope to have explained clearly...

And I wish you all a lot of time for your open source projects and your 
families, friends, wifes, girl-friends, etc...! ;-)

Regards

Markus
