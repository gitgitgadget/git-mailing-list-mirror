From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: git stash doesn't honor --work-tree or GIT_WORK_TREE
Date: Sun, 01 Dec 2013 16:50:00 +0100
Message-ID: <87zjokpo47.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <CABL6xpD9jvJWjUj0n+mgC419fGzA2N-b_yJho9zharCD6YTSiw@mail.gmail.com>
	<loom.20131130T221443-682@post.gmane.org>
	<874n6sddu7.fsf@thomasrast.ch>
	<CACsJy8BFqqy8T1zwZd7Ly1-sAKGoxh0YfhFBgX6fBMTt_b5Dbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 01 16:50:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vn9Hp-0002lw-KJ
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 16:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763Ab3LAPuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Dec 2013 10:50:16 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:38931 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627Ab3LAPuO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Dec 2013 10:50:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 93C664D64FC;
	Sun,  1 Dec 2013 16:50:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ehWT747zsJqd; Sun,  1 Dec 2013 16:50:01 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (pD9EB3CC1.dip0.t-ipconnect.de [217.235.60.193])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id A6A2E4D64C4;
	Sun,  1 Dec 2013 16:50:00 +0100 (CET)
In-Reply-To: <CACsJy8BFqqy8T1zwZd7Ly1-sAKGoxh0YfhFBgX6fBMTt_b5Dbw@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 1 Dec 2013 18:50:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238590>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Dec 1, 2013 at 6:12 PM, Thomas Rast <tr@thomasrast.ch> wrote:
>> =C3=98ystein Walle <oystwa@gmail.com> writes:
>>> The problem seems to be that git rev-parse --is-inside-work-tree do=
es
>>> not honor these. In fact it doesn't even honor --git-dir or --work-=
tree.
>>> Judging by the name this may be intentional.
>>
>> Thanks for investigating this.
>>
>> Duy, you are the expert on the worktree detection logic.  Do you kno=
w if
>> there is a reason for --is-inside-work-tree to not honor the
>> GIT_WORK_TREE / GIT_DIR overrides?
>
> It should. At the beginning of cmd_rev_parse(), setup_git_directory()
> is called, which will check and follow all GIT_* or their command lin=
e
> equivalent. I'll look into this some time later.

Hrm, I'm wrong, and it's not clear what to actually do in this case.
--is-inside-work-tree works as claimed: if we can detect a git
repository and your current directory is inside it, you are "inside a
worktree".

The problem here is that shell scripts that want to do something with a
worktree tend to call require_work_tree in git-sh-setup:

require_work_tree () {
	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" =3D true ||
	die "fatal: $0 cannot be used without a working tree."
}

However, when an explicit GIT_WORK_TREE is in effect, that seems a bit
silly.  The _intent_ of that command is "I need a worktree to work
with".  But what it currently checks is something completely different,
namely "am I _inside_ the worktree".

--show-cdup might be a better candidate, because it actually (and
despite what the docs suggest, sigh) shows the path to the worktree as
with --show-toplevel for the case where you are not --is-inside-work-tr=
ee.

Which means that the output --show-cdup is in fact not necessarily "up"
from the worktree, but something you could cd to to get to its top.

Long story short, this might work (and it passes tests):


diff --git i/git-sh-setup.sh w/git-sh-setup.sh
index 190a539..47c7f1d 100644
--- i/git-sh-setup.sh
+++ w/git-sh-setup.sh
@@ -192,8 +192,12 @@ require_work_tree_exists () {
 }
=20
 require_work_tree () {
-	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" =3D true ||
+	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" =3D true &&
+	return 0
+	cdup=3D"$(git rev-parse --show-cdup 2>/dev/null)"
+	test -z "$cdup" &&
 	die "fatal: $0 cannot be used without a working tree."
+	cd "$cdup"
 }
=20
 require_clean_work_tree () {


But it would give require_work_tree somewhat interesting and unintuitiv=
e
side effects.

--=20
Thomas Rast
tr@thomasrast.ch
