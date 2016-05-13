From: Jonas Bernoulli <jonas@bernoul.li>
Subject: Improve initial setup of submodules
Date: Fri, 13 May 2016 19:32:38 +0200
Message-ID: <87posplv7t.fsf@bernoul.li>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 19:32:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1GxC-0005Ts-RN
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 19:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbcEMRcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 13:32:42 -0400
Received: from mail.hostpark.net ([212.243.197.30]:43853 "EHLO
	mail.hostpark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbcEMRcl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 13:32:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hostpark.net (Postfix) with ESMTP id 0AC8316B43
	for <git@vger.kernel.org>; Fri, 13 May 2016 19:32:39 +0200 (CEST)
X-Virus-Scanned: by Hostpark/NetZone Mailprotection at hostpark.net
Received: from mail.hostpark.net ([127.0.0.1])
	by localhost (mail1.hostpark.net [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id oxlD5Vj4nBH9 for <git@vger.kernel.org>;
	Fri, 13 May 2016 19:32:38 +0200 (CEST)
Received: from hal (80-218-86-217.dclient.hispeed.ch [80.218.86.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hostpark.net (Postfix) with ESMTPSA id C4ECE16B42
	for <git@vger.kernel.org>; Fri, 13 May 2016 19:32:38 +0200 (CEST)
User-agent: mu4e 0.9.17; emacs 25.0.93.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294548>

Hello,

Currently "git submodule update" appears to be optimized for updating
existing submodules - which isn't surprising given its name.  However it
is also used for the "initial setup" of submodules, i.e. right after
running "git submodule init" or with the "--init" argument.

Below you find a list of features I wish existed during the initial
setup.  It might make sense to add an additional subcommand named
e.g. "bootstrap" or "setup" to accomplish this, but maybe a
"--bootstrap" argument might also suffice.

The goal is for a submodule to be "ready for use" after running "git
submodule init" and "git submodule bootstrap"/"git submodule update
--bootstrap".

* Add additional remotes.

  "submodule update" can only add a single remote, but a submodule might
  require additional remotes, i.e. "origin" and "my-fork".  It's likely
  that "my-fork" contains commits that are not available from "origin"
  and that such a commit is tracked as the HEAD of the submodule.

  When that is the case and if "submodule.<name>.url" points to the
  upstream repository, then "submodule update <name>" would fail because
  the commit is not available.

  To deal with that the user would have to set "url" to the url of the
  fork repository.  But then "submodule update" would name that remote
  "origin".  And the user would then have to rename that to "my-fork"
  and also add the real "origin".

  It would be nice if it were possible to configure additional remotes
  in .gitmodules or elsewhere and if "submodule bootstrap/update" could
  be told to setup these remotes before attempting to checkout the
  tracked commit.

  Since Git doesn't support nested config sections I am unsure what
  would be the best way to store this information in ".gitmodules".  A
  hacky implementation could use something like this:

    [submodule "example"]
            url = git://example.com/upstream.git
            remote = my-fork git@example.me:my-fork.git
            remote = third-party git://example.com/with-patches.git

  Of course Git usually doesn't use a single variable to define multiple
  values, so that's not really an option except while experimenting.

  Another alternative might be to use separate files located in a
  directory ".gitmodule.d", e.g. the remotes of the module
  ".gitmodule.d/example" could contain:

    [remote "origin"]
            url = git://example.com/upstream.git
    [remote "my-fork"]
            url = git@example.me:my-fork.git
    [remote "third-party"]
            url = git://example.com/with-patches.git

* Attach HEAD.

  I think it makes sense for "submodule update" to default to using
  "checkout" as "submodule.<name>.update" method, since it is the safest
  option which doesn't do any harm.

  It's also nice that there are some alternatives, "rebase", "merge" and
  "none", and even support for custom commands. (By the way "ff-only"
  and "ff-only-else-checkout" would be nice to have.)

  However neither "rebase" nor "merge" are suitable during bootstrap.

  During "submodule bootstrap" (but not "submodule update") a "rewind"
  variant might make sense.  During bootstrap, after cloning but before
  checkout/merge/update, we might have history like this:

    A---B---C origin/master, master -> origin/master, HEAD
        ^
        |
        commit recorded for submodule

  The "rewind" update variant (actually boostrap variant) would then do
  a "git reset --hard B", resulting in:

    A---B---C origin/master
        ^
        |
        master > origin/master, HEAD, commit recorded for submodule

  Of course the situation might be more complicated:

    A---B---C origin/master, master -> origin/master, HEAD
        \
         D---E---F my-fork/master
             ^
             |
             commit recorded for submodule

  Here "rewind" would fail because "master" cannot be rewound to E.  In
  some cases that might be the right thing to do, but another
  alternative would be a "reset" variant, which does a "git reset
  --hard" even if the recorded commit isn't an ancestor of the checked
  out branch.
  
    A---B---C origin/master, HEAD
        \
         D---E---F my-fork/master
             ^
             |
             master -> origin/master, HEAD, commit recorded for submodule

  Other, smarter, variants could be implemented, but the key point I am
  trying to make is that I would like to use diffent "update methods"
  during "submodule bootstrap" and "submodule update", and that "rewind"
  and "reset" should be available during "boostrap" by default.

* Preserve additional information.

  If a mechanism such as the ".gitmodules.d/<name>" file I suggested
  above were used to add additional remotes, then that could be used to
  distribute other information from ".git/modules/<name>/config".  This
  could also be used by the various "bootstrap" variants.

  As I have shown above ".gitmodules.d/example" could for example
  contain this:

    [remote "origin"]
            url = git://example.com/upstream.git
    [remote "my-fork"]
            url = git@example.me:my-fork.git
    [remote "third-party"]
            url = git://example.com/with-patches.git

  Here "origin.url" would be redundant because the same value is already
  set in "submodule.example.url".  However this could be used to allow
  setting an alternative remote name:

  (in .gitmodules)

    [submodule "example"]
            remote = upstream

  (in .gitmodules.d/example)

    [remote "upstream"]
            url = git://example.com/upstream.git

  But that's just a minor detail.  What I really would like to be able
  to do is this:
  
  (in .gitmodules)

    [submodule "example"]
            remote = origin
            bootstrap = rewind-either

  (in .gitmodules.d/example)

    [remote "origin"]
            url = git://example.com/upstream.git
    [remote "my-fork"]
            url = git@example.me:my-fork.git
    [branch "master"]
            remote = origin
            merge = refs/heads/master
            pushRemote = my-fork

  With such a setup the second example from above makes more sense:

    A---B---C origin/master, HEAD
        \
         D---E---F my-fork/master
             ^
             |
             master -> origin/master, HEAD, commit recorded for submodule

  And a new bootstrap variant "rewind-either" could make sense: if the
  commit recorded for the submodule is reachable from either the
  upstream branch *or* from "branch.<name>.pushRemote", then rewind,
  else checkout a detached HEAD.

  Additionally the settings from ".gitmodules.d/<name>" should be copied
  to ".git/modules/<name>/config", just like those from ".gitmodules"
  are copied to ".git/config":

  (in .git/modules/example/config)

    [remote "origin"]
            url = git://example.com/upstream.git
            fetch = +refs/heads/*:refs/remotes/origin/*
    [remote "my-fork"]
            url = git@example.me:my-fork.git
            fetch = +refs/heads/*:refs/remotes/my-fork/*
    [branch "master"]
            remote = origin
            merge = refs/heads/master
            pushRemote = my-fork

  Most of these variables are "copied" by adding the remotes, but
  "branch.master.pushRemote" would have to be explictily set.

  It should also be possible to checkout another branch by setting
  "submodule.<name>.branch", and to automatically create additional
  branches by adding additional "branch" sections to
  ".gitmodules.d/<name>".

  In addition to "branch.<name>.pushRemote" it would be nice if
  "remote.pushDefault" could be set in ".gitmodules.d/<name>".

So what do you think?  Is there a change that such features could be
added to Git (using the suggested mechanisms or something else)?

  Best regards,
  Jonas Bernoulli
  
  
  
