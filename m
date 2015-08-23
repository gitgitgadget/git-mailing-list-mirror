From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH] am: terminate state files with a newline
Date: Sun, 23 Aug 2015 13:50:53 +0800
Message-ID: <20150823055053.GA15849@yoshi.chippynet.com>
References: <20150820152247.Horde.3yFLIbhFFocB99yz8o1iwg1@webmail.informatik.kit.edu>
 <xmqqa8tl7qi3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Aug 23 07:51:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTOBi-0000jc-HX
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 07:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbbHWFvD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2015 01:51:03 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34187 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbbHWFvB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 01:51:01 -0400
Received: by padfa11 with SMTP id fa11so739431pad.1
        for <git@vger.kernel.org>; Sat, 22 Aug 2015 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uaLRkaUMJQgTUa3++oVVJOS4eAViZyEnywcCjceq/NE=;
        b=dRFOWcdAgEsH6HLa9DUL67VNZ0Ds8EGnwZfzWxiJ9jeGEO/OculpzFet4bBxtrtGq2
         dm9XBN/24Y5Fuo4DVjwFKzddTkeWmQme2LbeJMxLakXFvgaircX8kkQgWh7Fg4FSqTK7
         o7YfKdUUecc6biIZZNTcyRIHs8PW513fgwe8nBUbWC1WaautIEvImV9OiVY2tDTxft+y
         a1PkAUjprydAVgo21CEmYqPPjZ6EXahG0Ggo9crpjm4MmKPMRjtdHR0izUgpKVdERnNi
         wbkdHo5+C0KGH81ot5Vs2IqX+EnTRmRrOjcjZHD87D6PZED+uYuCPWLdo4zLUL71kEzk
         lotQ==
X-Received: by 10.66.62.229 with SMTP id b5mr32841762pas.81.1440309060350;
        Sat, 22 Aug 2015 22:51:00 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id v10sm12902064pbs.19.2015.08.22.22.50.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Aug 2015 22:50:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqa8tl7qi3.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276400>

On Thu, Aug 20, 2015 at 11:40:20AM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > The format of the files '.git/rebase-apply/{next,last}' changed sli=
ghtly
> > with the recent builtin 'git am' conversion: while these files were
> > newline-terminated when written by the scripted version, the ones w=
ritten
> > by the builtin are not.
>=20
> Thanks for noticing; that should be corrected, I think.

Okay then, this patch should correct this.

Did we ever explictly allow external programs to poke around the
contents of the .git/rebase-apply directory? I think it may not be so
good, as it means that it may not be possible to switch the storage
format in the future (e.g. to allow atomic modifications, maybe?) :-/ .

Regards,
Paul

-- >8 --
Subject: [PATCH] am: terminate state files with a newline

Since builtin/am.c replaced git-am.sh in 783d7e8 (builtin-am: remove
redirection to git-am.sh, 2015-08-04), the state files written by git-a=
m
did not terminate with a newline.

This is because the code in builtin/am.c did not write the newline to
the state files.

While the git codebase has no problems with the missing newline,
external software which read the contents of the state directory may be
strict about the existence of the terminating newline, and would thus
break.

=46ix this by correcting the relevant calls to write_file() to ensure t=
hat
the state files written terminate with a newline, matching how git-am.s=
h
behaves.

While we are fixing the write_file() calls, fix the writing of the
"dirtyindex" file as well -- we should be creating an empty file to
match the behavior of git-am.sh.

