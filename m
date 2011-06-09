From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Command-line interface thoughts
Date: Thu, 09 Jun 2011 23:37:04 +0200
Message-ID: <4DF13D00.2060000@alum.mit.edu>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <m339jps1wt.fsf@localhost.localdomain> <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com> <201106051311.00951.jnareb@gmail.com> <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com> <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DF08D30.7070603@alum.mit.edu> <20110609161832.GB25885@sigill.intra.peff.net> <4DF10ADA.5070206@alum.mit.edu> <7v8vtayhnm.fsf@alter.siamese.dyndns.org> <20110609200403.GA3955@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 23:37:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUmuq-0004XX-Uh
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 23:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206Ab1FIVhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 17:37:18 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60221 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241Ab1FIVhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 17:37:17 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p59Lb5M3020237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 9 Jun 2011 23:37:05 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110609200403.GA3955@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175578>

On 06/09/2011 10:04 PM, Jeff King wrote:
> I'm less sure about these new tokens, for a few reasons:
> 
>   1. You get less useful answers in some situations by treating each
>      stage as a separate tree (e.g., lack of combined diff). So why
>      would I want to use them?

Wouldn't it be nice to be able to do a combined diff between *any* two
trees?  Then the nonuniform merge behavior of "git diff" would be a
special case of a general concept:

    git diff3 OURS NEXT THEIRS

>   4. They're supposed to be simpler to understand than index stages. But
>      are they? The latest definitions seem to be:
> 
>        OURS is a tree of each path in the index, either from stage 2 if
>        it exists, or from NEXT otherwise.
> 
>        NEXT is a tree of each path in the index, either from stage 0 if
>        it exists, or from HEAD otherwise.
> 
>      But that doesn't seem any simpler to me than just saying "the index
>      has numbered stages, and they correspond to resolved, base, ours,
>      and theirs".

There is no need to explain the pseudotrees in terms of the index
stages; the pseudotrees are easier to understand and should therefore
become the primary way to describe the index.  Let me give it a try, at
tutorial level.  Assume that the concepts HEAD and WTREE have already
been introduced:

  The "index" is a special area that can hold one or more temporary
  snapshots of your version-controlled content.  Each snapshot is
  called a "tree" because it is analogous to a filesystem tree such
  as the working tree [1].

  Usually the index holds a single tree called "NEXT".  NEXT is a
  snapshot of the state of the working tree that is ready to be
  committed.  This usually consists of the contents from the commit
  that was last checked out (HEAD), plus any changes that have been
  staged for commit using "git stage".

  It is possible to use "git diff" to view the difference between any
  two trees, whether they be trees in the index, trees in commits, or
  the working tree.  For example, to see the difference between the
  last commit and the working tree, use

      git diff HEAD WTREE

  If you would like to see the changes that are ready to be committed,
  type

      git diff HEAD NEXT

  To see the changes in your working tree that have not yet been staged
  for commit, use

      git diff NEXT WTREE

  (The previous command can be abbreviated to "git diff".)

  However, things become more complicated during a merge, when the
  index is used to keep track of the merge's progress.  During a
  merge, the index contains four trees: "NEXT", "OURS", "THEIRS", and
  "BASE".  These four trees are modified as merge conflicts are
  resolved.

  NEXT, as usual, contains the contents that are ready to be committed.
  Specifically, NEXT contains:

    * the original contents of the branch being merged into
    * plus the merged versions of any files that merged cleanly
    * plus any changes that have been staged for commit using
      "git stage"; for example, files whose conflicts have been
      resolved manually.

  OURS contains all of the resolved merges from NEXT, with any
  remaining conflicts resolved by using the version from the branch
  being merged *into*.

  THEIRS contains all of the resolved merges from NEXT, with any
  remaining conflicts resolved by using the content from the branch
  being merged *from*.

  BASE contains all of the resolved merges from NEXT, with any
  remaining conflicts resolved by using the content from the most
  recent ancestor of the two branches being merged.

  As before, "git diff" can be used to view the differences between
  these various trees.  For example, the following command displays the
  conflicts that still have to be resolved:

      git diff NEXT WTREE

  To see how the resolved version differs from the contents of each of
  the original branches, use

      git diff HEAD NEXT
      git diff MERGE_HEAD NEXT

  The "git diff3" command can be used to compare three trees at once:

      git diff3 OURS NEXT THEIRS

  The previous command can be abbreviated to "git diff3".

  [1] The trees that are stored in the index are in an internal format
      that is optimized for efficiency.  They are not stored as
      individual files like in your working copy.

Thoughts?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
