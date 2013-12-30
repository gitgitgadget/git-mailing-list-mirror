From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/4] completion: introduce __gitcomp_2 ()
Date: Mon, 30 Dec 2013 20:22:16 +0530
Message-ID: <1388415138-11011-3-git-send-email-artagnon@gmail.com>
References: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 30 15:52:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxeCf-0006BS-T0
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 15:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994Ab3L3OwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 09:52:12 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:43126 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755988Ab3L3Ov7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 09:51:59 -0500
Received: by mail-pa0-f43.google.com with SMTP id bj1so11721264pad.30
        for <git@vger.kernel.org>; Mon, 30 Dec 2013 06:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YF50ZoWYTrtCwbajaylklEgMzxlwhgMvKnZ154I84Fk=;
        b=jJD0Cm5H0O/wTJEjj1r8lX+ahnwFOHqTHtmtcW/Wn/k7Jj0nAjafQoYq67SidbGgIy
         SNzlPjBnkWrSpF+lu7h8lvmPVmOIYIG9swomJaO9baq5+lUi39oh1JURUq6LmFtsX1w7
         elE/f+yo9lK1BeLMvAJwmm64INeD7pqNtJEgQR/zUGgyZqbhndc6gPluJrBgMaMINmVH
         tO+4jMrgXRaSQFd8gLUiGNKoXXCglyTTx3gWhNl/Z32qH5ANR7stdFfSHvDXlOAkCVN8
         4iFqgY5LytzrfzyflRUgHFlnISJvjhiJevtjqrMoazB02Eawp8rrGDDeBlVPwGQ6IoHb
         PEHQ==
X-Received: by 10.66.8.66 with SMTP id p2mr68805155paa.129.1388415118986;
        Mon, 30 Dec 2013 06:51:58 -0800 (PST)
Received: from localhost.localdomain ([122.164.121.180])
        by mx.google.com with ESMTPSA id vn10sm82123744pbc.21.2013.12.30.06.51.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Dec 2013 06:51:58 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239806>

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
