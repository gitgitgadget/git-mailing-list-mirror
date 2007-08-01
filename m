From: David Kastrup <dak@gnu.org>
Subject: [PATCH] git-sh-setup.sh: make GIT_EDITOR/core.editor/VISUAL/EDITOR accept commands
Date: Wed, 1 Aug 2007 23:47:20 +0200
Organization: Organization?!?
Message-ID: <S1752099AbXHAXHc/20070801230732Z+342@vger.kernel.org>
References: <85ejimrjb2.fsf@lola.goethe.zz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 01:07:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGNHz-0000OK-2f
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 01:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbXHAXHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 19:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbXHAXHc
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 19:07:32 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:38480 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751699AbXHAXHb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 19:07:31 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 06DA51F577C
	for <git@vger.kernel.org>; Thu,  2 Aug 2007 01:07:30 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id E6B712C6A1A
	for <git@vger.kernel.org>; Thu,  2 Aug 2007 01:07:29 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-058-172.pools.arcor-ip.net [84.61.58.172])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id C913F11CD8
	for <git@vger.kernel.org>; Thu,  2 Aug 2007 01:07:29 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id C3D101C3E076; Thu,  2 Aug 2007 01:06:39 +0200 (CEST)
In-Reply-To: <85ejimrjb2.fsf@lola.goethe.zz>
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
X-Virus-Scanned: ClamAV version 0.91.1, clamav-milter version 0.91.1 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54496>

The previous code only allowed specifying a single executable rather
than a complete command like "emacsclient --alternate-editor vi" in
those variables.  Since VISUAL/EDITOR appear to be traditionally
passed to a shell for interpretation (as corroborated with "less",
"mail" and "mailx", while the really ancient "more" indeed allows only
an executable name), the shell function git_editor has been amended
appropriately.

"eval" is employed to have quotes and similar interpreted _after_
expansion, so that specifying
EDITOR='"/home/dak/My Commands/notepad.exe"'
can be used for actually using commands with blanks.

Instead of passing just the first argument of git_editor on, we pass
all of them (so that +lineno might be employed at a later point of
time, or so that multiple files may be edited when appropriate).

Strictly speaking, there is a change in behavior: when
git config core.editor
returns a valid but empty string, the fallbacks are still searched.
This is more consistent, and the old code was problematic with regard
to multiple blanks.  Putting in additional quotes might have worked,
but quotes inside of command substitution inside of quotes is nasty
enough to not reliably work the same across "Bourne shells".

Signed-off-by: David Kastrup <dak@gnu.org>
---
 git-sh-setup.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c51985e..3c50bc1 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -29,7 +29,8 @@ set_reflog_action() {
 }
 
 git_editor() {
-	GIT_EDITOR=${GIT_EDITOR:-$(git config core.editor || echo ${VISUAL:-${EDITOR}})}
+	: "${GIT_EDITOR:=$(git config core.editor)}"
+	: "${GIT_EDITOR:=${VISUAL:-${EDITOR}}}"
 	case "$GIT_EDITOR,$TERM" in
 	,dumb)
 		echo >&2 "No editor specified in GIT_EDITOR, core.editor, VISUAL,"
@@ -40,7 +41,7 @@ git_editor() {
 		exit 1
 		;;
 	esac
-	"${GIT_EDITOR:-vi}" "$1"
+	eval "${GIT_EDITOR:=vi}" '"$@"'
 }
 
 is_bare_repository () {
-- 
1.5.3.rc2.86.gdc7ba
