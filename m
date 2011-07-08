From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] pack-objects: optimize "recency order"
Date: Thu, 7 Jul 2011 19:08:11 -0700
Message-ID: <CAJo=hJtEnGGH8yjTGHiVjjaiRd6TVznW+5DwpibNSN6JEY=Trw@mail.gmail.com>
References: <1310084657-16790-1-git-send-email-gitster@pobox.com> <1310084657-16790-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 08 04:08:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qf0Uf-0002Dz-VU
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 04:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab1GHCIc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jul 2011 22:08:32 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36522 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab1GHCIb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2011 22:08:31 -0400
Received: by vxb39 with SMTP id 39so1100012vxb.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 19:08:31 -0700 (PDT)
Received: by 10.52.174.49 with SMTP id bp17mr2089950vdc.243.1310090911059;
 Thu, 07 Jul 2011 19:08:31 -0700 (PDT)
Received: by 10.52.109.166 with HTTP; Thu, 7 Jul 2011 19:08:11 -0700 (PDT)
In-Reply-To: <1310084657-16790-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176795>

On Thu, Jul 7, 2011 at 17:24, Junio C Hamano <gitster@pobox.com> wrote:
> This optimizes the "recency order" (see pack-heuristics.txt in
> Documentation/technical/ directory) used to order objects within a
> packfile in three ways:

Yay!

> =A0- Commits at the tip of tags are written together, in the hope tha=
t
> =A0 revision traversal done in incremental fetch (which starts by
> =A0 putting them in a revision queue marked as UNINTERESTING) will se=
e a
> =A0 better locality of these objects;

Putting these together after the first tagged commit is an interesting
approach. Currently JGit drops these after 1024 recent commits have
been produced, the alternative here parks them around the most recent
release. I wonder which is really the better approach for the
upload-pack workload. I chose 1024 because linux-2.6 seemed to be
getting several thousand commits per MB of pack data, so 1024 would
park the tagged commits within the first MB (making a cold-cache
upload-pack slightly faster), but doesn't harm `git log` going through
the pager too badly because this block is 1024 commits back.

Have you tried putting commits in parse order rather than recency order=
?

By this I mean the revision traversal code needs to parse the parents
of a commit in order to get their commit date and enqueue them into
the priority queue at the right position. The order the commits get
parsed in is different from the order they are popped in, especially
when a commit is created on an older revision and there is much
concurrent activity on a different branch between the commit and its
ancestor. This pattern is very typical in repositories that pull from
others to merge changes in... aka linux, git.git, etc.

My intuition says emulating the priority queue in pack-objects and
using that to influence the order commits are written out (so its the
order commits enter the queue, rather than leave it) will further
reduce minor page faults during the `git log >/dev/null` test, and
possibly also help the other log based workloads. Its certainly a lot
more work to code than this patch, but I wonder if it produces better
ordering.

> =A0- In the original recency order, trees and blobs are intermixed. W=
rite
> =A0 trees together before blobs, in the hope that this will improve
> =A0 locality when running pathspec-limited revision traversal, i.e.
> =A0 "git log paths...";

=46WIW JGit has been doing "commits-then-trees-then-blobs" for a long
time now and we have generally found the same results as you did here,
segregating by object type helps page faults.

> =A0- When writing blob objects out, write the whole family of blobs t=
hat use
> =A0 the same delta base object together, by starting from the root of=
 the
> =A0 delta chain, and writing its immediate children in a width-first
> =A0 manner, in the hope that this will again improve locality when re=
ading
> =A0 blobs that belong to the same path, which are likely to be deltif=
ied
> =A0 against each other.

This is an interesting approach, and one I had not considered before.

> =A0* Simple commit-only log.
>
> =A0 $ git log >/dev/null
=2E..
> =A0 95% of the pack accesses look at data that is no further than 260=
kB
> =A0 from the previous location we accessed. The patch does not change=
 the
> =A0 order of commit objects very much, and the result is very similar=
=2E

I think a more interesting thing to examine is how often do we have to
"skip back" to an earlier part of the file. Consider the case that the
~190MBish of commits does not fully fit into kernel buffer cache, but
we do have read-ahead support in the kernel. Forward references are
relatively free, because read-ahead should populate that page before
we need it. Backward references are horribly expensive, because they
may have been evicted to make room for more read-ahead. From what I
could tell of similar traces in JGit, the recency commit ordering
causes a lot more backwards references than the parse ordering.

> =A0* Pathspec-limited log.
>
> =A0 $ git log drivers/net >/dev/null
>
> =A0 The path is touched by 26551 commits and merges (among 254656 tot=
al).
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0v1=
=2E7.6 =A0with patch
> =A0 Total number of access : =A0 =A0 =A0559,511 =A0 =A0 558,663
=2E..
> =A0 =A0 =A0 =A0 70.0% percentile : =A0319,574,732 110,370,100
> =A0 =A0 =A0 =A0 80.0% percentile : =A0361,647,599 123,707,229
> =A0 =A0 =A0 =A0 90.0% percentile : =A0393,195,669 128,947,636
> =A0 =A0 =A0 =A0 95.0% percentile : =A0405,496,875 131,609,321
=2E..

Does this result suggest that we needed less of the pack in-memory in
order to produce the result? That is, on a cold cache we should be
touching fewer pages of the pack when this patch was used to create
it, and fewer page references would allow the command to complete more
quickly on a cold cache.

> Note that a half-a-gigabyte packfile comfortably fits in the buffer c=
ache,
> and you would unlikely to see much performance difference on a modern=
 and
> reasonably beefy machine with enough memory and local disks. Benchmar=
king
> with cold cache (or over NFS) would be interesting.

It would also be easy to test these cases by setting the pack window
size to something small (e.g. 1 MB) and the pack limit to something
equally small (e.g. 25 MB), and stuffing a delay of 20 ms into the
code path that xmmaps a new window when its not already opened.

I'm glad you started working on this, it looks like it may lead to a
better pack ordering.

--=20
Shawn.
