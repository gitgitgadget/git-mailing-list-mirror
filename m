From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] push optimizations
Date: Wed, 02 Jul 2008 08:12:06 +0200
Message-ID: <20080702060113.11361.39006.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 08:14:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDvbb-0001en-Hu
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 08:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbYGBGNL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2008 02:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754425AbYGBGNL
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 02:13:11 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1106 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400AbYGBGNK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 02:13:10 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KDva1-000714-00; Wed, 02 Jul 2008 07:12:37 +0100
User-Agent: StGIT/0.14.3.182.gb4dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87087>

Here's the git-apply call you asked for. You were right: it was a huge
speed-up. I set up a benchmark to test it:

  * 32 directories, each containing 32 subdirectories, each containing
    32 small (and different) files.

  * A series of 250 patches that each add a line to one of the files.

  * An "upstream" that adds a line first in every file.

  * I set all this up with a python script feeding fast-import. A huge
    time-saver!

  * Pop patches, git-reset to upstream, then goto top patch. This
    makes sure that we use the new infrastructure to push, and that we
    get one file-level conflict in each patch.

Before the first patch, the "goto" command took 4:27 minutes,
wall-clock time. After the first patch, it took 1:31. After the
second, 0:48; one second or so slower than the stable branch (which
does not have a patch stack log).

Available in kha/experimental.

---

Karl Hasselstr=C3=B6m (2):
      Reuse the same temp index in a transaction
      Do simple in-index merge with diff+apply instead of read-tree


 stgit/lib/git.py         |   52 +++++++++++++++++++++++++++++++-------=
--------
 stgit/lib/transaction.py |   12 ++++++++++-
 2 files changed, 46 insertions(+), 18 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
