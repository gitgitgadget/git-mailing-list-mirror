From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 18/18] revert: Introduce --continue to continue the
 operation
Date: Wed, 27 Jul 2011 17:42:58 +0200
Message-ID: <20110727154258.GE24785@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-19-git-send-email-artagnon@gmail.com>
 <20110727052211.GM18470@elie>
 <CALkWK0nX5GsfGi9ifxkfvoZWxVzFKBs8X60Svda0rQWKzz0aww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 17:43:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm6GS-0007RZ-V8
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 17:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036Ab1G0PnN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 11:43:13 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:39527 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab1G0PnL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 11:43:11 -0400
Received: by eye22 with SMTP id 22so2035512eye.2
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IgJJ3uxte7N0fqyQ7FVP5t0smbkkLBnyw1+oSd+TE2c=;
        b=dZOI6lCP7N0MLJthRPw0hZv2XJOaLH0gxfUTVIvDg+STsZO/ZR56W33ZHk9B+UfTNz
         6GU9GLw5IHvfnyjskcwAqXtsB0kHOhKCwjY5Lu4xWIA6ziNrB1cuDgcDunyLRxZmbDCo
         sAJ+U9f6mrt5u1kxegXHRlmoP6XONaxxoDJyM=
Received: by 10.14.48.73 with SMTP id u49mr73168eeb.66.1311781390065;
        Wed, 27 Jul 2011 08:43:10 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id y9sm100044eeh.34.2011.07.27.08.43.05
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 08:43:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nX5GsfGi9ifxkfvoZWxVzFKBs8X60Svda0rQWKzz0aww@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177974>

Ramkumar Ramachandra wrote:
>> Ramkumar Ramachandra wrote:

>>> during commit time. =C2=A0One glitch to note is that the "--signoff=
" option
>>> specified at cherry-pick invocation time is not reflected in the
>>> commit message provided by CHERRY_PICK_HEAD
[...]
> The previous discussion thread for your reference [1] -- I thought we
> agreed that it was a glitch.

Ok.  I thought it had come up before and that there was not wide
agreement but probably I imagined it.  How about the patch below
(needs commit message, tests)?

Anyway, this is simple program logic that would be easy to change, not
a short-lived fault like the term "glitch" usually refers to.

> Neither of us can find any traces of it
> being intentional, and the commit that introduced this option doesn't
> say this: v1.5.6-rc0~83^2 (Allow cherry-pick (and revert) to add
> signoff line, 2008-04-26).

At the time, -x was not propagated to "git commit", either.  I guess
it was not considered notable that -s worked the same way, as in
"Of course 'git commit -c $original_commit' is going to discard
MERGE_MSG."

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/commit.c |   62 +---------------------------------------------
 builtin/revert.c |    5 ++-
 commit.c         |   71 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 commit.h         |    3 ++
 4 files changed, 79 insertions(+), 62 deletions(-)

diff --git c/builtin/commit.c i/builtin/commit.c
index e1af9b19..55ae8294 100644
--- c/builtin/commit.c
+++ i/builtin/commit.c
@@ -524,8 +524,6 @@ static int is_a_merge(const unsigned char *sha1)
 	return !!(commit->parents && commit->parents->next);
 }
=20
-static const char sign_off_header[] =3D "Signed-off-by: ";
-
 static void determine_author_info(struct strbuf *author_ident)
 {
 	char *name, *email, *date;
@@ -574,47 +572,6 @@ static void determine_author_info(struct strbuf *a=
uthor_ident)
 					      IDENT_ERROR_ON_NO_NAME));
 }
=20
-static int ends_rfc2822_footer(struct strbuf *sb)
-{
-	int ch;
-	int hit =3D 0;
-	int i, j, k;
-	int len =3D sb->len;
-	int first =3D 1;
-	const char *buf =3D sb->buf;
-
-	for (i =3D len - 1; i > 0; i--) {
-		if (hit && buf[i] =3D=3D '\n')
-			break;
-		hit =3D (buf[i] =3D=3D '\n');
-	}
-
-	while (i < len - 1 && buf[i] =3D=3D '\n')
-		i++;
-
-	for (; i < len; i =3D k) {
-		for (k =3D i; k < len && buf[k] !=3D '\n'; k++)
-			; /* do nothing */
-		k++;
-
-		if ((buf[k] =3D=3D ' ' || buf[k] =3D=3D '\t') && !first)
-			continue;
-
-		first =3D 0;
-
-		for (j =3D 0; i + j < len; j++) {
-			ch =3D buf[i + j];
-			if (ch =3D=3D ':')
-				break;
-			if (isalnum(ch) ||
-			    (ch =3D=3D '-'))
-				continue;
-			return 0;
-		}
-	}
-	return 1;
-}
-
 static char *cut_ident_timestamp_part(char *string)
 {
 	char *ket =3D strrchr(string, '>');
@@ -734,23 +691,8 @@ static int prepare_to_commit(const char *index_fil=
e, const char *prefix,
 	if (clean_message_contents)
 		stripspace(&sb, 0);
=20
-	if (signoff) {
-		struct strbuf sob =3D STRBUF_INIT;
-		int i;
-
-		strbuf_addstr(&sob, sign_off_header);
-		strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
-					     getenv("GIT_COMMITTER_EMAIL")));
-		strbuf_addch(&sob, '\n');
-		for (i =3D sb.len - 1; i > 0 && sb.buf[i - 1] !=3D '\n'; i--)
-			; /* do nothing */
-		if (prefixcmp(sb.buf + i, sob.buf)) {
-			if (!i || !ends_rfc2822_footer(&sb))
-				strbuf_addch(&sb, '\n');
-			strbuf_addbuf(&sb, &sob);
-		}
-		strbuf_release(&sob);
-	}
+	if (signoff)
+		add_signoff(&sb);
=20
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno(_("could not write commit template"));
diff --git c/builtin/revert.c i/builtin/revert.c
index 1f27c633..79ed9883 100644
--- c/builtin/revert.c
+++ i/builtin/revert.c
@@ -369,8 +369,6 @@ static int run_git_commit(const char *defmsg)
=20
 	args[i++] =3D "commit";
 	args[i++] =3D "-n";
