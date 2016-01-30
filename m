From: Eric Wong <normalperson@yhbt.net>
Subject: clones over rsync broken?
Date: Sat, 30 Jan 2016 05:11:33 +0000
Message-ID: <20160130051133.GA21973@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 06:12:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPNpd-0006jh-B5
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 06:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbcA3FLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 00:11:35 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:46657 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbcA3FLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 00:11:34 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61CDA1F736;
	Sat, 30 Jan 2016 05:11:33 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285099>

I have not used rsync remotes in ages, but I was working on the
patch for -4/-6 support and decided to test it against rsync.kernel.org

Cloning git.git takes forever and failed with:

$ git clone rsync://rsync.kernel.org/pub/scm/git/git.git
Checking connectivity... fatal: bad object ecdc6d8612df80e871ed34bb6c3b01b20b0b82e6
fatal: remote did not send all necessary objects

git.git is gigantic and I haven't looked closely, and that may not be
a git bug...

However, trying to clone a smaller repo like pahole.git via rsync fails
differently; this looks more like a git bug:

$ git clone rsync://rsync.kernel.org/pub/scm/devel/pahole/pahole.git
fatal: Multiple updates for ref 'refs/remotes/origin/master' not allowed.

Using rsync(1) manually to grab pahole.git and inspecting the bare
repo with yields no anomalies with "git fsck --full".
$GIT_DIR/info/refs and $GIT_DIR/packed-refs both look fine, but
perhaps it's confused by the existence of $GIT_DIR/refs/heads/master
as a loose ref?

I tried dumping the refnames with the following patch and can see
refs/remotes/origin/master is the only duplicated ref:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c648b5e..e0cb0ab 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3112,6 +3112,8 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	int i, n = refnames->nr;
 
 	assert(err);
+	for (i = 0; i < n; i++)
+		fprintf(stderr, "ref: %s\n", refnames->items[i].string);
 
 	for (i = 1; i < n; i++)
 		if (!strcmp(refnames->items[i - 1].string, refnames->items[i].string)) {

And the output is:

ref: refs/remotes/origin/master
ref: refs/remotes/origin/master
ref: refs/tags/v1.0
ref: refs/tags/v1.1
ref: refs/tags/v1.10
ref: refs/tags/v1.2
ref: refs/tags/v1.3
ref: refs/tags/v1.4
ref: refs/tags/v1.5
ref: refs/tags/v1.6
ref: refs/tags/v1.7
ref: refs/tags/v1.8
ref: refs/tags/v1.8pre1
ref: refs/tags/v1.9

Not sure what exactly is going on, my git internal API knowledge is not
great.  Anyways, this is without any of my pending patches, and I was
also able to reproduce a slightly different error with the Debian wheezy
version (1.7.10.4) with:

fatal: Duplicated ref, and SHA1s don't match: refs/remotes/origin/master
