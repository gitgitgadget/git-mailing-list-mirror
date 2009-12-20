From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] rebase -i: print the editor name if it fails to launch
Date: Sun, 20 Dec 2009 09:32:50 +0100
Message-ID: <4B2DE132.1080700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 09:33:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMHDo-0004RO-4J
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 09:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbZLTIcy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2009 03:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbZLTIcy
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 03:32:54 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:65144 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZLTIcx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2009 03:32:53 -0500
Received: by ewy1 with SMTP id 1so5175121ewy.28
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 00:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=v50yu8bHLXGZrwanN0iclu/21zx1pOZPcAZm81ur8Mg=;
        b=RyWKSbLXbryQOR2t01jLOB8UKrNP1PIDi1UTqoM+2Qb9Sqx9zU6nav+1KP6wSYBNRR
         jJ+SYnAi4hSaLoEfer9xpLJqheiCQriDTykq09jeJh8hK1QrJ7qvFjrKYzj3u3EYzMV0
         K9QiI4Z0YwTo2kznOzGnT6kXeQcg3ycHZp8wU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=BqcTH9noL15D29I/AL1+hRW+0I4QTPIN5mUsxyjBVBtOh0jKviCcFsfBfwTCKxLPx5
         C6v/xCh+24QlSg4U/wIx5UMenD5NndxIe8pSCkmJuh/9qrUZIK+IlvG/rn/paJjQ/+Mt
         49Y/3bLiKZFZ9kfXuOXh5lEycaQ4D3BpcV8Jg=
Received: by 10.213.96.221 with SMTP id i29mr7420233ebn.96.1261297971953;
        Sun, 20 Dec 2009 00:32:51 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 15sm3050616ewy.8.2009.12.20.00.32.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Dec 2009 00:32:51 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135524>

The "git rebase -i" commands simply prints "Could not execute
editor" if the editor fails to launch.

Be a little bit more helpful and be consistent with the
built-in commands that use launch_editor() and also print
the name of the editor that failed to launch.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
Here is a suggestion for how "git rebase -i" can be a
little bit more helpful if it fails to launch the editor.
This patch can be applied on top of my previous patch.

I am not sure whether "git am" also should be modified
to call git_editor_error_string. Currently it ignores
any errors from the call to git_editor. Should it abort
if there is an error or should it print a warning like this

echo "Warning: $(git_editor_error_string)"

if the editor fails to launch?

Grepping all *.sh files, I found no other references
to git_editor.

 git-rebase--interactive.sh |    3 +--
 git-sh-setup.sh            |    9 +++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d529328..a08a813 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -778,8 +778,7 @@ EOF
 			die_abort "Nothing to do"
=20
 		cp "$TODO" "$TODO".backup
-		git_editor "$TODO" ||
-			die_abort "Could not execute editor"
+		git_editor "$TODO" || die_abort "$(git_editor_error_string)"
=20
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index dfcb807..36782ec 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -107,6 +107,15 @@ git_editor() {
 	eval "$GIT_EDITOR" '"$@"'
 }
=20
+git_editor_error_string() {
+	if test -z "${GIT_EDITOR:+set}"
+	then
+		GIT_EDITOR=3D"$(git var GIT_EDITOR)" ||
+		(echo "No editor configured."; return 0)
+	fi
+	echo "There was a problem with the editor '$GIT_EDITOR'."
+}
+
 sane_grep () {
 	GREP_OPTIONS=3D LC_ALL=3DC grep "$@"
 }
--=20
1.6.6.rc3.2.ge3899
