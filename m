From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] read-cache.c: fix timestamp comparison
Date: Mon, 21 Jan 2008 11:47:39 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211141160.2957@woody.linux-foundation.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
 <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org> <7vd4rv3ds5.fsf@gitster.siamese.dyndns.org> <7vtzl71x1c.fsf@gitster.siamese.dyndns.org> <7vprvv1wnu.fsf@gitster.siamese.dyndns.org>
 <7vlk6j1wjj.fsf@gitster.siamese.dyndns.org> <7vhch71vvb.fsf@gitster.siamese.dyndns.org> <7v8x2j1sul.fsf@gitster.siamese.dyndns.org> <7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org>
 <alpine.LFD.1.00.0801211104590.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211120350.2957@woody.linux-foundation.org> <alpine.LSU.1.00.0801211925580.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:49:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH2dw-00089V-14
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbYAUTsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbYAUTsq
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:48:46 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34845 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751669AbYAUTsq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 14:48:46 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LJldq8020906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 11:47:40 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LJldUl016586;
	Mon, 21 Jan 2008 11:47:39 -0800
In-Reply-To: <alpine.LSU.1.00.0801211925580.5731@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.223 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71319>



On Mon, 21 Jan 2008, Johannes Schindelin wrote:
> 
> Not that I understand what is _really_ going on, but shouldn't the comment 
> be actually moved, not be deleted?

Well, the thing is, it's not a special case any more, and you can now see 
the code, and say "that's obviously correct".

The whole point of that function is to compare a index entry with the stat 
information, and it does that by validating it in special ways. It used to 
be that the "ce_mode = 0" was a special case. Now it isn't.

A deleted entry can obviously never match an entry that is still on disk 
(regardless of *any* other issues). So now the

	if (ce->ce_flags & CE_REMOVE)
		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;

statement is in no way a special case - rather the reverse, it's a lot 
more obvious than testing for inode ownership changes etc.

So I removed the comment, because it doesn't make sense any more.

Of course, I could have - instead of deleting it - changed it from 
"Special case: .." to something like "A deleted index entry doesn't match 
any on-disk file", but does that actually add any information to the above 
two lines? Sure, we can comment things, but shouldn't we comment the ones 
that are subtle or odd, rather than the obvious ones?

This was why the CE_REMOVE bit was done in the first place: to remove the 
rather special case of ce_mode being zero meaning something special.

			Linus
