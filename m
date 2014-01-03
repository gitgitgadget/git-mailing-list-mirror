From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 2/4] completion: introduce __gitcomp_nl_append ()
Date: Sat,  4 Jan 2014 01:27:00 +0530
Message-ID: <1388779022-14536-3-git-send-email-artagnon@gmail.com>
References: <1388779022-14536-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 03 20:57:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzAs5-0003PS-R6
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 20:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbaACT5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 14:57:16 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:52214 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbaACT5M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 14:57:12 -0500
Received: by mail-pd0-f174.google.com with SMTP id x10so15824377pdj.33
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 11:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wr0xdhz93QUCAIlBUOa4Cxsc4wn3On+7ggrP5Wbnxeo=;
        b=zUBOs0ucIXHHgCAXZJAlcidkgKscS+1OPOKLmqsbOEwESLsOfY1KRNPjSQfKfBnhl1
         IVUvwbPurRawf3it0sFdvPMFoDeL/mjxCJpMq/0P9bz6bSS0nzGLOYt/MwOXycaqcqcl
         ohsPyFp98T+VbzbpWn+X7FnzF1I6uurR/SRFjDjk9aiZaIr/bv0qyZY1WSAwMicUfIJW
         rGvRNirBQ3TQ2QNCDi5bihTbKpR2YRhxC2ilYAU/xI6n8pxTi0oqnEyl1g9UYKsYOER2
         OlcafBNSOtP4c4Foes4l380JjG0uyWeKqSFlTDLPi3s1fsTS+LtTyaiA9RJNgdNPJ2Jd
         yNDw==
X-Received: by 10.68.190.33 with SMTP id gn1mr97879295pbc.48.1388779030352;
        Fri, 03 Jan 2014 11:57:10 -0800 (PST)
Received: from localhost.localdomain ([122.164.141.93])
        by mx.google.com with ESMTPSA id e6sm110782903pbg.4.2014.01.03.11.57.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jan 2014 11:57:09 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388779022-14536-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239933>

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
 contrib/completion/git-completion.bash | 13 +++++++++++++
 contrib/completion/git-completion.zsh  |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 51c2dd4..bf358d6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -233,6 +233,19 @@ __gitcomp_nl ()
 	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
+# Variation of __gitcomp_nl () that appends to the existing list of
+# completion candidates, COMPREPLY.
+__gitcomp_nl_append ()
+{
+	local IFS=$'\n'
+	local i=${#COMPREPLY[@]}
+	for x in $1; do
+		if [[ "$x" == "$3"* ]]; then
+			COMPREPLY[i++]="$2$x$4"
+		fi
+	done
+}
+
 # Generates completion reply with compgen from newline-separated possible
 # completion filenames.
 # It accepts 1 to 3 arguments:
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
