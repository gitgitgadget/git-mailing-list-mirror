Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870A33E5
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 1674 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 05:32:01 PST
Received: from mail.inka.de (mail.inka.de [IPv6:2a04:c9c7:0:1073:217:a4ff:fe3b:e77c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB018F
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 05:32:01 -0800 (PST)
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1r0LkT-001X8l-Qm; Tue, 07 Nov 2023 14:04:05 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 746F3600B8; Tue,  7 Nov 2023 14:03:03 +0100 (CET)
Date: Tue, 7 Nov 2023 14:03:03 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Error when "git mv" file in a sparsed checkout
Message-ID: <20231107130303.GS7041@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hello,

I have used the procedure described below for many years. In fact,
this procedure is part of a script which I am using for about 10 years.
This procedure was definitely working with git-2-25-1 and git-2.26.2.

Now, with git-2.34.1 (on a freshly installed ubuntu-22.04), this
procedure fails.

Here is what I do:

I want to rename a file on a branch which is not currently checked out
without messing/touching my current working directory.

For this, I first create a clone of the repo with shared git-directory:

  $ SANDBOX=/var/tmp/manage-scans-X1pKZQiey
  $ WT=$SANDBOX/wt
  $ GIT=$SANDBOX/git

  $ mkdir -p $SANDBOX
  $ git --work-tree $WT --git-dir $GIT clone -qns -n ~/upstream-repo $GIT

Then, I do a sparse checkout in this clone, containing only the file
that is to be renamed:

  $ cd $WT
  $ echo 'path/to/old-filename' >>$GIT/info/sparse-checkout
  $ git --work-tree $WT --git-dir $GIT config core.sparsecheckout true
  $ git --work-tree $WT --git-dir $GIT checkout -b the-branch remotes/origin/the-branch
  Switched to a new branch 'the-branch'

Next step would be to "git mv" the file:

  $ mkdir -p /path/to  # already exists, but should do no harm
  $ git --work-tree $WT --git-dir $GIT mv path/to/old-filename path/to/new-filename
  The following paths and/or pathspecs matched paths that exist
  outside of your sparse-checkout definition, so will not be
  updated in the index:
  path/to/new-filename
  hint: If you intend to update such entries, try one of the following:
  hint: * Use the --sparse option.
  hint: * Disable or modify the sparsity rules.
  hint: Disable this message with "git config advice.updateSparsePath false"

This error is something I have not expected.

Error message suggests, there already exists a file named "new-filename". This
is not true at all. There is no file named "new-filename" in the entire
repository. Not in any directory of any branch.

-- 
Josef Wolf
jw@raven.inka.de
