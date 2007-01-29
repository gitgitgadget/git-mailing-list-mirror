From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git blame --progress
Date: Sun, 28 Jan 2007 18:35:44 -0800
Message-ID: <7vfy9ublvj.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
	<45BCB273.7010601@lsrfire.ath.cx>
	<7v4pqbezo9.fsf@assigned-by-dhcp.cox.net>
	<7vzm83dkw4.fsf@assigned-by-dhcp.cox.net>
	<45BD40AE.9020603@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jan 29 03:35:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBMN9-0007Vn-G4
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 03:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933103AbXA2Cfs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 28 Jan 2007 21:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933104AbXA2Cfs
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 21:35:48 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57196 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933103AbXA2Cfr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Jan 2007 21:35:47 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070129023546.PRQF20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 21:35:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Gqan1W00J1kojtg0000000; Sun, 28 Jan 2007 21:34:48 -0500
In-Reply-To: <45BD40AE.9020603@lsrfire.ath.cx> (=?iso-8859-1?Q?Ren=E9?=
 Scharfe's message of
	"Mon, 29 Jan 2007 01:32:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38061>

[PATCH] git blame --progress

With  --progress option, the command shows a fairly useless but
amusing eye-candy while making the user wait.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

 > Junio C Hamano schrieb:
 >> Although I'd apply it anyway, strictly speaking, I think this
 >> patch should not matter because any real Porcelain would be
 >> using this as an upstream of a pipe to its drawing engine.
 >>=20
 >> Well, unless that Porcelain drives --incremental through a pair
 >> of ptys, but I do not think it is likely ;-).
 >
 > Ha!, didn't think of that.  I still like it more without a pager
 > even if run on a terminal, because then you can *see* that it's
 > really incremental (without needing to unset PAGER).  I'm a
 > non-believer. ;-)

 builtin-blame.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 1 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 02bda5e..cd54acf 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -17,7 +17,7 @@
 #include "xdiff-interface.h"
=20
 static char blame_usage[] =3D
-"git-blame [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [-M=
] [-C] [-C] [commit] [--] file\n"
+"git-blame [-c] [-l] [-t] [-f] [-n] [-p] [--progress] [-L n,m] [-S <re=
vs-file>] [-M] [-C] [-C] [commit] [--] file\n"
 "  -c, --compatibility Use the same output mode as git-annotate (Defau=
lt: off)\n"
 "  -b                  Show blank SHA-1 for boundary commits (Default:=
 off)\n"
 "  -l, --long          Show long commit SHA1 (Default: off)\n"
@@ -29,6 +29,7 @@ static char blame_usage[] =3D
 "  -L n,m              Process only line range n,m, counting from 1\n"
 "  -M, -C              Find line movements within and across files\n"
 "  --incremental       Show blame entries as we find them, incremental=
ly\n"
+"  --progress          Show fairly useless progress display\n"
 "  -S revs-file        Use revisions from revs-file instead of calling=
 git-rev-list\n";
=20
 static int longest_file;
@@ -39,6 +40,7 @@ static int max_score_digits;
 static int show_root;
 static int blank_boundary;
 static int incremental;
+static int eye_candy;
=20
 #ifndef DEBUG
 #define DEBUG 0
@@ -1189,7 +1191,80 @@ static void write_filename_info(const char *path=
)
 	putchar('\n');
 }
