From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [RFC/WIP PATCH] Use config value rebase.editor as editor when starting git rebase -i
Date: Tue, 11 Oct 2011 19:56:08 +0200
Message-ID: <201110111956.08829.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 19:58:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDgav-0002mS-1T
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 19:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254Ab1JKR6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 13:58:18 -0400
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:40302 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755211Ab1JKR6R (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2011 13:58:17 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id 9261A885E
	for <git@vger.kernel.org>; Tue, 11 Oct 2011 19:58:15 +0200 (CEST)
Received: from mail-in-18.arcor-online.net (mail-in-18.arcor-online.net [151.189.21.58])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 8CCBE9DB7F
	for <git@vger.kernel.org>; Tue, 11 Oct 2011 19:58:15 +0200 (CEST)
Received: from soybean.localnet (188-22-107-88.adsl.highway.telekom.at [188.22.107.88])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-18.arcor-online.net (Postfix) with ESMTPSA id 5A2F115C002
	for <git@vger.kernel.org>; Tue, 11 Oct 2011 19:58:15 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-18.arcor-online.net 5A2F115C002
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1318355895; bh=Dg4p1heUc5IKkSLEQgyFfhVjyhlLpVJsTahSOWClgIo=;
	h=Subject:From:To:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id;
	b=VDbnjQl/Hysxi0FG7gFa1rSkSxomfTsNDnoVFOsflt69hbmJ2p9H1kuQ83x3/ICPw
	 7Ie6O+KqYvrGZIl8vHiSmv1Ih8vD+8hu1/5LjSO5mfbklY4Nl2zgkKHZe1m9sO1vwr
	 lPRVSSaJQiAhea1giIMfo86zFBU7iGDlS9U8+W5k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183314>

If rebase.editor is not set interactive rebase falls back
to the default editor.

With this change is it possible to have a separate
(possibly graphical) editor that helps the user
during a interactive rebase.

Using $GIT_EDITOR or core.editor config var for this is not possible
since it is also used to start the commit message editor for reword action.

Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
---
Hi,

i wrote a (not yet released) git rebase -i helper that allows to order commits
by drag/drop and allows to select the action from a combo box.
(written in Qt)
See http://i55.tinypic.com/2d94gg0.jpg for how it currently looks like. :-)
No more typos, no more lost commit by cutting without pasting...

To integrate this properly into git i need something like this patch.

Open questions/problems:
* GIT_EDITOR env var is not honored anymore after this change.
  Help from somebody with more bash knowledge is highly appreciated!

* Should git_rebase_editor be in git-rebase--interactive.sh instead
  (since it is only used there)

* How should the config be called?
  It is not directly used during rebase, only during rebase -i
  that might not be fully clear from the config name.

* Better config.txt description?

Thanks,
Greetings Peter

PS: My tool will hopefully be released soon.
Cleanup code, test(lin/ win), write some doc (how to use with git),
choose name :-), choose license...

 Documentation/config.txt   |    6 ++++++
 git-rebase--interactive.sh |    2 +-
 git-sh-setup.sh            |   13 +++++++++++++
 3 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 03296b7..1d9ae79 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1591,6 +1591,12 @@ rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
 
+rebase.editor::
+	Text editor used by git rebase -i for editing the rebasse todo file.
+	The value is meant to be interpreted by the shell when it is used.
+	When not configured the default commit message editor is used instead.
+	See "core.editor"
+
 rebase.autosquash::
 	If set to true enable '--autosquash' option by default.
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 94f36c2..0f3b569 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -832,7 +832,7 @@ has_action "$todo" ||
 	die_abort "Nothing to do"
 
 cp "$todo" "$todo".backup
-git_editor "$todo" ||
+git_rebase_editor "$todo" ||
 	die_abort "Could not execute editor"
 
 has_action "$todo" ||
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 8e427da..303fb96 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -113,6 +113,19 @@ git_editor() {
 	eval "$GIT_EDITOR" '"$@"'
 }
 
+git_rebase_editor() {
+	if test -z "${GIT_REBASEI_EDITOR:+set}"
+	then
+		GIT_REBASEI_EDITOR="$(git config rebase.editor)"
+		if [ -z "$GIT_REBASEI_EDITOR" ]
+		then
+			GIT_REBASEI_EDITOR="$(git var GIT_EDITOR)" || return $?
+		fi
+	fi
+
+	eval "$GIT_REBASEI_EDITOR" '"$@"'
+}
+
 git_pager() {
 	if test -t 1
 	then
-- 
1.7.7.215.gfef80
