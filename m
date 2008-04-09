From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] (parsecvs) avoid "git mktag" failure with newer git
Date: Wed, 09 Apr 2008 12:01:34 +0200
Message-ID: <871w5fz6rl.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: keithp@keithp.com
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 09 12:02:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjX8I-0000O1-37
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 12:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbYDIKBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 06:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbYDIKBh
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 06:01:37 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:46914 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbYDIKBg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 06:01:36 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 35A8A17B5BA
	for <git@vger.kernel.org>; Wed,  9 Apr 2008 12:01:35 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E38BE17B559
	for <git@vger.kernel.org>; Wed,  9 Apr 2008 12:01:34 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id A1EF59064;
	Wed,  9 Apr 2008 12:01:34 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79093>

With recent git, parsecvs now always fails like this:

  ...
  Save:                              master *....................     1 of   269
  Save:                              master *....................     2 of   269
  error: char77: malformed tagger field
  fatal: invalid tag signature file
  git-mktag < '.git-cvs/tag-0': No such file or directory

This is due to the change that makes git's mktag perform
stricter input validation.  parsecvs patch below.

[BTW, Keith, or anyone with write access to the parsecvs repo,
 I have a few other patches, but a few I sent have gone un-applied
 and with no response for months, I'm hoping there's a maintained
 repository somewhere else.

 I've been using this: git://people.freedesktop.org/~keithp/parsecvs

 Today's failure nearly pushed me to cvs2git (aka cvs2svn
 http://cvs2svn.tigris.org/cvs2git.html), which I hear is good,
 although still pretty new.  Since this fix was easy, I'm sticking
 with parsecvs for now. ]

>From 9c6ca141e82fae93ff173b87a27c118c5e87547c Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Wed, 9 Apr 2008 11:53:29 +0200
Subject: [PATCH] avoid "git mktag" failure with newer git

* git.c (git_mktag): Emit full tagger information, now that
git's mktag (since git's 5fbd0a44cfee7be96fe29b9252f34b8f1bce9ac5
on 2008-04-02) is more strict about it.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 git.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 614069d..a1828ef 100644
--- a/git.c
+++ b/git.c
@@ -371,11 +371,13 @@ git_mktag (rev_commit *commit, char *name)
 		"object %s\n"
 		"type commit\n"
 		"tag %s\n"
-		"tagger %s\n"
+		"tagger %s <%s> %lu +0000\n"
 		"\n",
 		commit->sha1,
 		name,
-		author ? author->full : commit->author);
+		author ? author->full : commit->author,
+		author ? author->email : commit->author,
+		commit->date);
     if (rv < 1) {
 	fprintf (stderr, "%s: %s\n", filename, strerror (errno));
 	fclose (f);
--
1.5.5.rc3.14.g78bf3
