Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784AEC7EE22
	for <git@archiver.kernel.org>; Tue,  2 May 2023 17:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbjEBRXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 13:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjEBRXk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 13:23:40 -0400
X-Greylist: delayed 138 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 10:23:39 PDT
Received: from kitenet.net (kitenet.net [66.228.36.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2524210CC
        for <git@vger.kernel.org>; Tue,  2 May 2023 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1683048075; bh=DKkpZxdNmjLhk3BXSwI+PlgdPzRw69hRrGZqZwy5AxA=;
        h=Date:From:To:Subject:From;
        b=EyhXnG6KpAvOfVTLbsAf1tg1Y8i5Axp1MBGE+aoy+VgSgy6vdbNehLwpGxx6PkPvr
         CQsU0syVId7HvgEkAUi0fOdO3T2CbDU5mPbY1M4MMtu+uaJyK/h0mdJf+hz71xU96G
         Pc/0ajFs6FSyrYWVMi1iPCBjfFaarYFdN7xdNP2U=
X-Question: 42
Date:   Tue, 2 May 2023 13:21:15 -0400
From:   Joey Hess <id@joeyh.name>
To:     Git Mailing List <git@vger.kernel.org>
Subject: git merge crash "fatal: stash failed" with smudge/clean filters
Message-ID: <ZFFGi9i7JGL9xNx5@kitenet.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AbXYcwiRJMdOV6D5"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AbXYcwiRJMdOV6D5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached testcase seems to show a bug in git. git merge crashes
with an internal error of "fatal: stash failed".

The testcase uses some very basic smudge/clean filters, and that
is necessary to see the crash. (The filters may be kinda broken,
they're the first thing I tried to detangle this bug from git-annex.)

The test case first creates an empty file, and that is somehow
significant. While the merge does not directly involve that empty file,
omitting adding the empty file, or making it have any non-empty content
avoids the merge crash. And the crash happens after cleaning the empty file:

joey@darkstar:~/tmp/x/testcase-workdir/repo1>GIT_PACKET_TRACE=1 GIT_TRACE=1 git merge repo2/master
13:17:20.064936 git.c:439               trace: built-in: git merge repo2/master
13:17:20.070120 run-command.c:655       trace: run_command: '.git/test-clean '\''emptyfile'\'''
13:17:20.094653 run-command.c:655       trace: run_command: git stash create
13:17:20.097780 git.c:439               trace: built-in: git stash create
13:17:20.099213 run-command.c:655       trace: run_command: '.git/test-clean '\''emptyfile'\'''
fatal: stash failed

git version 2.40.1.459.g48d89b51b3

-- 
see shy jo

--AbXYcwiRJMdOV6D5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=testcase

#!/bin/bash
setup_smudge_clean() {
	cat <<'EOF' > .git/test-clean
#!/bin/sh
mkdir -p ../content
cat > ../content/new.content
v=$(sha1sum ../content/new.content | cut -d ' ' -f 1)
mv ../content/new.content ../content/$v.content
echo "$v"
EOF
	cat <<'EOF' > .git/test-smudge
#!/bin/sh
v=$(cat)
cat ../content/$v.content
EOF
	chmod +x .git/test-clean
	chmod +x .git/test-smudge
	git config filter.foo.smudge '.git/test-smudge %f'
	git config filter.foo.clean '.git/test-clean %f'
	echo "* filter=foo" > .git/info/attributes
}

mkdir testcase-workdir
cd testcase-workdir
git init repo1
cd repo1
setup_smudge_clean
git commit --allow-empty -m foo
git remote add repo2 ../repo2
cd ..
git clone repo1 repo2
cd repo2
git remote add repo1 ../repo1
setup_smudge_clean
cd ..

cd repo1
touch emptyfile
git add emptyfile
git commit -m add
cd ../repo2
git pull

echo foo > testfile
git add testfile
git commit -m foo
cd ../repo1
echo bar > testfile
git add testfile
git commit -m bar
git fetch repo2 master
git merge repo2/master # crashes

--AbXYcwiRJMdOV6D5--
