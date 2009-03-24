From: Adam Heath <doogie@brainfood.com>
Subject: Re: large(25G) repository in git
Date: Tue, 24 Mar 2009 12:59:35 -0500
Message-ID: <49C91F87.3050105@brainfood.com>
References: <49C7FAB3.7080301@brainfood.com> <alpine.LFD.2.00.0903232056520.26337@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 19:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmAwn-0002HZ-Cc
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 19:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760291AbZCXR7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 13:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760448AbZCXR7p
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 13:59:45 -0400
Received: from newmail.brainfood.com ([70.103.162.5]:55499 "EHLO
	newmail.brainfood.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759369AbZCXR7n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 13:59:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by newmail.brainfood.com (Postfix) with ESMTP id B7EDDF8928;
	Tue, 24 Mar 2009 12:59:40 -0500 (CDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 0.101
X-Spam-Level: 
X-Spam-Status: No, score=0.101 tagged_above=-10 required=6.6
	tests=[BAYES_50=0.001, RDNS_DYNAMIC=0.1]
Received: from newmail.brainfood.com ([127.0.0.1])
	by localhost (newmail.brainfood.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ibs5i1TJHOiQ; Tue, 24 Mar 2009 12:59:36 -0500 (CDT)
Received: from [192.168.2.49] (70-103-162-249.brainfood.com [70.103.162.249])
	by newmail.brainfood.com (Postfix) with ESMTP id 0333AF88A9;
	Tue, 24 Mar 2009 12:59:35 -0500 (CDT)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <alpine.LFD.2.00.0903232056520.26337@xanadu.home>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114475>

Nicolas Pitre wrote:

> Strange.  You could instruct ssh to keep the connection up with the 
> ServerAliveInterval option (see the ssh_config man page).

Sure, could do that.  Already have a separate ssh config entry for
this host.  But why should a connection be kept open for that long?
Why not close and re-open?

Consider the case of other protocol access.  http/git/ssh.  Should
they *all* be changed to allow for this?  Wouldn't it be simpler to
just make git smarter?

>> So, to work around that, I ran git gc.  When done, I discovered that
>> git repacked the *entire* repository.  While not something I care for,
>> I can understand that, and live with it.  It just took *hours* to do so.
>>
>> Then, what really annoys me, is that when I finally did the push, it
>> tried sending the single 27G pack file, when the remote already had
>> 25G of the repository in several different packs(the site was an
>> hg->git conversion).  This part is just unacceptable.
> 
> This shouldn't happen either.  When pushing, git reconstruct a pack with 
> only the necessary objects to transmit.  Are you sure it was really 
> trying to send a 27G pack?

Of course I'm sure.  I wouldn't have sent the email if it didn't
happen.  And, I have the bandwidthd graph and lost time to prove it.

After I ran git push, ssh timed out, the temp pack that was created
was then removed, as git complained about the connection being gone.

I then decided to do a 'git gc', which collapsed all the separate
packs into one.  This allowed git push to proceed quickly, but at that
point, it started sending the entire pack.

It's entirely possible that the temp pack created by git push was
incremental; it just took too long to create it, so it got aborted.

But, doing git gc shouldn't cause things to be resent.

The machines in question have done push before.  Even small amounts;
just the set of objects that are newer.  It's just this time, when the
1.6G of new data was added, git ended up creating a new pack file,
that contained the entire repo, and then tried sending that.

I forgot to mention previously, that the source machine was running
git 1.5.6.5, and was pushing to 1.5.6.3.

I've tried duplicating this problem on a machine with 1.6.1.3, but
either I don't fully understand the issue enough to replicate it, or
the newer git doesn't have the problem.

>> 2: Is there an option to tell git to *not* be so thorough when trying
>> to find similiar files.  videos/doc/pdf/etc aren't always very
>> deltafiable, so I'd be happy to just do full content compares.
> 
> Look at the gitattribute documentation.  One thing that the doc appears 
> to be missing is information about the "delta" attribute.  You can 
> disable delta compression on a file pattern that way.

Um, if it's missing documentation, then how am I supposed to know
about it?  google does give me info, tho.  Thanks for the pointer.

> 
>> 3: delta packs seem to be poorly done.  it seems that if one repo gets
>> repacked completely, that the entire new pack gets sent, when the
>> target has most of the objects already.
> 
> This is not supposed to happen.  Please provide more details if you can.

Well, I haven't been able to replicate it with a script.  I might have
to actually clone this huge repo, do history removal, and reapply the
changes, just to see if I can get it to fail.  But that will take time.
