From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/11] completion: zsh: add proper file support
Date: Sat, 27 Apr 2013 05:19:54 -0500
Message-ID: <1367057994-19887-12-git-send-email-felipe.contreras@gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 12:22:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW2GU-0003W0-Pv
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 12:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880Ab3D0KVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 06:21:42 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:48662 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785Ab3D0KVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 06:21:40 -0400
Received: by mail-oa0-f53.google.com with SMTP id m6so4781979oag.12
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dRlXoMizOqaM0EpU3wOHz8KzJt6s+SHh03rCNdJDkuU=;
        b=E9zfkpecfIP9dKOUwQAzpyW2m4J97MLYJ3Fye3OlZCeo7QUfiUIjxGB+M+HbdiSIQg
         K0Qlw4NeFIG6MpIuWhRAsnDSWVeufCw/X63d33FRH45hKv2TFNQI6UU11iJcqz0ZX8sC
         iaWrKFf5Dym7v5ZMG3DLwZAMeaucgej7B3T0Q7SHDk/ZqFMsJHZjF+Q0tgJUtcSHS6lH
         pwT+9vAQ1LQLfZJob8muf5iF1VjNAicMd3t+5teI5/MgV6YLNKLA7pU5WXGGulExruYu
         X/kvEyrzyJd/B4DvuYxQElJLLn7yFQl9AgljTx13g1FD1l2DL3by48do3oSg/aHQ+DXc
         1zwA==
X-Received: by 10.182.47.199 with SMTP id f7mr12903370obn.2.1367058100421;
        Sat, 27 Apr 2013 03:21:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zc8sm11667195obc.8.2013.04.27.03.21.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 03:21:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222636>

So the files are completed and coloured nicely.

The code would be only a couple of lines if only _multi_parts or
_path_files worked correctly, but alas, they don't.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 4577502..8c6916a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -60,6 +60,48 @@ __gitcomp_nl ()
 	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 }
 
+#
+# We need to remove the extra slash for directories, and we need to remove the
+# spaces for files, otherwise zsh can't stat them and threat them as proper files.
+#
+__git_index_files ()
+{
+	local dir="$(__gitdir)" root="${2-.}" file
+
+	if [ -d "$dir" ]; then
+		local -a files
+		emulate ksh -c '__git_ls_files_helper "$root" "$1"' |
+		while read -r file; do
+			case "$file" in
+			?*/*)
+				files+="${file%%/*}"
+				;;
+			*)
+				files+="$file"
+				;;
+			esac
+		done
+		compadd -Q -p "${2-}" -f -a files && _ret=0
+	fi
+}
+
+__git_complete_index_file ()
+{
+	emulate -L zsh
+
+	local pfx="" cur_="$cur"
+
+	case "$cur_" in
+	?*/*)
+		pfx="${cur_%/*}"
+		cur_="${cur_##*/}"
+		pfx="${pfx}/"
+		;;
+	esac
+
+	__git_index_files "$1" "$pfx"
+}
+
 _git ()
 {
 	local _ret=1
-- 
1.8.2.1.1031.g2ee5873
