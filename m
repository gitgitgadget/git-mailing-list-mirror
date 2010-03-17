From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/16] cherry-pick: add a label for ancestor
Date: Wed, 17 Mar 2010 07:23:14 -0500
Message-ID: <20100317122314.GO25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 13:23:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrsH1-0007HI-ML
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab0CQMWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 08:22:51 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60209 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab0CQMWu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:22:50 -0400
Received: by pva4 with SMTP id 4so448008pva.19
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 05:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VBqfK7PsyPuslR8MiQo9Et3JJGnxTMw5y2APcDFK1HQ=;
        b=VxOxWMa+pogW97v3H15ap383jYcH+d6oxS1AA7RvY/FQH+LmH4EvDDYaAnjfEf3506
         UAsho8h4qntdAJ9duAgFnCuxrxL3HOo0UOWPuval2DjSpA0eSTuG6tYfSdM7jusYDvXr
         BtP2LqI9PRmdrG2bJUS9NPVGR2KNLVU1i0VHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ih2p0mmlsY8pH9ynfdCAAak04W1GMHtlLnYPPNhdehLXuRjvsWAuOF7Qd3r7vtQj6D
         ixjzvoz8HLDUF0yOik/RXkgTFHllhy/3ela1UvmPTaaqiAf7/AuZVZclMVCj2B03P8FY
         bVzlMj0rEjO+QpiaytULqenKspMZScxbb6rzk=
Received: by 10.141.15.8 with SMTP id s8mr621098rvi.45.1268828569600;
        Wed, 17 Mar 2010 05:22:49 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm6390450iwn.13.2010.03.17.05.22.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 05:22:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142390>

git cherry-pick and git revert will write conflict hunks something
like what =E2=80=98diff3 -m=E2=80=99 produces if the merge.conflictstyl=
e configuration
option is set to diff3.  Unlike =E2=80=98diff3 -m=E2=80=99, though, the=
 output lacks a
label for the merge base on the ||||||| line of the output.

Some tools can misparse the conflict hunks without such a label.
Especially in a cherry-pick, humans parsing the conflict hunks by hand
might want to know what the common ancestor represents, too.  Add a
label.

Example:

	<<<<<<< HEAD
	Something old.
	Something new.
	Something rotten.
	Something blue.
	||||||| parent of 387924c... Remove something rotten
	Something old.
	Something rotten.
	Something blue.
	=3D=3D=3D=3D=3D=3D=3D
	Something old.
	something blue.
	>>>>>>> 387924c... Remove something rotten

git rerere does not have trouble parsing the new output, and its
preimage ids are unchanged since it includes its own code for
recreating conflict hunks.  No other code in git parses conflict
hunks.

Requested-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hopefully the new labels clearer, especially when reverting a commit.
Thoughts?

 builtin/revert.c                |   27 ++++++++++++++++-----------
 t/t3507-cherry-pick-conflict.sh |    4 ++--
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 56f2947..7a39b52 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -73,11 +73,11 @@ static void parse_args(int argc, const char **argv)
 		exit(1);
 }
=20
-static char *get_oneline(const char *message, int revert, char **body)
+static char *get_oneline(const char *message, char **body, char **pare=
nt)
 {
 	char *result, *q;
-	const char *p =3D message, *prefix, *abbrev, *eol;
-	int prefix_len, abbrev_len, oneline_len;
+	const char *p =3D message, *abbrev, *eol;
+	int abbrev_len, oneline_len;
=20
 	if (!p)
 		die ("Could not read commit message of %s",
@@ -91,14 +91,12 @@ static char *get_oneline(const char *message, int r=
evert, char **body)
 			; /* do nothing */
 	} else
 		eol =3D p;
-	prefix =3D revert ? "parent of " : "";
-	prefix_len =3D revert ? strlen("parent of ") : 0;
 	abbrev =3D find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 	abbrev_len =3D strlen(abbrev);
 	oneline_len =3D eol - p;
-	q =3D result =3D xmalloc(prefix_len + abbrev_len +
-			     strlen("... ") + oneline_len + 1);
-	q =3D mempcpy(q, prefix, prefix_len);
+	*parent =3D q =3D xmalloc(strlen("parent of ") + abbrev_len +
+			      strlen("... ") + oneline_len + 1);
+	result =3D q =3D mempcpy(q, "parent of ", strlen("parent of "));
 	q =3D mempcpy(q, abbrev, abbrev_len);
 	*body =3D q =3D mempcpy(q, "... ", strlen("... "));
 	q =3D mempcpy(q, p, oneline_len);
@@ -252,8 +250,10 @@ static int revert_or_cherry_pick(int argc, const c=
har **argv)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
+	const char *base_label, *next_label;
 	int i, index_fd, clean;
-	char *oneline, *oneline_body, *reencoded_message =3D NULL;
+	char *oneline, *oneline_body, *parent_label;
+	char *reencoded_message =3D NULL;
 	const char *message, *encoding;
 	char *defmsg =3D git_pathdup("MERGE_MSG");
 	struct merge_options o;
@@ -345,11 +345,13 @@ static int revert_or_cherry_pick(int argc, const =
char **argv)
 					git_commit_encoding, encoding)))
 		message =3D reencoded_message;
=20
-	oneline =3D get_oneline(message, action =3D=3D REVERT, &oneline_body)=
;
+	oneline =3D get_oneline(message, &oneline_body, &parent_label);
=20
 	if (action =3D=3D REVERT) {
 		base =3D commit;
+		base_label =3D oneline;
 		next =3D parent;
+		next_label =3D parent_label;
 		add_to_msg("Revert \"");
 		add_to_msg(oneline_body);
 		add_to_msg("\"\n\nThis reverts commit ");
@@ -362,7 +364,9 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
 		add_to_msg(".\n");
 	} else {
 		base =3D parent;
+		base_label =3D parent_label;
 		next =3D commit;
+		next_label =3D oneline;
 		set_author_ident_env(message);
 		add_message_to_msg(message);
 		if (no_replay) {
@@ -374,8 +378,9 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
=20
 	read_cache();
 	init_merge_options(&o);
+	o.ancestor =3D base ? base_label : "(empty tree)";
 	o.branch1 =3D "HEAD";
-	o.branch2 =3D oneline;
+	o.branch2 =3D next ? next_label : "(empty tree)";
=20
 	head_tree =3D parse_tree_indirect(head);
 	next_tree =3D next ? next->tree : empty_tree();
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conf=
lict.sh
index 6a20817..e25cf80 100644
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -112,7 +112,7 @@ test_expect_success 'diff3 -m style' '
 	cat <<-EOF > expected &&
 	<<<<<<< HEAD
 	a
-	|||||||
+	||||||| parent of objid picked
 	b
 	=3D=3D=3D=3D=3D=3D=3D
 	c
@@ -179,7 +179,7 @@ test_expect_success 'revert conflict, diff3 -m styl=
e' '
 	cat <<-EOF > expected &&
 	<<<<<<< HEAD
 	a
-	|||||||
+	||||||| objid picked
 	c
 	=3D=3D=3D=3D=3D=3D=3D
 	b
--=20
1.7.0
