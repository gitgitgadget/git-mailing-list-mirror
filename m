X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,
	MSGID_FROM_MTA_HEADER,SPF_SOFTFAIL shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Some tips for doing a CVS importer
Date: Mon, 27 Nov 2006 23:09:02 +0100
Message-ID: <456B61FE.7060100@alum.mit.edu>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com> <456ACAF3.1050608@alum.mit.edu> <456AD137.8060209@bluegap.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 22:09:25 +0000 (UTC)
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	dev@cvs2svn.tigris.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061117 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <456AD137.8060209@bluegap.ch>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32455>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoofA-0004rM-Oq for gcvg-git@gmane.org; Mon, 27 Nov
 2006 23:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933875AbWK0WJS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 17:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933882AbWK0WJS
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 17:09:18 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:14480 "EHLO
 einhorn.in-berlin.de") by vger.kernel.org with ESMTP id S933875AbWK0WJR
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 17:09:17 -0500
Received: from [192.168.69.130] (kaiserty.in-dsl.de [217.197.85.174])
 (authenticated bits=0) by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with
 ESMTP id kARM97bZ019667 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA
 bits=256 verify=NOT); Mon, 27 Nov 2006 23:09:08 +0100
To: Markus Schiltknecht <markus@bluegap.ch>
Sender: git-owner@vger.kernel.org

Markus Schiltknecht wrote:
> Michael Haggerty wrote:
>> Jon, I wish you wouldn't portray as obstinacy what is simply a lack of
>> resources.  I would like very much to support other cvs2svn output
>> formats.  I think it would be great if other projects could benefit from
>> our work.  Most of the work I've been doing on cvs2svn lately has been
>> towards supporting other output SCMs.
> 
> Really? Hm. I'm somehow sorry for not joining cvs2svn but running my own
> thing with monotone. But I really think it took me less time. OTOH, I'm
> far from finished, yet...

There's still time to join forces :-)  "Far from finished" on a project
of this messiness can equal quite a bit of time.

But even if you want to pursue your own converter, consider visiting
#cvs2svn on irc.freenode.net if you want to discuss things.

> Anyway, I've made an attempt at solving the 'picking better sources for
> symbols'-problem:

Let me try to understand this...

> During parsing of all the *,v files, where I'm collecting events
> (commits, branching and tagging) into blobs, I do also remember
> 'possible parent branches' for all the symbols (tag and branch events).

This is the part that can get quite expensive for large repositories, as
there can be orders of magnitude more symbol creations than revisions.
According to Daniel Jacobowitz:

> [...] at one point I believe the GCC repository was gaining up
> to four tags a day (head, two supported release branches, and one
> vendor branch).  I've been using the principal that the number of tags
> might be unworkable, but the number of branches generally is not.

This means that the number of tag events is O(number-of-days *
total-number-of-files-in-repo), where the gcc repo has about 50000
files.  By contrast, only a small fraction of files is typically touched
in any day.

I've been trying to find a solution that doesn't require quite so much
space.  I think that if you allow yourself this much space, the problem
is not very difficult.

> After that and *before* the blob sorting, I check all blobs and try to
> find one single parent branch for them. In the best case, those symbol
> blobs do have exactly one possible parent branch, then I just pick that
> one. If there are multiple possible parents, I try to pick the deepest.
> As branches are symbols themselves, I have to run that multiple times
> until all symbols are resolved.
> 
> An example: having branches ROOT -> A -> B -> C (branched in that order)
> plus a branch D derived from branch A.

I assume that you are talking about a situation for which CVS is
ambiguous, like a file with

A = 1.2.2
B = 1.2.4
C = 1.2.6
D = 1.2.2.5.2

> The symbol blob for branch A: has only one possible parent: ROOT. Thus I
> assign A->parent_branch = ROOT.
> 
> Next comes the blob for branch C: it has two possible parents: branch B
> and branch A.

Why is ROOT not considered as a possible parent of C?

> At that point we know that A is derived from ROOT, but we
> don't have assigned a parent to B, yet. Thus we can not resolve C this
> time.
> 
> Then comes branch B: one parent: A. Mark it.
> 
> Next round, we process C again: this time, we know B is branched from A.
> Thus we can remove the possible parent A. Leaving only one possible
> parent branch: B.

But the fact that B preceded C chronologically does not mean that C is
derived from B.  If I branch from ROOT or A after creating branch B, the
result as stored in CVS looks exactly the same as if I branch from B
(unless a file was modified between the creation of the parent branch
and the creation of the child branch).

> Now, say we have a tag 'X', which ended up in a blob having A, B, C and
> D as possible parent branches. I currently remove A and B, as they are
> parents of C. But C and D still remain and conflict. I'm unable to
> resolve that symbol. I'm thinking about leaving such conflicts to the
> user to resolve.

From your description, this sounds like a tag that cannot be created
from a single parent branch.  Therefore it would have to be cobbled
together from multiple parents.

> I've not yet tested this algorithm extensively. Most larger repositories
> seem to fail somewhere, but not necessarily because of that symbol
> resolving algorithm... :-(
> 
> Any comments? Questions? Ideas? I hope to have explained clearly...
> 
> And I wish you all a lot of time for your open source projects and your
> families, friends, wifes, girl-friends, etc...! ;-)

:-) Thanks.  The same to you!

