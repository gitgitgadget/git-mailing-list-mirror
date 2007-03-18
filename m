From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [RFH] straightening out "read-tree -m"
Date: Sun, 18 Mar 2007 16:20:59 -0700
Message-ID: <45FDC95B.5020106@midwinter.com>
References: <7vtzwjnhcb.fsf@assigned-by-dhcp.cox.net>	<20070318121810.GA17807@moooo.ath.cx> <7v8xdul2rt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 00:21:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT4gO-0001sb-88
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 00:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbXCRXU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 19:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933228AbXCRXU6
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 19:20:58 -0400
Received: from tater.midwinter.com ([216.32.86.90]:60368 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751722AbXCRXU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 19:20:57 -0400
Received: (qmail 2007 invoked from network); 18 Mar 2007 23:20:56 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.135?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 18 Mar 2007 23:20:56 -0000
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7v8xdul2rt.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42541>

Junio C Hamano wrote:
> In any case, the reason why for full two years this switching
> between branches that have "foo/" and "foo" never surfaced as an
> issue is that people are saner than doing that in practice (and
> I think people coming from CVS couldn't do that before so they
> may not even think about doing so).
>   

I can at least give you some insight into the real-world scenario that 
led to the current discussion. It's only slightly insane. :) We had a 
shell script called "foo" in our source directory. It had to turn into a 
multi-source-file app for various reasons. So the standalone script got 
replaced with a directory "foo" containing the source files.

I suppose one could argue that we should have called the original 
"foo.sh" or something and renamed it to "foo" at build/deploy time, but 
given that extensions aren't required on shell scripts (and that we have 
zillions of other scripts happily living without extensions) I suppose 
that just felt unnecessary.

By the way, Subversion required that we do this in two separate commits, 
the first to delete the shell script and the second to make the 
directory with the files in it. We originally tried to do both in one 
commit and it got confused. Then, some time after we'd done the separate 
commits in svn, we updated our git-svn repositories and ran into the 
problem.

In fact, when we tried to merge in the batch of changes from the git-svn 
tracking branch, we also ran into merge problems. Git got rather 
confused and the merge started complaining about files being untracked 
when in fact they were tracked in both branches! It looked like the 
index and/or working copy were left in an inconsistent state when the 
merge engine bailed out on the file-to-directory transition.

On my to-do list for next week is to try to come up with a minimally 
complex test case to demonstrate the problem, as the actual repositories 
in question are pretty convoluted and there were a bunch of other 
unrelated changes. I didn't mention it before now because I knew my 
description was certain to be too vague to be useful without a test case 
to look at.

We ended up successfully doing the merge by doing exactly what we had to 
do on the Subversion side: first explicitly merge up to the "delete the 
file" revision, then merge the "create the directory" revision. After 
that git was able to successfully fast-forward us through the subsequent 
revisions.

-Steve
