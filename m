From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/2] Fixes for git branch -m / update-ref --no-deref -d
Date: Sat, 25 Oct 2008 14:58:40 +0200
Message-ID: <cover.1224939436.git.vmiklos@frugalware.org>
References: <7v63nh1sc7.fsf@gitster.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 14:59:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktijw-00008K-E5
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 14:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbYJYM6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 08:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbYJYM6B
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 08:58:01 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:43615 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbYJYM57 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 08:57:59 -0400
Received: from vmobile.example.net (dsl5401C809.pool.t-online.hu [84.1.200.9])
	by yugo.frugalware.org (Postfix) with ESMTPA id 9BF19446CCF;
	Sat, 25 Oct 2008 14:57:56 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 4F5BF14E35; Sat, 25 Oct 2008 14:58:42 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <7v63nh1sc7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99106>

On Fri, Oct 24, 2008 at 04:33:28PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Hmm, remote_get() can read from all three supported places that you
> can
> define remotes.  Could you explain what happens if the old remote is
> read
> from say $GIT_DIR/remotes/origin and you are renaming it to "upstream"
> with "git remote rename origin upstream"?

While trying to answer your question, I noticed that
rename_ref()/delete_ref() did not really handled symrefs.

Regarding rename_ref() (for users: git branch -m) I think you can't
create symrefs in the refs/heads namespace without using plumbing, so
most users are not affected.

Regarding delete_ref() (for users: git update-ref --no-deref -d) in most
repos you just have HEAD as symref and you never want to delete it, but
in case the user asks for it, I think we just have to do so.

Here are two patches to fix these issues (and in fact they will be
required for git remote rename as well).

Miklos Vajna (2):
  Fix git branch -m for symrefs.
  Fix git update-ref --no-deref -d.

 builtin-branch.c       |    2 +-
 builtin-receive-pack.c |    2 +-
 builtin-remote.c       |    4 +-
 builtin-reset.c        |    2 +-
 builtin-send-pack.c    |    2 +-
 builtin-tag.c          |    2 +-
 builtin-update-ref.c   |    8 ++++--
 cache.h                |    2 +-
 refs.c                 |   56 ++++++++++++++++++++++++++++++------------------
 t/t1400-update-ref.sh  |    7 ++++++
 t/t3200-branch.sh      |    9 +++++++
 11 files changed, 64 insertions(+), 32 deletions(-)
