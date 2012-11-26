From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 0/4] git-submodule add: Add --local-branch option
Date: Mon, 26 Nov 2012 16:00:15 -0500
Message-ID: <cover.1353962698.git.wking@tremily.us>
References: <20121123175402.GH2806@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:02:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5oV-00058l-9F
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 22:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328Ab2KZVB3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2012 16:01:29 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:62412 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab2KZVB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 16:01:27 -0500
Received: from odin.tremily.us ([unknown] [72.68.108.240])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME4008XI51QGCB0@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 26 Nov 2012 15:01:08 -0600 (CST)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id E17B26DEFC7; Mon,
 26 Nov 2012 16:01:01 -0500 (EST)
X-Mailer: git-send-email 1.8.0.3.g95edff1.dirty
In-reply-to: <20121123175402.GH2806@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210491>

=46rom: "W. Trevor King" <wking@tremily.us>

On Fri, Nov 23, 2012 at 12:54:02PM -0500, W. Trevor King wrote:
> We could add
>
>   $ git submodule update --branch
>
> to checkout the gitlinked SHA1 as submodule.<name>.branch in each of
> the submodules, leaving the submodules on the .gitmodules-configured
> branch.  Effectively (for each submodule):
>
>   $ git branch -f $branch $sha1
>   $ git checkout $branch

I haven't gotten any feedback on this as an idea, but perhaps someone
will comment on it as a patch series ;).

Changes since v3:

* --record=3D=E2=80=A6 is now --local-branch=3D=E2=80=A6
* Dropped patches 2 ($submodule_ export) and 3 (motivating documentatio=
n)
* Added local git-config overrides of .gitmodules' submodule.<name>.bra=
nch
* Added `submodule update --branch`

Because you need to recurse through submodules for `update --branch`
even if "$subsha1" =3D=3D "$sha1", I had to amend the conditional
controlling that block.  This broke one of the existing tests, which I
"fixed" in patch 4.  I think a proper fix would involve rewriting

  (clear_local_git_env; cd "$sm_path" &&
   ( (rev=3D$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
    test -z "$rev") || git-fetch)) ||
  die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"

but I'm not familiar enough with rev-list to want to dig into that
yet.  If feedback for the earlier three patches is positive, I'll work
up a clean fix and resubmit.

W. Trevor King (4):
  git-submodule add: Add --local-branch option
  git-submodule init: Record submodule.<name>.branch in repository
    config.
  git-submodule update: Add --branch option
  Hack fix for 'submodule update does not fetch already present
    commits'

 Documentation/config.txt        |  9 ++---
 Documentation/git-submodule.txt | 32 ++++++++++++-----
 Documentation/gitmodules.txt    |  5 +++
 git-submodule.sh                | 76 +++++++++++++++++++++++++++++++++=
--------
 t/t7400-submodule-basic.sh      | 43 +++++++++++++++++++++++
 t/t7406-submodule-update.sh     | 50 ++++++++++++++++++++++++++-
 6 files changed, 187 insertions(+), 28 deletions(-)

--=20
1.8.0.3.g95edff1.dirty
