From: Michael Sims <michael.h.sims@gmail.com>
Subject: "sha1 information is lacking or useless" when rebasing with a
 submodule pointer conflict
Date: Wed, 30 Jan 2013 12:43:31 -0600
Message-ID: <CAFyOhY8YAO4zx6jKQxrEW=-Vbo-TTjU6wJ7UgNVEjA7B2dasng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 19:44:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cdb-0003G4-6o
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567Ab3A3Snd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:43:33 -0500
Received: from mail-ia0-f178.google.com ([209.85.210.178]:33754 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502Ab3A3Snb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 13:43:31 -0500
Received: by mail-ia0-f178.google.com with SMTP id y26so2736567iab.37
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 10:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=/36tJFwtu1x2Z2j0ghpwolDg9ONeksl8kp2Fh/f0sLE=;
        b=rDF1C67aSW86Gtflg7G5P2hOmze1eQeKBDgstaTJEuWypzGiKACVz9WBz5SL8KpQxi
         38X+dyxrDVqsZS6kFEIi2NwMk9Dism3vp7xY+C0IpQxdexxys/vEAnT32+ytSCuW9QzJ
         gsKqUMBGy8UukmoxFCWhOlZoldjprYTyd05pySIYM8MSBkKiSdt4YEJJ0MqN9tjx0wsd
         h62wsDMVzrXxAUI0KZfK4DhqMygHWwVQJZnyD/Oain8A76iAeAzMQIdbIQcfAov+X5/R
         E+2qdCI8AS+uwi/iMu+j9UWVkt9HnbIyxet+rUF5Yali3O5bbsLIIGoH4xtDIPc1I6/z
         cbQQ==
X-Received: by 10.50.185.196 with SMTP id fe4mr4267096igc.17.1359571411119;
 Wed, 30 Jan 2013 10:43:31 -0800 (PST)
Received: by 10.64.53.138 with HTTP; Wed, 30 Jan 2013 10:43:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215045>

I'm seeing what might be a bug that was introduced in git 1.7.12 (also
observed in 1.8.1.2).  If not a bug, it's a changed behavior from
previous versions that I don't understand.

Here's the scenario:
* I have a remote repo containing a pointer to a submodule.
* Developer A and Developer B clone this repo, and both make a commit
to first the submodule, and then the parent repo, changing some files
and also the submodule pointer at the same time.
* Developer A pushes his changes to both the submodule and the parent
module to the shared remote
* Developer B either does a "git pull --rebase" or a "git fetch && git
rebase origin/master"

Results:
When applying Developer B's changes on top of origin/master, the
following messages are observed:
"fatal: sha1 information is lacking or useless (sub).
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge."

Furthermore, an immediate "git status" reports "all conflicts fixed",
does not report the submodule pointer as unmerged, and the changes to
the other files in the parent module made by Developer B are not
applied.

Expected Results:
Similar to how 1.7.12.1 behaves.  No mention of sha1 information or
blobs being lacking.  "git status" should report the submodule pointer
and any other changed files as being unmerged.  Conflicting changes
should not be lost.

I'm witnessing this behavior on OS X 10.8.2 with git versions 1.7.12,
1.7.12.1, and 1.8.1.2, installed via homebrew.  I do not see this
behavior in 1.7.11.5 or any of the 8 previous versions I've tried back
to 1.7.4.1.

Workaround:
Using an interactive rebase ("git fetch && git rebase -i
origin/master") with no changes made to the commit list seems to
sidestep this behavior.

Thanks in advance for any help with this.

Reproduce script:
Execute the following, then "cd local-b; git pull --rebase"

#!/bin/sh

set -e -v

BASEDIR=`pwd`

# Make bare remote repos
mkdir remotes
pushd remotes
git init --bare super.git
git init --bare sub.git
popd

# Initialize the submodule repo
git clone --no-hardlinks remotes/sub.git sub
pushd sub
echo subfile > subfile
git add subfile
git commit -m initial-submodule
git push origin master
popd
rm -Rf sub

# Clone into local-a and initialize supermodule repo
git clone --no-hardlinks remotes/super.git local-a
pushd local-a
git submodule add $BASEDIR/remotes/sub.git sub
echo file > file
git add sub file
git commit -m initial
git push origin master
popd

# Clone into local-b
git clone --no-hardlinks remotes/super.git local-b
pushd local-b
git submodule init && git submodule update
popd

# Make a change to supermodule file and submodule pointer from local-a
and push to remote
pushd local-a
cd sub
echo subfile changed from local-a > subfile
git add subfile
git commit -m subfile-changed-from-local-a
git push
cd ..
echo file changed from local-a > file
git add sub file
git commit -m change-from-local-a
git push
popd

# Make a conflicting change to both supermodule file and submodule
pointer from local-b
pushd local-b
cd sub
echo subfile changed from local-b > subfile
git add subfile
git commit -m subfile-changed-from-local-b
cd ..
echo file changed from local-b > file
git add sub file
git commit -m change-from-local-b
popd
