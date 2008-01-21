From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] read-cache.c: fix timestamp comparison
Date: Mon, 21 Jan 2008 13:22:15 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211242330.2957@woody.linux-foundation.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
 <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org> <7vd4rv3ds5.fsf@gitster.siamese.dyndns.org> <7vtzl71x1c.fsf@gitster.siamese.dyndns.org> <7vprvv1wnu.fsf@gitster.siamese.dyndns.org>
 <7vlk6j1wjj.fsf@gitster.siamese.dyndns.org> <7vhch71vvb.fsf@gitster.siamese.dyndns.org> <7v8x2j1sul.fsf@gitster.siamese.dyndns.org> <7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org>
 <alpine.LFD.1.00.0801211104590.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211120350.2957@woody.linux-foundation.org> <7vabmyykvg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:23:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH476-0000i0-C1
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbYAUVWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbYAUVWz
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:22:55 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43051 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751597AbYAUVWy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 16:22:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LLMGUG026348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 13:22:17 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LLMFcZ020543;
	Mon, 21 Jan 2008 13:22:16 -0800
In-Reply-To: <7vabmyykvg.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.223 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71345>



On Mon, 21 Jan 2008, Junio C Hamano wrote:
> >
> > I'd forgotten about that really ugly special case. It's no longer ugly, 
> > but missing that part of the ce_mode handling cleanup certainly explains 
> > the test-suite failing.
> 
> Very good catch.

The stupid thing is that I literally _grepped_ for the code testing 
"ce_mode".

I had missed that one because I had looked for things like

	if ([!].*ce_mode)

but that switch statement meant that the comparison to zero was 
non-local and my grep didn't see it. And while the test-suite did have a 
test for this, it was hidden by the racy index logic.. Unlucky.

Anyway, I've created a rebased tree with the commits fixed (and some 
whitespace fixes too), so that it should hopefully all be bisect-clean 
etc.

[ To clarify: it's both rebased to the current git 'master' (which is 
  currently -rc4) _and_ it has the commits fixed up. So I also squashed 
  the "-m" flag fix into the commit that made diff-index use unpack_trees, 
  etc, so that none of the commits should be introducing bugs that get 
  fixed later.

  I also cleaned up some of the commit messages, particularly the one 
  about using unpack_trees() (which was talking about "take 2" of lstat 
  reduction - true, but not very descriptive of what it actually did) ]

It's in the same place: branch 'new-lstat' at

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git new-lstat

and I'll continue to maintain it if only because it's what I use myself 
(until I just switch to 'next' or something).

		Linus
