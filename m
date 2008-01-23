From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 08:25:01 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801230817390.1741@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <7vabmxqnz8.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801221844570.1741@woody.linux-foundation.org> <7vprvtngxk.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0801231224300.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 17:26:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHiQt-0002nO-FE
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 17:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbYAWQ0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 11:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbYAWQ0D
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 11:26:03 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35318 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752267AbYAWQ0B (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 11:26:01 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NGP21q020221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jan 2008 08:25:03 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NGP1QI015793;
	Wed, 23 Jan 2008 08:25:01 -0800
In-Reply-To: <alpine.LSU.1.00.0801231224300.5731@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71551>



On Wed, 23 Jan 2008, Johannes Schindelin wrote:
> 
> I fully expect it to be noticable with that UTF-8 "normalisation".  But 
> then, the infrastructure is there, and whoever has an itch to scratch...

Actually, it's going to be totally invisible even with UTF-8 
normalization, because we're going to do it sanely.

And by "sanely" I mean just having the code test the high bit, and using 
US-ASCII as-is (possibly with that " & ~0x20 " thing to ignore case in 
it).

End result: practically all projects will never notice anything at all for 
99.9% of all files. One extra well-predicted branch, and a few more hash 
collissions for cases where you have both "Makefile" and "makefile" etc.

Doing names with *lots* of UTF-8 characters will be rather slower. It's 
still not horrible to do if you do it the smart way, though. In fact, it's 
pretty simple, just a few table lookups (one to find the NFD form, one to 
do the upcasing).

And yes, for hashing, it makes sense to turn things into NFD because it's 
generally simpler, but the point is that you really don't actually modify 
the name itself at all, you just hash things (or compare things) character 
by expanded character.

IOW, only a total *moron* does Unicode name comparisons with

	strcmp(convert_to_nfd(a), convert_to_nfd(b));

which is essentially what Apple does. It's quite possible to do

	utf8_nfd_strcmp(a,b)

and (a) do it tons and tons faster and (b) never have to modify the 
strings themselves. Same goes (even more) for hashing.

			Linus
