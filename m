From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Sat, 25 Jul 2009 21:49:41 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907252147130.3960@localhost.localdomain>
References: <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain> <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain>
 <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <20090724234648.GA4616@Pilar.aei.mpg.de> <20090725004122.GA28477@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907251046140.3960@localhost.localdomain>
 <20090725215739.d074e947.tihirvon@gmail.com> <20090725203130.GB1640@glandium.org> <alpine.LFD.2.01.0907251353410.3960@localhost.localdomain> <alpine.LFD.2.01.0907251406390.3960@localhost.localdomain> <alpine.DEB.1.00.0907260123090.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Timo Hirvonen <tihirvon@gmail.com>,
	git@vger.kernel.org, "Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 26 06:50:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUvgt-00015x-8i
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 06:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbZGZEuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 00:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbZGZEuU
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 00:50:20 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53017 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751014AbZGZEuU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 00:50:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6Q4ngr8014409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Jul 2009 21:49:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6Q4nfPf004654;
	Sat, 25 Jul 2009 21:49:41 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0907260123090.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.459 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124102>



On Sun, 26 Jul 2009, Johannes Schindelin wrote:
> > 
> > It seems to come from libcrypto. I can get rid of it with NO_OPENSSL, and 
> > that cuts down on the number of system calls in my startup by 16 (getting 
> > rid of both libcrypto and libdl). I wonder if there is some way to get the 
> > optimized openssl sha1 routines _without_ that silly ldl thing.
> 
> OpenSSL allows for so-called engines implementing certain algorithms.  
> These engines are dynamic libraries, loaded via dlopen().

Ah. Ok, that explains it.

It's a bit sad, since the _only_ thing we load all of libcrypto for is the 
(fairly trivial) SHA1 code. 

But at the same time, last time I benchmarked the different SHA1 
libraries, the openssl one was the fastest. I think it has tuned assembly 
language for most architectures. Our regular mozilla-based C code is 
perfectly fine, but it doesn't hold a candle to assembler tuning.

Oh well. 

		Linus
