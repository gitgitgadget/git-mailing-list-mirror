From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Hacks for AIX
Date: Wed, 16 Jul 2008 11:26:28 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807161117460.2835@woody.linux-foundation.org>
References: <5855afd30807161057v54ed4112jaea3bc07cebf44d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Chris Cowan <chris.o.cowan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 20:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJBir-0006qW-Qt
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 20:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbYGPS0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615AbYGPS0b
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:26:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52320 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753172AbYGPS0a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jul 2008 14:26:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6GIQSvv022806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jul 2008 11:26:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6GIQSrD006509;
	Wed, 16 Jul 2008 11:26:28 -0700
In-Reply-To: <5855afd30807161057v54ed4112jaea3bc07cebf44d4@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.409 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88711>



On Wed, 16 Jul 2008, Chris Cowan wrote:
> 
> I also saw one instance where the behavior of git-grep was affected by
> the grep selected at build time.    I'm not sure if there's other
> instances within the code base, but I'm wondering whether the
> configure script can be changed to do the check for /usr/linux/bin and
> use those versions?   I can imagine that similar problems may occur on
> Solaris and HPUX.

The grep selection at compile time is purely a choice between "no external 
grep at all" and "whatever external grep is in $PATH".

exec_grep() literally does

	..
	pid = fork();
	if (pid < 0)
		return pid;
	if (!pid) {
		execvp("grep", (char **) argv);
		exit(255);
	}
	..

so you can choose your version of external grep at run-time by just 
setting PATH appropriately.

Or you can just decide that you don't want to use any external grep binary 
at all, which is the compile-time choice of NO_EXTERNAL_GREP. In that 
case, git will do the grep implementation all internally. It can do so, 
but then it relies on the regex() library which is often less optimized 
than the external grep.

Note the "often". It's possible that the external grep is never worth it, 
in which case you should use NO_EXTERNAL_GREP. GNU grep happens to be very 
good.

Even with an external grep configured in, you'll end up using the internal 
one for the case where you ask for the index information ("--cached") or 
when you ask for a particular version of the tree rather than the 
checked-out tree. So regardless, you'll fall back to the internal version 
for some things.

			Linus
