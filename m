From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: 'git mailinfo' whitespace bug
Date: Thu, 18 Feb 2010 10:05:27 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1002180936240.4141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Thu Feb 18 19:06:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiAm4-000246-8Q
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 19:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab0BRSGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 13:06:20 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42060 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425Ab0BRSGS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 13:06:18 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o1II5S0V009817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Feb 2010 10:05:29 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o1II5RlF027307;
	Thu, 18 Feb 2010 10:05:27 -0800
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140352>


'git mailinfo' removes the whitespace from the beginning of the email 
body, but it does it incorrectly.

In particular, some people use indented paragraphs, like this:

	  Four-score and Four score and seven years ago our fathers 
   brought forth, upon this continent, a new nation, conceived in Liberty, 
   and dedicated to the proposition that all men are created equal.

	Now we are engaged in a great civil war, testing whether that 
   nation, or any nation so conceived, and so dedicated, can long endure. 
   We are met here on a great battlefield of that war. We have come to 
   dedicate a portion of it as a final resting place for those who here 
   gave their lives that that nation might live. It is altogether fitting 
   and proper that we should do this.

   ...

and mailinfo will not just remove empty lines from the beginning of the 
email body, it will also remove the _first_ indentation (but not any 
others). Which makes the whole thing come out wrong.

I bisected it, and this bug was introduced almost two years ago. In commit 
3b6121f69b2 ("git-mailinfo: use strbuf's instead of fixed buffers"), to be 
exact. I'm pretty sure the bug is that handle_commit_msg() was changed to 
use 'strbuf_ltrim()' for the 'still_looking' case.

Before commit 3b6121f69b2, it would create a new variable that had the 
trimmed results ("char *cp = line;"), after that commit it would just trim 
the line itself. Which is correct for the case of it being a header, but 
if it's the first non-header line, it's wrong.

			Linus
