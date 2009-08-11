From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: block-sha1: improve code on large-register-set machines
Date: Tue, 11 Aug 2009 15:57:10 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908111553460.28882@localhost.localdomain>
References: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain> <alpine.LFD.2.00.0908102246210.10633@xanadu.home> <alpine.LFD.2.01.0908110758160.3417@localhost.localdomain> <alpine.LFD.2.00.0908111254290.10633@xanadu.home> <alpine.LFD.2.00.0908111517390.10633@xanadu.home>
 <fLYKSyures_wcvAvAV9-MgKQlhk959HJpx-pKz7T1n-Mel7f2RBkMw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 12 00:58:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb0IY-0001xI-0C
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 00:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbZHKW6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 18:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbZHKW6V
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 18:58:21 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37323 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754124AbZHKW6U (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 18:58:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7BMvBCm023037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Aug 2009 15:57:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7BMvADW006494;
	Tue, 11 Aug 2009 15:57:11 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <fLYKSyures_wcvAvAV9-MgKQlhk959HJpx-pKz7T1n-Mel7f2RBkMw@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125613>



On Tue, 11 Aug 2009, Brandon Casey wrote:
> 
> In that case, why not change the interface of blk_SHA1Block() so that its
> second argument is const unsigned char* and get rid of __d and the { } ?

Because on big-endian, or on architectures like x86 that have an efficient 
byte swap, that would be horrible.

You absoluetoy MUST NOT do things a byte at a time in those cases. The 
memory operations and the shifting just kills you.

The reason you want to do things a byte at a time on ARM is that ARM 
cannot do unaligned accesses well (very modern cores are better, but 
rare), and that ARM has no bswap instruction and has fairly cheap shifts.

On no sane architecture is that true. Unaligned loads are fast (and quite 
frankly, hardware where unaliged loads aren't fast is just crazy sh*t), 
and doing 'bswap' is way faster than doing many shifts and masks.

So everything should be fundamentally word-oriented. Then, broken 
architectures that can't handle it should split up the words, not the 
other way around.

			Linus
