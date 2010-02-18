From: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Thu, 18 Feb 2010 10:32:49 -0500
Message-ID: <20100218153249.GA11733@gibbs.hungrycats.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix> <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix> <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com> <20100213223733.GP24809@gibbs.hungrycats.org> <20100214011812.GA2175@dpotapov.dyndns.org> <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org> <7vzl37z6f3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 16:33:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni8N7-00039V-7s
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 16:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758367Ab0BRPcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 10:32:52 -0500
Received: from ip-70-38-54-39.static.privatedns.com ([70.38.54.39]:35526 "EHLO
	ginevra.hungrycats.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757716Ab0BRPcv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 10:32:51 -0500
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
Received: from gibbs.hungrycats.org (gibbs.vpn7.hungrycats.org [10.132.226.42])
	by ginevra.hungrycats.org (Postfix) with ESMTP id 17315770092;
	Thu, 18 Feb 2010 10:32:50 -0500 (EST)
Received: from zblaxell by gibbs.hungrycats.org with local (Exim 4.69)
	(envelope-from <zblaxell@gibbs.hungrycats.org>)
	id 1Ni8Mz-0005CK-W1; Thu, 18 Feb 2010 10:32:49 -0500
Content-Disposition: inline
In-Reply-To: <7vzl37z6f3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140346>

On Wed, Feb 17, 2010 at 05:20:00PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> With a small fix to the test program earlier in the thread, this seems to
> protect the repository; I didn't bother to assess the performance impact
> of the patch, though.
> 
> Here is the corrected test.

Depends on what you mean by "corrected" I suppose.

> # Thread 2:  loop until the repo is corrupted
> while git fsck; do
> 	# Note the implied 'git add' in 'commit -a'
> 	# It will do the same with explicit 'git add'
> 	git commit -a -m'Test' || break

This is at least partly wrong--it will terminate prematurely if Thread
1 gets stalled and fails to modify 'foo' during the loop (git commit
normally refuses to commit a tree with no changes).  This can cause
the test for the corruption bug to return false success results.

If you add '--allow-empty' to the git commit command you will fix that
case, but there might be others.  

If git commit runs out of disk space, for example, the commit should
fail, but the repository should still not be corrupt.  Future commits
(for example after freeing some disk space) should eventually succeed.
Really, the original loop was correct, and this new one isn't.

> else
> 	echo Repository is still healthy.  You are stupid.

If git is working, you should never reach this line, because git
fsck should not fail after executing any sequence of git porcelain
operations--and this particular sequence is nothing but 'git commit'
in a single thread.
