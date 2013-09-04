From: Chris Packham <judge.packham@gmail.com>
Subject: [Bug?] MERGE_HEAD lost with git checkout master
Date: Wed, 4 Sep 2013 18:17:26 +1200
Message-ID: <CAFOYHZD0reLWt-wYrcKy=LVKD3q0uJjgVLVYSAzU+zWMgtWguQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 04 08:17:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH6PE-0003KM-8O
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 08:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947Ab3IDGR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 02:17:28 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:52895 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab3IDGR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 02:17:27 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so7488673pab.29
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 23:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=4pWPbiUXz9xUjdntXAqBrZzO3fREm5/avLmxk+1TY5c=;
        b=jMysEQ65/vIlttcVyBASh7XUdy/1Lb00vV/GJGPYu+QosBla3TMbLimNtVr8FSEw6B
         NRq5ivsOnTtq28XigEKZCF07QHSLWy4qpznjTE/NulgU0PnOu5LMrK3f4rHV2NZR106i
         nWGDq9LsXco6nvaBZO9rzyCnZIDpsQ+ohkuE7P1W8ci4mBU5Dkrc6JjVW1mri9L0MI4U
         48ar2M3KVznWH8L/xcuRdRUNZKc2MeNtLkJ8FsAj1KCLWxHlXAmkxhg54bcv4S3ZzPEj
         v8YY/vgvsasYMLBQdy/RnOa5+l6u+1uNisTYu+7maQA89CdJXBrRpz1+YW6sp+kZWO/O
         D9qQ==
X-Received: by 10.66.231.42 with SMTP id td10mr1384184pac.144.1378275446799;
 Tue, 03 Sep 2013 23:17:26 -0700 (PDT)
Received: by 10.70.35.205 with HTTP; Tue, 3 Sep 2013 23:17:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233806>

Hi,

At $dayjob we have some simple "code quality" checks that we run to
make sure that things are heading in the right direction. These are
usually run as part of our automated builds but people occasionally
run them when merging updates from other teams or preparing to merge
to the integration branch.

The typical invocation is something like
  git checkout HEAD^
  score1=$(script.sh)
  git checkout master
  score2=$(script.sh)
  # compare scores ...

The problem is that if this is run after resolving merge conflicts but
before committing the changes (i.e. the merge resolution is in the
index) the fact that a merge was in progress is lost. I have modified
script.sh to check for a clean work tree but I'm wondering if this is
actually a bug worth fixing.

Here's a simple reproduction (apologies in advance for gmails wrapping)

  $ git --version
  git version 1.8.4.rc2
  $ git init
  $ for x in a b c d e f; do echo "$x" >"${x}.txt"; git add
"${x}.txt"; git commit -m"Add ${x}.txt"; done
  $ git checkout -b foo HEAD^^^
  $ for x in d e f; do echo "x" >"${x}.txt"; git add "${x}.txt"; git
commit -m"Add ${x}.txt"; done
  $ git checkout master
  $ git merge foo
  $ git mergetool

  # At this point the conflict resolution is in the index as expected

  $ git checkout HEAD^
  error: Your local changes to the following files would be
overwritten by checkout:
        f.txt
  Please, commit your changes or stash them before you can switch branches.
  Aborting

  # OK so far so good. Checkout failed and we're still in a mergey state

  $ ll .git
  drwxr-xr-x  2 chrisp swdept 4096 Sep  4 17:47 info/
  drwxr-xr-x  3 chrisp swdept 4096 Sep  4 17:49 logs/
  -rw-r--r--  1 chrisp swdept   41 Sep  4 17:51 MERGE_HEAD
  -rw-r--r--  1 chrisp swdept    0 Sep  4 17:51 MERGE_MODE
  -rw-r--r--  1 chrisp swdept   52 Sep  4 17:51 MERGE_MSG
  -rw-r--r--  1 chrisp swdept  141 Sep  4 17:51 MERGE_RR
  drwxr-xr-x 40 chrisp swdept 4096 Sep  4 17:52 objects/
  -rw-r--r--  1 chrisp swdept   41 Sep  4 17:51 ORIG_HEAD

  $ git checkout master
  M       d.txt
  M       e.txt
  M       f.txt
  Already on 'master'

  # Hmm, that kind of indicates that it did something but "Already on
'master'" makes me think it was a noop

  $ ll .git
  drwxr-xr-x  2 chrisp swdept 4096 Sep  4 17:47 info/
  drwxr-xr-x  3 chrisp swdept 4096 Sep  4 17:49 logs/
  drwxr-xr-x 40 chrisp swdept 4096 Sep  4 17:52 objects/
  -rw-r--r--  1 chrisp swdept   41 Sep  4 17:51 ORIG_HEAD

  # mergey state is lost but the changes are still in the index.

Cheers,
Chris
