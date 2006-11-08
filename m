X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nix <nix@esperi.org.uk>
Subject: Re: What's the meaning of `parenthood' in git commits?
Date: Wed, 08 Nov 2006 01:28:24 +0000
Message-ID: <874ptabubr.fsf@hades.wkstn.nix>
References: <878ximbwm3.fsf@hades.wkstn.nix>
	<Pine.LNX.4.64.0611071644430.3667@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 01:28:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Emacs: it's like swatting a fly with a supernova.
In-Reply-To: <Pine.LNX.4.64.0611071644430.3667@g5.osdl.org> (Linus Torvalds's message of "Tue, 7 Nov 2006 16:58:43 -0800 (PST)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31109>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhcF2-0002Qi-NR for gcvg-git@gmane.org; Wed, 08 Nov
 2006 02:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753818AbWKHB2d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 20:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbWKHB2d
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 20:28:33 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:1032 "EHLO
 mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1753818AbWKHB2c (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 20:28:32 -0500
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18]) by
 mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id kA81SPq5013501;
 Wed, 8 Nov 2006 01:28:25 GMT
Received: (from nix@localhost) by esperi.org.uk
 (8.12.11.20060614/8.12.11/Submit) id kA81SOnF028481; Wed, 8 Nov 2006 01:28:24
 GMT
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 8 Nov 2006, Linus Torvalds uttered the following:
> On Wed, 8 Nov 2006, Nix wrote:
>> 
>> [ Nix explains what he's doing now with SCCS ]: you may be
>> sick now.
>
> Wow. You've got some strange setup there, Nix.

It's what happens when a version-control system gets implemented as
an emergency hack when moving from VMS, by people who don't really
grok Unix shell scripting... and then you let fifteen years pass,
and nobody dares touch the hack because it's so damned delicate.
It took months of agony to implement crude half-functional branching
in this. Writing a git porcelain should be vastly simpler, even with
the overhead of a conversion tool as well.

Writing that conversion tool will be fun :( e.g. I'm going to have to
identify branches by diffing/xdeltaing each version of a file with every
single previous version of that file, and if the diff is smallest
against a version other than the immediate ancestor, it's assumed to be
a branch against that version. (I'm going to have to fake up packed refs
for these tiny branches so that they're at least accessible in
emergencies, gah.)

It's all, well, nasty. But all will be so much happier in the shining
world of git.

>> After all that setup, my question's simple. Does a `parent' in git
>> terminology simply mean `this commit was derived in some way from the
>> commit listed here'?
>
> Well, strictly speaking, git doesn't itself assign much any real meaning 
> to "parent" at all. It has the obvious meanings:

Oh *good*, that's what I thought.

[snip more things which match my understanding]

>  - parenthood will be used to show the diff ("git show", "git log -p" and 
>    friends)

I'll list the patch-merged parent as the second parent, so that you'll only
get the mostly-useless huge diff from that if you actually ask for it, and
will get a more useful result with ^.

>  - the "merge-base" algorithms obviously use it to find the most recent 
>    common ancestor, and that in turn impacts the normal merge strategies, 
>    of course.

Hm, yeah, if merging iterates down patch-merged branches it might have
interesting consequences, because the trees on one side of patch- merges
are likely to be very different to trees on the other side (years of
development separate them). I'd like a way to specify that those parents
are *not* to be traversed by the merge-base algorithms, really.

A series of

not-merge-base: <sha1 id>

headers, perhaps? (I think that's likely to involve much less code churn
than introducing a new `not-merge-base-parent' tag).

> Yeah, git won't care. If you screw up parenthood, you have a few problems:
>
>  - the diffs may look really strange. In particular, if you list multiple 
>    parents, the git "diff" functions will all just assume that it's a 
>    merge, and a "git show" will start showing the combined diff (which is 
>    usually empty).

It is a merge, so that's right. It's just a rather odd merge.

(I don't envisage actual *changes* being made in these commits except to
resolve conflicts.)

>    So if you end up having multiple parents, not because it was "really" a 
>    merge, but because you use the other parent pointer to point to some 
>    "source" for the patch, things like "git log -p" won't give nice output 
>    any more. You need to manually ask for the diff with something like

Well, I was envisaging that the other parent pointer would point to the
tip of the changes tree. Going back to that graph again:

     B
------------- ref trunks/latest
     \
      ------ ref heads/some-change-foo

 ... -------- ref trunks/old-and-grotty

The idea is that the patch-merge of trunks/old-and-grotty and
heads/some-change-foo would consist textually of the diff between B and
heads/some-change-foo, applied to trunks/old-and-grotty, and would list
as its parents trunks/old-and-grotty, *and heads/some-change-foo*.

(Perhaps this isn't really a merge after all? Should merge parents be
treated as differently as this? It'll all be covered over by the
porcelain in any case: it won't be possible to confuse a trunk/ with a
normal head and accidentally patch-merge in the wrong direction.)

>  - listing too _few_ parents is potentially more serious, if you have 
>    reachability issues (ie you wanted to keep the other source around, but 
>    since you didn't list it as a parent, git won't know that it had 
>    anything to do with your commit, so it may be pruned away unless you 
>    have some other way to reach it)

Yeah, that would be bad.

> but if you just have a really strange merge algorithm, and the _data_ 
> associated with the parents is "surprising" from the standpoint of the 
> default merge, git really won't care at all.

Good.

> Your usage does sound a bit strange.

Agreed. But there are hundreds of people banging on my door asking for a
proper version control system, quilt isn't a proper version control
system in that sense, and stgit has... issues when you try to distribute
it and when you have a lot of people working on one tree at once: plus
it doesn't fit our weird workflow with multiple parallel release
branches, at least one active development trunk, and all changes done
under a carefully-controlled bug tracking system (it's as if *every*
change has a bugzilla ticket associated, *always*, and we expect to be
able to get from ticket to change efficiently).

(We do both distribution and working-copy-sharing: the trees are too
large to have one tree per person, not least because each tree requires
an entire Oracle instance of its own to play with and massive amounts of
memory; and we have geographically distributed sites with trees of their
own.)

-- 
Rich industrial heritage: lifeless wasteland. `The land