Reported-by: SZEDER G=E1bor <szeder@ira.uka.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1399c8d..2e57fad 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -994,13 +994,13 @@ static void am_setup(struct am_state *state, enum=
 patch_format patch_format,
 	if (state->rebasing)
 		state->threeway =3D 1;
=20
-	write_file(am_path(state, "threeway"), 1, state->threeway ? "t" : "f"=
);
+	write_file(am_path(state, "threeway"), 1, "%s\n", state->threeway ? "=
t" : "f");
=20
-	write_file(am_path(state, "quiet"), 1, state->quiet ? "t" : "f");
+	write_file(am_path(state, "quiet"), 1, "%s\n", state->quiet ? "t" : "=
f");
=20
-	write_file(am_path(state, "sign"), 1, state->signoff ? "t" : "f");
+	write_file(am_path(state, "sign"), 1, "%s\n", state->signoff ? "t" : =
"f");
=20
-	write_file(am_path(state, "utf8"), 1, state->utf8 ? "t" : "f");
+	write_file(am_path(state, "utf8"), 1, "%s\n", state->utf8 ? "t" : "f"=
);
=20
 	switch (state->keep) {
 	case KEEP_FALSE:
@@ -1016,9 +1016,9 @@ static void am_setup(struct am_state *state, enum=
 patch_format patch_format,
 		die("BUG: invalid value for state->keep");
 	}
=20
-	write_file(am_path(state, "keep"), 1, "%s", str);
+	write_file(am_path(state, "keep"), 1, "%s\n", str);
=20
-	write_file(am_path(state, "messageid"), 1, state->message_id ? "t" : =
"f");
+	write_file(am_path(state, "messageid"), 1, "%s\n", state->message_id =
? "t" : "f");
=20
 	switch (state->scissors) {
 	case SCISSORS_UNSET:
@@ -1034,10 +1034,10 @@ static void am_setup(struct am_state *state, en=
um patch_format patch_format,
 		die("BUG: invalid value for state->scissors");
 	}
=20
-	write_file(am_path(state, "scissors"), 1, "%s", str);
+	write_file(am_path(state, "scissors"), 1, "%s\n", str);
=20
 	sq_quote_argv(&sb, state->git_apply_opts.argv, 0);
-	write_file(am_path(state, "apply-opt"), 1, "%s", sb.buf);
+	write_file(am_path(state, "apply-opt"), 1, "%s\n", sb.buf);
=20
 	if (state->rebasing)
 		write_file(am_path(state, "rebasing"), 1, "%s", "");
@@ -1045,7 +1045,7 @@ static void am_setup(struct am_state *state, enum=
 patch_format patch_format,
 		write_file(am_path(state, "applying"), 1, "%s", "");
=20
 	if (!get_sha1("HEAD", curr_head)) {
-		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(curr=
_head));
+		write_file(am_path(state, "abort-safety"), 1, "%s\n", sha1_to_hex(cu=
rr_head));
 		if (!state->rebasing)
 			update_ref("am", "ORIG_HEAD", curr_head, NULL, 0,
 					UPDATE_REFS_DIE_ON_ERR);
@@ -1060,9 +1060,9 @@ static void am_setup(struct am_state *state, enum=
 patch_format patch_format,
 	 * session is in progress, they should be written last.
 	 */
=20
-	write_file(am_path(state, "next"), 1, "%d", state->cur);
+	write_file(am_path(state, "next"), 1, "%d\n", state->cur);
=20
-	write_file(am_path(state, "last"), 1, "%d", state->last);
+	write_file(am_path(state, "last"), 1, "%d\n", state->last);
=20
 	strbuf_release(&sb);
 }
@@ -1095,12 +1095,12 @@ static void am_next(struct am_state *state)
 	unlink(am_path(state, "original-commit"));
=20
 	if (!get_sha1("HEAD", head))
-		write_file(am_path(state, "abort-safety"), 1, "%s", sha1_to_hex(head=
));
+		write_file(am_path(state, "abort-safety"), 1, "%s\n", sha1_to_hex(he=
ad));
 	else
 		write_file(am_path(state, "abort-safety"), 1, "%s", "");
=20
 	state->cur++;
-	write_file(am_path(state, "next"), 1, "%d", state->cur);
+	write_file(am_path(state, "next"), 1, "%d\n", state->cur);
 }
=20
 /**
@@ -1461,7 +1461,7 @@ static int parse_mail_rebase(struct am_state *sta=
te, const char *mail)
 	write_commit_patch(state, commit);
=20
 	hashcpy(state->orig_commit, commit_sha1);
-	write_file(am_path(state, "original-commit"), 1, "%s",
+	write_file(am_path(state, "original-commit"), 1, "%s\n",
 			sha1_to_hex(commit_sha1));
=20
 	return 0;
@@ -1764,7 +1764,7 @@ static void am_run(struct am_state *state, int re=
sume)
 	refresh_and_write_cache();
=20
 	if (index_has_changes(&sb)) {
-		write_file(am_path(state, "dirtyindex"), 1, "t");
+		write_file(am_path(state, "dirtyindex"), 1, "%s", "");
 		die(_("Dirty index: cannot apply patches (dirty: %s)"), sb.buf);
 	}
=20
--=20
2.5.0.400.gff86faf.dirty
