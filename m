From: =?UTF-8?q?Guillaume=20Pag=C3=A8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [RFC/PATCH 1/2] status: give more information during rebase -i
Date: Wed,  3 Jun 2015 10:35:44 +0200
Message-ID: <1433320545-14244-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 10:36:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z049X-00061D-2j
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 10:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbbFCIfy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 04:35:54 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:59027 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753074AbbFCIfw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 04:35:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 1E97648853;
	Wed,  3 Jun 2015 10:35:50 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z9rsQwNOwEPF; Wed,  3 Jun 2015 10:35:50 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 02CF748846;
	Wed,  3 Jun 2015 10:35:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id EA5F720E4;
	Wed,  3 Jun 2015 10:35:49 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ofECm+nI5ETV; Wed,  3 Jun 2015 10:35:49 +0200 (CEST)
Received: from guillaume-W35-37ET.grenet.fr (wificampus-029182.grenet.fr [130.190.29.182])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id B446220DF;
	Wed,  3 Jun 2015 10:35:49 +0200 (CEST)
X-Mailer: git-send-email 2.4.2.340.g37f3f38
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270667>

git status gives more information during rebase -i, about the list of
command that are done during the rebase. It displays the two last
commands executed and the two next lines to be executed. It also gives
hints to find the whole files in .git directory.

Signed-off-by: Guillaume Pag=C3=A8s <guillaume.pages@ensimag.grenoble-i=
np.fr>
---

At the moment it only gives information during an interactive rebase. I=
t=20
displays full sha1 identifiers, changing to short sha1 would be better.

 wt-status.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++--=
--------
 1 file changed, 106 insertions(+), 20 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 33452f1..8a32aea 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1026,13 +1026,104 @@ static int split_commit_in_progress(struct wt_=
status *s)
 	return split_in_progress;
 }
