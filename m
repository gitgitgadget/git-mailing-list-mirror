From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] cherry-pick/revert: Use advise() for hints
Date: Wed, 11 Aug 2010 03:37:51 -0500
Message-ID: <20100811083751.GE16495@burratino>
References: <20100725005443.GA18370@burratino>
 <AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com>
 <201007251122.41166.trast@student.ethz.ch>
 <20100729235151.GB6623@burratino>
 <AANLkTi=ao2RY8NGm4cACqz3_5zfT2zvXB4JHOopBD9T5@mail.gmail.com>
 <20100811083100.GA16495@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 10:39:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6qg-0002s6-QJ
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784Ab0HKIjW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 04:39:22 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60965 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932727Ab0HKIjU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 04:39:20 -0400
Received: by gwb20 with SMTP id 20so3982382gwb.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 01:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Olsm/op73LOvYu1S97pSRL8BVz+LfCmBYlejscTMDKY=;
        b=CyPHnR1Wd/4zNIppdIsb9vFTbTYm6/8xSoHgAiEhBZfE94jENmatlzKzFnqST0duZX
         Abk0celUHC3OmewEwTG1RkSOEtVmcNd1eLpVEnUoFwzIcV5XNhiy+9+oHVxP/yOE9pgA
         Lh43dm08kxPScYQudo3bRcN0+NW/at/z/7c0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RqNFfyXZJxQtF6maU3A2/V/mkpe2aVwt1W/RN+OR11PTlNV41QRFdmdpC6RbWTvjxe
         Bq+lVfb72tDqBUMVxlozA+MJrbXDYgvwA7ctgAnJatKP16jIJa90zGfvqrIADmRgzFZC
         QZh5k8HPnjsrjdQrBu6c3sJQOMJwcXZh2w/cs=
Received: by 10.151.122.2 with SMTP id z2mr20659520ybm.435.1281515959660;
        Wed, 11 Aug 2010 01:39:19 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id 18sm396471ybk.7.2010.08.11.01.39.18
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 01:39:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100811083100.GA16495@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153210>

When cherry-pick fails after picking a large series of commits, it can
be hard to pick out the error message and advice.  Prefix the advice
with =E2=80=9Chint: =E2=80=9D to help.

Before:

    error: could not apply 7ab78c9... foo
      After resolving the conflicts,
    mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
    and commit the result with:

            git commit -c 7ab78c9a7898b87127365478431289cb98f8d98f

After:

    error: could not apply 7ab78c9... foo
    hint: after resolving the conflicts, mark the corrected paths
    hint: with 'git add <paths>' or 'git rm <paths>'
    hint: and commit the result with 'git commit -c 7ab78c9'

Noticed-by: Thomas Rast <trast@student.ethz.ch>
Encouraged-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 builtin/revert.c                |   36 ++++++++++++-------------------=
-----
 git-rebase--interactive.sh      |    6 +++---
 t/t3507-cherry-pick-conflict.sh |   20 ++++++++++++++++++++
 3 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 9a7483b..7f35cc6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -250,27 +250,21 @@ static void advise(const char *advice, ...)
 	va_end(params);
 }
=20
-static char *help_msg(void)
+static void print_advice(void)
 {
-	struct strbuf helpbuf =3D STRBUF_INIT;
 	char *msg =3D getenv("GIT_CHERRY_PICK_HELP");
=20
-	if (msg)
-		return msg;
-
-	strbuf_addstr(&helpbuf, "  After resolving the conflicts,\n"
-		"mark the corrected paths with 'git add <paths>' or 'git rm <paths>'=
\n"
-		"and commit the result");
-
-	if (action =3D=3D CHERRY_PICK) {
-		strbuf_addf(&helpbuf, " with: \n"
-			"\n"
-			"        git commit -c %s\n",
-			    sha1_to_hex(commit->object.sha1));
+	if (msg) {
+		fprintf(stderr, "%s\n", msg);
+		return;
 	}
-	else
-		strbuf_addch(&helpbuf, '.');
-	return strbuf_detach(&helpbuf, NULL);
+
+	advise("after resolving the conflicts, mark the corrected paths");
+	advise("with 'git add <paths>' or 'git rm <paths>'");
+
+	if (action =3D=3D CHERRY_PICK)
+		advise("and commit the result with 'git commit -c %s'",
+		       find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
 }
=20
 static void write_message(struct strbuf *msgbuf, const char *filename)
@@ -404,7 +398,6 @@ static int do_pick_commit(void)
 	struct commit_message msg =3D { NULL, NULL, NULL, NULL, NULL };
 	char *defmsg =3D NULL;
 	struct strbuf msgbuf =3D STRBUF_INIT;
-	struct strbuf mebuf =3D STRBUF_INIT;
 	int res;
=20
 	if (no_commit) {
@@ -501,9 +494,6 @@ static int do_pick_commit(void)
 		}
 	}
=20
-	strbuf_addf(&mebuf, "%s of commit %s", me,
-		    find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
-
 	if (!strategy || !strcmp(strategy, "recursive") || action =3D=3D REVE=
RT) {
 		res =3D do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf);
@@ -512,7 +502,6 @@ static int do_pick_commit(void)
 		struct commit_list *common =3D NULL;
 		struct commit_list *remotes =3D NULL;
=20
-		strbuf_addf(&mebuf, " with strategy %s", strategy);
 		write_message(&msgbuf, defmsg);
=20
 		commit_list_insert(base, &common);
@@ -528,14 +517,13 @@ static int do_pick_commit(void)
 		      action =3D=3D REVERT ? "revert" : "apply",
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
 		      msg.subject);
-		fprintf(stderr, help_msg());
+		print_advice();
 		rerere(allow_rerere_auto);
 	} else {
 		if (!no_commit)
 			res =3D run_git_commit(defmsg);
 	}
=20
-	strbuf_release(&mebuf);
 	free_message(&msg);
 	free(defmsg);
=20
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 31e6860..8f6876d 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -113,9 +113,9 @@ REBASE_ROOT=3D
 AUTOSQUASH=3D
 NEVER_FF=3D
=20
-GIT_CHERRY_PICK_HELP=3D"  After resolving the conflicts,
-mark the corrected paths with 'git add <paths>', and
-run 'git rebase --continue'"
+GIT_CHERRY_PICK_HELP=3D"\
+hint: after resolving the conflicts, mark the corrected paths
+hint: with 'git add <paths>' and run 'git rebase --continue'"
 export GIT_CHERRY_PICK_HELP
=20
 warn () {
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conf=
lict.sh
index e25cf80..3f29594 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -38,6 +38,26 @@ test_expect_success 'failed cherry-pick does not adv=
ance HEAD' '
 	test "$head" =3D "$newhead"
 '
=20
+test_expect_success 'advice from failed cherry-pick' '
+	git checkout -f initial^0 &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x &&
+
+	git update-index --refresh &&
+	git diff-index --exit-code HEAD &&
+
+	picked=3D$(git rev-parse --short picked) &&
+	cat <<-EOF >expected &&
+	error: could not apply $picked... picked
+	hint: after resolving the conflicts, mark the corrected paths
+	hint: with 'git add <paths>' or 'git rm <paths>'
+	hint: and commit the result with 'git commit -c $picked'
+	EOF
+	test_must_fail git cherry-pick picked 2>actual &&
+
+	test_cmp expected actual
+'
+
 test_expect_success 'failed cherry-pick produces dirty index' '
=20
 	git checkout -f initial^0 &&
--=20
1.7.2.1.544.ga752d.dirty