-	if (signoff)
-		args[i++] =3D "-s";
 	if (!edit) {
 		args[i++] =3D "-F";
 		args[i++] =3D defmsg;
@@ -485,6 +483,9 @@ static int do_pick_commit(void)
 			write_cherry_pick_head();
 	}
=20
+	if (signoff)
+		add_signoff(&msgbuf);
+
 	if (!strategy || !strcmp(strategy, "recursive") || action =3D=3D REVE=
RT) {
 		res =3D do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf);
diff --git c/commit.c i/commit.c
index ac337c7d..5022db6e 100644
--- c/commit.c
+++ i/commit.c
@@ -10,6 +10,7 @@
 int save_commit_buffer =3D 1;
=20
 const char *commit_type =3D "commit";
+const char sign_off_header[] =3D "Signed-off-by: ";
=20
 static struct commit *check_commit(struct object *obj,
 				   const unsigned char *sha1,
@@ -348,6 +349,76 @@ int find_commit_subject(const char *commit_buffer,=
 const char **subject)
 	return eol - p;
 }
=20
+static int ends_rfc2822_footer(struct strbuf *sb)
+{
+	int ch;
+	int hit =3D 0;
+	int i, j, k;
+	int len =3D sb->len;
+	int first =3D 1;
+	const char *buf =3D sb->buf;
+
+	for (i =3D len - 1; i > 0; i--) {
+		if (hit && buf[i] =3D=3D '\n')
+			break;
+		hit =3D (buf[i] =3D=3D '\n');
+	}
+
+	while (i < len - 1 && buf[i] =3D=3D '\n')
+		i++;
+
+	for (; i < len; i =3D k) {
+		for (k =3D i; k < len && buf[k] !=3D '\n'; k++)
+			; /* do nothing */
+		k++;
+
+		if ((buf[k] =3D=3D ' ' || buf[k] =3D=3D '\t') && !first)
+			continue;
+
+		first =3D 0;
+
+		for (j =3D 0; i + j < len; j++) {
+			ch =3D buf[i + j];
+			if (ch =3D=3D ':')
+				break;
+			if (isalnum(ch) ||
+			    (ch =3D=3D '-'))
+				continue;
+			return 0;
+		}
+	}
+	return 1;
+}
+
+void add_signoff(struct strbuf *sb)
+{
+	struct strbuf sob =3D STRBUF_INIT;
+	const char *p;
+
+	strbuf_addstr(&sob, sign_off_header);
+	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
+				     getenv("GIT_COMMITTER_EMAIL")));
+	strbuf_addch(&sob, '\n');
+
+	/* final line */
+	p =3D memrchr(sb->buf, '\n', sb->len ? sb->len - 1 : 0);
+	if (!p)
+		p =3D sb->buf;
+	else
+		p++;
+
+	/*
+	 * If the line does not already contain our sign-off,
+	 * add it.
+	 */
+	if (prefixcmp(p, sob.buf)) {
+		if (p =3D=3D sb->buf || !ends_rfc2822_footer(sb))
+			strbuf_addch(sb, '\n');
+		strbuf_addbuf(sb, &sob);
+	}
+	strbuf_release(&sob);
+}
+
 struct commit_list *commit_list_insert(struct commit *item, struct com=
mit_list **list_p)
 {
 	struct commit_list *new_list =3D xmalloc(sizeof(struct commit_list));
diff --git c/commit.h i/commit.h
index a2d571b9..3d198afb 100644
--- c/commit.h
+++ i/commit.h
@@ -23,6 +23,7 @@ struct commit {
=20
 extern int save_commit_buffer;
 extern const char *commit_type;
+extern const char sign_off_header[];
=20
 /* While we can decorate any object with a name, it's only used for co=
mmits.. */
 extern struct decoration name_decoration;
@@ -44,6 +45,8 @@ int parse_commit(struct commit *item);
 /* Find beginning and length of commit subject. */
 int find_commit_subject(const char *commit_buffer, const char **subjec=
t);
=20
+void add_signoff(struct strbuf *sb);
+
 struct commit_list *commit_list_insert(struct commit *item,
 					struct commit_list **list);
 unsigned commit_list_count(const struct commit_list *l);
--=20
