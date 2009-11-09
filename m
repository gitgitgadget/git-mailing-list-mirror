From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: [PATCH RFC v2] builtin-push: add --delete as syntactic sugar for 
 :foo
Date: Mon, 9 Nov 2009 19:20:44 +0100
Message-ID: <20091109192044.605e50ba@perceptron>
References: <20091109130935.2bea7771@perceptron>
	<7v8wefy6pi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 19:21:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7YrL-0004HM-OE
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 19:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbZKISUs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 13:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbZKISUs
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 13:20:48 -0500
Received: from zoidberg.org ([88.198.6.61]:55559 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbZKISUr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 13:20:47 -0500
Received: from perceptron (xdsl-78-35-153-14.netcologne.de [::ffff:78.35.153.14])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Mon, 09 Nov 2009 19:20:51 +0100
  id 004D0215.4AF85D83.000054F3
In-Reply-To: <7v8wefy6pi.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132502>

Refspecs without a source side have been reported as confusing by many.
As an alternative, this adds support for commands like:

    git push origin --delete somebranch

Specifically, --delete will prepend a colon to all colon-less refspecs
given on the command line, and will refuse to accept refspecs with
colons to prevent undue confusion.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
All good points, and I actually remembered to catch the colon-refspec
case a few minutes after sending the patch, but didn't have time to fix
it up. (Sorry for not considering the old thread; I had gotten
unsubscribed from the list back then).

I think with this change it becomes much saner. And no, I'm not
proposing to add --rename and --copy, too. ;)

The new error message is not completely technically correct since it's
still a refspec we're taking, we just force it to be without a colon.
On the other hand, this error message will hopefully make much more
sense to people who don't know all the background, and it's not too
horribly wrong either.

(Sverre added to Cc list from subthread)

 builtin-push.c        |   16 ++++++++++++++++
 t/t5516-fetch-push.sh |    6 ++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 8631c06..e40bfe8 100644
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
@@ -44,6 +45,15 @@ static void set_refspecs(const char **refs, int nr)
 			strcat(tag, refs[i]);
 			ref =3D tag;
 		}
+		if (deleterefs && !strchr(ref, ':')) {
+			char *delref;
+			int len =3D strlen(refs[i] + 1);
+			delref =3D xmalloc(len);
+			strcpy(delref, ":");
+			strcat(delref, refs[i]);
+			ref =3D delref;
+		} else if (deleterefs)
+			die("--delete only accepts plain target ref names");
 		add_refspec(ref);
 	}
 }
@@ -181,6 +191,7 @@ int cmd_push(int argc, const char **argv, const cha=
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
@@ -193,6 +204,11 @@ int cmd_push(int argc, const char **argv, const ch=
ar *prefix)
=20
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
index 6889a53..aa1450a 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -546,6 +546,12 @@ test_expect_success 'allow deleting an invalid rem=
ote ref' '
=20
 '
=20
+test_expect_success 'allow deleting a ref using --delete' '
+	mk_test heads/master &&
+	git push testrepo --delete master &&
+	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/mast=
er)
+'
+
 test_expect_success 'warn on push to HEAD of non-bare repository' '
 	mk_test heads/master
 	(cd testrepo &&
--=20
1.6.5.2.155.gbb47.dirty
