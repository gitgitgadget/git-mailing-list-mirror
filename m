From: =?utf-8?B?UGF3ZcWC?= Sikora <pawel.sikora@agmk.net>
Subject: Re: cherry-pick is slow
Date: Tue, 15 May 2012 20:57:07 +0200
Message-ID: <29715654.5ciT9KkCQq@localhost>
References: <CAPZ_ugYojqTaWi0atr2ApOu9xmcwy4y8FduNC+TDhgWgSxXNPQ@mail.gmail.com> <CAPZ_ugbD=mOPBs6GyapWtv6NWuJ-=r2+bqBN9n+gdTPwGj3F0Q@mail.gmail.com> <20120515132451.GA25378@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: Jeff King <peff@peff.net>,
	Dmitry Risenberg <dmitry.risenberg@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 21:06:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUN4c-0007Iz-3H
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 21:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966444Ab2EOTGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 15:06:13 -0400
Received: from mail.agmk.net ([91.192.224.71]:41198 "EHLO mail.agmk.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966266Ab2EOTGN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 15:06:13 -0400
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 May 2012 15:06:12 EDT
Received: from localhost.localnet (unknown [89.78.237.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pluto@agmk.net)
	by mail.agmk.net (Postfix) with ESMTPSA id 74793203015D;
	Tue, 15 May 2012 20:57:13 +0200 (CEST)
User-Agent: KMail/4.8.3 (Linux/3.3.6-1; KDE/4.8.3; x86_64; ; )
In-Reply-To: <20120515132451.GA25378@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197848>

On Tuesday 15 of May 2012 09:24:51 Jeff King wrote:
> [let's keep this on-list so others can benefit from the discussion]
> 
> On Tue, May 15, 2012 at 12:38:59PM +0400, Dmitry Risenberg wrote:
> 
> > > It's probably detecting renames as part of the merge, which can be
> > > expensive if the thing you are cherry-picking is far away from HEAD. You
> > > can try setting the merge.renamelimit config variable to something small
> > > (like 1; setting it to 0 means "no limit").
> > 
> > I set it to 1, but it didn't help at all - cherry-pick time is still
> > about the same.
> 
> OK, then my guess was probably wrong. You'll have to try profiling (if
> you are on Linux, "perf record git cherry-pick ..."; perf report" is the
> simplest way). Or if the repository is publicly available, I can do a
> quick profile run.

i have two big repos (few GB) and cherry-pick utilizes i/o and cpu heavy.
timing varies from few seconds on raid-0 (2x500GB) to ~30 second
on linear lvm (few TB). here's perf report:

 36,24%  git  libc-2.15.so        [.] __memmove_ssse3_back
  7,04%  git  libz.so.1.2.7       [.] inflate_fast
  6,17%  git  libz.so.1.2.7       [.] inflate
  5,53%  git  git                 [.] xdl_recs_cmp
  3,04%  git  libc-2.15.so        [.] __memcmp_sse4_1
  2,54%  git  libz.so.1.2.7       [.] inflate_table
  1,83%  git  libc-2.15.so        [.] __strcmp_sse42
  1,52%  git  libc-2.15.so        [.] __memcpy_ssse3_back
  1,49%  git  git                 [.] match_trees
  1,39%  git  libc-2.15.so        [.] _int_malloc
  1,18%  git  libz.so.1.2.7       [.] adler32
  1,08%  git  git                 [.] do_head_ref
  1,02%  git  git                 [.] splice_tree
  0,83%  git  libc-2.15.so        [.] __strlen_sse2_pminub
  0,71%  git  [kernel.kallsyms]   [k] _raw_spin_lock
  0,68%  git  git                 [.] shift_tree_by
  0,67%  git  libc-2.15.so        [.] _int_free
  0,63%  git  [kernel.kallsyms]   [k] __d_lookup_rcu
  0,60%  git  [kernel.kallsyms]   [k] link_path_walk
  0,57%  git  git                 [.] get_shallow_commits
(...)
