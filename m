From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git_mkstemp to return an error when path is too long.
Date: Wed, 25 Jul 2007 21:26:54 -0700
Message-ID: <7vabtjbxip.fsf@assigned-by-dhcp.cox.net>
References: <46A7F9C4.7030004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 06:27:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDuwY-0002U4-7r
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 06:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbXGZE1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 00:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbXGZE05
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 00:26:57 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33057 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbXGZE0z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 00:26:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726042655.OMB1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 26 Jul 2007 00:26:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U4St1X00g1kojtg0000000; Thu, 26 Jul 2007 00:26:54 -0400
In-Reply-To: <46A7F9C4.7030004@gmail.com> (Carlos Rica's message of "Thu, 26
	Jul 2007 03:32:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53761>

Carlos Rica <jasampler@gmail.com> writes:

> Now the function returns -2 to the caller if the given buffer
> is too short to save the entire path for the temporary file.
>
> Signed-off-by: Carlos Rica <jasampler@gmail.com>

Trying not to overstep the static buffer is of course a good
thing, and I think it is probably Ok to error out on a TMPDIR
environment variable that is insanely long, instead of using an
extra malloc/free, as underlying mkstemp() would error out if it
is given an insanely long template buffer anyway.

However, I think it is not so useful to return -2, even if that
is done so that you can differentiate the case where the TMPDIR
and/or the template were too long and the case mkstemp() errored
out.

Stop and think for a minute: what does the underlying mkstemp()
do, if the given template is too long?

That's right.  You would get ENAMETOOLONG.  So why don't we do
this instead?

---
 diff.c |    2 +-
 path.c |   25 ++++++++++---------------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index cd6b0c4..a5fc56b 100644
--- a/diff.c
+++ b/diff.c
@@ -1695,7 +1695,7 @@ static void prep_temp_blob(struct diff_tempfile *temp,
 
 	fd = git_mkstemp(temp->tmp_path, PATH_MAX, ".diff_XXXXXX");
 	if (fd < 0)
-		die("unable to create temp-file");
+		die("unable to create temp-file: %s", strerror(errno));
 	if (write_in_full(fd, blob, size) != size)
 		die("unable to write temp-file");
 	close(fd);
diff --git a/path.c b/path.c
index c4ce962..dc7ded9 100644
--- a/path.c
+++ b/path.c
@@ -71,25 +71,20 @@ char *git_path(const char *fmt, ...)
 /* git_mkstemp() - create tmp file honoring TMPDIR variable */
 int git_mkstemp(char *path, size_t len, const char *template)
 {
-	char *env, *pch = path;
-
-	if ((env = getenv("TMPDIR")) == NULL) {
-		strcpy(pch, "/tmp/");
-		len -= 5;
-		pch += 5;
-	} else {
-		size_t n = snprintf(pch, len, "%s/", env);
-
-		len -= n;
-		pch += n;
+	const char *tmp;
+	size_t n;
+
+	tmp = getenv("TMPDIR");
+	if (!tmp)
+		tmp = "/tmp";
+	n = snprintf(path, len, "%s/%s", tmp, template);
+	if (len <= n) {
+		errno = ENAMETOOLONG;
+		return -1;
 	}
-
-	strlcpy(pch, template, len);
-
 	return mkstemp(path);
 }
 
-
 int validate_headref(const char *path)
 {
 	struct stat st;
