From: Tim Harper <timcharper@gmail.com>
Subject: using rev-list to tell if a branch is behind or ahead
Date: Tue, 20 May 2008 14:14:46 -0600
Message-ID: <3703BF54-3619-432F-8B65-09AF17299CAD@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 22:15:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyYFO-0007jS-Gb
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 22:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761236AbYETUOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 16:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760200AbYETUOx
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 16:14:53 -0400
Received: from rn-out-0910.google.com ([64.233.170.186]:47466 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759262AbYETUOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 16:14:52 -0400
Received: by rn-out-0910.google.com with SMTP id k40so174940rnd.17
        for <git@vger.kernel.org>; Tue, 20 May 2008 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=WeXzxSqqjFwg25V24s01nLY0tHLFdLY7OOqiTOoLkV4=;
        b=sOayNsnxCvLKAp5WEJQsL43rbQUw5JgfVpghwI70IAKUPay++2qLYSS8SPF2TK3aY+Z5AG8g4niOrEu5VPRMLTaaSmqZLyaNvGKHQ1BMBsY0BmmbOHD0JxiB1tGC8El9t6O0bhJAVMwCdPsPTitWZVFL1HG8CYVY0WmuC+vPO9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=lL8Of00vGU0aF0bgdtsMZU0nVmtpztxj0hNUC0Rpq8TLvzmMBKe74Iq6RyO9igDvXj6zB4t9UoAo7sL5nHN6eBGxVkbOiUpaOS89nVlVM2+qzJv6BcRNc0feEporv7RE+tF+1w2g9jCDb3TDjFdhXF20vvp4h3r6tsJI6PdIw34=
Received: by 10.142.213.9 with SMTP id l9mr3509511wfg.180.1211314490585;
        Tue, 20 May 2008 13:14:50 -0700 (PDT)
Received: from timcharper.SME ( [168.103.178.89])
        by mx.google.com with ESMTPS id 27sm933057wff.7.2008.05.20.13.14.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 May 2008 13:14:49 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82496>

I'm implementing a ruby interface to git and am wanting to be able to  
ask if a branch is ahead or behind.

I looked in the builtin-checkout.c file and see this code:

	/* Run "rev-list --left-right ours...theirs" internally... */
	rev_argc = 0;
	rev_argv[rev_argc++] = NULL;
	rev_argv[rev_argc++] = "--left-right";
	rev_argv[rev_argc++] = symmetric;
	rev_argv[rev_argc++] = "--";
	rev_argv[rev_argc] = NULL;

	strcpy(symmetric, sha1_to_hex(ours->object.sha1));
	strcpy(symmetric + 40, "...");
	strcpy(symmetric + 43, sha1_to_hex(theirs->object.sha1));

	init_revisions(&revs, NULL);
	setup_revisions(rev_argc, rev_argv, &revs, NULL);
	prepare_revision_walk(&revs);

	/* ... and count the commits on each side. */
	num_ours = 0;
	num_theirs = 0;
	while (1) {
		struct commit *c = get_revision(&revs);
		if (!c)
			break;
		if (c->object.flags & SYMMETRIC_LEFT)
			num_ours++;
		else
			num_theirs++;
	}


It looks like it's calling rev-parse.  But, when I call it with the  
same arguments (using branches or commit sha1's), it only will list  
commits that are in right and not in left.  I need it to show both  
ways: commits that are in the right and not in left, and commits that  
are in the left but not in right.

Do I need to call rev-parse twice to achieve this?

Here's a sample of what I'm trying currently:
~ $ mkdir test
~ $ cd test/
~/test $ git init
Initialized empty Git repository in .git/
~/test $ git
~/test $ echo content > file.txt
~/test $ git add file.txt && git commit -m "Initial commit"
Created initial commit f5e4160: Initial commit
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 file.txt
~/test master$ git co -b task
Switched to a new branch "task"
~/test task$ echo changes >> file.txt
~/test task$ git add file.txt && git commit -m "Some changes"
Created commit 96492ee: Some changes
  1 files changed, 1 insertions(+), 0 deletions(-)
~/test task$ git rev-list --left-right task..master --
~/test task$ git rev-list --left-right master..task --
 >96492ee80143f43417b00699ff29330d0027df7f


Thanks,

Tim
