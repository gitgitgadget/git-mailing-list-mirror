From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: performance problem: "git commit filename"
Date: Mon, 14 Jan 2008 09:07:27 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801140902140.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org> <7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
 <7vd4s6qal0.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org> <7vr6glnrvp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 18:09:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JESo1-0007OV-Vn
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 18:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448AbYANRIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 12:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYANRIa
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 12:08:30 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49580 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755405AbYANRI3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2008 12:08:29 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0EH7Rh0012120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jan 2008 09:07:29 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0EH7R1E005129;
	Mon, 14 Jan 2008 09:07:27 -0800
In-Reply-To: <7vr6glnrvp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70464>



On Sun, 13 Jan 2008, Junio C Hamano wrote:
> 
> I've reworked the patch, and in the kernel repository, a
> single-path commit after touching that path now calls 23k
> lstat(2).  It used to call 46k lstat(2) after your fix.

Ok, I really like what the patch does, and how it looks.

At the same time, I *really* hate how we now edit the cache entries in 
place for these kinds of things that really have nothing to do with the 
on-disk format. That's not a new thing (CE_UPDATE is the same), but it 
definitely got uglier.

So I think this patch is good, but I think it would be even better if we 
just bit the bullet and started looking at having a different in-memory 
representation from the on-disk one. Possibly not *that* much different: 
perhaps just keeping a pointer to the on-disk one along with a flags 
value.

That would be a fairly painful change, though (and quite independent from 
this particular one - apart from the fact that CE_UPTODATE is one of the 
users that could be cleaned up if we did that).

Comments?

			Linus
