From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] rebase -i: abort cleanly if the editor fails to launch
Date: Sat, 19 Dec 2009 13:04:03 +0100
Message-ID: <4B2CC133.9010704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 13:04:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLy2i-0002rS-Of
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 13:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbZLSMEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Dec 2009 07:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZLSMEK
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 07:04:10 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:46930 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbZLSMEG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 07:04:06 -0500
Received: by ewy1 with SMTP id 1so4524627ewy.28
        for <git@vger.kernel.org>; Sat, 19 Dec 2009 04:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=9aXgGDD5s9TzN699Cu+m8sV8kxt9lKEv6Ns9qCqlqDA=;
        b=ecurrp9XL4cxj5YgpR0R3nyJp2KzxU6bKIF1ht/Ecd8W7XWBhBNIR1ZfZ8QlKE3hXD
         X2TlywL1QXan+nVKql4DXu6NyqmrlhFojatY8T3vYc55brKYjk8n4REGAaj2gMYdzmRU
         YaxYDf0DiiCIr52t91SonsSfnRbiER5Fb2vK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=tytSbjISw0gnDV2CX3DEOzPFQrYVLogRP6RtpIxdhtCLDa7HYg6kI9RRWCs2/4VKrV
         UYVYr5mteefHDgmriDHY9cMxj2BC3N3/hlDsHuKzUhLTUmFqRVRgmSPo9r8BzZUKY3CI
         KJzU4rhkXOaPFBNeCyuGuPZaw28J4XUC9sMKk=
Received: by 10.213.107.131 with SMTP id b3mr11661485ebp.91.1261224244913;
        Sat, 19 Dec 2009 04:04:04 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 13sm2532133ewy.1.2009.12.19.04.04.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Dec 2009 04:04:04 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135476>

If the user's configured editor is emacsclient, the editor
will fail to launch if emacs is not running and the git
command that tried to lanuch the editor will abort. For most
commands, all you have to do is to start emacs and repeat
the command.

The "git rebase -i" command, however, aborts without cleaning
the "$GIT_DIR/rebase-merge" directory if it fails to launch the
editor, so you'll need to do "git rebase --abort" before
repeating the rebase command.

Change "git rebase -i" to terminate using "die_abort" (instead of
with "die") if the initial launch of the editor fails.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0bd3bf7..d529328 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -779,7 +779,7 @@ EOF
=20
 		cp "$TODO" "$TODO".backup
 		git_editor "$TODO" ||
-			die "Could not execute editor"
+			die_abort "Could not execute editor"
=20
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
--=20
1.6.6.rc3.dirty
