From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/3] Avoid using 'lstat()' to figure out directories
Date: Thu, 9 Jul 2009 17:13:52 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907091658210.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain> <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain> <7vab3d3dpc.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain> <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain>
 <4A5670F3.9020309@gnu.org> <alpine.LFD.2.01.0907091626080.3352@localhost.localdomain> <alpine.LFD.2.01.0907091647400.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 02:14:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP3lP-0005X1-Mr
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 02:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbZGJAOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 20:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbZGJAOE
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 20:14:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58920 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752441AbZGJAOC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 20:14:02 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6A0DrQ0032656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jul 2009 17:13:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6A0DqU5027773;
	Thu, 9 Jul 2009 17:13:52 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907091647400.3352@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123026>



On Thu, 9 Jul 2009, Linus Torvalds wrote:
> 
> So we'd need to do the whole "copy name and add '/' at the end" thing. But 
> the upside would then be that after that, we'd not need any looping to 
> find the right ce. So it might be the right thing to do despite the 
> extra copy.

Naah. I did the numbers. For any normal repository, the 'loop' is going to 
hit exactly once. Trying to be smarter about the initial binary search 
isn't going to help, and copying the pathname around is only going to 
hurt.

In the Linux repo, there's a small handful of cases like this, eg

 - "arch/x86/vdso32"
	arch/x86/vdso/vdso32-setup.c
	arch/x86/vdso/vdso32.S
	arch/x86/vdso/vdsp32/
 - "drivers/scsi/megaraid"
	drivers/scsi/megaraid.c
	drivers/scsi/megaraid.h
	drivers/scsi/megaraid/
 - "include/linux/i2c"
	include/linux/i2c-algo-bit.h
	include/linux/i2c-algo-pca.h
	include/linux/i2c-algo-pcf.h
	include/linux/i2c-dev.h
	include/linux/i2c-gpio.h
	include/linux/i2c-id.h
	include/linux/i2c-ocores.h
	include/linux/i2c-pca-platform.h
	include/linux/i2c-pnx.h
	include/linux/i2c-pxa.h
	include/linux/i2c.h
	include/linux/i2c/

etc (for a total of 45 cases in the whole kernel, if I did my script 
right), where we'd loop a few times. But we'd spend more effort trying to 
avoid looping than we spend now on the loop.

		Linus
