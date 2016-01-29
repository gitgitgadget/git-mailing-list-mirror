From: Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Re: Bugs in git filter-branch (git replace related)
Date: Fri, 29 Jan 2016 18:24:07 +0000 (UTC)
Message-ID: <n8gao5$3c6$1@ger.gmane.org>
References: <loom.20160128T153147-396@post.gmane.org> <20160129061820.GB23106@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 19:24:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPDie-0007Tq-BF
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 19:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901AbcA2SYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2016 13:24:23 -0500
Received: from plane.gmane.org ([80.91.229.3]:51672 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756768AbcA2SYV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 13:24:21 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aPDiT-0007J1-U1
	for git@vger.kernel.org; Fri, 29 Jan 2016 19:24:17 +0100
Received: from fokus169149.fokus.fraunhofer.de ([194.95.169.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2016 19:24:17 +0100
Received: from anatoly.borodin by fokus169149.fokus.fraunhofer.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2016 19:24:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: fokus169149.fokus.fraunhofer.de
User-Agent: tin/2.3.1-20141224 ("Tallant") (UNIX) (Linux/4.2.0-25-generic (x86_64))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285082>

Hi Jeff,


I've created a gist with the script
https://gist.github.com/anatolyborodin/6505a364a68584f13846

I've added some changes and a second test (will be discussed in the
comments).


Jeff King <peff@peff.net> wrote:
> I'm not sure if this is a bug or not. The "empty commit" check works =
by
> checking the tree sha1s, without doing a full diff respecting replace
> refs.
>=20
> You're expecting git to notice a tree change, even though it never ev=
en
> examined the tree in the first place (because you didn't give it a tr=
ee
> or index filter).

When git-filter-branch(1) says "If you have any grafts or replacement
refs defined, running this command will make them permanent.", and it
doesn't work like that because of some optimization, it *is* a bug.

> Try:
>=20
>   git filter-branch --prune-empty --tree-filter true master
>=20
> which will force git to go through the motions of checking out the
> replaced content and re-examining it.

Thank you, I've added this command to the script, and it works! I think
it should be added to git-filter-branch(1), if there is no other way to
rewrite the optimization.

>> Bug 2: the replace refs are not ignored (they can epresent blobs, tr=
ees etc,
>> but even if they represent commits - should they be rewritten?).
>=20
> You told it "--all", which is passed to rev-list, where it means "all
> refs". I agree that running filter-branch on refs/replace is probably
> not going to yield useful results, but I'm not sure if it is
> filter-branch's responsibility to second-guess the rev-list options.

Look how `git log --all` works (see the second test in the script): it
ignores (without any messages) the blobs, and writes only the commits.
=46or example, the same commit log message is printed twice in the seco=
nd
testcase.

Maybe it makes sence, I don't know. I would suggest that all
refs/replace/* heads should be ignored by `git log`. `git rev-list
--no-replace` maybe?

> Probably the documentation for filter-branch should recommend
> "--branches --tags" instead of "--all", though.

Or redefine `--all` as "all refs excepting refs/replace/*". Who would
really want to run `--all` the way it works now?

The blobs replaces should be ignored, as in `git log --all`. Is there
any reason to rewrite refs/rebase/hash if it's a replace commit?


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Anatoly Borodin
