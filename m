X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Using git as a general backup mechanism (was Re: Using GIT to store
 /etc)
Date: Tue, 12 Dec 2006 14:49:10 -0800
Message-ID: <457F31E6.8090701@midwinter.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <Pine.LNX.4.64.0612111837210.20138@iabervon.org> <8900B938-1360-4A67-AB15-C9E84255107B@mac.com> <200612121553.37499.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 22:49:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=ckk46LG/3o8BMHZsWdyw4Yb+MnpF76tJp7dUI9eXXscVC8e8WQmbiNegmj8RELOO  ;
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <200612121553.37499.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34159>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGQv-0007lA-LL for gcvg-git@gmane.org; Tue, 12 Dec
 2006 23:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932538AbWLLWtG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 17:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWLLWtG
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 17:49:06 -0500
Received: from tater.midwinter.com ([216.32.86.90]:37718 "HELO midwinter.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932538AbWLLWtD
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 17:49:03 -0500
Received: (qmail 11347 invoked from network); 12 Dec 2006 22:49:02 -0000
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1) by localhost
 with SMTP; 12 Dec 2006 22:49:02 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This discussion reminds me of a use of git I've had in the back of my 
head to try out for a while. Right now I'm doing my local snapshot 
backups using the rsync-with-hard-links scheme 
(http://www.mikerubel.org/computers/rsync_snapshots/ if you're not 
familiar with it). This is nice in that the contents of files that don't 
change are only stored once on the backup disk. But it is less than 
optimal in that a file that changes even a little bit is stored from 
scratch.

What would be great for this would be to store each day's backup as a 
git revision; with a periodic repack, this would be much more 
space-efficient than the rsync hard links.

The problem is that while that would give me a very efficient backup 
scheme, the repository would still grow over time. In rsync land, I 
solve the disk space issue by keeping two weeks' worth of daily 
snapshots, then six months' worth of weekly snapshots, then two years' 
worth of monthly snapshots; files that change daily have a constant 
number of revisions stored in my backups, and older files drop off the 
backup disk as they age.

Given that there's no way (or is there?) to delete revisions from the 
*beginning* of a git revision history, right now it seems like the only 
approach that comes close is to give up on the "daily then weekly then 
monthly" thing -- probably fine given the space savings of delta 
compression -- and periodically make shallow clones of the backup 
repository that fetch all but the first N revisions; once a shallow 
clone is made, the original gets deleted and the clone is the new backup 
repo.

But it would sure be more efficient to be able to "shallow-ize" an 
existing repository. That would be useful for things other than backups, 
too, e.g. the recent request for some way to track just the current 
version of the kernel code rather than its revision history. If there 
were a shallowize command, you could do something like "git pull; git 
shallowize --depth 1" to track the latest revision without keeping the 
history locally.

Anyone think that sounds like an interesting thing to explore?

-Steve
