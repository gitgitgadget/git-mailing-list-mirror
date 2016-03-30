From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2] clone: respect configured fetch respecs during initial fetch
Date: Wed, 30 Mar 2016 16:53:43 +0200
Message-ID: <1459349623-16443-1-git-send-email-szeder@ira.uka.de>
References: <20160307153304.GA23010@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 16:55:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alHWX-0006lr-31
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 16:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbcC3OzA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2016 10:55:00 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:37499 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754034AbcC3OzA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2016 10:55:00 -0400
Received: from x4db1c097.dyn.telefonica.de ([77.177.192.151] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1alHWB-0001Tp-B7; Wed, 30 Mar 2016 16:54:48 +0200
X-Mailer: git-send-email 2.8.0.46.gb821760
In-Reply-To: <20160307153304.GA23010@sigill.intra.peff.net>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1459349689.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290307>

Conceptually 'git clone' should behave as if the following commands
were run:

  git init
  git config ... # set default configuration and origin remote
  git fetch
  git checkout   # unless '--bare' is given

However, that initial 'git fetch' behaves differently from any
subsequent fetches, because it takes only the default fetch refspec
into account and ignores all other fetch refspecs that might have
been explicitly specified on the command line (e.g. 'git -c
remote.origin.fetch=3D<refspec> clone' or 'git clone -c ...').

Check whether there are any fetch refspecs configured for the origin
remote and take all of them into account during the initial fetch as
well.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
Changes since previous (RFC) version:
 - new commit message
 - additional configured fetch refspecs are taken into account with
   '--single-branch' as well

 builtin/clone.c         | 36 ++++++++++++++++++++++++++++--------
 t/t5708-clone-config.sh | 24 ++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 661639255c56..5e2d2c21e456 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -515,7 +515,7 @@ static struct ref *find_remote_branch(const struct =
ref *refs, const char *branch
 }
=20
 static struct ref *wanted_peer_refs(const struct ref *refs,
-		struct refspec *refspec)
+		struct refspec *refspec, unsigned int refspec_count)
 {
 	struct ref *head =3D copy_ref(find_ref_by_name(refs, "HEAD"));
 	struct ref *local_refs =3D head;
@@ -536,13 +536,18 @@ static struct ref *wanted_peer_refs(const struct =
ref *refs,
 			warning(_("Could not find remote branch %s to clone."),
 				option_branch);
 		else {
-			get_fetch_map(remote_head, refspec, &tail, 0);
+			unsigned int i;
+			for (i =3D 0; i < refspec_count; i++)
+				get_fetch_map(remote_head, &refspec[i], &tail, 0);
=20
 			/* if --branch=3Dtag, pull the requested tag explicitly */
 			get_fetch_map(remote_head, tag_refspec, &tail, 0);
 		}
-	} else
-		get_fetch_map(refs, refspec, &tail, 0);
+	} else {
+		unsigned int i;
+		for (i =3D 0; i < refspec_count; i++)
+			get_fetch_map(refs, &refspec[i], &tail, 0);
+	}
=20
 	if (!option_mirror && !option_single_branch)
 		get_fetch_map(refs, tag_refspec, &tail, 0);
@@ -840,7 +845,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	int err =3D 0, complete_refs_before_fetch =3D 1;
=20
 	struct refspec *refspec;
-	const char *fetch_pattern;
+	unsigned int refspec_count =3D 1;
+	const char **fetch_patterns;
+	const struct string_list *config_fetch_patterns;
=20
 	packet_trace_identity("clone");
 	argc =3D parse_options(argc, argv, prefix, builtin_clone_options,
@@ -967,9 +974,21 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	if (option_reference.nr)
 		setup_reference();
=20
-	fetch_pattern =3D value.buf;
-	refspec =3D parse_fetch_refspec(1, &fetch_pattern);
+	strbuf_addf(&key, "remote.%s.fetch", option_origin);
+	config_fetch_patterns =3D git_config_get_value_multi(key.buf);
+	if (config_fetch_patterns)
+		refspec_count =3D 1 + config_fetch_patterns->nr;
+	fetch_patterns =3D xcalloc(refspec_count, sizeof(*fetch_patterns));
+	fetch_patterns[0] =3D value.buf;
+	if (config_fetch_patterns) {
+		struct string_list_item *fp;
+		unsigned int i =3D 1;
+		for_each_string_list_item(fp, config_fetch_patterns)
+			fetch_patterns[i++] =3D fp->string;
+	}
+	refspec =3D parse_fetch_refspec(refspec_count, fetch_patterns);
=20
+	strbuf_reset(&key);
 	strbuf_reset(&value);
=20
 	remote =3D remote_get(option_origin);
@@ -1013,7 +1032,7 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 	refs =3D transport_get_remote_refs(transport);
=20
 	if (refs) {
-		mapped_refs =3D wanted_peer_refs(refs, refspec);
+		mapped_refs =3D wanted_peer_refs(refs, refspec, refspec_count);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
@@ -1094,6 +1113,7 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 	strbuf_release(&value);
 	junk_mode =3D JUNK_LEAVE_ALL;
=20
+	free(fetch_patterns);
 	free(refspec);
 	return err;
 }
diff --git a/t/t5708-clone-config.sh b/t/t5708-clone-config.sh
index 27d730c0a720..136a8611c7f3 100755
--- a/t/t5708-clone-config.sh
+++ b/t/t5708-clone-config.sh
@@ -37,4 +37,28 @@ test_expect_success 'clone -c config is available du=
ring clone' '
 	test_cmp expect child/file
 '
=20
+test_expect_success 'clone -c remote.origin.fetch=3D<refspec> works' '
+	rm -rf child &&
+	git update-ref refs/grab/it refs/heads/master &&
+	git update-ref refs/keep/out refs/heads/master &&
+	git clone -c "remote.origin.fetch=3D+refs/grab/*:refs/grab/*" . child=
 &&
+	(
+		cd child &&
+		git for-each-ref --format=3D"%(refname)" refs/grab/ >../actual
+	) &&
+	echo refs/grab/it >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git -c remote.origin.fetch=3D<refspec> clone work=
s' '
+	rm -rf child &&
+	git -c "remote.origin.fetch=3D+refs/grab/*:refs/grab/*" clone . child=
 &&
+	(
+		cd child &&
+		git for-each-ref --format=3D"%(refname)" refs/grab/ >../actual
+	) &&
+	echo refs/grab/it >expect &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.8.0.46.gb821760
