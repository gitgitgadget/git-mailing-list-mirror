From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sun, 20 Jan 2008 14:09:26 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801201358280.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
 <alpine.LSU.1.00.0801200142170.5731@racer.site> <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de> <alpine.LFD.1.00.0801200942191.2957@woody.linux-foundation.org> <65FCA357-7F7E-4FE0-A423-2528A43B915D@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 20 23:10:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGiMj-0001AU-Rz
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 23:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930AbYATWJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 17:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755924AbYATWJk
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 17:09:40 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60282 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755915AbYATWJj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 17:09:39 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0KM9RUn029466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 Jan 2008 14:09:28 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0KM9QFK004959;
	Sun, 20 Jan 2008 14:09:26 -0800
In-Reply-To: <65FCA357-7F7E-4FE0-A423-2528A43B915D@zib.de>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.723 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71197>



On Sun, 20 Jan 2008, Steffen Prohaska wrote:
> > 
> > fnmatch? It's certainly visible on Linux, I wonder if the Windows/OSX
> > version is more expensive due to trying to be case-insensitive or
> > something?
> 
> So roughly 50% of the running time is spent in getdirentries
> and fnmatch on the MacBook Pro I used to run these tests.

Ok. That seems to explain it (I have some trouble reading/comparing your 
profiles against mine, but yeah, fnmatch and getdirentries seem to be 
excessive from that "invert call tree" thing.

On Linux, the fnmatch and readdir overhead is way down in the noise both 
before and after the lstat removal. So removing the lstat's - which were 
fairly cheap, but there were _lots_ of them, made more of a relative 
difference on Linux.

I don't know what can be done about that on OS X. We really can't avoid 
reading the directory tree and matching it against ignore files. That's 
very integral for the status generation of "git commit", after all.

Maybe there are better fnmatch libraries for OS X? But getdirentries() was 
the bigger cost, and I don't see any alternative for that.

			Linus
