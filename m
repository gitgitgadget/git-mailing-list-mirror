From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 3/3] completion: add new zsh completion
Date: Mon, 22 Oct 2012 03:45:42 +0200
Message-ID: <1350870342-22653-4-git-send-email-felipe.contreras@gmail.com>
References: <1350870342-22653-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 03:46:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ75x-0002tq-Kn
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 03:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799Ab2JVBqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 21:46:04 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47837 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688Ab2JVBqD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 21:46:03 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1802046wgb.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 18:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WVSj82kQtRbdz4Knbaessncai7EaswylHzPFq4WLmzk=;
        b=bQBFnIbQk5YUfRpn89Sc++oBXKLWArJ8flXY66vMbStEQ7X1NcmBmNAgpD1ITfTG1u
         JCpbcHPzVvvZQbu8LIHOvVMf0lfayKW9krUiGrZ1ofhbNzYqVUWUcgMtTrMNAkDWVcrr
         haxbtcK0UOTEBwvVhMhZmxJjowDqYaKbTirD2/jp50XR7LBI3WA6KwQDscEzz1NCAejL
         I5NDB3dIm/2ynlDUrReDet1NpvGmrNg33rjd5ueiX2Iw/z0vnsEHkW+xqaInZirSnHMF
         1ej5lC8drPTTfxaXNRaTwLvICmUxt/5Td9hL1GhteIlTMwgiD/1Fs4lTd4blDd3nzDdK
         22KA==
Received: by 10.180.91.71 with SMTP id cc7mr17576944wib.2.1350870362640;
        Sun, 21 Oct 2012 18:46:02 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id hb6sm11891473wib.7.2012.10.21.18.46.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 18:46:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1350870342-22653-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208173>

It seems there's always issues with zsh's bash completion emulation.
I've tried to fix as many as I could and most of the fixes are already
in the latest version of zsh, but still, there are issues.

There is no point in going through all that pain; the emulation is easy
to achieve, and this patch works better than zsh's emulation.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

v5:

 * Even more simplification by using __gitcompadd

v4:

 * Simplification updates for the latest bash completion

v3:

 * Simplification
 * Avoid COMPREPLY; call compadd directly
 * Fix _get_comp_words_by_ref

 contrib/completion/git-completion.zsh | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 contrib/completion/git-completion.zsh

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
new file mode 100644
index 0000000..ae9c532
--- /dev/null
+++ b/contrib/completion/git-completion.zsh
@@ -0,0 +1,48 @@
+#compdef git gitk
+
+# zsh completion wrapper for git
+#
+# You need git's bash completion script installed somewhere, by default on the
+# same directory as this script.
+#
+# If your script is on ~/.git-completion.sh instead, you can configure it on
+# your ~/.zshrc:
+#
+#  zstyle ':completion:*:*:git:*' script ~/.git-completion.sh
+#
+# The recommended way to install this script is to copy to
+# '~/.zsh/completion/_git', and then add the following to your ~/.zshrc file:
+#
+#  fpath=(~/.zsh/completion $fpath)
+
+complete ()
+{
+	# do nothing
+	return 0
+}
+
+zstyle -s ":completion:*:*:git:*" script script
+test -z "$script" && script="$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
+ZSH_VERSION='' . "$script"
+
+__gitcompadd ()
+{
+	compadd -Q -S "$4" -P "${(M)cur#*[=:]}" -p "$2" -- ${=1} && _ret=0
+}
+
+_git ()
+{
+	local _ret=1
+	() {
+		emulate -L ksh
+		local cur cword prev
+		cur=${words[CURRENT-1]}
+		prev=${words[CURRENT-2]}
+		let cword=CURRENT-1
+		__${service}_main
+	}
+	let _ret && _default -S '' && _ret=0
+	return _ret
+}
+
+_git
-- 
1.8.0
