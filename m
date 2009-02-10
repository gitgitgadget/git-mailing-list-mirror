From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 17:55:39 -0500
Message-ID: <20090210225539.GC26954@coredump.intra.peff.net>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com> <20090210110330.GB12089@coredump.intra.peff.net> <7vwsbynv0o.fsf@gitster.siamese.dyndns.org> <20090210181052.GA19634@coredump.intra.peff.net> <20090210191118.GA26651@coredump.intra.peff.net> <7vtz72kjz0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Tuncer Ayaz <tuncer.ayaz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 23:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX1Xg-0004Ee-Vw
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 23:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115AbZBJWzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 17:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756037AbZBJWzm
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 17:55:42 -0500
Received: from peff.net ([208.65.91.99]:47415 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755995AbZBJWzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 17:55:41 -0500
Received: (qmail 19278 invoked by uid 107); 10 Feb 2009 22:55:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 17:55:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 17:55:39 -0500
Content-Disposition: inline
In-Reply-To: <7vtz72kjz0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109332>

On Tue, Feb 10, 2009 at 02:25:39PM -0800, Junio C Hamano wrote:

> > Warm cache, it runs in .042s on my git repo, about half of which is the
> > untracked files check. It takes about .49s on the kernel repo. The
> > read_directory() bit is not optimized at all, and could probably benefit
> > from an early return (OTOH, the worst case is still going to need to
> > look at every path).
> 
> I suspect that with a large tree your have_untracked() would show
> unnecessary overhead from dir_add_name(), because you only want one bit of
> information but there is no way to stop with "ok, we know enough".  This
> toy patch adds a trivial "early return" to read_directory() codepath, but
> there are two sad things about it.

My timings are exactly the same (with my have_untracked removed,
of course). Due most likely to the fact that I keep my repos clean, so
we have to look at every directory to realize there are no files.

Here are a few timings:

For the relative times of each action, I get (in the linux-2.6 tree):

  - nothing (just read_cache / refresh_cache)
    real    0m0.178s
    user    0m0.060s
    sys     0m0.116s

  - just index_differs_from (minus nothing = 0.107s)
    real    0m0.285s
    user    0m0.140s
    sys     0m0.140s

  - just worktree_is_dirty (minus nothing = 0.0s)
    real    0m0.178s
    user    0m0.048s
    sys     0m0.132s

  - just untracked_files_exist (minus nothing = 0.184s)
    real    0m0.362s
    user    0m0.188s
    sys     0m0.176s

So untracked_files is definitely the worst, but I was surprised that
the index to HEAD diff takes so long.

For just index_differs_from, gprof claims we spend most of our time in
unpack-trees stuff:

 33.33      0.01     0.01    28301     0.00     0.00  unpack_callback
 33.33      0.02     0.01    28301     0.00     0.00  unpack_nondirectories
 33.33      0.03     0.01    26627     0.00     0.00  convert_from_disk

For just untracked_files_exist, gprof claims we spend most of our time
dealing with the index name hash (and obviously a bit of time in
excluded_1):

 27.27      0.03     0.03  1479931     0.00     0.00  icase_hash
 18.18      0.05     0.02    74142     0.00     0.00  excluded_1
  9.09      0.06     0.01   120178     0.00     0.00  lookup_hash_entry
  9.09      0.07     0.01    49855     0.00     0.00  hash_name
  9.09      0.08     0.01    26627     0.00     0.00  convert_from_disk
  9.09      0.09     0.01    24739     0.00     0.00  excluded
  9.09      0.10     0.01       18     0.56     0.88  grow_hash_table

So maybe there are speedups to be had there. ISTR the icase_hash stuff
came about to support case-challenged filesystems. I haven't looked to
see if it could be turned into a ALL_OF_MY_FILESYSTEMS_ARE_SANE
compile-time option to get some speedup.

-Peff
