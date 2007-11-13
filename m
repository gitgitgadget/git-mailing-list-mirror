From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Strange "beagle" interaction..
Date: Tue, 13 Nov 2007 12:56:19 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711131241050.2786@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:57:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is2pA-0004nR-9P
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070AbXKMU5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757678AbXKMU5P
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:57:15 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33577 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755672AbXKMU5O (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2007 15:57:14 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lADKuK3x007715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 13 Nov 2007 12:56:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lADKuJ6L003692;
	Tue, 13 Nov 2007 12:56:19 -0800
X-Spam-Status: No, hits=-2.736 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64863>


Ok, I've made a bugzilla entry for this for the Fedora people, but I 
thought I'd mention something I noticed yesterday but only tracked down 
today: it seems like the beagle file indexing code is able to screw up git 
in subtle ways.

I do not know exactly what happens, but the symptoms are random (and 
quite hard-to-trigger) dirty index contents where git believes that some 
set of files are not clean in the index.

I *suspect* that beagle is playing games with the file access times, 
causing the ctime on disk to not match the ce_ctime in the index file. But 
that's just a guess.

I'm posting here in case somebody on the list knows what beagle does, or 
somebody has been bitten by strange behaviour and realizes that he has 
beagle running and prefers to fix the problem by just disabling beagle 
(which will also be a great boon for performance - beagle seems to be very 
good at flushing your file caches, but I guess that's not a bug, but a 
"feature").

The easiest way I have found so far to trigger this is to run

	while ./t7003-filter-branch.sh -i; do echo ok; done

in the git t/ directory, while at the same time telling beagle to index 
just that git/t/ directory. That seems to trigger a failure on subtest 17 
fairly reliably (not the first time through the loop, but *eventually* - 
it takes a few minutes). I think it's because "git filter-branch" requires 
the index to be clean.

(But I've also seen it fail on subtest 4).

I opened bugzilla

	https://bugzilla.redhat.com/show_bug.cgi?id=380791

for this, since I consider it a beagle bug (indexing shouldn't change 
directory state, and if beagle wants to avoid changing access times, it 
should use O_NOATIME). But I don't actually know exactly what it is that 
causes problems, so if somebody is interested and tries to figure this 
out, that would probably be good.

			Linus
