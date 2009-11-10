From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 7/8] builtin-fetch: add --dry-run option
Date: Tue, 10 Nov 2009 09:19:43 +0100
Message-ID: <4AF9221F.3080605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 09:19:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7lxA-0000hY-EH
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 09:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbZKJITl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 03:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbZKJITl
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 03:19:41 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:49345 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbZKJITk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 03:19:40 -0500
Received: by ewy3 with SMTP id 3so3976318ewy.37
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 00:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=3KvK2QNSKj27dImU6nMJZnaqzxKR8gXXDP/eUJvpXRE=;
        b=K0+xSBKjDL6GMGVZZUBrugbDkz7d8fgk5FKNJCtxEhOaHONndgY6k3Sa+nvjfpQKiM
         ucC65mRq3JNZsGjeB9rFr+r+0tp9pb7CDV3jnBK4vjWN5oxoyUl+co336O9wSkQO1prY
         ltQQpto9cHV5Q+RFM0hAAiaJUl9kp8VPQbsEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=vVOcya/UnOtZ0jaKkspbU7TiEJeqjnMb/1/JoxzEJBBP7pCX03qftu/C27njvlfa99
         ISW0ftZ3XL0ZXV5J6QGVOmDJLdbwNKx7uWfFvMH1O705/637L/4MWtHg4924sOJZpvZZ
         3f4qoNm/QgxujPp+J3Yn16FaAaH2GQmfzfUF0=
Received: by 10.213.103.83 with SMTP id j19mr2166063ebo.30.1257841184724;
        Tue, 10 Nov 2009 00:19:44 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 24sm1164525eyx.29.2009.11.10.00.19.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 00:19:44 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132547>

=46rom: Jay Soffian <jaysoffian@gmail.com>

Teach fetch --dry-run as users of "git remote prune" switching to "git =
fetch
--prune" may expect it. Unfortunately OPT__DRY_RUN() cannot be used as =
fetch
already uses "-n" for something else.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
I have removed the changes to builtin_remote.c and
the test case and also removed mentioning of those
changes in the commit message.

 Documentation/fetch-options.txt |    5 +++++
 builtin-fetch.c                 |   14 ++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 500637a..ab6419f 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -12,6 +12,11 @@
 	`git clone` with `--depth=3D<depth>` option (see linkgit:git-clone[1]=
)
 	by the specified number of commits.
=20
+ifndef::git-pull[]
+--dry-run::
+	Show what would be done, without making any changes.
+endif::git-pull[]
+
 -f::
 --force::
 	When 'git-fetch' is used with `<rbranch>:<lbranch>`
diff --git a/builtin-fetch.c b/builtin-fetch.c
index fd31072..8082d36 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -26,7 +26,7 @@ enum {
 	TAGS_SET =3D 2
 };
=20
-static int all, append, force, keep, multiple, prune, update_head_ok, =
verbosity;
+static int all, append, dry_run, force, keep, multiple, prune, update_=
head_ok, verbosity;
 static int tags =3D TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -51,6 +51,8 @@ static struct option builtin_fetch_options[] =3D {
 		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
 	OPT_BOOLEAN('p', "prune", &prune,
 		    "prune tracking branches no longer on remote"),
+	OPT_BOOLEAN(0, "dry-run", &dry_run,
+		    "dry run"),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
 		    "allow updating of HEAD ref"),
@@ -187,6 +189,8 @@ static int s_update_ref(const char *action,
 	char *rla =3D getenv("GIT_REFLOG_ACTION");
 	static struct ref_lock *lock;
=20
+	if (dry_run)
+		return 0;
 	if (!rla)
 		rla =3D default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
@@ -312,7 +316,7 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 	char note[1024];
 	const char *what, *kind;
 	struct ref *rm;
-	char *url, *filename =3D git_path("FETCH_HEAD");
+	char *url, *filename =3D dry_run ? "/dev/null" : git_path("FETCH_HEAD=
");
=20
 	fp =3D fopen(filename, "a");
 	if (!fp)
@@ -658,7 +662,7 @@ static int do_fetch(struct transport *transport,
 		die("Don't know how to fetch from %s", transport->url);
=20
 	/* if not appending, truncate FETCH_HEAD */
-	if (!append) {
+	if (!append && !dry_run) {
 		char *filename =3D git_path("FETCH_HEAD");
 		FILE *fp =3D fopen(filename, "w");
 		if (!fp)
@@ -766,9 +770,11 @@ static int add_remote_or_group(const char *name, s=
truct string_list *list)
 static int fetch_multiple(struct string_list *list)
 {
 	int i, result =3D 0;
-	const char *argv[] =3D { "fetch", NULL, NULL, NULL, NULL, NULL };
+	const char *argv[] =3D { "fetch", NULL, NULL, NULL, NULL, NULL, NULL =
};
 	int argc =3D 1;
=20
+	if (dry_run)
+		argv[argc++] =3D "--dry-run";
 	if (prune)
 		argv[argc++] =3D "--prune";
 	if (verbosity >=3D 2)
--=20
1.6.5.1.69.g36942
