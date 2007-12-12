From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 17:12:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0712111653520.1671@alien.or.mcafeemobile.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
 <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
 <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
 <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org>
 <7vprxcdhis.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.9999.0712111523210.25032@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>
 <Pine.LNX.4.64.0712111611570.1671@alien.or.mcafeemobile.com>
 <alpine.LFD.0.9999.0712111648180.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 02:12:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2G9e-0004an-Uh
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 02:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbXLLBMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 20:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbXLLBMY
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 20:12:24 -0500
Received: from x35.xmailserver.org ([64.71.152.41]:46193 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbXLLBMX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 20:12:23 -0500
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S263F13> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Tue, 11 Dec 2007 20:12:22 -0500
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <alpine.LFD.0.9999.0712111648180.25032@woody.linux-foundation.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67980>

On Tue, 11 Dec 2007, Linus Torvalds wrote:

> > Libxdiff already has a xdl_trim_ends() that strips all the common 
> > beginning and ending records, but at that point files are already loaded.
> 
> That's not the problem. The problem with xdl_trim_ends() is that it 
> happens *after* you have done all the hashing, so as an optimization it's 
> fairly useless, because it still leaves the real cost (the per-line 
> hashing) on the table.

Careful. The real cost of diffing, is not the O(1) pass of the prepare 
phase. It's the potentially O(N*M) worst case of the cross-record compare. 
So that optimization is far from useless. That optimization is indeed 
mainly targeted to avoid such worst case.



> So doing the trimming of the ends before you do even that, allows you to 
> just do the trivial "let's see if the ends are identical" with a plain 
> memcmp, which is much faster.

Yes, tail trimming done on a block-basis is faster and does not consume 
memory. The code for libxdiff would have to be a bit more complex though, 
since memory files can be composed by many sections, of different sizes 
(so you cannot just assume it's a single block you're trimming the end). 
Also, you'd need some code at the end that hands you back at least the N 
lines you want for context.



- Davide
