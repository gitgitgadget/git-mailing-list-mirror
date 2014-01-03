From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 2/4] completion: introduce __gitcomp_2 ()
Date: Fri,  3 Jan 2014 13:30:29 +0530
Message-ID: <1388736031-6068-3-git-send-email-artagnon@gmail.com>
References: <1388736031-6068-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 03 09:00:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VyzgX-0005Md-Ah
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 09:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbaACIAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 03:00:43 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:61268 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbaACIAl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 03:00:41 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so15013724pdj.23
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 00:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YF50ZoWYTrtCwbajaylklEgMzxlwhgMvKnZ154I84Fk=;
        b=SH5hnGfDZvVSrRGVJugigTzmFqUFRihoNlQe5Qr09ATmuv20E08m4WhqtFa2wVwnkW
         Y9/RganXQi/IfUBXhmHXM0H1+8SFu2Ova7HHwuyoAVwrC2Kdj29HIGEioUdGUTSYUbTJ
         NNXIKNWOV+HSHlETXocf1quwDETi0lY/iSRr12nu/e5Q32+mOdKhl8b4OrbSIriEjpWC
         OjJVJE4YWyQE9ksIPZP3P2t70Ejjn3AjVk1ffzpNTOe4ftRfofABRa/cqZLpEmmdQV2g
         bqoE4+MRpQCKwIGACKHjTPSCLSEtMUX7MQ769j6NJC9RlGvKqXB8FWir6LHSQZCXqaWo
         zclA==
X-Received: by 10.66.65.134 with SMTP id x6mr87083721pas.12.1388736041132;
        Fri, 03 Jan 2014 00:00:41 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id gf5sm106943913pbc.22.2014.01.03.00.00.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jan 2014 00:00:40 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388736031-6068-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239909>

There are situations where two classes of completions possible. For
example

  branch.<TAB>

should try to complete

  branch.master.
  branch.autosetupmerge
  branch.autosetuprebase

The first candidate has the suffix ".", and the second/ third candidates
have the suffix " ". To facilitate completions of this kind, create a
variation of __gitcomp_nl () that accepts two sets of arguments and two
independent suffixes.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 30 ++++++++++++++++++++++++++++++
 contrib/completion/git-completion.zsh  | 10 ++++++++++
 2 files changed, 40 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 51c2dd4..64b20b8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -233,6 +233,36 @@ __gitcomp_nl ()
 	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
+# Generates completion reply from two sets of completion words, with
+# configurable suffixes for each.
+#
+# It accepts 2 to 6 arguments:
+# 1: First set of possible completion words.
+# 2: Second set of possible completion words.
+# 3: A prefix to be added to each completion word (both $1 and $2)
+#    (optional).
+# 4: Generate possible completion matches for this word (optional).
+# 5: A suffix to be appended to each completion word in the first set
+#    ($1) instead of the default space (optional).
+# 6: A suffix to be appended to each completion word in the second set
+#    ($2) instead of the default space (optional).
+__gitcomp_2 ()
+{
+	local pfx="${3-}" cur_="${4-$cur}" sfx="${5- }" sfx2="${6- }" i=0
+	local IFS=$' \t\n'
+
+	for x in $1; do
+		if [[ "$x" == "$cur_"* ]]; then
+			COMPREPLY[i++]="$pfx$x$sfx"
+		fi
+	done
+	for x in $2; do
+		if [[ "$x" == "$cur_"* ]]; then
+			COMPREPLY[i++]="$pfx$x$sfx2"
+		fi
+	done
+}
+
 # Generates completion reply with compgen from newline-separated possible
 # completion filenames.
 # It accepts 1 to 3 arguments:
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 6fca145..261a7f5 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -76,6 +76,16 @@ __gitcomp_nl ()
 	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 }
 
+__gitcomp_2 ()
+{
+	emulate -L zsh
+
+	local IFS=$' \t\n'
+	compset -P '*[=:]'
+	compadd -Q -S "${5- }" -p "${3-}" -- ${=1} && _ret=0
+	compadd -Q -S "${6- }" -p "${3-}" -- ${=2} && _ret=0
+}
+
 __gitcomp_file ()
 {
 	emulate -L zsh
-- 
1.8.5.2.227.g53f3478
