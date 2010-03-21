From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/14] revert: clarify label on conflict hunks
Date: Sat, 20 Mar 2010 19:45:21 -0500
Message-ID: <20100321004521.GG23888@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
 <20100321002535.GA23681@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:44:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt9HI-0002mY-BD
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180Ab0CUAoX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 20:44:23 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52339 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab0CUAoW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:44:22 -0400
Received: by gwaa18 with SMTP id a18so399716gwa.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LzaFxmxpFnTXlMU+u2R32XBJskCbTul1cV0jWugblBI=;
        b=J/MYFbrLOlaXeYDKVzXJV1tQhlI4zklDJJBH1eDKi8n3oRjGGtfSCYPlXbLKT+Uyvl
         Kmnlr7uCMz26yubs3rbbkplSPTzOps0zZT4UWIwW9pe/DsOY4xqnZwneb7gSp5hsWKjB
         EikV39Lanc7xIUa4SSA9ErCkt5iZspsuUBucU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=oSZqqdOlRCXXgcJxSGAiqgFr3c9sMEXpGdzyXbcVijaaywamv7HLwgxDHL+Bekmvxa
         lHLQ9nXZ+o2awWBa9dVWo05wTdU5GL7ocPrKyE0WH+AkwwG98BOt6gpLEpuB9QvQtlPT
         +FiRx4FGfisrpthH3IIdpNm55gWiSufwCzYA0=
Received: by 10.100.27.31 with SMTP id a31mr4820616ana.133.1269132261861;
        Sat, 20 Mar 2010 17:44:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2765068iwn.2.2010.03.20.17.44.20
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:44:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321002535.GA23681@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142780>

When reverting a commit, the commit being merged is not the commit
to revert itself but its parent.  Add =E2=80=9Cparent of=E2=80=9D to th=
e conflict
hunk label to make this more clear.

The conflict hunk labels are all pieces of a single string written in
the new get_message() function.  Avoid some complication by using
mempcpy to advance a pointer as the result is written.

Also free the corresponding temporary buffer (it was leaked before).
This is not important because it is a small one-time allocation.  It
would become a memory leak if unnoticed when libifying revert.

This patch uses calls to strlen() instead of integer constants in some
places.  GCC will compute the length at compile time; I am not sure
about other compilers, but this is not performance-critical anyway.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
=46rom <http://thread.gmane.org/gmane.comp.version-control.git/142374/f=
ocus=3D142448>.

Thanks to Stephen for advice.

 builtin/revert.c                |  100 ++++++++++++++++++++++++-------=
--------
 t/t3507-cherry-pick-conflict.sh |    4 +-
 2 files changed, 63 insertions(+), 41 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index eff5268..b314629 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -45,6 +45,8 @@ static const char *me;
=20
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
=20
+static char *get_encoding(const char *message);
+
 static void parse_args(int argc, const char **argv)
 {
 	const char * const * usage_str =3D
@@ -73,33 +75,63 @@ static void parse_args(int argc, const char **argv)
 		exit(1);
 }
=20
-static char *get_oneline(const char *message)
+struct commit_message {
+	char *parent_label;
+	const char *label;
+	const char *subject;
+	char *reencoded_message;
+	const char *message;
+};
+
+static int get_message(const char *raw_message, struct commit_message =
*out)
 {
-	char *result;
-	const char *p =3D message, *abbrev, *eol;
+	const char *encoding;
+	const char *p, *abbrev, *eol;
+	char *q;
 	int abbrev_len, oneline_len;
=20
-	if (!p)
-		die ("Could not read commit message of %s",
-				sha1_to_hex(commit->object.sha1));
+	if (!raw_message)
+		return -1;
+	encoding =3D get_encoding(raw_message);
+	if (!encoding)
+		encoding =3D "UTF-8";
+	if (!git_commit_encoding)
+		git_commit_encoding =3D "UTF-8";
+	if ((out->reencoded_message =3D reencode_string(raw_message,
+					git_commit_encoding, encoding)))
+		out->message =3D out->reencoded_message;
+
+	abbrev =3D find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
+	abbrev_len =3D strlen(abbrev);
+
+	/* Find beginning and end of commit subject. */
+	p =3D out->message;
 	while (*p && (*p !=3D '\n' || p[1] !=3D '\n'))
 		p++;
-
 	if (*p) {
 		p +=3D 2;
 		for (eol =3D p + 1; *eol && *eol !=3D '\n'; eol++)
 			; /* do nothing */
 	} else
 		eol =3D p;
-	abbrev =3D find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
-	abbrev_len =3D strlen(abbrev);
 	oneline_len =3D eol - p;
-	result =3D xmalloc(abbrev_len + 5 + oneline_len);
-	memcpy(result, abbrev, abbrev_len);
-	memcpy(result + abbrev_len, "... ", 4);
-	memcpy(result + abbrev_len + 4, p, oneline_len);
-	result[abbrev_len + 4 + oneline_len] =3D '\0';
-	return result;
+
+	out->parent_label =3D xmalloc(strlen("parent of ") + abbrev_len +
+			      strlen("... ") + oneline_len + 1);
+	q =3D out->parent_label;
+	q =3D mempcpy(q, "parent of ", strlen("parent of "));
+	out->label =3D q;
+	q =3D mempcpy(q, abbrev, abbrev_len);
+	q =3D mempcpy(q, "... ", strlen("... "));
+	out->subject =3D q;
+	q =3D mempcpy(q, p, oneline_len);
+	*q =3D '\0';
+	return 0;
+}
+
+static void free_message(struct commit_message *msg) {
+	free(msg->parent_label);
+	free(msg->reencoded_message);
 }
