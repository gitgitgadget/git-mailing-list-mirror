From: Stephen Kelly <steveire@gmail.com>
Subject: Pushing and pulling the result of `git replace` and objects/info/alternates
Date: Fri, 22 May 2015 16:38:34 +0200
Message-ID: <CACHsx4Kz3_bMbKqd1O7-ZXLBUqJBs6hTsiRNAALNJhDV44v6Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 22 16:38:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvo6A-0002ar-WC
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 16:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211AbbEVOir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 10:38:47 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:35470 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757164AbbEVOig (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 10:38:36 -0400
Received: by labbd9 with SMTP id bd9so14065589lab.2
        for <git@vger.kernel.org>; Fri, 22 May 2015 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=0gZOAORY3oGMM0euaoCJ2LvWHeXyXgyLmCk5dgoqzh0=;
        b=ESXF1K03hAK89AvRNZxJU6Ys/LQOGuUYME6eM8VBXL69WD6YzpdEgI16dAzCCMpNxG
         hSbAPXsBXD+FgZYbDkA24pfMY4igAXT5qZNj7tMhkhudh2XiMkkpPHseFixsUDCxtSlZ
         rnKGZWOJ1KnjpnNFTho5zWj02O9hXDOGfzjenbaO7BoKh4UkmtGaoWp+FkNgpGIcMTVP
         KPNETpi95oZtt4zF33Fg4nVcmbbMDUA4hCGkJJ02tv+MKmK8se+GnT0DiE6T2PZcnVNq
         qWSxO4srXvWhUX924gVBW5toRlc8XczdOiT5iQ0HlysTp6aZVMdR1yMdWfgIrTPlFRFo
         LIXQ==
X-Received: by 10.112.199.1 with SMTP id jg1mr6835136lbc.59.1432305514342;
 Fri, 22 May 2015 07:38:34 -0700 (PDT)
Received: by 10.114.200.16 with HTTP; Fri, 22 May 2015 07:38:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269723>

Hello,

I have an 'integration repo' which contains other git repos as submodules.

One of the submodules is to be split in two to extract a library.

A common way of doing that is to use git-filter-branch. A disadvantage
of that is that it results in duplicated partial-history in the
extracted repo. So, git log shows the entire history, but there is not
one canonical sha which represents the history at that point. The
split repo will contain 'false history', and checking it out will not
be useful.

So, I want to avoid git-filter-branch.

I have tried out using `git replace --graft` and
.git/objects/info/alternates to 'refer to' the history in the origin
repo instead of 'duplicating' it. This is similar to how Qt5 repos
refer to Qt 4 history in a different repo.

Question 1) Is this a reasonable thing to do for this scenario?

Question 2) Is there a way to push the `git replace` result and the
`info/alternates` content so that clients cloning the 'integration
repo' do not have to do that 'manually' or with a 'setup-repo.sh'
script?

The sequence of commands below can be pasted into a tmp directory to
see the scenario in action.

Thanks!


mkdir calculator
cd calculator
mkdir mainui libcalc
echo "print \"hello\"" > mainui/app.py
echo "print \"hello\"" > libcalc/adder.py
echo "print \"hello\"" > libcalc/subtracter.py
git init
git add .
git commit -am "Initial commit"
git checkout `git rev-parse HEAD`

cd ..
mkdir appsuite
cd appsuite
git init
git submodule add ../calculator
git commit -m "Add calculator submodule"

# Add other submodules in the suite...

cd calculator

echo "print \"goodbye\"" > libcalc/subtracter.py
git add libcalc/subtracter.py
git commit -am "Fix bug in subtracter"

echo "print \"Hi\"" > libcalc/adder.py
git add libcalc/adder.py
git commit -am "Make adder more efficient"

echo "print \"Hello, world!\"" > mainui/app.py
git add mainui/app.py
git commit -am "Improve app"

echo "print \"hello, hello\"" > libcalc/multiplier.py
git add libcalc/multiplier.py
git commit -am "Add multiplier"

cd ..
git add calculator
git commit -m "Update calculator submodule"

mkdir compute
cd calculator
mv libcalc ../compute

extraction_sha=`git rev-parse HEAD`
git commit -am "Remove libcalc from calculator repo" -m "It is moved
to a new compute repo"
removal_sha=`git rev-parse HEAD`
git push

cd ../compute
git init
git add .
git commit -m "Create the compute repo." -m "This commit will not be
normally visible after the replace --graft below."

echo "This is the compute framework. It contains the libcalc library." > README
git add README
git commit -m "Initialize the compute repo." -m "This has been
extracted from calculator.git at $removal_sha"
git checkout `git rev-parse HEAD`

cd ..
mv compute ..
git submodule add ../compute

git add calculator compute
git commit -m "Split compute framework out of calculator repo."

cd compute
git log --oneline
# We don't see older history from the calculator repo

# Let's add alternates
echo "../../calculator/objects" >
../.git/modules/compute/objects/info/alternates

# ... and graft onto the extraction commit
git replace --graft HEAD $extraction_sha

git log --oneline
# Great, now we see history from the calculator repo.

cd ../..
git clone appsuite appsuite-clone
cd appsuite-clone
git submodule update --init
cd compute
ls ../.git/modules/compute/objects/info
git log --oneline
# The replacement and alternatives did not get cloned ... :(

echo "../../calculator/objects" >
../.git/modules/compute/objects/info/alternates
git replace --graft HEAD $extraction_sha

# And now we see the history from the calculator repo. Great. But, it
required user action after the clone.
