From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/9] wt-status: split wt_status_print into digestible pieces
Date: Sat, 24 Jul 2010 19:56:26 -0500
Message-ID: <20100725005626.GA18420@burratino>
References: <20100725005443.GA18370@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 02:57:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcpX5-0007La-RZ
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 02:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab0GYA5b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 20:57:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39820 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580Ab0GYA5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 20:57:30 -0400
Received: by iwn7 with SMTP id 7so1571709iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 17:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vffW427ZXXLo0si6Pzch7XLxBiSsKmkwqqlXgvQjgxY=;
        b=cz2qj0kRf/BIrDODf8z+JrPUGurDuDJzwe5Wg1XIkXmp2ws92LyQDzktnptchozLoI
         qcPtjyYZAaBIhgrHtmeiQ9RpuveHzG/3hAglbBQDg5i4LZJcPn5J/FbZmKDpQmg74NfL
         Poc8IlXMLNGdTEa8SPBVl3E9u1MqubMbDThXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=N3RhSNlcqym6oQXVmW8UtKnSok4Z9MB+jwAwmjJalMz3az+U7sum+ftaHH2J7Zg8lA
         VDsbIfzayw39l15wTluE4rxUn6sKbnShKP4Vkkl3SRQCf01Nee92jaTiNvaHn63OVVux
         EB/S4XSizyBLHiIfgjUyGQirwsh/wy4jhQSnw=
Received: by 10.231.144.15 with SMTP id x15mr6399996ibu.73.1280019449968;
        Sat, 24 Jul 2010 17:57:29 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm1909362ibk.21.2010.07.24.17.57.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 17:57:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100725005443.GA18370@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151693>

The result does not fit on a 24-line terminal yet, but it=E2=80=99s
getting close.  No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 wt-status.c |   85 ++++++++++++++++++++++++++++++++-------------------=
--------
 1 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 2f9e33c..b0f17cf 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -604,6 +604,31 @@ static void wt_status_print_verbose(struct wt_stat=
us *s)
 	run_diff_index(&rev, 1);
 }
=20
+static void wt_status_print_nochanges(struct wt_status *s)
+{
+	if (s->amend)
+		fprintf(s->fp, "# No changes\n");
+	else if (s->nowarn)
+		; /* nothing */
+	else if (s->workdir_dirty)
+		printf("no changes added to commit%s\n",
+			advice_status_hints
+			? " (use \"git add\" and/or \"git commit -a\")" : "");
+	else if (s->untracked.nr)
+		printf("nothing added to commit but untracked files present%s\n",
+			advice_status_hints
+			? " (use \"git add\" to track)" : "");
+	else if (s->is_initial)
+		printf("nothing to commit%s\n", advice_status_hints
+			? " (create/copy files and use \"git add\" to track)" : "");
+	else if (!s->show_untracked_files)
+		printf("nothing to commit%s\n", advice_status_hints
+			? " (use -u to show untracked files)" : "");
+	else
+		printf("nothing to commit%s\n", advice_status_hints
+			? " (working directory clean)" : "");
+}
+
 static void wt_status_print_tracking(struct wt_status *s)
 {
 	struct strbuf sb =3D STRBUF_INIT;
@@ -623,25 +648,28 @@ static void wt_status_print_tracking(struct wt_st=
atus *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 }
=20
-void wt_status_print(struct wt_status *s)
+static void wt_status_print_onbranch(struct wt_status *s)
 {
 	const char *branch_color =3D color(WT_STATUS_HEADER, s);
-
-	if (s->branch) {
-		const char *on_what =3D "On branch ";
-		const char *branch_name =3D s->branch;
-		if (!prefixcmp(branch_name, "refs/heads/"))
-			branch_name +=3D 11;
-		else if (!strcmp(branch_name, "HEAD")) {
-			branch_name =3D "";
-			branch_color =3D color(WT_STATUS_NOBRANCH, s);
-			on_what =3D "Not currently on any branch.";
-		}
-		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "# ");
-		color_fprintf_ln(s->fp, branch_color, "%s%s", on_what, branch_name);
-		if (!s->is_initial)
-			wt_status_print_tracking(s);
+	const char *on_what =3D "On branch ";
+	const char *branch_name =3D s->branch;
+	if (!prefixcmp(branch_name, "refs/heads/"))
+		branch_name +=3D 11;
+	else if (!strcmp(branch_name, "HEAD")) {
+		branch_name =3D "";
+		branch_color =3D color(WT_STATUS_NOBRANCH, s);
+		on_what =3D "Not currently on any branch.";
 	}
+	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "# ");
+	color_fprintf_ln(s->fp, branch_color, "%s%s", on_what, branch_name);
+	if (!s->is_initial)
+		wt_status_print_tracking(s);
+}
+
+void wt_status_print(struct wt_status *s)
+{
+	if (s->branch)
+		wt_status_print_onbranch(s);
=20
 	if (s->is_initial) {
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
@@ -669,29 +697,8 @@ void wt_status_print(struct wt_status *s)
=20
 	if (s->verbose)
 		wt_status_print_verbose(s);
-	if (!s->commitable) {
-		if (s->amend)
-			fprintf(s->fp, "# No changes\n");
-		else if (s->nowarn)
-			; /* nothing */
-		else if (s->workdir_dirty)
-			printf("no changes added to commit%s\n",
-				advice_status_hints
-				? " (use \"git add\" and/or \"git commit -a\")" : "");
-		else if (s->untracked.nr)
-			printf("nothing added to commit but untracked files present%s\n",
-				advice_status_hints
-				? " (use \"git add\" to track)" : "");
-		else if (s->is_initial)
-			printf("nothing to commit%s\n", advice_status_hints
-				? " (create/copy files and use \"git add\" to track)" : "");
-		else if (!s->show_untracked_files)
-			printf("nothing to commit%s\n", advice_status_hints
-				? " (use -u to show untracked files)" : "");
-		else
-			printf("nothing to commit%s\n", advice_status_hints
-				? " (working directory clean)" : "");
-	}
+	if (!s->commitable)
+		wt_status_print_nochanges(s);
 }
=20
 static void wt_shortstatus_unmerged(int null_termination, struct strin=
g_list_item *it,
--=20
1.7.2.9.ge3789.dirty
