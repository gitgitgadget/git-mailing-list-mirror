From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: "git stash list" shows HEAD reflog
Date: Sat, 13 Mar 2010 18:37:50 +0100
Message-ID: <4B9BCD6E.4090902@lsrfire.ath.cx>
References: <op.u9gl97fstuzx1w@cybershadow.mshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Vladimir Panteleev <vladimir@thecybershadow.net>
X-From: git-owner@vger.kernel.org Sat Mar 13 18:38:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqVHl-0007LM-Re
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 18:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933625Ab0CMRh4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Mar 2010 12:37:56 -0500
Received: from india601.server4you.de ([85.25.151.105]:49972 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933453Ab0CMRhz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 12:37:55 -0500
Received: from [10.0.1.100] (p57B7E76C.dip.t-dialin.net [87.183.231.108])
	by india601.server4you.de (Postfix) with ESMTPSA id 1F4CE2F8045;
	Sat, 13 Mar 2010 18:37:54 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <op.u9gl97fstuzx1w@cybershadow.mshome.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142100>

Am 12.03.2010 15:52, schrieb Vladimir Panteleev:
> I stumbled upon a curious problem with a repository: the command "git
> stash list" displayed the HEAD reflog instead of the stash list.
>=20
> The problem was caused by a very long line in ".git/logs/refs/stash".
> (The stash was based on a commit imported from Subversion, the commit
> message of which didn't follow git conventions.) The entire line was
> longer than 1023 characters, which is the buffer size passed to fgets=
 in
> for_each_recent_reflog_ent. The validation check (buf[len-1] !=3D '\n=
')
> causes the line to be skipped. The fix should be simple - if the line
> read didn't fit in the buffer, add a newline anyway instead of skippi=
ng
> the line entirely.

Thanks, nice analysis.  Patch below; it uses strbuf instead of truncati=
ng
the long message, though.

> That doesn't explain why git displayed the HEAD reflog, though. That
> seems to happen thanks to the check (revs->def && !revs->pending.nr) =
in
> setup_revisions ("HEAD" is the default, as specified in the caller
> cmd_log_init). It looks like (ideally) git shouldn't rely on whether
> revs->pending is empty to decide whether to use the default, but rath=
er
> if a ref was specified by the user or not.

We could add some kind of check there, but with the patch applied I can=
't
trigger this second issue any more.  It would be nice to have a test sc=
ript
along with such a sanity check.  Any idea how to cause this error, perh=
aps
with another type of invalid reflog file?

Ren=C3=A9


-- >8 --
Subject: for_each_recent_reflog_ent(): use strbuf, fix offset handling

As Vladimir reported, "git log -g refs/stash" surprisingly showed the r=
eflog
of HEAD if the message in the reflog file was too long.  To fix this, c=
onvert
for_each_recent_reflog_ent() to use strbuf_getwholeline() instead of fg=
ets(),
for safety and to avoid any size limits for reflog entries.

Also reverse the logic of the part of the function that only looks at f=
ile
tails.  It used to close the file if fgets() succeeded.  The following
fgets() call in the while loop was likely to fail in this case, too, so
passing an offset to for_each_recent_reflog_ent() never worked.  Change=
 it to
error out if strbuf_getwholeline() fails instead.

Reported-by: Vladimir Panteleev <vladimir@thecybershadow.net>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 refs.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index f3fcbe0..63e30d7 100644
--- a/refs.c
+++ b/refs.c
@@ -1574,7 +1574,7 @@ int for_each_recent_reflog_ent(const char *ref, e=
ach_reflog_ent_fn fn, long ofs,
 {
 	const char *logfile;
 	FILE *logfp;
-	char buf[1024];
+	struct strbuf sb =3D STRBUF_INIT;
 	int ret =3D 0;
=20
 	logfile =3D git_path("logs/%s", ref);
@@ -1587,24 +1587,24 @@ int for_each_recent_reflog_ent(const char *ref,=
 each_reflog_ent_fn fn, long ofs,
 		if (fstat(fileno(logfp), &statbuf) ||
 		    statbuf.st_size < ofs ||
 		    fseek(logfp, -ofs, SEEK_END) ||
-		    fgets(buf, sizeof(buf), logfp)) {
+		    strbuf_getwholeline(&sb, logfp, '\n')) {
 			fclose(logfp);
+			strbuf_release(&sb);
 			return -1;
 		}
 	}
=20
-	while (fgets(buf, sizeof(buf), logfp)) {
+	while (!strbuf_getwholeline(&sb, logfp, '\n')) {
 		unsigned char osha1[20], nsha1[20];
 		char *email_end, *message;
 		unsigned long timestamp;
-		int len, tz;
+		int tz;
=20
 		/* old SP new SP name <email> SP time TAB msg LF */
-		len =3D strlen(buf);
-		if (len < 83 || buf[len-1] !=3D '\n' ||
-		    get_sha1_hex(buf, osha1) || buf[40] !=3D ' ' ||
-		    get_sha1_hex(buf + 41, nsha1) || buf[81] !=3D ' ' ||
-		    !(email_end =3D strchr(buf + 82, '>')) ||
+		if (sb.len < 83 || sb.buf[sb.len - 1] !=3D '\n' ||
+		    get_sha1_hex(sb.buf, osha1) || sb.buf[40] !=3D ' ' ||
+		    get_sha1_hex(sb.buf + 41, nsha1) || sb.buf[81] !=3D ' ' ||
+		    !(email_end =3D strchr(sb.buf + 82, '>')) ||
 		    email_end[1] !=3D ' ' ||
 		    !(timestamp =3D strtoul(email_end + 2, &message, 10)) ||
 		    !message || message[0] !=3D ' ' ||
@@ -1618,11 +1618,13 @@ int for_each_recent_reflog_ent(const char *ref,=
 each_reflog_ent_fn fn, long ofs,
 			message +=3D 6;
 		else
 			message +=3D 7;
-		ret =3D fn(osha1, nsha1, buf+82, timestamp, tz, message, cb_data);
+		ret =3D fn(osha1, nsha1, sb.buf + 82, timestamp, tz, message,
+			 cb_data);
 		if (ret)
 			break;
 	}
 	fclose(logfp);
+	strbuf_release(&sb);
 	return ret;
 }
=20
--=20
1.7.0.2
