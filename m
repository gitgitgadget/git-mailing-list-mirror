From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: Following history of a copied file from another indirect branch
Date: Thu, 21 Oct 2010 15:39:51 -0400
Message-ID: <9089D1F5-A19B-4030-A6ED-463F250E450B@gernhardtsoftware.com>
References: <4CC08AA5.8070502@workspacewhiz.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 21:40:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90za-00043B-RV
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 21:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab0JUTj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 15:39:57 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48750 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431Ab0JUTj4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 15:39:56 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 9D3D91FFC057; Thu, 21 Oct 2010 19:39:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 9C1391FFC057;
	Thu, 21 Oct 2010 19:39:47 +0000 (UTC)
In-Reply-To: <4CC08AA5.8070502@workspacewhiz.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159554>


On Oct 21, 2010, at 2:47 PM, Joshua Jensen wrote:

> It has become a necessity to copy a file from one long-lived branch to another.  It is not possible to merge the branches at this time.
> 
> I would like to have 'git gui blame' follow the copy back through its original history, but I don't believe Git has metadata for storing this.  Something along the lines of a 'followparent' in the commit object, for instance, would allow the revision walking code to wander the history down an alternate line.

Git stores no per-file metadata.  The closest we come is .gitattributes and .gitignore.

> By comparison, integrates work at a file level in Perforce.  That means I can integrate a file from one branch to another, and parentage is stored such that I can follow the file back through its history.
> 
> Are there any facilities to do this now?

Git simply does not have the idea of the history of a file.  Nothing in git will help merge "just a file" from one branch to another.  Either we have merged the two commits or not.

HOWEVER...

You can use git-filter-branch to create a new branch that contains only that single file and only the commits that affected it.  Something like the following (untested):

	# Merging "file" from branch "src" to branch "dest"
	git checkout -b temp src
	git filter-branch --prune-empty --index-filter="git read-tree --empty; git add file"
	# Since you describe the branch as "long-running", I'd suspect you'll have to wait a while here.
	git checkout dest
	git merge temp
	git branch -d temp
	git branch -D refs/original/temp

This will go faster if you have a ramdisk/tmpfs to perform the filtering in.  (git-filter-branch is very I/O intensive.)  Something like the following in place of the `git filter-branch` invocation above:

	mkdir /tmp/filter-branch # Assuming /tmp is tmpfs or similar
	git filter-branch -d /tmp/filter-branch --prune-empty --index-filter="git read-tree --empty; git add file"
	rm -rf /tmp/filter-branch

You could use --msg-filter to add the SHA-1 of the original commits to the "file history" branch.  Something like --msg-filter='cat;echo;echo From: $GIT_COMMIT'

I would recommend using cherry-pick to pull any further changes to the file across branches (be careful of commits that touch more than that file!).  I think git-filter-branch could be used to keep the one file branch up to date, but that is likely more effort than it's worth.  I would specifically advise against merging the single file branch into both "src" and "dest", as I think any later merge of the two would find these commits as a merge-base.

~~ Brian Gernhardt
