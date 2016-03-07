From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [RFC/PATCH] clone: make 'git clone -c remote.origin.fetch=<refspec>' work
Date: Mon,  7 Mar 2016 02:11:02 +0100
Message-ID: <1457313062-10073-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 02:11:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acjhm-0000oV-Ko
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 02:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbcCGBLW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Mar 2016 20:11:22 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:58120 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751221AbcCGBLV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Mar 2016 20:11:21 -0500
Received: from x4db1bd2a.dyn.telefonica.de ([77.177.189.42] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1acjhd-0003jP-Rv; Mon, 07 Mar 2016 02:11:19 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1457313079.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288375>

Configuration variables specified via 'git clone -c <key>=3D<value>'
"take effect immediately after the repository is initialized, but
before the remote history is fetched".  This implies that any fetch
refspecs specified this way should already be taken into account
during the initial fetch and remote refs matching these refspecs
should be retrieved as well.

This never worked, however, not even when the feature was introduced
in v1.7.7-rc0~90^2 (clone: accept config options on the command line,
2011-06-09).  While the given refspecs are written to the config file
alright, no matching refs are fetched, because the initial fetch
ignores them and respects only that single default refspec.

Check whether there are any relevant configured fetch refspecs and
take those into account during the initial fetch, unless running 'git
clone --single-branch'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

I'm unsure what to do with the '-c <fetch-refspec> --single-branch'
combination: it doesn't really make sense to me and can't imagaine a
use case where it would be useful...  but perhaps I just lack
imagination on this Sunday night.  Hence the RFC.

 builtin/clone.c         | 32 +++++++++++++++++++++++++-------
 t/t5708-clone-config.sh | 13 +++++++++++++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9ac6c0144279..5b96b373675a 100644
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
@@ -541,8 +541,11 @@ static struct ref *wanted_peer_refs(const struct r=
ef *refs,
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
@@ -840,7 +843,9 @@ int cmd_clone(int argc, const char **argv, const ch=
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
@@ -967,9 +972,21 @@ int cmd_clone(int argc, const char **argv, const c=
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
@@ -1013,7 +1030,7 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 	refs =3D transport_get_remote_refs(transport);
=20
 	if (refs) {
-		mapped_refs =3D wanted_peer_refs(refs, refspec);
+		mapped_refs =3D wanted_peer_refs(refs, refspec, refspec_count);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
@@ -1094,6 +1111,7 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 	strbuf_release(&value);
 	junk_mode =3D JUNK_LEAVE_ALL;
=20
+	free(fetch_patterns);
 	free(refspec);
 	return err;
 }
diff --git a/t/t5708-clone-config.sh b/t/t5708-clone-config.sh
index 27d730c0a720..377837e3539a 100755
--- a/t/t5708-clone-config.sh
+++ b/t/t5708-clone-config.sh
@@ -37,4 +37,17 @@ test_expect_success 'clone -c config is available du=
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
 test_done
--=20
2.7.2.410.g92cb358
