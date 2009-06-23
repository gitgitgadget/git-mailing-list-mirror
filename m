From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [BUG] malloc error when using large file.
Date: Tue, 23 Jun 2009 14:15:21 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906231412070.3240@localhost.localdomain>
References: <B03A893ADFE80748942D13AFAF2845190C2D5D388A@ITSVLEX06.it.maxim-ic.internal> <20090622211542.GA19364@coredump.intra.peff.net> <B03A893ADFE80748942D13AFAF2845190C2D5D3BDC@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Emmanuel Puerto <emmanuel.puerto@maxim-ic.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 23:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJDL7-00084e-DO
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 23:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755999AbZFWVP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 17:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755194AbZFWVP1
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 17:15:27 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34880 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753128AbZFWVP1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2009 17:15:27 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5NLFMXH020536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Jun 2009 14:15:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n5NLFLp0015398;
	Tue, 23 Jun 2009 14:15:21 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <B03A893ADFE80748942D13AFAF2845190C2D5D3BDC@ITSVLEX06.it.maxim-ic.internal>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.97 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122111>



On Tue, 23 Jun 2009, Emmanuel Puerto wrote:
> 
> 
> > Many operations in git assume that a whole file can be held in memory at
> > once. Do you actually have 2G available on the machine? Are there any OS
> > limits that might be a problem?
> 
> Thanks for your answer Jeff, 
> 
> Yes I have more that 2 Go available when a do it, and after this 
> allocation error if I try to do a 'git add' with a 9Go file, I did not 
> have any issue.

Can you add the 2GB files individually, using

	for i in All-f00?.vmdk; do git add $i; done

or similar?

It does sound like an unlucky malloc VM space fragmentation issue, 
although since the files you add are the same size I'd have not really 
expected that with any normal malloc library. But with some mixed small 
and large allocations, I could imagine that the fragmentation happens, and 
you end up having huge areas that aren't _quite_ useful for the next file 
due to having some small allocation taking part of it.

		Linus
