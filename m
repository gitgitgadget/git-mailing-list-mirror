From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Pushing and pulling the result of `git replace` and objects/info/alternates
Date: Sun, 24 May 2015 07:28:15 +0200
Message-ID: <CAP8UFD3G8_ChRX6HHtieFTksUJBiXu9FLNbewFQVj7qPyGh8EQ@mail.gmail.com>
References: <CACHsx4Kz3_bMbKqd1O7-ZXLBUqJBs6hTsiRNAALNJhDV44v6Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 07:44:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwOhv-00076A-Iy
	for gcvg-git-2@plane.gmane.org; Sun, 24 May 2015 07:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbbEXF2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2015 01:28:17 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36427 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbbEXF2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2015 01:28:16 -0400
Received: by wgbgq6 with SMTP id gq6so48824042wgb.3
        for <git@vger.kernel.org>; Sat, 23 May 2015 22:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zPxOtl1eiqRfy6uOd9tDujeC+wF1JgWTi+4DrzGj1Ds=;
        b=v+nHkaoG3RrTcH2QCsb22Y/EKp3o/rOllvm7dJqFsGVp2+9Kl9Qi45vAuXqnmtBFE4
         c4aOWvW7lUKFehBu+Mu0QXRjfdWVUUVelFAVsqTQ6vqIs8nD+N05M/BfS8AaTfm9nKkJ
         KfJVbM+iznXTmXv7VTXIQw7PyN9vLoyDqo9DXmZ75kJ78pkNqq4ov4JcVq18B81q5Z1C
         pSBzVhKZMci/mo1B84QIZ0q9tBIvgHvc4zXiuX43aW4ZLGBX7eTisZQgdIJtUr9w+vIS
         EVDmVJZxFKfLUNxMgsoA4BeT44IvUahkBb2aS5C9D0vQBceRXNO8rf6dA5tBYH5dsRGS
         okpA==
X-Received: by 10.194.95.132 with SMTP id dk4mr29493190wjb.88.1432445295393;
 Sat, 23 May 2015 22:28:15 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sat, 23 May 2015 22:28:15 -0700 (PDT)
In-Reply-To: <CACHsx4Kz3_bMbKqd1O7-ZXLBUqJBs6hTsiRNAALNJhDV44v6Rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269823>

Hi,

On Fri, May 22, 2015 at 4:38 PM, Stephen Kelly <steveire@gmail.com> wrote:
> Hello,
>
> I have an 'integration repo' which contains other git repos as submodules.
>
> One of the submodules is to be split in two to extract a library.
>
> A common way of doing that is to use git-filter-branch. A disadvantage
> of that is that it results in duplicated partial-history in the
> extracted repo. So, git log shows the entire history, but there is not
> one canonical sha which represents the history at that point. The
> split repo will contain 'false history', and checking it out will not
> be useful.
>
> So, I want to avoid git-filter-branch.
>
> I have tried out using `git replace --graft` and
> .git/objects/info/alternates to 'refer to' the history in the origin
> repo instead of 'duplicating' it. This is similar to how Qt5 repos
> refer to Qt 4 history in a different repo.
>
> Question 1) Is this a reasonable thing to do for this scenario?

I think it should work without too much work, but see the answer to
the next question.

> Question 2) Is there a way to push the `git replace` result and the
> `info/alternates` content so that clients cloning the 'integration
> repo' do not have to do that 'manually' or with a 'setup-repo.sh'
> script?

In short no.

"git replace" creates replace refs in "refs/replace/". To fetch these
refs, people need to use either "git fetch
'refs/replace/*:refs/replace/*'" or add a "fetch =
refs/replace/*:refs/replace/*" line in their config.
For simplicity and security reasons fetching replace refs is not on by default.

Also changing the objects/info/alternates to make it point to another
repo cannot be done automatically when cloning.

> The sequence of commands below can be pasted into a tmp directory to
> see the scenario in action.
>
> Thanks!
>
>
> mkdir calculator
> cd calculator
> mkdir mainui libcalc
> echo "print \"hello\"" > mainui/app.py
> echo "print \"hello\"" > libcalc/adder.py
> echo "print \"hello\"" > libcalc/subtracter.py
> git init
> git add .
> git commit -am "Initial commit"
> git checkout `git rev-parse HEAD`
>
> cd ..
> mkdir appsuite
> cd appsuite
> git init
> git submodule add ../calculator
> git commit -m "Add calculator submodule"
>
> # Add other submodules in the suite...
>
> cd calculator
>
> echo "print \"goodbye\"" > libcalc/subtracter.py
> git add libcalc/subtracter.py
> git commit -am "Fix bug in subtracter"
>
> echo "print \"Hi\"" > libcalc/adder.py
> git add libcalc/adder.py
> git commit -am "Make adder more efficient"
>
> echo "print \"Hello, world!\"" > mainui/app.py
> git add mainui/app.py
> git commit -am "Improve app"
>
> echo "print \"hello, hello\"" > libcalc/multiplier.py
> git add libcalc/multiplier.py
> git commit -am "Add multiplier"
>
> cd ..
> git add calculator
> git commit -m "Update calculator submodule"
>
> mkdir compute
> cd calculator
> mv libcalc ../compute
>
> extraction_sha=`git rev-parse HEAD`
> git commit -am "Remove libcalc from calculator repo" -m "It is moved
> to a new compute repo"
> removal_sha=`git rev-parse HEAD`
> git push
>
> cd ../compute
> git init
> git add .
> git commit -m "Create the compute repo." -m "This commit will not be
> normally visible after the replace --graft below."
>
> echo "This is the compute framework. It contains the libcalc library." > README
> git add README
> git commit -m "Initialize the compute repo." -m "This has been
> extracted from calculator.git at $removal_sha"
> git checkout `git rev-parse HEAD`
>
> cd ..
> mv compute ..
> git submodule add ../compute
>
> git add calculator compute
> git commit -m "Split compute framework out of calculator repo."
>
> cd compute
> git log --oneline
> # We don't see older history from the calculator repo
>
> # Let's add alternates
> echo "../../calculator/objects" >
> ../.git/modules/compute/objects/info/alternates
>
> # ... and graft onto the extraction commit
> git replace --graft HEAD $extraction_sha
>
> git log --oneline
> # Great, now we see history from the calculator repo.
>
> cd ../..
> git clone appsuite appsuite-clone
> cd appsuite-clone
> git submodule update --init
> cd compute
> ls ../.git/modules/compute/objects/info
> git log --oneline
> # The replacement and alternatives did not get cloned ... :(
>
> echo "../../calculator/objects" >
> ../.git/modules/compute/objects/info/alternates
> git replace --graft HEAD $extraction_sha

Maybe use the following instead of the above line:

git fetch 'refs/replace/*:refs/replace/*'

> # And now we see the history from the calculator repo. Great. But, it
> required user action after the clone.

Yeah, but if the 2 above commands are in a script maybe it's
reasonable to ask the user to launch the script once after cloning.

Best,
Christian.
