From: YONETANI Tomokazu <qhwt+git@les.ath.cx>
Subject: Re: [PATCH] git-fast-import possible memory corruption problem
Date: Sun, 14 Dec 2008 19:45:34 +0900
Message-ID: <20081214104534.GA72082@les.ath.cx>
References: <20081214020822.GB4121@les.ath.cx> <7vd4fv4e3u.fsf@gitster.siamese.dyndns.org> <7vskor2tfw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 11:46:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBoUw-0004lV-E5
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 11:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbYLNKph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 05:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbYLNKph
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 05:45:37 -0500
Received: from x219233.ppp.asahi-net.or.jp ([122.249.219.233]:3778 "EHLO
	les.ath.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbYLNKpg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 05:45:36 -0500
Received: by les.ath.cx (Postfix, from userid 1000)
	id 7684986653; Sun, 14 Dec 2008 19:45:34 +0900 (JST)
Content-Disposition: inline
In-Reply-To: <7vskor2tfw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103061>

On Sat, Dec 13, 2008 at 09:53:55PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> As the `round out' takes place AFTER it found the room in the mem_pool,
> >> there's a small chance of p->next_free being set outside of the chosen
> >> area, up to (sizeof(uintmax_t) - 1) bytes.  pool_strdup() is one of the
> >> functions which can trigger the problem, when pool_alloc() finds a room
> >> at the end of a pool entry and the requested length is not multiple of
> >> size(uintmax_t).  I believe attached patch addresses this problem.
> >
> > Thanks -- do you mean your reproducible crash does not reproduce with the
> > patch anymore?
> >
> > I think your change to move the "round up" logic up in the codepath makes
> > perfect sense.  But your patch seems to conflate totally unrelated change
> > to move memzero from the caller to callee into it, and I do not see the
> > reason why it should be that way.  If the caller asked 10 bytes to calloc
> > from the pool, and the underlying pool allocator gives you a 16-byte
> > block, you only have to guarantee that the first 10 bytes are cleared, and
> > can leave the trailing padding 6 bytes at the end untouched.
> 
> That is, something like this...
> 
>  fast-import.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git c/fast-import.c w/fast-import.c
> index 3c035a5..3276d5d 100644
[snip]
Yes, that was what it originally looked like, but after fixing the crash
I encountered another problem, and thought that I had to clear rounded up
area too.  It turned out that the second problem has nothing to do with
[the pool allocator, but the data fed to git-fast-import.  After fixing
the data, the git-fast-import with above patch finished successfully,
no more crashes.
