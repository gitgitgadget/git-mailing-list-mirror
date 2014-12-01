From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: [BUG] git rebase -X fails with merge-recursive error
Date: Mon, 1 Dec 2014 14:33:33 +0000 (UTC)
Message-ID: <loom.20141201T152914-672@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 15:33:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvS2w-0004PJ-NV
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 15:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbaLAOdr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2014 09:33:47 -0500
Received: from plane.gmane.org ([80.91.229.3]:51657 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548AbaLAOdq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 09:33:46 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XvS2q-0004Lz-2t
	for git@vger.kernel.org; Mon, 01 Dec 2014 15:33:44 +0100
Received: from 46.19.18.182 ([46.19.18.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 15:33:44 +0100
Received: from oystwa by 46.19.18.182 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 15:33:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 46.19.18.182 (Mozilla/5.0 (Windows NT 6.3; WOW64; rv:33.0) Gecko/20100101 Firefox/33.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260482>

Hi,

I discovered this while rebasing a branch after having converted files
to use LF line endings. I got around the problem by using
--ignore-whitespace but the error still seems strange to me so I'm
reporting it.

The following script is equivalent: it creates a repo with a CRLF file,
creates a "feature" branch, converts the file and then tries to rebase
the feature branch with git rebase -X ignore-whitespace-at-eol:

    git init
    echo "That's some catch, that Catch-1984" >file.txt
    unix2dos file.txt
    git add file.txt
    git commit -m 'Initial commit'
    git checkout -b feature
    ex -sc 's/1984/22/|x' file.txt
    git commit -m "Fix literary confusion" file.txt
    git checkout master
    echo '* text=3Dauto' > .gitattributes
    dos2unix file.txt
    git add .
    git commit -m 'CRLF to LF'
    git checkout feature
    gti config merge.renormalize true
    git rebase -X ignore-space-at-eol master

While rebasing the following error appears:

    error: addinfo_cache failed for path 'file.txt'

It comes from the git-merge-recursive invocation git-rebase performs[1]
and is printed because make_cache_entry() fails[2]. I also get this
error when using the other 'ignore-*' strategy options, as well as
'theirs'.

At this point file.txt still has its CRLF terminator, but simply:

git add file.txt
git rebase --continue

has the desired effect (as it did in my real life situation). I've
tested this on Git 2.2.0, 2.1.3 and 1.9.0.

I don't know whether this is actually related to git-rebase. It's a way
to reproduce it if nothing else. I haven't tried any experiments with
git-merge-recursive directly, I get the impression I'm not supposed to
since it doesn't have a manpage ;) Interestingly, removing the creation
of .gitattributes makes the problem go away.

Additionally, git-merge-recursive exits with status 0. This confuses
git-rebase which will continue and then complain about the state of the
index. (Interestingly, at this point my prompt thingy complains that
=2Egit/rebase-merge/done isn't there).

Regards,
=C3=98sse

[1]: https://github.com/git/git/blob/master/git-rebase--merge.sh#L70
[2]: https://github.com/git/git/blob/master/merge-recursive.c#L209
