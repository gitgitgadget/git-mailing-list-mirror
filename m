From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git blame --progress
Date: Mon, 29 Jan 2007 20:59:06 +0100
Message-ID: <45BE520A.6050906@lsrfire.ath.cx>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>	<20070127080126.GC9966@spearce.org>	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>	<45BCB273.7010601@lsrfire.ath.cx>	<7v4pqbezo9.fsf@assigned-by-dhcp.cox.net>	<7vzm83dkw4.fsf@assigned-by-dhcp.cox.net>	<45BD40AE.9020603@lsrfire.ath.cx> <7vfy9ublvj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 29 20:59:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBcf0-00025A-Ut
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 20:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbXA2T7Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 29 Jan 2007 14:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbXA2T7Q
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 14:59:16 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:59629
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752578AbXA2T7P (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jan 2007 14:59:15 -0500
Received: from [10.0.1.20] (p508E43C4.dip.t-dialin.net [80.142.67.196])
	by neapel230.server4you.de (Postfix) with ESMTP id B067B3021;
	Mon, 29 Jan 2007 20:59:13 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <7vfy9ublvj.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38094>

Junio C Hamano schrieb:
> [PATCH] git blame --progress
>=20
> With  --progress option, the command shows a fairly useless but=20
> amusing eye-candy while making the user wait.

Nicely done, I like it.  Well, then again, I used to watch the progress
of filesystem defragmentors as a kid.  Ahem. :-P

The problem here is, of course, that we don't know how beforehand much
work needs to be done.  The indicator could be full of stars long befor=
e
the start of history is reached.

This could be helped somewhat by having three states instead of two:
unblamed (.), blamed (o) and just-now-blamed (*).  Each time new stars
are written you'd demote the other stars in the field to o's.  This way
you'll at least see something moving until the end, no matter how often
blame is pushed further down for already blamed lines.

This increases terminal bandwidth usage and on-screen activity, but not
necessarily the usefulness of this thing. :)

Ren=E9


diff --git a/builtin-blame.c b/builtin-blame.c
index cd54acf..9bed52f 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1229,18 +1229,9 @@ static int eye_candy_spot(struct scoreboard *sb,=
 int lno)
 	return lno * cnt / sb->num_lines;
 }
=20
-static void update_eye_candy(struct scoreboard *sb, struct blame_entry=
 *ent)
+static void update_eye_candy_spots(int cnt, int spot_lo, int spot_hi, =
char c)
 {
-	int cnt =3D eye_candy_spots(sb);
-	int spot_lo, spot_hi, spot;
-	struct blame_entry *lo, *hi;
-
-	for (lo =3D ent; lo->prev && lo->prev->guilty; lo =3D lo->prev)
-		;
-	spot_lo =3D eye_candy_spot(sb, lo->lno);
-	for (hi =3D ent; hi->next && hi->next->guilty; hi =3D hi->next)
-		;
-	spot_hi =3D eye_candy_spot(sb, hi->lno + hi->num_lines - 1);
+	int spot;
=20
 	for (spot =3D spot_lo; spot <=3D spot_hi; spot++) {
 		int spot_x, spot_y;
@@ -1257,13 +1248,35 @@ static void update_eye_candy(struct scoreboard =
*sb, struct blame_entry *ent)
 			fprintf(stderr, "\033[%dA", spot_y);
 		if (spot_x)
 			fprintf(stderr, "\033[%dC", spot_x);
-		fputc('*', stderr);
+		fputc(c, stderr);
 		fprintf(stderr, "\033[%dD", spot_x + 1);
 		if (spot_y)
 			fprintf(stderr, "\033[%dB", spot_y);
 	}
 }
=20
+static void update_eye_candy(struct scoreboard *sb, struct blame_entry=
 *ent)
+{
+	int cnt =3D eye_candy_spots(sb);
+	int spot_lo, spot_hi;
+	struct blame_entry *lo, *hi;
+	static int prev_cnt, prev_spot_lo, prev_spot_hi;
+
+	for (lo =3D ent; lo->prev && lo->prev->guilty; lo =3D lo->prev)
+		;
+	spot_lo =3D eye_candy_spot(sb, lo->lno);
+	for (hi =3D ent; hi->next && hi->next->guilty; hi =3D hi->next)
+		;
+	spot_hi =3D eye_candy_spot(sb, hi->lno + hi->num_lines - 1);
+
+	update_eye_candy_spots(prev_cnt, prev_spot_lo, prev_spot_hi, 'o');
+	update_eye_candy_spots(cnt, spot_lo, spot_hi, '*');
+
+	prev_cnt =3D cnt;
+	prev_spot_lo =3D spot_lo;
+	prev_spot_hi =3D spot_hi;
+}
+
 static void found_guilty_entry(struct scoreboard *sb, struct blame_ent=
ry *ent)
 {
 	if (ent->guilty)
