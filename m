From: Jeff King <peff@peff.net>
Subject: Re: [PATCH WIP] sha1-lookup: make selection of 'middle' less
	aggressive
Date: Tue, 1 Jan 2008 01:36:16 -0500
Message-ID: <20080101063616.GA21605@coredump.intra.peff.net>
References: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org> <7vtzm08l9w.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0712301150120.32517@woody.linux-foundation.org> <7vodc77t0o.fsf@gitster.siamese.dyndns.org> <e5bfff550712301404g273dd092w9b36b48d94ed1e70@mail.gmail.com> <alpine.LFD.1.00.0712311232520.32517@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 07:36:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9akB-0003dy-Nr
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 07:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbYAAGgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 01:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbYAAGgU
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 01:36:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4512 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbYAAGgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 01:36:19 -0500
Received: (qmail 5227 invoked by uid 111); 1 Jan 2008 06:36:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 01 Jan 2008 01:36:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jan 2008 01:36:16 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0712311232520.32517@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69429>

On Mon, Dec 31, 2007 at 12:37:36PM -0800, Linus Torvalds wrote:

> And quite honestly I'm not really even sure that the performance downside 
> is entirely about zlib itself: I suspect a lot of the reason zlib shows up 
> in the profiles is that the source data is usually cold in the cache, so 
> it probably takes a lot of cache misses (it also will take all the page 
> faults!).

zlib makes a noticeable impact in real world cases. On a git.git repo,
fully packed with stock config, warm cache:

  $ /usr/bin/time git whatchanged >/dev/null
  4.12user 0.37system 0:04.50elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+6452minor)pagefaults 0swaps

  $ git config pack.compression 0
  $ git repack -a -d -f
  $ /usr/bin/time git whatchanged >/dev/null
  2.93user 0.43system 0:03.36elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+8501minor)pagefaults 0swaps

More pagefaults, but a 25% improvement in wall clock time.  The packfile
is noticeably larger (55M versus 40M), so I'm sure the cold cache case
sucks. It may also change with larger repos, where the packfile size
difference kills your cache.

-Peff
