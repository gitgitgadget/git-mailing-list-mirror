From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: performance problem: "git commit filename"
Date: Sun, 13 Jan 2008 00:38:51 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801130028460.13593@iabervon.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 06:39:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDvZ5-0004uZ-3a
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 06:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbYAMFix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 00:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbYAMFix
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 00:38:53 -0500
Received: from iabervon.org ([66.92.72.58]:52797 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbYAMFix (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 00:38:53 -0500
Received: (qmail 2868 invoked by uid 1000); 13 Jan 2008 05:38:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Jan 2008 05:38:51 -0000
In-Reply-To: <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70369>

On Sat, 12 Jan 2008, Linus Torvalds wrote:

> It makes builtin-commit.c use the same logic that "git read-tree -i -m" 
> does (which is what the old shell script did), and it seems to pass the 
> test-suite, and it looks pretty obvious.

The only issue I know about with using unpack_trees in C as a replacement 
for read-tree in shell is that unpack_trees leaves "deletion" index 
entries in memory which are not written to disk, but may surprise some 
code (these are used to allow -u to remove the files from the working 
tree). So you may want to make sure that you don't get any weird results 
out of a commit of particular files that involves not committing some 
newly-added files:

$ git add new-file
$ (edit old-file)
$ git commit old-file

This may cause the unpack_trees to leave a misleading entry for new-file 
that the code doesn't expect. I've got a patch to make it saner as part of 
my builtin-checkout series, but I can't say for sure that that change 
won't either confuse something else or have performance problems without a 
bunch of analysis I haven't done recently.

	-Daniel
*This .sig left intentionally blank*