=20
 static char *get_encoding(const char *message)
@@ -248,9 +280,10 @@ static int revert_or_cherry_pick(int argc, const c=
har **argv)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
+	const char *next_label;
 	int i, index_fd, clean;
-	char *oneline, *reencoded_message =3D NULL;
-	const char *message, *encoding;
+	struct commit_message msg =3D { NULL, NULL, NULL, NULL, NULL };
+
 	char *defmsg =3D git_pathdup("MERGE_MSG");
 	struct merge_options o;
 	struct tree *result, *next_tree, *base_tree, *head_tree;
@@ -314,14 +347,14 @@ static int revert_or_cherry_pick(int argc, const =
char **argv)
 	else
 		parent =3D commit->parents->item;
=20
-	if (!(message =3D commit->buffer))
-		die ("Cannot get commit message for %s",
-				sha1_to_hex(commit->object.sha1));
-
 	if (parent && parse_commit(parent) < 0)
 		die("%s: cannot parse parent commit %s",
 		    me, sha1_to_hex(parent->object.sha1));
=20
+	if (get_message(commit->buffer, &msg) !=3D 0)
+		die ("Cannot get commit message for %s",
+				sha1_to_hex(commit->object.sha1));
+
 	/*
 	 * "commit" is an existing commit.  We would want to apply
 	 * the difference it introduces since its first parent "prev"
@@ -332,24 +365,12 @@ static int revert_or_cherry_pick(int argc, const =
char **argv)
 	msg_fd =3D hold_lock_file_for_update(&msg_file, defmsg,
 					   LOCK_DIE_ON_ERROR);
=20
-	encoding =3D get_encoding(message);
-	if (!encoding)
-		encoding =3D "UTF-8";
-	if (!git_commit_encoding)
-		git_commit_encoding =3D "UTF-8";
-	if ((reencoded_message =3D reencode_string(message,
-					git_commit_encoding, encoding)))
-		message =3D reencoded_message;
-
-	oneline =3D get_oneline(message);
-
 	if (action =3D=3D REVERT) {
-		char *oneline_body =3D strchr(oneline, ' ');
-
 		base =3D commit;
 		next =3D parent;
+		next_label =3D msg.parent_label;
 		add_to_msg("Revert \"");
-		add_to_msg(oneline_body + 1);
+		add_to_msg(msg.subject);
 		add_to_msg("\"\n\nThis reverts commit ");
 		add_to_msg(sha1_to_hex(commit->object.sha1));
=20
@@ -361,8 +382,9 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
 	} else {
 		base =3D parent;
 		next =3D commit;
-		set_author_ident_env(message);
-		add_message_to_msg(message);
+		next_label =3D msg.label;
+		set_author_ident_env(msg.message);
+		add_message_to_msg(msg.message);
 		if (no_replay) {
 			add_to_msg("(cherry picked from commit ");
 			add_to_msg(sha1_to_hex(commit->object.sha1));
@@ -373,7 +395,7 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
 	read_cache();
 	init_merge_options(&o);
 	o.branch1 =3D "HEAD";
-	o.branch2 =3D oneline;
+	o.branch2 =3D next ? next_label : "(empty tree)";
=20
 	head_tree =3D parse_tree_indirect(head);
 	next_tree =3D next ? next->tree : empty_tree();
@@ -437,7 +459,7 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
 		args[i] =3D NULL;
 		return execv_git_cmd(args);
 	}
-	free(reencoded_message);
+	free_message(&msg);
 	free(defmsg);
=20
 	return 0;
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conf=
lict.sh
index e856356..6a20817 100644
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -138,7 +138,7 @@ test_expect_success 'revert also handles conflicts =
sanely' '
 	a
 	=3D=3D=3D=3D=3D=3D=3D
 	b
-	>>>>>>> objid picked
+	>>>>>>> parent of objid picked
 	EOF
 	{
 		git checkout picked -- foo &&
@@ -183,7 +183,7 @@ test_expect_success 'revert conflict, diff3 -m styl=
e' '
 	c
 	=3D=3D=3D=3D=3D=3D=3D
 	b
-	>>>>>>> objid picked
+	>>>>>>> parent of objid picked
 	EOF
=20
 	git update-index --refresh &&
--=20
1.7.0.2
