From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: [PATCH v4] builtin-push: add --delete as syntactic sugar for :foo
Date: Wed, 30 Dec 2009 20:57:42 +0100
Message-ID: <20091230205742.23d73eb6@perceptron>
References: <20091109130935.2bea7771@perceptron>
	<7v8wefy6pi.fsf@alter.siamese.dyndns.org>
	<20091109192044.605e50ba@perceptron>
	<20091229200523.6117@nanako3.lavabit.com>
	<7vvdfpg1je.fsf@alter.siamese.dyndns.org>
	<20091230105244.67f5969e@perceptron>
	<7vvdfoz1hi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Git ML <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 20:57:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ4g6-00053c-Ic
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 20:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbZL3T5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2009 14:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbZL3T5u
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 14:57:50 -0500
Received: from zoidberg.org ([88.198.6.61]:57084 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914AbZL3T5t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 14:57:49 -0500
Received: from perceptron (xdsl-78-35-135-121.netcologne.de [::ffff:78.35.135.121])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Wed, 30 Dec 2009 20:57:46 +0100
  id 004D0244.4B3BB0BB.00006C79
In-Reply-To: <7vvdfoz1hi.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135922>

Refspecs without a source side have been reported as confusing by many.
As an alternative, this adds support for commands like:

    git push origin --delete somebranch
    git push origin --delete tag sometag

Specifically, --delete will prepend a colon to all colon-less refspecs
given on the command line, and will refuse to accept refspecs with
colons to prevent undue confusion.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
 Documentation/git-push.txt |    4 ++++
 builtin-push.c             |   26 +++++++++++++++++++++++---
 t/t5516-fetch-push.sh      |   26 ++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 3 deletions(-)

Junio C Hamano <gitster@pobox.com> wrote:

> Thanks.  From a cursory read, the patch looks good.  We would however
> want to have a test that has test_must_fail to protect the error
> codepath from getting broken in the future.

Here you are.

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 52c0538..e3eb1e8 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -91,6 +91,10 @@ nor in any Push line of the corresponding remotes fi=
le---see below).
 	will be tab-separated and sent to stdout instead of stderr.  The full
 	symbolic names of the refs will be given.
=20
+--delete::
+	All listed refs are deleted from the remote repository. This is
+	the same as prefixing all refs with a colon.
+
 --tags::
 	All refs under `$GIT_DIR/refs/tags` are pushed, in
 	addition to refspecs explicitly listed on the command
diff --git a/builtin-push.c b/builtin-push.c
index dcfb53f..f7661d2 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -15,6 +15,7 @@ static const char * const push_usage[] =3D {
 };
=20
 static int thin;
+static int deleterefs;
 static const char *receivepack;
=20
 static const char **refspec;
@@ -39,11 +40,24 @@ static void set_refspecs(const char **refs, int nr)
 			if (nr <=3D ++i)
 				die("tag shorthand without <tag>");
 			len =3D strlen(refs[i]) + 11;
-			tag =3D xmalloc(len);
-			strcpy(tag, "refs/tags/");
+			if (deleterefs) {
+				tag =3D xmalloc(len+1);
+				strcpy(tag, ":refs/tags/");
+			} else {
+				tag =3D xmalloc(len);
+				strcpy(tag, "refs/tags/");
+			}
 			strcat(tag, refs[i]);
 			ref =3D tag;
-		}
+		} else if (deleterefs && !strchr(ref, ':')) {
+			char *delref;
+			int len =3D strlen(ref)+1;
+			delref =3D xmalloc(len);
+			strcpy(delref, ":");
+			strcat(delref, ref);
+			ref =3D delref;
+		} else if (deleterefs)
+			die("--delete only accepts plain target ref names");
 		add_refspec(ref);
 	}
 }
@@ -196,6 +210,7 @@ int cmd_push(int argc, const char **argv, const cha=
r *prefix)
 		OPT_BIT( 0 , "all", &flags, "push all refs", TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
+		OPT_BOOLEAN( 0, "delete", &deleterefs, "delete refs"),
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags (can't be used with --all=
 or --mirror)"),
 		OPT_BIT('n' , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output", TRANSPO=
RT_PUSH_PORCELAIN),
@@ -209,6 +224,11 @@ int cmd_push(int argc, const char **argv, const ch=
ar *prefix)
 	git_config(git_default_config, NULL);
 	argc =3D parse_options(argc, argv, prefix, options, push_usage, 0);
=20
+	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_P=
USH_MIRROR))))
+		die("--delete is incompatible with --all, --mirror and --tags");
+	if (deleterefs && argc < 2)
+		die("--delete doesn't make sense without any refs");
+
 	if (tags)
 		add_refspec("refs/tags/*");
=20
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 516127b..0f04b2e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -547,6 +547,32 @@ test_expect_success 'allow deleting an invalid rem=
ote ref' '
=20
 '
=20
+test_expect_success 'allow deleting a ref using --delete' '
+	mk_test heads/master &&
+	(cd testrepo && git config receive.denyDeleteCurrent warn) &&
+	git push testrepo --delete master &&
+	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/mast=
er)
+'
+
+test_expect_success 'allow deleting a tag using --delete' '
+	mk_test heads/master &&
+	git tag -a -m dummy_message deltag heads/master &&
+	git push testrepo --tags &&
+	(cd testrepo && git rev-parse --verify -q refs/tags/deltag) &&
+	git push testrepo --delete tag deltag &&
+	(cd testrepo && test_must_fail git rev-parse --verify refs/tags/delta=
g)
+'
+
+test_expect_success 'push --delete without args aborts' '
+	mk_test heads/master &&
+	test_must_fail git push testrepo --delete
+'
+
+test_expect_success 'push --delete refuses src:dest refspecs' '
+	mk_test heads/master &&
+	test_must_fail git push testrepo --delete master:foo
+'
+
 test_expect_success 'warn on push to HEAD of non-bare repository' '
 	mk_test heads/master
 	(cd testrepo &&
--=20
1.6.6.60.gc2ff1
