From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/7] block-sha1: improved SHA1 hashing
Date: Thu, 6 Aug 2009 08:13:44 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908060803140.3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 17:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ4fE-0007bh-3o
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 17:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983AbZHFPNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 11:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755935AbZHFPNr
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 11:13:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52159 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755949AbZHFPNq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 11:13:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FDjhS008225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 08:13:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n76FDiMK020367;
	Thu, 6 Aug 2009 08:13:45 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125079>


The bulk of this is the patches I sent out yesterday, but there's a few 
added tweaks from today there, and it's now one nice series instead of a 
patch followed by a "Haa, I improved on it" etc, so you can get the whole 
thing without actually having to hunt for the pieces.

It's a series of 7 patches:

      block-sha1: add new optimized C 'block-sha1' routines
      block-sha1: try to use rol/ror appropriately
      block-sha1: make the 'ntohl()' part of the first SHA1 loop
      block-sha1: re-use the temporary array as we calculate the SHA1
      block-sha1: macroize the rounds a bit further
      block-sha1: Use '(B&C)+(D&(B^C))' instead of '(B&C)|(D&(B|C))' in round 3
      block-sha1: get rid of redundant 'lenW' context

where the thing is loosely based on the Mozilla SHA1 routines but by the 
end doesn't really resemble them all that much. The Mozilla ones suck 
donkey d*ck in so many ways - unnecessary copies, idiotic byte-at-a-time 
build-up of the hash input etc.

The end result is pretty much equivalent in performance to the OpenSSL 
SHA1 code for me on x86-64. Getting rid of OpenSSL gets rid of another 
couple of shared library loadings, and as a result my "make -j64 test" is 
now a couple of seconds faster with this than with OpenSSL in my rather 
unscientific tests.

The code isn't very big:

 Makefile          |    9 +++
 block-sha1/sha1.c |  158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 block-sha1/sha1.h |   20 +++++++
 3 files changed, 187 insertions(+), 0 deletions(-)
 create mode 100644 block-sha1/sha1.c
 create mode 100644 block-sha1/sha1.h

and passes all my tests. It's really hard to not do the SHA1 right and 
still pass any tests at all, so it should all be good.

Enable them with BLK_SHA1=1.

		Linus
