From: Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: A different bug in git-filter-branch (v2.7.0)
Date: Mon, 8 Feb 2016 23:55:37 +0000 (UTC)
Message-ID: <n9b9tp$gbr$1@ger.gmane.org>
References: <loom.20160128T153147-396@post.gmane.org> <20160129061820.GB23106@sigill.intra.peff.net> <n8gao5$3c6$1@ger.gmane.org> <20160129231127.GA31798@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 00:55:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSvet-0001sw-GP
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 00:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404AbcBHXzt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 18:55:49 -0500
Received: from plane.gmane.org ([80.91.229.3]:59736 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756366AbcBHXzr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 18:55:47 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aSvei-0001ds-4w
	for git@vger.kernel.org; Tue, 09 Feb 2016 00:55:44 +0100
Received: from x4db398ac.dyn.telefonica.de ([77.179.152.172])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 00:55:44 +0100
Received: from anatoly.borodin by x4db398ac.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 00:55:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x4db398ac.dyn.telefonica.de
User-Agent: tin/2.3.2-20151224 ("Glenavullen") (UNIX) (FreeBSD/10.2-STABLE (i386))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285828>

Hi Jeff,


unfortunately, `--tree-filter true` doesn't solve the problem with the
repo at my work: not all old blobs are replaced with the new ones. I've
made a test repository to demonstrate it; it's a huge one (115M), but I
couldn't make it much smaller, because the bug fails to reproduce if th=
e
repo is not big enough:

https://github.com/anatolyborodin/git-filter-branch-bug

There are some description and instructions in `README.md`. I hope you
will be able to reproduce it on your machine, if not - just add more
files :)

I've debugged the test case and found the place where `git diff-index`
behaves differently regarding `aa/bb.dat`:

read-cache.c +351	ie_match_stat():
=2E..
	if (!changed && is_racy_timestamp(istate, ce)) {
		if (assume_racy_is_modified)
			changed |=3D DATA_CHANGED;
		else
			changed |=3D ce_modified_check_fs(ce, st);
	}
=2E..

After `git-checkout-index` the blob hash for `aa/bb.dat` in the index i=
s
88a0f09b9b2e4ccf2faec89ab37d416fba4ee79d (the huge binary), but the fil=
e
on disk is a text file "This file was to big, and it has been removed."
with the hash 16e0939430610600301680d5bf8a24a22ff8b6c4.

In the case of a "good behaving" commit, the timestamps of the index an=
d
the cache entry are the same, is_racy_timestamp() returns 1, and
ce_modified_check_fs() finds that the content of the file has changed.
`git diff-index` lists the file `aa/bb.dat`.

In the case of a "bad behaving" commit, the timestamps of the index and
the cache entry are different (the index is 1 second newer),
is_racy_timestamp() returns 0, and the file is assumed unchanged; `git
diff-index` prints nothing.

I don't know if it should be considered to be a bug in in the logic of
`git checkout-index`, or `git diff-index` / `git update-index`.


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Anatoly Borodin