=20
+void get_two_last_lines(char *filename,int * numlines, char ** lines)
+{
+	*numlines=3D0;
+	struct strbuf buf =3D STRBUF_INIT;
+	FILE *fp =3D fopen(git_path("%s", filename), "r");
+	if (!fp) {
+		strbuf_release(&buf);
+		return;
+	}
+	while (strbuf_getline(&buf, fp, '\n')!=3DEOF){
+		(*numlines)++;
+		lines[0]=3Dlines[1];
+		lines[1]=3Dstrbuf_detach(&buf, NULL);
+	}
+	if (!fclose(fp))
+		strbuf_detach(&buf, NULL);
+	else
+		strbuf_release(&buf);
+}
+
+void get_two_first_lines(char *filename,int * numlines, char ** lines)
+{
+	*numlines=3D0;
+	struct strbuf buf =3D STRBUF_INIT;
+	char *line;
+	FILE *fp =3D fopen(git_path("%s", filename), "r");
+	if (!fp) {
+		strbuf_release(&buf);
+		return;
+	}
+	while (strbuf_getline(&buf, fp, '\n')!=3DEOF){
+		stripspace(&buf, 1);
+		line =3D strbuf_detach(&buf, NULL);
+		if (strcmp(line,"")=3D=3D0)
+			continue;
+		if (*numlines<2)
+			lines[*numlines] =3D line;
+		(*numlines)++;
+	}
+	if (!fclose(fp))
+		strbuf_detach(&buf, NULL);
+	else
+		strbuf_release(&buf);
+}
+
+void show_rebase_information(struct wt_status *s,
+				    struct wt_status_state *state,
+				    const char *color)
+{
+	if (state->rebase_interactive_in_progress){
+		int i, begin;
+		int numlines =3D0;
+		char* lines[2];
+		get_two_last_lines("rebase-merge/done", &numlines, lines);
+		if (numlines=3D=3D0)
+			status_printf_ln(s,color,"No command done.");
+		else{
+			status_printf_ln(s,color,
+				"Last command(s) done (%d command(s) done):",
+				numlines);
+			begin =3D numlines > 1? 0 : 1;
+			for (i =3D begin; i < 2; i++){
+				status_printf_ln(s,color,"   %s",lines[i]);
+			}
+			if (numlines>2 && s->hints )
+			   status_printf_ln(s,color,
+				"  (see more at .git/rebase-merge/done)");
+		}
+		numlines =3D0;
+		get_two_first_lines("rebase-merge/git-rebase-todo",
+					 &numlines, lines);
+		if (numlines=3D=3D0)
+			status_printf_ln(s,color,
+					 "No command remaining.");
+		else{
+
+			status_printf_ln(s,color,
+				"Next command(s) to do (%d remaining command(s)):",
+				numlines);
+			begin =3D numlines > 1? 0 : 1;
+			for (i =3D 0; (i < 2 && i < numlines); i++){
+				status_printf(s,color,"   %s",lines[i]);
+			}
+			if (s->hints )
+			   status_printf_ln(s,color,
+				"  (use git rebase --edit-todo to view and edit)");
+		}
+	}
+}
+
 static void show_rebase_in_progress(struct wt_status *s,
 				struct wt_status_state *state,
 				const char *color)
 {
 	struct stat st;
=20
-	if (has_unmerged(s)) {
+	show_rebase_information(s,state,color);
+	if (has_unmerged(s) || state->rebase_in_progress || !stat(git_path("M=
ERGE_MSG"), &st)) {
 		if (state->branch)
 			status_printf_ln(s, color,
 					 _("You are currently rebasing branch '%s' on '%s'."),
@@ -1042,25 +1133,17 @@ static void show_rebase_in_progress(struct wt_s=
tatus *s,
 			status_printf_ln(s, color,
 					 _("You are currently rebasing."));
 		if (s->hints) {
-			status_printf_ln(s, color,
-				_("  (fix conflicts and then run \"git rebase --continue\")"));
-			status_printf_ln(s, color,
-				_("  (use \"git rebase --skip\" to skip this patch)"));
-			status_printf_ln(s, color,
-				_("  (use \"git rebase --abort\" to check out the original branch)=
"));
+			if (has_unmerged(s)) {
+				status_printf_ln(s, color,
+						 _("  (fix conflicts and then run \"git rebase --continue\")"));
+				status_printf_ln(s, color,
+						 _("  (use \"git rebase --skip\" to skip this patch)"));
+				status_printf_ln(s, color,
+						 _("  (use \"git rebase --abort\" to check out the original bran=
ch)"));
+			} else
+				status_printf_ln(s, color,
+						 _("  (all conflicts fixed: run \"git rebase --continue\")"));
 		}
-	} else if (state->rebase_in_progress || !stat(git_path("MERGE_MSG"), =
&st)) {
-		if (state->branch)
-			status_printf_ln(s, color,
-					 _("You are currently rebasing branch '%s' on '%s'."),
-					 state->branch,
-					 state->onto);
-		else
-			status_printf_ln(s, color,
-					 _("You are currently rebasing."));
-		if (s->hints)
-			status_printf_ln(s, color,
-				_("  (all conflicts fixed: run \"git rebase --continue\")"));
 	} else if (split_commit_in_progress(s)) {
 		if (state->branch)
 			status_printf_ln(s, color,
@@ -1327,7 +1410,10 @@ void wt_status_print(struct wt_status *s)
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_status_color =3D color(WT_STATUS_NOBRANCH, s);
 			if (state.rebase_in_progress || state.rebase_interactive_in_progres=
s) {
-				on_what =3D _("rebase in progress; onto ");
+				if (state.rebase_interactive_in_progress)
+					on_what =3D _("interactive rebase in progress; onto ");
+				else
+					on_what =3D _("rebase in progress; onto ");
 				branch_name =3D state.onto;
 			} else if (state.detached_from) {
 				branch_name =3D state.detached_from;
--=20
2.4.2.340.g37f3f38
