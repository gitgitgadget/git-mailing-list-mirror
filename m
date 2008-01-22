From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] read-cache.c: fix timestamp comparison
Date: Tue, 22 Jan 2008 14:00:25 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801221355110.1741@woody.linux-foundation.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org> <7vd4rv3ds5.fsf@gitster.siamese.dyndns.org> <7vtzl71x1c.fsf@gitster.siamese.dyndns.org> <7vprvv1wnu.fsf@gitster.siamese.dyndns.org> <7vlk6j1wjj.fsf@gitster.siamese.dyndns.org>
 <7vhch71vvb.fsf@gitster.siamese.dyndns.org> <7v8x2j1sul.fsf@gitster.siamese.dyndns.org> <7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211104590.2957@woody.linux-foundation.org>
 <alpine.LFD.1.00.0801211120350.2957@woody.linux-foundation.org> <7vabmyykvg.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801211242330.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 23:01:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHRBo-0004a0-2z
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 23:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbYAVWBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 17:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbYAVWBV
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 17:01:21 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43399 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751045AbYAVWBU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 17:01:20 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0MM0Q6a003145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Jan 2008 14:00:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0MM0PVt009637;
	Tue, 22 Jan 2008 14:00:25 -0800
In-Reply-To: <alpine.LFD.1.00.0801211242330.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.223 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71472>



On Mon, 21 Jan 2008, Linus Torvalds wrote:
> On Mon, 21 Jan 2008, Junio C Hamano wrote:
> > 
> > Very good catch.
> 
> The stupid thing is that I literally _grepped_ for the code testing 
> "ce_mode".
> 
> I had missed that one because I had looked for things like
> 
> 	if ([!].*ce_mode)
> 
> but that switch statement meant that the comparison to zero was 
> non-local and my grep didn't see it. And while the test-suite did have a 
> test for this, it was hidden by the racy index logic.. Unlucky.

Ok, having looked a bit more, I found another two cases that my grep had 
missed. They were regular if-statements, just more complex than my stupid 
grep pattern had taken into account.

Both are in read-cache.c:

read-cache.c:                   if (stage || istate->cache[pos]->ce_mode) {
read-cache.c:                   if (ce_stage(p) == stage && (stage || p->ce_mode))

and I'd send a patch, except my tree right now is in pretty bad shape 
because I'm also trying to see if I can add a name hash to the index.

Anyway, the "xyzzy->ce_mode" check should in both cases become a 
"!(xyzzy->ce_flags & CE_REMOVE)" instead.

And we obviously don't seem to have any tests for this situation (I think 
they are both D/F conflicts with the file having been marked removed by an 
earlier phase, so they'd be some really odd kind of merge or something).

		Linus
