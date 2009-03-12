From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] read-tree A B C: do not create a bogus index and do not
 segfault
Date: Thu, 12 Mar 2009 09:34:49 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903120929250.32478@localhost.localdomain>
References: <35476bd20903101234q71bc520fh18828d7170a4a2f5@mail.gmail.com> <alpine.DEB.1.00.0903102120290.14295@intel-tinevez-2-302> <35476bd20903110059v7d6d8aa0g93af17a940c91919@mail.gmail.com> <alpine.DEB.1.00.0903111300330.10279@pacific.mpi-cbg.de>
 <7vtz5zjnai.fsf@gitster.siamese.dyndns.org> <7vfxhjjkcm.fsf@gitster.siamese.dyndns.org> <7v3adjjj1y.fsf_-_@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0903121024400.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jiri Olsa <olsajiri@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Mar 12 17:47:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhnvn-0005GI-6U
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 17:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbZCLQhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 12:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755110AbZCLQhW
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 12:37:22 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51960 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754074AbZCLQhV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 12:37:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2CGYo6U027514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Mar 2009 09:35:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2CGYniA011248;
	Thu, 12 Mar 2009 09:34:49 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LNX.1.00.0903121024400.19665@iabervon.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.454 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113085>



On Thu, 12 Mar 2009, Daniel Barkalow wrote:
> 
> I think one of the later refactorings may have given up on seeing 
> conflicts while reading trees, but didn't drop the flag (perhaps because 
> Linus knew at the time that my assumption that conflicts would actually 
> have been recognized was false, and didn't realize that it was also the 
> source of the flag).

That is very thoughtful of you, but I suspect the real reason was a much 
simpler one: redoing the read-tree logic was a huge pain in the posterior, 
and my primary goal at the time was to make the code more readable while 
passing all the tests.

So while I tried to make patches minimal (which may well explain why the 
flag remained), it wasn't the main goal, and trying to sort out the 
read-tree logic into something more understandable was quite test-driven.

So I think the big issue to take away from this is that I think this is 
such an odd case that if we want to support it, it would need explicit 
tests. Or:

> I think it might be a good idea to take this as evidence that nobody is 
> using read-tree with multiple trees without merge, and just disallow it. 

Hmm. It _has_ been used. It's been useful for really odd things 
historically, namely trying to merge different trees by hand. So while I 
agree that we could probably remove it, it _is_ a very interesting 
feature in theory, and since we have the code.. 

So I'd say "add a few tests for the known horrible cases" should be the 
first approach. If it ever actually breaks again and becomes a big 
maintenance headache, maybe _then_ remove the feature as not being worth 
the pain?

			Linus
