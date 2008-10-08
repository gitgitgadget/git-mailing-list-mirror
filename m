From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-who
Date: Wed, 8 Oct 2008 11:35:53 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810081119490.3208@nehalem.linux-foundation.org>
References: <DE2CF127-A7FD-4765-A8E4-5235C5F1B9A9@gmail.com> <48EC4F9D.4020202@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Rhodes, Kate" <masukomi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 08 20:38:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knduj-0000Vd-SJ
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 20:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649AbYJHSg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 14:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754582AbYJHSg0
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 14:36:26 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38772 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754580AbYJHSgZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Oct 2008 14:36:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m98IZsMI007734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Oct 2008 11:35:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m98IZrk3001418;
	Wed, 8 Oct 2008 11:35:54 -0700
In-Reply-To: <48EC4F9D.4020202@viscovery.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.435 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97806>



On Wed, 8 Oct 2008, Johannes Sixt wrote:
> 
> Wouldn't
> 
>    git shortlog -s -- path/to/file

I suspect "-sn" is better. It sorts by number rather than by name, and if 
you're interested in who has touched a file, you probably wants to know 
who has touched it _most_.

And as usual, the nice thing about it is that all the normal git rules 
apply, so you can do it by multiple files or subdirectories, and you can 
filter by time. And ignore merges, since they tend to be about upper-level 
maintainers than about the people doing patches.

So for the kernel, you can do something like

	git shortlog -ns --no-merges --since=6.months.ago drivers/scsi include/scsi

and see who has been doing scsi-related stuff lately.

Of course, when it comes to relevance, it may be more interesting to just 
look at 'git blame' output, and then you're limited to single files at a  
time. And performance is going to be a problem, especially if you enable 
movement detection. 

But we don't have anything special for that. You can do it with something 
like

	git blame -M -w kernel/sched.c |
		grep -v '^^' |
		cut -d'(' -f2- |
		cut -c1-20 |
		sort |
		uniq -c |
		sort -n

which will ignore the root commit (so as not to give me all the credit for 
old history), but it would probably be better (but more complex - need 
perl or some other "real" language with associative arrays etc to remember 
the commit information) to parse the output of "git blame --incremental" 
instead.

		Linus
