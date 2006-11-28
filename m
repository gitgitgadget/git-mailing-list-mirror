X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Markus Schiltknecht <markus@bluegap.ch>
Subject: Re: Some tips for doing a CVS importer
Date: Tue, 28 Nov 2006 16:18:59 +0100
Message-ID: <456C5363.6040409@bluegap.ch>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com> <456ACAF3.1050608@alum.mit.edu> <456AD137.8060209@bluegap.ch> <456B61FE.7060100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 15:20:01 +0000 (UTC)
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	dev@cvs2svn.tigris.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Icedove 1.5.0.8 (X11/20061121)
In-Reply-To: <456B61FE.7060100@alum.mit.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32535>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp4jl-0004Xd-2v for gcvg-git@gmane.org; Tue, 28 Nov
 2006 16:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935336AbWK1PTF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 10:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758687AbWK1PTF
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 10:19:05 -0500
Received: from ns1.bugaboo.mu ([213.133.111.57]:4844 "EHLO bugaboo.mu") by
 vger.kernel.org with ESMTP id S1758686AbWK1PTC (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 10:19:02 -0500
Received: from [192.168.0.237] (berlin.programmfabrik.de
 [::ffff:213.221.101.147]) (AUTH: CRAM-MD5 markus@bluegap.ch) by bugaboo.mu
 with esmtp; Tue, 28 Nov 2006 16:19:00 +0100 id 0224045D.456C5364.00005894
To: Michael Haggerty <mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org

Hi,

Michael Haggerty wrote:
> There's still time to join forces :-)  "Far from finished" on a project
> of this messiness can equal quite a bit of time.

Yes. Maybe I'm a little pessimistic ;-)

> But even if you want to pursue your own converter, consider visiting
> #cvs2svn on irc.freenode.net if you want to discuss things.

Thanks, I just happen to not particularly like IRC... I prefer emails
and mailing lists.

>> During parsing of all the *,v files, where I'm collecting events
>> (commits, branching and tagging) into blobs, I do also remember
>> 'possible parent branches' for all the symbols (tag and branch events).
> 
> This is the part that can get quite expensive for large repositories, as
> there can be orders of magnitude more symbol creations than revisions.
> According to Daniel Jacobowitz:
> 
>> [...] at one point I believe the GCC repository was gaining up
>> to four tags a day (head, two supported release branches, and one
>> vendor branch).  I've been using the principal that the number of tags
>> might be unworkable, but the number of branches generally is not.
> 
> This means that the number of tag events is O(number-of-days *
> total-number-of-files-in-repo), where the gcc repo has about 50000
> files.  By contrast, only a small fraction of files is typically touched
> in any day.

Yeah, 50'000 * 1825 (5 years) * say 100 bytes -> 8GB  sounds like a lot.
OTOH, I certainly don't need 100 bytes per tag and one tag per day over 
five years is really a lot. Repositories that large are probably not 
converted to CVS on an old Pentium III...

I've just tested with the mozilla repository (I don't have the gcc one). 
The import has been run only through the first two stpes: collecting the 
blobs and symbol resolving. That took almost one and a half hour on my 
Core Duo with 2GB of memory:

real    85m20.684s
user    39m59.082s
sys     1m32.874s

And peak memory consumption was:

VmPeak:  1814024 kB

While the mozilla/mozilla cvs repository sums up to 3.1 GB. The monotone 
repository (which is still lacking the revisions, but has all files and 
file deltas) is 588MB after that step. I'd guess that once it finishes, 
it would be less than 1GB.

> I've been trying to find a solution that doesn't require quite so much
> space.  I think that if you allow yourself this much space, the problem
> is not very difficult.

Okay. As long as I can import it on my laptop I'm fine ;-)

>> After that and *before* the blob sorting, I check all blobs and try to
>> find one single parent branch for them. In the best case, those symbol
>> blobs do have exactly one possible parent branch, then I just pick that
>> one. If there are multiple possible parents, I try to pick the deepest.
>> As branches are symbols themselves, I have to run that multiple times
>> until all symbols are resolved.
>>
>> An example: having branches ROOT -> A -> B -> C (branched in that order)
>> plus a branch D derived from branch A.
> 
> I assume that you are talking about a situation for which CVS is
> ambiguous, like a file with
> 
> A = 1.2.2
> B = 1.2.4
> C = 1.2.6
> D = 1.2.2.5.2

Well, almost. I meant a whole repository with these branches. If one
file included all the branches it's getting easy to resolve. But for my
example, I had something like that in mind:

fileA:

A = 1.2.2
(no changes for branch B)
C = 1.2.4      --> makes A a possible parent of branch C
D = 1.2.2.5.2  --> makes A a possible parent of branch D
X = 1.2.4      --> makes C a possible parent of tag X

fileB:

A = 1.2.2
B = 1.2.4      --> makes A a possible parent of branch B
C = 1.2.6      --> makes B a possible parent of branch C
D = 1.2.2.5.2  --> makes A a possible parent of branch D
X = 1.2.2.5.2  --> makes D a possible parent of tag X

fileC:
A = 1.2.2
X = 1.2.2      --> makes A a possible parent of tag X

fileD:
A = 1.2.2
B = 1.2.4
X = 1.2.4      --> makes B a possible parent of tag X

>> The symbol blob for branch A: has only one possible parent: ROOT. Thus I
>> assign A->parent_branch = ROOT.
>>
>> Next comes the blob for branch C: it has two possible parents: branch B
>> and branch A.
> 
> Why is ROOT not considered as a possible parent of C?

Those were just examples. In my CVS-repository-in-mind, none of the
files were branching from ROOT directly into C.

>> At that point we know that A is derived from ROOT, but we
>> don't have assigned a parent to B, yet. Thus we can not resolve C this
>> time.
>>
>> Then comes branch B: one parent: A. Mark it.
>>
>> Next round, we process C again: this time, we know B is branched from A.
>> Thus we can remove the possible parent A. Leaving only one possible
>> parent branch: B.
> 
> But the fact that B preceded C chronologically does not mean that C is
> derived from B.

No. And I don't assume so in any place. Given the files above, I can
however clearly say that C got branched off from B, no?

> If I branch from ROOT or A after creating branch B, the
> result as stored in CVS looks exactly the same as if I branch from B
> (unless a file was modified between the creation of the parent branch
> and the creation of the child branch).

Sure. That would result in an unresolvable symbol.

>> Now, say we have a tag 'X', which ended up in a blob having A, B, C and
>> D as possible parent branches. I currently remove A and B, as they are
>> parents of C. But C and D still remain and conflict. I'm unable to
>> resolve that symbol. I'm thinking about leaving such conflicts to the
>> user to resolve.
> 
> From your description, this sounds like a tag that cannot be created
> from a single parent branch.  Therefore it would have to be cobbled
> together from multiple parents.

Right. I somehow have to cope with those cases, as CVS allows them and
monotone does not.

The main point in my symbol resolving code is trying to uniquely assign
a symbol to one branch wherever possible. And handing cases where this
is not possible to the user. AFAICT, it does so quite well.

Regards

Markus
