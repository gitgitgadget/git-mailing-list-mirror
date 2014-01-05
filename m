From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 2/4] completion: introduce __gitcomp_nl_append ()
Date: Sun,  5 Jan 2014 15:48:03 +0530
Message-ID: <1388917085-18701-3-git-send-email-artagnon@gmail.com>
References: <1388917085-18701-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 05 11:18:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vzkmm-0002wf-Ge
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 11:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbaAEKSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 05:18:12 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:56927 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbaAEKSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 05:18:09 -0500
Received: by mail-pd0-f177.google.com with SMTP id q10so16945142pdj.36
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 02:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ZKvy3f4hBGrSh5u0WBKKfndBI+a62LdUGeShQ0jw+A=;
        b=gm1FWmGlj+kKyuqXoREORJfCWS6DAySocrb7J0qLqF4xng8pFqZapMytODFrtLQxbt
         f4N1rqfBEiId0F4LM1sbrtA4myEVuoC4w+pc3A64Og3RqxcjBV6jA1s5Wj5w+ZdQBeIm
         W9u98tisPp4ipc6zjFFawhmMQFRy4bglkPpmGTBwVUkKdv+FZYzQWZuehGmE8VlCJIoc
         7+hx1Fkh7tDQm3FlseBcKJaTCfwe/skNfDpf/Ju2zzGxZVnmOGruqlyyUFh8oNdcxrIS
         GKWnik+D962r8UUMqqR95GMA2eQ4rZTXstYFFRDZfi9yrkMtTSaiE9qhs6xbsqTsXiiv
         vP5A==
X-Received: by 10.68.170.225 with SMTP id ap1mr113201025pbc.117.1388917088764;
        Sun, 05 Jan 2014 02:18:08 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id fk4sm25113615pab.23.2014.01.05.02.18.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jan 2014 02:18:07 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388917085-18701-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239965>

There are situations where multiple classes of completions possible. For
example

  branch.<TAB>

should try to complete

  branch.master.
  branch.autosetupmerge
  branch.autosetuprebase

The first candidate has the suffix ".", and the second/ third candidates
have the suffix " ". To facilitate completions of this kind, create a
variation of __gitcomp_nl () that appends to the existing list of
completion candidates, COMPREPLY.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 22 ++++++++++++++++++----
 contrib/completion/git-completion.zsh  |  8 ++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 51c2dd4..20febff 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -178,9 +178,9 @@ _get_comp_words_by_ref ()
 }
 fi
 
-__gitcompadd ()
+__gitcompappend ()
 {
-	local i=0
+	local i=${#COMPREPLY[@]}
 	for x in $1; do
 		if [[ "$x" == "$3"* ]]; then
 			COMPREPLY[i++]="$2$x$4"
@@ -188,6 +188,12 @@ __gitcompadd ()
 	done
 }
 
+__gitcompadd ()
+{
+	COMPREPLY=()
+	__gitcompappend "$@"
+}
+
 # Generates completion reply, appending a space to possible completion words,
 # if necessary.
 # It accepts 1 to 4 arguments:
@@ -218,6 +224,14 @@ __gitcomp ()
 	esac
 }
 
+# Variation of __gitcomp_nl () that appends to the existing list of
+# completion candidates, COMPREPLY.
+__gitcomp_nl_append ()
+{
+	local IFS=$'\n'
+	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
+}
+
 # Generates completion reply from newline-separated possible completion words
 # by appending a space to all of them.
 # It accepts 1 to 4 arguments:
@@ -229,8 +243,8 @@ __gitcomp ()
 #    appended.
 __gitcomp_nl ()
 {
-	local IFS=$'\n'
-	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
+	COMPREPLY=()
+	__gitcomp_nl_append "$@"
 }
 
 # Generates completion reply with compgen from newline-separated possible
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 6fca145..6b77968 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -76,6 +76,14 @@ __gitcomp_nl ()
 	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 }
 
+__gitcomp_nl_append ()
+{
+	emulate -L zsh
+
+	local IFS=$'\n'
+	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+}
+
 __gitcomp_file ()
 {
 	emulate -L zsh
-- 
1.8.5.2.227.g53f3478
