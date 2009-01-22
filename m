From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/5] diff: refactor tempfile cleanup handling
Date: Thu, 22 Jan 2009 00:59:56 -0500
Message-ID: <20090122055956.GB30133@coredump.intra.peff.net>
References: <20090122042643.GB31427@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 07:01:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPsd3-0006E6-V0
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 07:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbZAVGAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 01:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbZAVF77
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 00:59:59 -0500
Received: from peff.net ([208.65.91.99]:38192 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112AbZAVF76 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 00:59:58 -0500
Received: (qmail 24419 invoked by uid 107); 22 Jan 2009 06:00:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 22 Jan 2009 01:00:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jan 2009 00:59:56 -0500
Content-Disposition: inline
In-Reply-To: <20090122042643.GB31427@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106725>

There are two pieces of code that create tempfiles for diff:
run_external_diff and run_textconv. The former cleans up its
tempfiles in the face of premature death (i.e., by die() or
by signal), but the latter does not. After this patch, they
will both use the same cleanup routines.

To make clear what the change is, let me first explain what
happens now:

  - run_external_diff uses a static global array of 2
    diff_tempfile structs (since it knows it will always
    need exactly 2 tempfiles). It calls prepare_temp_file
    (which doesn't know anything about the global array) on
    each of the structs, creating the tempfiles that need to
    be cleaned up. It then registers atexit and signal
    handlers to look through the global array and remove the
    tempfiles. If it succeeds, it calls the handler manually
    (which marks the tempfile structs as unused).

  - textconv has its own tempfile struct, which it allocates
    using prepare_temp_file and cleans up manually. No
    signal or atexit handlers.

The new code moves the installation of cleanup handlers into
the prepare_temp_file function. Which means that that
function now has to understand that there is static tempfile
storage. So what happens now is:

  - run_external_diff calls prepare_temp_file
  - prepare_temp_file calls claim_diff_tempfile, which
    allocates an unused slot from our global array
  - prepare_temp_file installs (if they have not already
    been installed) atexit and signal handlers for cleanup
  - prepare_temp_file sets up the tempfile as usual
  - prepare_temp_file returns a pointer to the allocated
    tempfile

The advantage being that run_external_diff no longer has to
care about setting up cleanup handlers. Now by virtue of
calling prepare_temp_file, run_textconv gets the same
benefit, as will any future users of prepare_temp_file.

There are also a few side benefits to the specific
implementation:

  - we now install cleanup handlers _before_ allocating the
    tempfile, closing a race which could leave temp cruft

  - when allocating a slot in the global array, we will now
    detect a situation where the old slots were not properly
    vacated (i.e., somebody forgot to call remove upon
    leaving the function). In the old code, such a situation
    would silently overwrite the tempfile names, meaning we
    would forget to clean them up. The new code dies with a
    bug warning.

  - we make sure only to install the signal handler once.
    This isn't a big deal, since we are just overwriting the
    old handler, but will become an issue when a later patch
    converts the code to use sigchain

Signed-off-by: Jeff King <peff@peff.net>
---
This patch is new since v1. I started with just looking at whether it
was safe to move the signal() call, but there were really several things
to be cleaned up, and it just made sense to do them all together.

 diff.c |  107 +++++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 55 insertions(+), 52 deletions(-)

diff --git a/diff.c b/diff.c
index 0731313..ae6d552 100644
--- a/diff.c
+++ b/diff.c
@@ -167,6 +167,33 @@ static struct diff_tempfile {
 	char tmp_path[PATH_MAX];
 } diff_temp[2];
 
+static struct diff_tempfile *claim_diff_tempfile(void) {
+	int i;
+	for (i = 0; i < ARRAY_SIZE(diff_temp); i++)
+		if (!diff_temp[i].name)
+			return diff_temp + i;
+	die("BUG: diff is failing to clean up its tempfiles");
+}
+
+static int remove_tempfile_installed;
+
+static void remove_tempfile(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(diff_temp); i++)
+		if (diff_temp[i].name == diff_temp[i].tmp_path) {
+			unlink(diff_temp[i].name);
+			diff_temp[i].name = NULL;
+		}
+}
+
+static void remove_tempfile_on_signal(int signo)
+{
+	remove_tempfile();
+	signal(SIGINT, SIG_DFL);
+	raise(signo);
+}
+
 static int count_lines(const char *data, int size)
 {
 	int count, ch, completely_empty = 1, nl_just_seen = 0;
@@ -1859,10 +1886,11 @@ static void prep_temp_blob(struct diff_tempfile *temp,
 	sprintf(temp->mode, "%06o", mode);
 }
 
-static void prepare_temp_file(const char *name,
-			      struct diff_tempfile *temp,
-			      struct diff_filespec *one)
+static struct diff_tempfile *prepare_temp_file(const char *name,
+		struct diff_filespec *one)
 {
+	struct diff_tempfile *temp = claim_diff_tempfile();
+
 	if (!DIFF_FILE_VALID(one)) {
 	not_a_valid_file:
 		/* A '-' entry produces this for file-2, and
@@ -1871,7 +1899,13 @@ static void prepare_temp_file(const char *name,
 		temp->name = "/dev/null";
 		strcpy(temp->hex, ".");
 		strcpy(temp->mode, ".");
-		return;
+		return temp;
+	}
+
+	if (!remove_tempfile_installed) {
+		atexit(remove_tempfile);
+		signal(SIGINT, remove_tempfile_on_signal);
+		remove_tempfile_installed = 1;
 	}
 
 	if (!one->sha1_valid ||
@@ -1911,7 +1945,7 @@ static void prepare_temp_file(const char *name,
 			 */
 			sprintf(temp->mode, "%06o", one->mode);
 		}
-		return;
+		return temp;
 	}
 	else {
 		if (diff_populate_filespec(one, 0))
@@ -1919,24 +1953,7 @@ static void prepare_temp_file(const char *name,
 		prep_temp_blob(temp, one->data, one->size,
 			       one->sha1, one->mode);
 	}
-}
-
-static void remove_tempfile(void)
-{
-	int i;
-
-	for (i = 0; i < 2; i++)
-		if (diff_temp[i].name == diff_temp[i].tmp_path) {
-			unlink(diff_temp[i].name);
-			diff_temp[i].name = NULL;
-		}
-}
-
-static void remove_tempfile_on_signal(int signo)
-{
-	remove_tempfile();
-	signal(SIGINT, SIG_DFL);
-	raise(signo);
+	return temp;
 }
 
 /* An external diff command takes:
@@ -1954,34 +1971,22 @@ static void run_external_diff(const char *pgm,
 			      int complete_rewrite)
 {
 	const char *spawn_arg[10];
-	struct diff_tempfile *temp = diff_temp;
 	int retval;
-	static int atexit_asked = 0;
-	const char *othername;
 	const char **arg = &spawn_arg[0];
 
-	othername = (other? other : name);
-	if (one && two) {
-		prepare_temp_file(name, &temp[0], one);
-		prepare_temp_file(othername, &temp[1], two);
-		if (! atexit_asked &&
-		    (temp[0].name == temp[0].tmp_path ||
-		     temp[1].name == temp[1].tmp_path)) {
-			atexit_asked = 1;
-			atexit(remove_tempfile);
-		}
-		signal(SIGINT, remove_tempfile_on_signal);
-	}
-
 	if (one && two) {
+		struct diff_tempfile *temp_one, *temp_two;
+		const char *othername = (other ? other : name);
+		temp_one = prepare_temp_file(name, one);
+		temp_two = prepare_temp_file(othername, two);
 		*arg++ = pgm;
 		*arg++ = name;
-		*arg++ = temp[0].name;
-		*arg++ = temp[0].hex;
-		*arg++ = temp[0].mode;
-		*arg++ = temp[1].name;
-		*arg++ = temp[1].hex;
-		*arg++ = temp[1].mode;
+		*arg++ = temp_one->name;
+		*arg++ = temp_one->hex;
+		*arg++ = temp_one->mode;
+		*arg++ = temp_two->name;
+		*arg++ = temp_two->hex;
+		*arg++ = temp_two->mode;
 		if (other) {
 			*arg++ = other;
 			*arg++ = xfrm_msg;
@@ -3450,15 +3455,15 @@ void diff_unmerge(struct diff_options *options,
 static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 		size_t *outsize)
 {
-	struct diff_tempfile temp;
+	struct diff_tempfile *temp;
 	const char *argv[3];
 	const char **arg = argv;
 	struct child_process child;
 	struct strbuf buf = STRBUF_INIT;
 
-	prepare_temp_file(spec->path, &temp, spec);
+	temp = prepare_temp_file(spec->path, spec);
 	*arg++ = pgm;
-	*arg++ = temp.name;
+	*arg++ = temp->name;
 	*arg = NULL;
 
 	memset(&child, 0, sizeof(child));
@@ -3467,13 +3472,11 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 	if (start_command(&child) != 0 ||
 	    strbuf_read(&buf, child.out, 0) < 0 ||
 	    finish_command(&child) != 0) {
-		if (temp.name == temp.tmp_path)
-			unlink(temp.name);
+		remove_tempfile();
 		error("error running textconv command '%s'", pgm);
 		return NULL;
 	}
-	if (temp.name == temp.tmp_path)
-		unlink(temp.name);
+	remove_tempfile();
 
 	return strbuf_detach(&buf, outsize);
 }
-- 
1.6.1.403.g6c435