=20
-static void found_guilty_entry(struct blame_entry *ent)
+#define NUM_EC_SPOT 500
+#define NUM_EC_SPOT_PER_GROUP 10
+#define NUM_EC_SPOT_PER_ROW 50
+
+static int eye_candy_spots(struct scoreboard *sb)
+{
+	int num_lines =3D sb->num_lines;
+	if (NUM_EC_SPOT < num_lines)
+		return NUM_EC_SPOT;
+	return num_lines;
+}
+
+static void initialize_eye_candy(struct scoreboard *sb)
+{
+	int cnt =3D eye_candy_spots(sb);
+	int i, j;
+
+	fprintf(stderr, "\033[2JAssigning blame for %s\n", sb->path);
+	for (i =3D j =3D 0; i < cnt; i++) {
+		fputc('.', stderr);
+		j++;
+		if (NUM_EC_SPOT_PER_ROW <=3D j) {
+			j =3D 0;
+			fputc('\n', stderr);
+		}
+		else if ((j % NUM_EC_SPOT_PER_GROUP) =3D=3D 0)
+			fputc(' ', stderr);
+	}
+	if (j)
+		fputc('\n', stderr);
+}
+
+static int eye_candy_spot(struct scoreboard *sb, int lno)
+{
+	int cnt =3D eye_candy_spots(sb);
+	return lno * cnt / sb->num_lines;
+}
+
+static void update_eye_candy(struct scoreboard *sb, struct blame_entry=
 *ent)
+{
+	int cnt =3D eye_candy_spots(sb);
+	int spot_lo, spot_hi, spot;
+	struct blame_entry *lo, *hi;
+
+	for (lo =3D ent; lo->prev && lo->prev->guilty; lo =3D lo->prev)
+		;
+	spot_lo =3D eye_candy_spot(sb, lo->lno);
+	for (hi =3D ent; hi->next && hi->next->guilty; hi =3D hi->next)
+		;
+	spot_hi =3D eye_candy_spot(sb, hi->lno + hi->num_lines - 1);
+
+	for (spot =3D spot_lo; spot <=3D spot_hi; spot++) {
+		int spot_x, spot_y;
+
+		spot_x =3D spot % NUM_EC_SPOT_PER_ROW;
+		spot_x =3D spot_x + spot_x / NUM_EC_SPOT_PER_GROUP;
+
+		spot_y =3D spot / NUM_EC_SPOT_PER_ROW;
+		spot_y =3D (cnt / NUM_EC_SPOT_PER_ROW) - spot_y;
+		if (cnt < NUM_EC_SPOT && (cnt % NUM_EC_SPOT_PER_ROW))
+			spot_y++;
+
+		if (spot_y)
+			fprintf(stderr, "\033[%dA", spot_y);
+		if (spot_x)
+			fprintf(stderr, "\033[%dC", spot_x);
+		fputc('*', stderr);
+		fprintf(stderr, "\033[%dD", spot_x + 1);
+		if (spot_y)
+			fprintf(stderr, "\033[%dB", spot_y);
+	}
+}
+
+static void found_guilty_entry(struct scoreboard *sb, struct blame_ent=
ry *ent)
 {
 	if (ent->guilty)
 		return;
@@ -1218,6 +1293,8 @@ static void found_guilty_entry(struct blame_entry=
 *ent)
 		}
 		write_filename_info(suspect->path);
 	}
+	else if (eye_candy)
+		update_eye_candy(sb, ent);
 }
=20
 static void assign_blame(struct scoreboard *sb, struct rev_info *revs,=
 int opt)
@@ -1253,7 +1330,7 @@ static void assign_blame(struct scoreboard *sb, s=
truct rev_info *revs, int opt)
 		/* Take responsibility for the remaining entries */
 		for (ent =3D sb->ent; ent; ent =3D ent->next)
 			if (!cmp_suspect(ent->suspect, suspect))
-				found_guilty_entry(ent);
+				found_guilty_entry(sb, ent);
 		origin_decref(suspect);
=20
 		if (DEBUG) /* sanity */
@@ -1768,6 +1845,8 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
 		else if (!strcmp("-n", arg) ||
 			 !strcmp("--show-number", arg))
 			output_option |=3D OUTPUT_SHOW_NUMBER;
+		else if (!strcmp("--progress", arg))
+			eye_candy =3D 1;
 		else if (!strcmp("-p", arg) ||
 			 !strcmp("--porcelain", arg))
 			output_option |=3D OUTPUT_PORCELAIN;
@@ -1951,6 +2030,8 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
 		die("reading graft file %s failed: %s",
 		    revs_file, strerror(errno));
=20
+	if (eye_candy)
+		initialize_eye_candy(&sb);
 	assign_blame(&sb, &revs, opt);
=20
 	if (incremental)
