From: "Edward Z. Yang" <ezyang@mit.edu>
Subject: git-new-workdir submodules interact poorly with core.worktree
Date: Fri, 12 Sep 2014 09:58:31 -0400
Message-ID: <1410527113-sup-9003@sabre>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 15:58:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSRN2-0006Gt-3r
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 15:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbaILN6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 09:58:36 -0400
Received: from dmz-mailsec-scanner-5.mit.edu ([18.7.68.34]:56366 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752965AbaILN6f (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2014 09:58:35 -0400
X-AuditID: 12074422-f79436d000000c21-f9-5412fc0ab6fa
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	(using TLS with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 6D.72.03105.A0CF2145; Fri, 12 Sep 2014 09:58:34 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id s8CDwXB5008685
	for <git@vger.kernel.org>; Fri, 12 Sep 2014 09:58:34 -0400
Received: from localhost (ool-18b93804.dyn.optonline.net [24.185.56.4])
	(authenticated bits=0)
        (User authenticated as ezyang@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id s8CDwWbH002201
	for <git@vger.kernel.org>; Fri, 12 Sep 2014 09:58:33 -0400
User-Agent: Sup/git
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsUixG6nrsv1RyjEYGu7vEXXlW4mB0aPz5vk
	AhijuGxSUnMyy1KL9O0SuDLebf3BVtAqWTFh6xOmBsb3Ql2MnBwSAiYSnfuPs0LYYhIX7q1n
	62Lk4hASmM0kceb+BXaQhJDAaUaJk3vTIBLTmSSWr9vD2MXIwcEsoC6xfh7YIDYgc9LfjUwg
	toiArMTRj2/BhgoLuEmsaZrKDGKzCKhKzJiwmAXE5gWq33kRokZUQFjiyZFmsBpmAXmJ5q2z
	mScw8s5C2DALSWYBI9MqRtmU3Crd3MTMnOLUZN3i5MS8vNQiXVO93MwSvdSU0k2M4HBxUdrB
	+POg0iFGAQ5GJR7eChbBECHWxLLiytxDjJIcTEqivHn3hEKE+JLyUyozEosz4otKc1KLDzFK
	cDArifDeeAWU401JrKxKLcqHSUlzsCiJ8276wRciJJCeWJKanZpakFoEk5Xh4FCS4J30C6hR
	sCg1PbUiLTOnBCHNxMEJMpwHaPgtkBre4oLE3OLMdIj8KUZdjnWd3/qZhFjy8vNSpcR5D4IU
	CYAUZZTmwc2BxfkrRnGgt4R5V4BU8QBTBNykV0BLmICWvJsDtqQkESEl1cDIrR4VHxDNkxvY
	2c4vvrf0Xt0ngeZjU6p5128VLt31RqYzJHXuBNm4tIU/bIp47khznr4QqcZ9bUmU2Mw3bGb8
	Zcs6/2ltWzx7idRBltmvDnFl9ngfm8iVvPuopmfXlEUT/l2War2/N2+6pKKtidC674sfnzoz
	V87cTZ//iWSIT62mRRpr+iYlluKMREMt5qLiRACPsP6UzgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256921>

tl;dr You can't git-new-workdir checkouts which use core.worktree.  This
is unfortunate because 'git submodule init' uses core.worktree by
default, which means you can't recursively git-new-workdir without a
hack.

In the beginning, the Developer created the remote Git repository and
the submodule.

    mkdir -p remote/sub
    (cd remote/sub && git init && touch a && git add a && git commit -m "sub init")
    mkdir remote/top
    cd remote/top
    git init
    git submodule add ../sub
    git commit -m "top init"
    cd ../..

And the Developer said, "Let there be a local clone and submodule", and
lo, there was a local clone and submodule:

    git clone remote/top top
    (cd top && git submodule init && git submodule update)

the Developer blessed the working copy, and said "Be fruitful and
increase in number with git-new-workdir":

    git-new-workdir top worktop

Unfortunately, this workdir didn't have the submodules initialized.

    $ ls worktop/sub/
    $

Now, the Developer could have run:

    $ (cd worktop && git submodule init && git submodule update)

but the resulting submodule would not have been shared with the original
submodule, in the same way that git-new-workdir shared the Git metadata.

The Developer sought to create the submodule in its own likeness, but it
did not work:

    $ rmdir worktop/sub && git-new-workdir top/sub worktop/sub
    fatal: Could not chdir to '../../../sub': No such file or directory

What was the Developer's fall from grace?  A glance at the config of
the original and new submodule shed light on the matter:

    $ cat top/sub/.git
    gitdir: ../.git/modules/sub
    $ cat top/.git/modules/sub/config
    [core]
            repositoryformatversion = 0
            filemode = true
            bare = false
            logallrefupdates = true
            worktree = ../../../sub
    $ cat worktop/sub/.git/config
    [core]
            repositoryformatversion = 0
            filemode = true
            bare = false
            logallrefupdates = true
            worktree = ../../../sub

git-new-workdir sought to reuse the config of top/sub/.git, but this
configuration had core.worktree set.  For the original checkout,
this worked fine, since its location was .git/modules/sub; but for the
new workdir, this relative path was nonsense.

I do not think there is really a way to make this work with
core.worktree.  Our saving grace, however, is there is a hack that can
make this work: we just need to use the
pre-501770e1bb5d132ae4f79aa96715f07f6b84e1f6 style of cloning
submodules:

    git clone remote/top oktop
    git clone remote/sub oktop/sub
    (cd oktop && git submodule init && git submodule update)

Now recursive git-new-workdir will work.

What's the upshot?  I propose two new features:

1. A flag for git submodule update which reverts to the old behavior
of making a seperate .git directory rather than collecting them together
in the top-level .git/modules

2. Teach git-new-workdir to complain if core.worktree is set in the
source config, and how to recursively copy submodules.

What do peopl think?

Thanks,
Edward
