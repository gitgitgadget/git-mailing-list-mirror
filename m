From: Dan Fabulich <dan@fabulich.com>
Subject: Bug report: OS X git-merge deletes recapitalized files when rename detection fails
Date: Thu, 10 Oct 2013 15:46:34 -0700
Message-ID: <83737702-F966-457E-A77D-85CCD06FFECA@fabulich.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 11 00:46:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUP0C-0002Ow-EP
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 00:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495Ab3JJWqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 18:46:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59787 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751857Ab3JJWqf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 18:46:35 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9FC89223DD
	for <git@vger.kernel.org>; Thu, 10 Oct 2013 18:46:33 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 10 Oct 2013 18:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:content-type
	:content-transfer-encoding:subject:message-id:date:to
	:mime-version; s=smtpout; bh=FXAVMa0kteXsqds/CX/2iAKEG7g=; b=EIm
	FJcn0B1BryylyewsHsPt89JVP2zaUuwaQLdkioDzJGWcULoNXlgXaALYB3l9kQ1i
	o2fNf2ibFfrfAiQUQE2QSuWt1ehkUOmWaxuiS052q3MxSo0wr6LhCY3poSY9E6wx
	8BoPl5AUIp7RYRUfEnP1mvf4DwRVIzVoggnRMJxE=
X-Sasl-enc: xtvA4D60tF3HHtTZ5WmJNgAtCuyGXf2oNIMz9XgtySog 1381445193
Received: from [10.5.8.42] (unknown [206.15.64.254])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1F38EC00E80
	for <git@vger.kernel.org>; Thu, 10 Oct 2013 18:46:33 -0400 (EDT)
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235889>

On case-insensitive filesystems, git-merge deletes files that were recapitalized in another branch if rename detection fails.

To repro: Run this script with git 1.8.4 on a case-insensitive filesystem. It repros for me on the default HFS filesystem on OS X 10.8, and also on Win7 NTFS.

#!/bin/sh -x
# create git repo
git --version
rm -rf caps
git init caps
cd caps
git config --get core.ignorecase
# commit empty file called "file"
echo file > file
git add .
git commit -am "initial commit"
# create branch called "branch"
git branch branch
# rename "file" to "File"
# using --force per http://stackoverflow.com/questions/6899582
git mv --force file File
echo "completely different content" > File
git commit -am "renamed to File"
# switch to branch, make a non-conflicting commit
git checkout branch
echo newfile > newfile
git add .
git commit -am "branch commit"
# merge master into branch, commit merge
git merge --verbose --commit --no-edit master
ls File
git status

Actual: At the end of the script, the renamed File has been deleted by git-merge. "ls: File: No such file or directory" According to git-status, the deletion is not yet staged.

Expected: There should be no untracked changes at the end of this script. The script runs as expected on Linux or case-sensitive HFS.

-Dan Fabulich

P.S. On case-insensitive HFS, git-init will automatically set core.ignorecase to true. For the sake of the experiment, I also tried setting core.ignorecase to false in the test repository.

When I did that, I was unable to even checkout the "branch" branch without using --force. ("The following untracked working tree files would be overwritten by checkout: file" But git-status reported no untracked changes.)

And then, once I did use force to switch to the branch, I was unable to merge from master at all. ("The following untracked working tree files would be overwritten by merge: File" But again, git-status reported no untracked changes.)
