From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 13:34:10 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111323270.25032@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>  <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>  <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>  <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
  <alpine.LFD.0.9999.0712111146200.25032@woody.linux-foundation.org> <4aca3dc20712111314wf4525l790120dce29a9bc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Berlin <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 22:35:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Ckx-0000Vr-CC
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbXLKVeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbXLKVet
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:34:49 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50193 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751799AbXLKVet (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 16:34:49 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBLYA97029861
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 13:34:11 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBLYABn009976;
	Tue, 11 Dec 2007 13:34:10 -0800
In-Reply-To: <4aca3dc20712111314wf4525l790120dce29a9bc5@mail.gmail.com>
X-Spam-Status: No, hits=-2.416 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_33
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67951>



On Tue, 11 Dec 2007, Daniel Berlin wrote:
> 
> You theroetically can generate blame info from SVN/GIT's block deltas,
> but you of course, have the problem GIT does, which is that the delta
> is not meant to represent the actual changes that occurred, but
> instead, the smallest way to reconstruct data x from data y.
> This only sometimes has any relation to how the file actually changed

Exactly. Git objects in themselves have no history or relationships, and 
being a delta against another object means nothing at all except for the 
fact that the data seems to resemble that other object (which has a 
_correlation_ with being related, but nothign more).

Anyway, I think the git annotate memory usage was simpyl just a real bug 
that nobody had noticed before because the memory leak wasn't all that 
noticeable with smaller files and/or less deep histories. Can'you verify 
that it works for you with the patch I sent out?

With that fix, I could even run 

	git blame -C gcc/ChangeLog-2000

to see the blame machinery work past the strange "combine many different 
changelogs into year-based ones" commit. Now, I cannot honestly claim that 
it was really *usable* (it did take three minutes to run!), but sometimes 
those three minutes of CPU time may be worth it, if it shows the real 
historical context it came from. 

In the case of the ChangeLog-2000 file, all the original lines obviously 
came from older versions of a file called "gcc/ChangeLog", so the end 
result doesn't really show what an involved situation it was to track the 
sources back through not just renames, but actually file splits and 
merges. Sad, but once you know what it did it's still a bit cool to see 
that it worked ;)

			Linus
