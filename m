From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [RFC] Replace rebase with filtering
Date: Tue, 16 Jan 2007 11:43:35 -0800
Message-ID: <45AD2AE7.2010908@midwinter.com>
References: <45AC3B5D.6080700@midwinter.com> <Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45AD2568.4040408@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 20:43:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6uDe-00058M-Hg
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 20:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbXAPTnh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 14:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbXAPTnh
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 14:43:37 -0500
Received: from tater.midwinter.com ([216.32.86.90]:42924 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751304AbXAPTng (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 14:43:36 -0500
Received: (qmail 27247 invoked from network); 16 Jan 2007 19:43:35 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.131?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 16 Jan 2007 19:43:35 -0000
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <45AD2568.4040408@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36955>

Steven Grimm wrote:
> Johannes Schindelin wrote:
>> I had the impression that the use of "--ignore-if-in-upstream" in 
>> git-rebase avoids exactly this case: re-applying changes which are 
>> already in upstream.  
> Where's that option documented? The manpage makes no mention of it at 
> all.

Ah, okay, poking around in the git-rebase source, I see you mean that 
git-format-patch is called with that option. Gotcha. The problem is that 
after a rebase, the revisions in question *aren't* in the upstream. 
Here's my understanding of why. Say I have this in my integration 
repository:

a---b---c---d (master)
 \
  e---f---g   (integration)

Now, I rebase the integration branch onto master:

a---b---c---d
             \
              e'---f'---g'

The problem is that, since e' contains all the changes in e *and* in 
b/c/d, it does not have the same SHA1 as the original e revision, nor in 
fact the same hash as any of the revisions in the pre-rebase tree. And 
after rebase succeeds, it wipes the original e, f, and g from the 
history of the integration branch.

When a clone fetches e', f', and g' from this repo and tries to rebase 
onto the integration branch, git-format-patch will think b, c, and d are 
new (correct) but also that e', f', and g' are new. Since they have 
previously unknown hashes and there's no record of the original e, f, 
and g or their relation to the new revisions -- at least, no record that 
gets pulled down to the clone when it fetches -- there's no way for 
git-format-patch to know that it has already applied those changes.

As always, correct me if I'm wrong -- that's my understanding of the 
problem with rebasing in a parent repository.

-Steve
