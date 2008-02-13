From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM
Date: Tue, 12 Feb 2008 18:06:37 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802121758220.2920@woody.linux-foundation.org>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org> <alpine.LSU.1.00.0802130003370.3870@racer.site> <alpine.LSU.1.00.0802130108060.3870@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, Voltage Spike <voltspike@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 13 03:07:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP720-00089W-DX
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 03:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbYBMCGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 21:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbYBMCGx
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 21:06:53 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47176 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753278AbYBMCGw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 21:06:52 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1D26crq022755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 18:06:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1D26bUU002558;
	Tue, 12 Feb 2008 18:06:37 -0800
In-Reply-To: <alpine.LSU.1.00.0802130108060.3870@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.741 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73737>



On Wed, 13 Feb 2008, Johannes Schindelin wrote:
> 
> With XDL_MERGE_ZEALOUS_ALNUM, we use the following heuristics: when a
> hunk does not contain any letters or digits, it is treated as conflicting.

Well, I think this is interesting in itself, but..

To some degree it would be even more interesting to at least partially 
separate the issue of "what conflicts" with the issue of "how do we 
express things when they _do_ conflict".

IOW, it's quite possible that we want to have the ZEALOUS algorithm for 
doing conflict resolution (on the assumption that we want aggressively 
merge), but then when conflicts happen _despite_ being zealous in the 
resolver, print out the resulting conflict with near-by conflicts merged 
into bigger block.

> In other words, a conflict which used to look like this:
> 
> 	<<<<<<<
> 	if (a == 1)
> 	=======
> 	if (a == 2)
> 	>>>>>>>
> 	{
> 	<<<<<<<
> 		b = 2;
> 	=======
> 		b = 1;
> 	>>>>>>>
> 
> will look like this with ZEALOUS_ALNUM:
> 
> 	<<<<<<<
> 	if (a == 1)
> 	{
> 		b = 2;
> 	=======
> 	if (a == 2)
> 	{
> 		b = 1;
> 	>>>>>>>

I think this is an improvement already, but to take the example that 
voltspike had:

 <<<<<<< HEAD:file.txt
 void newfunc1()
 =======
 void newfunc2()
 >>>>>>> merge:file.txt
 {
   int err;
 <<<<<<< HEAD:file.txt
   err = doSomething();
 =======
   err = doSomethingElse();
 >>>>>>> merge:file.txt

this does have alnum's in the shared region ("int err") so it wouldn't 
have been modified by this, but it would be nice to notice: "there were 
just two small lines between two conflicts, and we could actually make the 
final conflict marker _smaller_ by merging them", and just doing the 
reverse of xdl_refine_conflicts(), and do a "xdl_merge_conflicts()" before 
printout, and get

 <<<<<<< HEAD:file.txt
 void newfunc1()
 {
   int err;
   err = doSomething();
 =======
 void newfunc2()
 {
   int err;
   err = doSomethingElse();
 >>>>>>> merge:file.txt

(note how this really *is* smaller: it's 11 lines rather than 12 lines, 
because while we had to duplicate the two common lines in between the 
conflicts (+2), we got rid of the three marker lines (-3), giving us a net 
win of one line.

So the "merge adjacent conflicts" logic should actually be pretty simple: 
if there is less than three lines between two conflicts, the conflicts 
should always be merged, because the end result is smaller.

(And with three lines in between the end result is as many lines, but 
arguably simpler, so it's probably better to merge then too).

Hmm? What do you think?

			Linus
