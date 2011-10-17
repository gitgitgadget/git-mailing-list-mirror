From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [PATCH] Allow to specify the editor used for git rebase -i by config/environment var
Date: Mon, 17 Oct 2011 22:26:23 +0200
Message-ID: <57346812.Rh0UlzroDp@soybean>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Junio C Hamano <gitster@pobox.com>, Phil Hord <phil.hord@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 22:27:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFtmA-0003Yc-MK
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 22:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab1JQU1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 16:27:05 -0400
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:55208 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753762Ab1JQU1D (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 16:27:03 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mx.arcor.de (Postfix) with ESMTP id D8BD7CBC3E;
	Mon, 17 Oct 2011 22:26:59 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 96FB7175470;
	Mon, 17 Oct 2011 22:26:59 +0200 (CEST)
Received: from soybean.localnet (88-117-55-195.adsl.highway.telekom.at [88.117.55.195])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-11.arcor-online.net (Postfix) with ESMTPSA id 7CFE035A366;
	Mon, 17 Oct 2011 22:26:59 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-11.arcor-online.net 7CFE035A366
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1318883219; bh=4P8hz1e9wLvgv/vSXssP1ZQ7CXktVDKMxDj1R+HPWKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Xx1HW4kyvg5xRwyPrWofPhiLLqDg5d76YvF7KtNNTJMzfWkoT2sAnkAQKktVMu8kq
	 stLxuro4nPfStRz6dQClLwq2zS5oOxlZOQQUagce5yvKACzwtdEbKmFzCHBdgEEGJ8
	 F1ABTxD0bIBzlxNPu/yGUlse+URKCs1nXAh7A7rw=
User-Agent: KMail/4.7.2 (Linux/3.0.0-12-generic-pae; KDE/4.7.1; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183819>

The search order for choosing the sequence editor is:
$GIT_SEQUENCE_EDITOR
git config sequence.editor
git var GIT_EDITOR (default editor for commit messages)

With this change is it possible to have a separate
(possibly graphical) editor that helps the user
during a interactive rebase.

Using $GIT_EDITOR or core.editor config var for this is not possible
since they is also used to start the commit message editor for reword action.

Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
---
I reworded the commit message and the config description a bit.
renamed to sequence.editor / $GIT_SEQUENCE_EDITOR
and moved the helper to git-rebase--interactive.sh

 Documentation/config.txt   |    7 +++++++
 git-rebase--interactive.sh |   15 ++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 03296b7..048c5f9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -473,6 +473,13 @@ core.editor::
 	variable when it is set, and the environment variable
 	`GIT_EDITOR` is not set.  See linkgit:git-var[1].
 
+sequence.editor::
+	Text editor used by git rebase -i for editing the rebase todo file.
+	The value is meant to be interpreted by the shell when it is used.
+	It can be overridden by the 'GIT_SEQUENCE_EDITOR' environment variable.
+	When not configured the default commit message editor is used instead.
+	See linkgit:git-var[1]
+
 core.pager::
 	The command that git will use to paginate output.  Can
 	be overridden with the `GIT_PAGER` environment
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 94f36c2..13a0661 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -161,6 +161,19 @@ do_with_author () {
 	)
 }
 
+git_sequence_editor() {
+	if test -z "${GIT_SEQUENCE_EDITOR:+set}"
+	then
+		GIT_SEQUENCE_EDITOR="$(git config sequence.editor)"
+		if [ -z "$GIT_SEQUENCE_EDITOR" ]
+		then
+			GIT_SEQUENCE_EDITOR="$(git var GIT_EDITOR)" || return $?
+		fi
+	fi
+
+	eval "$GIT_SEQUENCE_EDITOR" '"$@"'
+}
+
 pick_one () {
 	ff=--ff
 	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
@@ -832,7 +845,7 @@ has_action "$todo" ||
 	die_abort "Nothing to do"
 
 cp "$todo" "$todo".backup
-git_editor "$todo" ||
+git_sequence_editor "$todo" ||
 	die_abort "Could not execute editor"
 
 has_action "$todo" ||
-- 
1.7.7.329.g2140c
