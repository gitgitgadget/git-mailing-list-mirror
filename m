From: Zygo Blaxell <zblaxell@esightcorp.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Thu, 18 Feb 2010 11:18:43 -0500
Message-ID: <20100218161843.GB11733@gibbs.hungrycats.org>
References: <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix> <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com> <20100213223733.GP24809@gibbs.hungrycats.org> <20100214011812.GA2175@dpotapov.dyndns.org> <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org> <20100218013822.GB15870@coredump.intra.peff.net> <alpine.LFD.2.00.1002172350080.1946@xanadu.home> <7vocjnqf5c.fsf@alter.siamese.dyndns.org> <5DDD89A9-900F-40AD-8F3F-F756D6E0AD6C@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 17:18:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni95W-0005JN-9k
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 17:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758336Ab0BRQSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 11:18:45 -0500
Received: from ip-70-38-54-39.static.privatedns.com ([70.38.54.39]:47677 "EHLO
	ginevra.hungrycats.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758258Ab0BRQSo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 11:18:44 -0500
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
Received: from gibbs.hungrycats.org (gibbs.vpn7.hungrycats.org [10.132.226.42])
	by ginevra.hungrycats.org (Postfix) with ESMTP id 524DE8013;
	Thu, 18 Feb 2010 11:18:43 -0500 (EST)
Received: from zblaxell by gibbs.hungrycats.org with local (Exim 4.69)
	(envelope-from <zblaxell@esightcorp.com>)
	id 1Ni95P-0006LX-7O; Thu, 18 Feb 2010 11:18:43 -0500
Content-Disposition: inline
In-Reply-To: <5DDD89A9-900F-40AD-8F3F-F756D6E0AD6C@wincent.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140349>

On Thu, Feb 18, 2010 at 08:27:28AM +0100, Wincent Colaiuta wrote:
> Shouldn't a switch that hurts performance and is only needed for insane use cases default to off rather than on?

While I don't disagree that default off might(*) be a good idea,
I do object to the categorization of this use case as 'insane'.

Neither the documentation for 'git add' nor its various aliases (e.g. 'git
commit' with paths or -a, etc) mentions that any use of 'git add'
might cause repository corruption under any circumstances.  Contrast with
examples of repository-corrupting pitfalls in the man pages of tools
such as 'git clone' and 'git gc'.

In fact, the language in the git add man page seems to suggest the
opposite, using words like "snapshot" and pointing out several times
that the index is intentionally immune to changes interleaved between
'git add' and 'git commit' commands.

Common sense (for Unix users) is that the index is not immune to changes
*during* git add, but nowhere in my wildest nightmares would I conceive
that changes in file contents during git add would *corrupt the
repository* and git would *fail to notice or give useful diagnostics*
until *days or weeks later* after the corruption has already *spread to
multiple repositories* through *git push with default options*.

Now, if you want to put that text in the man pages of 'git add' and
friends, and point out the paranoia switch there, I have nothing to
object to.

I also see nothing prohibiting concurrent file modification in some
reasonable revision-control use cases.  What happens if I do a 'git
commit -a' on, say, proprietary EDA tool data files or Microsoft Office
documents, and those tools choose an unfortunate moment to automatically
update files under revision control?  Granted, I can't really expect the
repo to contain usable data, but what I do expect is another commit, or
a rebased/amended commit, that fixes the mangled file's contents--not to
be required to rebase on the commit's parent everything that comes
after it, then purge my reflogs so 'git gc' will work again.

Working directories on network filesystems might do all kinds of strange
things, most of which aren't intentional.  It's one thing to commit a
useless tree, and quite another to unintentionally commit an irretrievable
one.

(*) "might" be a good idea because there's been some evidence to suggest
that a paranoid implementation of git add might perform better than the
mmap-based one in all cases, if more work was done than anyone seems
willing to do.
