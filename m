From: Yann Droneaud <ydroneaud@opteya.com>
Subject: git merge <tag> behavior
Date: Tue, 19 Mar 2013 15:55:14 +0100
Organization: OPTEYA
Message-ID: <1363704914.6289.39.camel@test.quest-ce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 19 15:57:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHxyz-0005zD-OX
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 15:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214Ab3CSO4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 10:56:08 -0400
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:47271 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756841Ab3CSO4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 10:56:06 -0400
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 43D3877C9AD
	for <git@vger.kernel.org>; Tue, 19 Mar 2013 15:56:03 +0100 (CET)
Received: from [192.168.20.20] (unknown [37.161.111.80])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 08BF74C8231
	for <git@vger.kernel.org>; Tue, 19 Mar 2013 15:55:22 +0100 (CET)
X-Mailer: Evolution 3.4.4 (3.4.4-2.fc17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218519>

Hi,

While trying to reproduce/understand the problems[1][2] I was facing
when using Google's Git repo tool[3], I've found minor problems in Git:

1) there's no mention of the git merge <tag> behavior in git-merge.1

When asking Git to merge a tag (such as a signed tag or annotated tag),
it will always create a merge commit even if fast-forward was possible.
It's like having --no-ff present on the command line.

It's a difference from the default behavior described in git-merge.1[4].
It should be documented as an exception of "FAST-FORWARD MERGE" section
and "--ff" option description.

2) git merge <tag> VS git merge <object-id>

If <tag> is an object (not a lightweight/reference tag), git merge <tag>
will by default create a merge commit with the tag message.
Additionally, the signature check will be reported as comment, for
example:

    Merge tag 'v1.12.2' into branch-v1.12.2

    repo 1.12.2

    # gpg: Signature made Fri Mar  1 18:36:42 2013 CET using DSA key ID 920F5C65
    # gpg: Good signature from "Repo Maintainer <repo@android.kernel.org>"
    # gpg: WARNING: This key is not certified with a trusted signature!
    # gpg:          There is no indication that the signature belongs to the owner.
    # Primary key fingerprint: 8BB9 AD79 3E8E 6153 AF0F  9A44 1653 0D5E 920F 5C65

But, if you use the tag object-id instead of its name, for example using
git merge `git show-ref <tag>`, the tag is not recognized and the
signature is not checked. Git still create a merge commit, but doesn't
prepare a commit message with the tag message and the signature:

    Merge commit 'ac22c7ae2e652f63366b65ee23122292d3564fff' into
branch-ac22c7ae2e652f63366b65ee23122292d3564fff

It would be great to have Git using the tag message and check the
signature.

3) Merge options can't be overridden.

If I modify .git/config to set a merge option, for example forcing
fast-forward merge, this option cannot be overridden on command line:

Example 1:

    $ cat .git/config:
    [branch "master"]
            mergeoptions = --ff-only

    $ git merge --no-ff <tag>
    fatal: You cannot combine --no-ff with --ff-only

Example 2:

    $ cat .git/config:
    [merge]
           ff = only

    $ git merge --no-ff <tag>
    fatal: You cannot combine --no-ff with --ff-only

Setting the merge options in config should overridden by command line.

Regards.

[1] issue 135: repo: repo sync should force fast-forward merge
https://code.google.com/p/git-repo/issues/detail?id=135

[2] Issue 136: repo: repo sync should use the tag name instead of object identifier of the tag
https://code.google.com/p/git-repo/issues/detail?id=136

[3] git-repo - repo - The multiple repository tool 
http://code.google.com/p/git-repo/

[4] git-merge(1) Manual Page
https://www.kernel.org/pub/software/scm/git/docs/git-merge.html

-- 
Yann Droneaud
OPTEYA
