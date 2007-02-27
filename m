From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Broken dependencies..
Date: Tue, 27 Feb 2007 15:46:48 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271543080.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMC1j-0007kI-Ot
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbXB0Xqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbXB0Xqd
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:46:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:57597 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbXB0Xqc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:46:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1RNkThB022961
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 15:46:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1RNkSwJ000413;
	Tue, 27 Feb 2007 15:46:28 -0800
X-Spam-Status: No, hits=-0.443 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40851>


Try this on the current git archive:

	git checkout master
	make clean
	make
	...
	git checkout next
	make

and at least I get 

	...
	gcc -g -O2 -Wall  -DSHA1_HEADER='<openssl/sha.h>' -DETC_GITCONFIG='"/home/torvalds/etc/gitconfig"' -DNO_STRLCPY -o git-local-fetch   local-fetch.o fetch.o libgit.a xdiff/lib.a -lz  -lcrypto
	fetch.o: In function `process_object':
	/home/torvalds/git/fetch.c:137: undefined reference to `type_names'
	fetch.o: In function `typename':
	/home/torvalds/git/object.h:46: undefined reference to `type_names'
	collect2: ld returned 1 exit status

apparently because fetch.c wasn't recompiled and it used the old fetch.o.

Ugh. I take full blame for the Makefile being a total mess, and us not 
doing proper dependencies, but I'm too lazy to fix it. Any ideas on how to 
generate real dependency data so that we don't have these kinds of things 
(I bet there are other files than just fetch.c that lack the full header 
file dependencies, this one just happened to trigger now)?

		Linus
