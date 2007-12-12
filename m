From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 18:39:38 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111834510.25032@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com> <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org> <7vprxcdhis.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0712111523210.25032@woody.linux-foundation.org> <alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>
 <7vwsrkbuje.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0712111816220.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 03:40:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2HWW-0002OK-0j
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 03:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbXLLCkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 21:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbXLLCkN
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 21:40:13 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53466 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751446AbXLLCkM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 21:40:12 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBC2ddCZ012646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 18:39:40 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBC2dcUl021358;
	Tue, 11 Dec 2007 18:39:38 -0800
In-Reply-To: <alpine.LFD.0.9999.0712111816220.25032@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67985>



On Tue, 11 Dec 2007, Linus Torvalds wrote:
> 
> But no, I didn't create a test-case.

This *should* trigger the special case:

	mkdir test-dir
	cd test-dir
	git init
	(echo -n a ; yes '' | dd count=2) > file
	git add file
	git commit -m "'a' + 1k newlines"
	(echo -n b ; yes '' | dd count=2) > file
	git add file
	git commit -m "'b' + 1k newlines"

and it all seems to work fine.

But I didn't actually check that it really triggered, this is just 
creating a 1025-byte file that has a single character and then 1024 
newlines. So when the logic removes the shared tail (all the newlines), it 
leaves a single-character newlineless buffer for diff, and no, git-blame 
didn't care, and got the right answer.

			Linus
