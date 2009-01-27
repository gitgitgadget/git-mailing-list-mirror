From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Valgrind updates
Date: Mon, 26 Jan 2009 19:38:56 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain>
References: <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer> <20090121190757.GB21686@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 04:40:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LReoW-0005u8-N9
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 04:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbZA0DjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 22:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbZA0DjL
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 22:39:11 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37467 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751798AbZA0DjK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2009 22:39:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0R3cvN8005831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Jan 2009 19:38:58 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0R3cuUv006336;
	Mon, 26 Jan 2009 19:38:56 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107302>



On Tue, 27 Jan 2009, Johannes Schindelin wrote:
> 
> Just that much, most of the backtraces are pretty repetitive.  In fact, I 
> think most if not all of them touch xwrite.c (I got other errors from my 
> patches, as I expected).
> 
> ==valgrind== Syscall param write(buf) points to uninitialised byte(s)
> ==valgrind==    at 0x5609E40: __write_nocancel (in /lib/libpthread-2.6.1.so)
> ==valgrind==    by 0x4D0380: xwrite (wrapper.c:129)
> ==valgrind==    by 0x4D046E: write_in_full (wrapper.c:159)
> ==valgrind==    by 0x4C0697: write_buffer (sha1_file.c:2275)
> ==valgrind==    by 0x4C0B1C: write_loose_object (sha1_file.c:2387)

Looks entirely bogus.

I suspect that valgrind for some reason doesn't see the writes made by 
zlib as being initialization, possibly due to some incorrect valgrind 
annotations on deflate().  We've just totally initialized that whole 
buffer with deflate().

It definitely does not look like a git bug, but a valgrind run issue.

		Linus
