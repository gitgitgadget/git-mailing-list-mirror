X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nix <nix@esperi.org.uk>
Subject: Re: What's the meaning of `parenthood' in git commits?
Date: Wed, 08 Nov 2006 03:04:51 +0000
Message-ID: <87velqabak.fsf@hades.wkstn.nix>
References: <878ximbwm3.fsf@hades.wkstn.nix>
	<Pine.LNX.4.64.0611071644430.3667@g5.osdl.org>
	<874ptabubr.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 03:06:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Emacs: Lovecraft was an optimist.
In-Reply-To: <874ptabubr.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of "Wed, 08 Nov 2006 01:28:24 +0000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31111>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhdlE-0005fI-OH for gcvg-git@gmane.org; Wed, 08 Nov
 2006 04:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753969AbWKHDFE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 22:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753954AbWKHDFD
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 22:05:03 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:1807 "EHLO
 mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1753946AbWKHDFA (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 22:05:00 -0500
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18]) by
 mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id kA834rw4021329;
 Wed, 8 Nov 2006 03:04:53 GMT
Received: (from nix@localhost) by esperi.org.uk
 (8.12.11.20060614/8.12.11/Submit) id kA834qRR012450; Wed, 8 Nov 2006 03:04:52
 GMT
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 8 Nov 2006, nix@esperi.org.uk spake thusly:
> On 8 Nov 2006, Linus Torvalds uttered the following:
>>  - the "merge-base" algorithms obviously use it to find the most recent 
>>    common ancestor, and that in turn impacts the normal merge strategies, 
>>    of course.
>
> Hm, yeah, if merging iterates down patch-merged branches it might have
> interesting consequences, because the trees on one side of patch- merges
> are likely to be very different to trees on the other side (years of
> development separate them). I'd like a way to specify that those parents
> are *not* to be traversed by the merge-base algorithms, really.
>
> A series of
>
> not-merge-base: <sha1 id>
>
> headers, perhaps? (I think that's likely to involve much less code churn
> than introducing a new `not-merge-base-parent' tag).

Wrong. Sort of.

When doing normal merges you don't want to consider patch-merged parents
as real merges: but there is one situation when you *do* want merge-base
checking to traverse such links.

Say you have the tree just described:

     B
------------- ref trunks/latest
     \
      ------ ref heads/some-change-foo

 ... -------- ref trunks/old-and-grotty

and you want to patch-merge heads/some-change-foo with
trunks/old-and-grotty.

It doesn't quite apply, so you end up with a conflict-resolution. This
will normally be in the merge commit, but there's no guarantee of that:
perhaps you knew the source tree would conflict in advance and fixed it
up so that it wouldn't, leaving the old heads/some-change-foo pointing
before that fixup:

     B
------------- ref trunks/latest
     \
      ------- ref heads/some-change-foo
          D \
            c
            |
 ... -------------- ref trunks/old-and-grotty

Later on, you find a bug in that change. It's still the same conceptual
change, so you fix it, and you want to patch-merge the fix across:

     B
------------- ref trunks/latest
     \
      -----------\ ref heads/some-change-foo
          C \    .
            c    . (link under construction)
            |    .
 ... -------------- ref trunks/old-and-grotty
            E    F

What patch-merge must do in order to produce a diff-merge at point F is
therefore rather more involved than I'd hoped:

 - determine B as above (most recent merge-base of heads/some-change-foo
   with anything in trunks/).

 - determine the merge-base of trunks/old-and-grotty with
   heads/some-change-foo, *traversing patch-merge parents*. Call this
   base C. (This is the only circumstance in which merge-base
   determination should traverse patch-merged parents.)

 - Iff that base C is topologically a child of B, then we have already
   merged part of this change in the past. In that case, instead of the
   merge consisting of the diff between B and F, it consists of the diff
   between C and the head, minus the set of changes c. So it remains to
   determine c.

 - scan backwards along F with git-rev-list, searching specifically for
   the most recent patch-merge naming any commit which has C as a
   transitive parent: that is point E. (Such a point must exist as long
   as only patch-merges have been used to merge heads/some-change-foo
   with trunks/old-and-grotty: if other sorts of merge have been used,
   all bets are off and I think we can legitimately fail the merge.)
   (This requires the ability to distinguish patch-merges from normal
   merges, but that's easy if we have any tag at all to distinguish
   them, which we must for merge- base traversal to avoid such parents
   normally.)

 - Reverse out the diff between C and E (if the two are not the same
   commit) and remember it temporarily as c.

 - Apply the forwards diff between point C and heads/some-change-foo,
   and then apply c in the forwards direction (if c is already present,
   this is not an error: it just means that whatever conflict-
   resolution was necessary as a one-off was later needed on the change
   trunk).

I think that should cope with just about everything. I've tried to mock
up all sorts of contrived trees and I can't find anything that doesn't
reduce to that case or a simplification of it. (And no, this case is not
contrived: we test on trunks, so we deal with it whenever anything fails
testing and has to be fixed...)

(Now all I have to do is write it... enough words, time for action.
Actually time for sleep, it's three in the morning here. Action
tomorrow.)

-- 
Rich industrial heritage: lifeless wasteland. `The land
