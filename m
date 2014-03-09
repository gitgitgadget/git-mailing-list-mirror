From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] rebase: new option to post edit a squashed or fixed up commit
Date: Sun,  9 Mar 2014 10:12:17 +0700
Message-ID: <1394334737-17406-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 04:12:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMU9y-0000Gq-OZ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 04:12:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbaCIDLs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Mar 2014 22:11:48 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:53197 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbaCIDLr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2014 22:11:47 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so5631684pdj.12
        for <git@vger.kernel.org>; Sat, 08 Mar 2014 19:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=7cBs75weFgNo5a+PEf32VIjK7+r2V8fyWslVKZJNHmc=;
        b=BIiqJ7tX8y64MCC13dUTw5FlIlZUzakQ5WWK5YLjURGE7hVHIxrwbRB6TjbhufV4ud
         Jbbpm7sFKJtXewH29hN0pf+XzFph+SlCD6Ym/DOqWOk6HqA8H6CEZhTxRgTCIUL9ZXR4
         W6e/beZIlrxrPdwBX2yugP9QTo1AnDRiUGZUfu+6AOMp4cbcPqk/o9FiVsqmv0c930wF
         flt3exyRamZ/3ExvLCXJryJRXJOVkJ9WhO90p35+qfil+iaqEPmTMqe2RiKBWhXyTyjd
         ntzG7splRAYnGcIHlYDXO26XspOWbnM4I+9yFL1ha0Kpxc2BLtjGyhVdpxfyQfRMX8Dr
         AztQ==
X-Received: by 10.66.191.131 with SMTP id gy3mr24882pac.152.1394334706647;
        Sat, 08 Mar 2014 19:11:46 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id os1sm45398849pac.20.2014.03.08.19.11.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Mar 2014 19:11:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Mar 2014 10:12:20 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243688>

After squashing or fixing up, you may want to have a final look at the
commit, edit some more if needed or even do some testing. --postedit
enables that. This is (to me) a paranoid mode so either I enable it
for all squashes and fixups, or none. Hence a new option, not new todo
commands that give finer selection.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-rebase.txt | 5 +++++
 git-rebase--interactive.sh   | 5 +++++
 git-rebase.sh                | 7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 2a93c64..dacb163 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -432,6 +432,11 @@ recreates the topic branch with fresh commits so i=
t can be remerged
 successfully without needing to "revert the reversion" (see the
 link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] fo=
r details).
=20
+--[no-]postedit::
+	With --interactive, stop after performing the command "squash"
+	or "fixup". This gives the user a chance to look at the final
+	commit and update or test it if needed.
+
 include::merge-strategies.txt[]
=20
 NOTES
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a1adae8..42061fc 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -571,6 +571,11 @@ do_next () {
 			;;
 		esac
 		record_in_rewritten $sha1
+		if test -n "$postedit"
+		then
+			warn "Stopped at $sha1... $rest"
+			exit_with_patch $sha1 0
+		fi
 		;;
 	x|"exec")
 		read -r command rest < "$todo"
diff --git a/git-rebase.sh b/git-rebase.sh
index 5f6732b..2d4beb7 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -32,6 +32,7 @@ verify             allow pre-rebase hook to run
 rerere-autoupdate  allow rerere to update index with resolved conflict=
s
 root!              rebase all reachable commits up to the root(s)
 autosquash         move commits that begin with squash!/fixup! under -=
i
+postedit           stop after squash or fixup commands
 committer-date-is-author-date! passed to 'git am'
 ignore-date!       passed to 'git am'
 whitespace=3D!       passed to 'git apply'
@@ -264,6 +265,12 @@ do
 	--no-autosquash)
 		autosquash=3D
 		;;
+	--postedit)
+		postedit=3Dt
+		;;
+	--no-postedit)
+		postedit=3D
+		;;
 	--fork-point)
 		fork_point=3Dt
 		;;
--=20
1.9.0.40.gaa8c3ea
