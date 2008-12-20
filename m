From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] fast-export: deal with tag objects that do not have a
 tagger
Date: Sat, 20 Dec 2008 01:00:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812200059480.30769@pacific.mpi-cbg.de>
References: <20081218164614.GS5691@genesis.frugalware.org> <7vbpv9guqd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0812182044100.6952@intel-tinevez-2-302> <20081218213407.GX5691@genesis.frugalware.org> <7viqphf4ua.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	scott@canonical.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 00:54:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDpAP-0004Pg-Vf
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 00:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbYLSXw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 18:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYLSXw2
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 18:52:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:52817 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750961AbYLSXw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 18:52:27 -0500
Received: (qmail invoked by alias); 19 Dec 2008 23:52:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 20 Dec 2008 00:52:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181MaF0rJU1MZ9YcKrOhpzyMYjTNyOPMe+d6c/VDa
	BxeT6zJmtfZxJI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7viqphf4ua.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103606>


When no tagger was found (old Git produced tags like this),
no "tagger" line is printed (but this is incompatible with the current
git fast-import).

Alternatively, you can pass the option --fake-missing-tagger, forcing
fast-export to fake a tagger

	Unspecified Tagger <no-tagger>

with a tag date of the beginning of (Unix) time in the case of a missing
tagger, so that fast-import is still able to import the result.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-fast-export.txt |    6 ++++++
 builtin-fast-export.c             |   21 ++++++++++++++++-----
 t/t9301-fast-export.sh            |   20 ++++++++++++++++++++
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 99a1c31..0c9eb56 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -65,6 +65,12 @@ If the backend uses a similar \--import-marks file, this allows for
 incremental bidirectional exporting of the repository by keeping the
 marks the same across runs.
 
+--fake-missing-tagger::
+	Some old repositories have tags without a tagger.  The
+	fast-import protocol was pretty strict about that, and did not
+	allow that.  So fake a tagger to be able to fast-import the
+	output.
+
 
 EXAMPLES
 --------
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 7d5d57a..8386338 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -24,6 +24,7 @@ static const char *fast_export_usage[] = {
 
 static int progress;
 static enum { VERBATIM, WARN, STRIP, ABORT } signed_tag_mode = ABORT;
+static int fake_missing_tagger;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -297,10 +298,17 @@ static void handle_tag(const char *name, struct tag *tag)
 		message_size = strlen(message);
 	}
 	tagger = memmem(buf, message ? message - buf : size, "\ntagger ", 8);
-	if (!tagger)
-		die ("No tagger for tag %s", sha1_to_hex(tag->object.sha1));
-	tagger++;
-	tagger_end = strchrnul(tagger, '\n');
+	if (!tagger) {
+		if (fake_missing_tagger)
+			tagger = "tagger Unspecified Tagger "
+				"<unspecified-tagger> 0 +0000";
+		else
+			tagger = "";
+		tagger_end = tagger + strlen(tagger);
+	} else {
+		tagger++;
+		tagger_end = strchrnul(tagger, '\n');
+	}
 
 	/* handle signed tags */
 	if (message) {
@@ -326,9 +334,10 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	if (!prefixcmp(name, "refs/tags/"))
 		name += 10;
-	printf("tag %s\nfrom :%d\n%.*s\ndata %d\n%.*s\n",
+	printf("tag %s\nfrom :%d\n%.*s%sdata %d\n%.*s\n",
 	       name, get_object_mark(tag->tagged),
 	       (int)(tagger_end - tagger), tagger,
+	       tagger == tagger_end ? "" : "\n",
 	       (int)message_size, (int)message_size, message ? message : "");
 }
 
@@ -483,6 +492,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			     "Dump marks to this file"),
 		OPT_STRING(0, "import-marks", &import_filename, "FILE",
 			     "Import marks from this file"),
+		OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
+			     "Fake a tagger when tags lack one"),
 		OPT_END()
 	};
 
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 2057435..9985721 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -239,4 +239,24 @@ test_expect_success 'fast-export | fast-import when master is tagged' '
 
 '
 
+cat > tag-content << EOF
+object $(git rev-parse HEAD)
+type commit
+tag rosten
+EOF
+
+test_expect_success 'cope with tagger-less tags' '
+
+	TAG=$(git hash-object -t tag -w tag-content) &&
+	git update-ref refs/tags/sonnenschein $TAG &&
+	git fast-export -C -C --signed-tags=strip --all > output &&
+	test $(grep -c "^tag " output) = 4 &&
+	! grep "Unspecified Tagger" output &&
+	git fast-export -C -C --signed-tags=strip --all \
+		--fake-missing-tagger > output &&
+	test $(grep -c "^tag " output) = 4 &&
+	grep "Unspecified Tagger" output
+
+'
+
 test_done
-- 
1.6.1.rc3.412.ga72b
