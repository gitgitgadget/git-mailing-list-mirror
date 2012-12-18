From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Tue, 18 Dec 2012 11:24:02 -0500
Message-ID: <20121218162402.GA20122@sigill.intra.peff.net>
References: <7v38zb3ux0.fsf@alter.siamese.dyndns.org>
 <877goht6eu.fsf@pctrast.inf.ethz.ch>
 <20121217114058.449cbc3c@chalon.bertin.fr>
 <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
 <m21ueo78f8.fsf@igel.home>
 <7vwqwgjs8f.fsf@alter.siamese.dyndns.org>
 <20121218120058.0c558ba5@chalon.bertin.fr>
 <50D05BAF.4000200@viscovery.net>
 <871uentthz.fsf@pctrast.inf.ethz.ch>
 <20121218144157.00ccd915@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:24:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkzxx-00019p-0c
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 17:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab2LRQYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 11:24:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57667 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755159Ab2LRQYF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 11:24:05 -0500
Received: (qmail 18783 invoked by uid 107); 18 Dec 2012 16:25:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Dec 2012 11:25:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2012 11:24:02 -0500
Content-Disposition: inline
In-Reply-To: <20121218144157.00ccd915@chalon.bertin.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211757>

On Tue, Dec 18, 2012 at 02:41:57PM +0100, Yann Dirson wrote:

> > I wouldn't even want a script -- we'd end up inventing a complicated
> > command-line editor for what can simply be done by judicious use of an
> > actual text editor.  How about something like the following?
> 
> Well, while it does the job, it is still hardly as straightforward as the
> old "vi .git/info/grafts", or as a single easily-remembered commandline.

I wouldn't discount coming up with something based around "git commit"
that might be easier to use for specific instances, but it does seem
like an obvious feature to "git replace" to encapsulate Thomas's edit
script, which is the most general form.

I am not really interested in pushing this forward myself, but I worked
up this toy that somebody might find interesting (you can "git replace
HEAD~20" to get dumped in an editor). It should probably handle trees,
and it would probably make sense to do per-object-type sanity checks
(e.g., call verify_tag on tags).

diff --git a/builtin/replace.c b/builtin/replace.c
index 398ccd5..90979b6 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -81,6 +81,57 @@ static int delete_replace_ref(const char *name, const char *ref,
 	return 0;
 }
 
+static void edit_buffer(struct strbuf *out, const char *buf, unsigned long len)
+{
+	char tmpfile[PATH_MAX];
+	int fd;
+
+	fd = git_mkstemp(tmpfile, sizeof(tmpfile), "replace.XXXXXX");
+	if (fd < 0)
+		die_errno("unable to create tempfile");
+	if (write_in_full(fd, buf, len) < 0)
+		die_errno("unable to write to tempfile");
+	if (launch_editor(tmpfile, out, NULL) < 0)
+		die_errno("unable to run editor");
+
+	close(fd);
+	unlink_or_warn(tmpfile);
+}
+
+static void edit_object(unsigned char old[20], unsigned char new[20])
+{
+	enum object_type type;
+	unsigned long size;
+	char *old_buf;
+	struct strbuf new_buf = STRBUF_INIT;
+
+	old_buf = read_sha1_file_extended(old, &type, &size, 0);
+	if (!old_buf)
+		die("unable to read object '%s'", sha1_to_hex(old));
+
+	switch (type) {
+	case OBJ_COMMIT:
+	case OBJ_TAG:
+	case OBJ_BLOB:
+		/* These are OK to edit literally. */
+		edit_buffer(&new_buf, old_buf, size);
+		break;
+	case OBJ_TREE:
+		/*
+		 * XXX we'd probably want to massage this into ls-tree format,
+		 * and then read the result back via mktree.
+		 */
+		die("editing tree objects is not yet supported");
+	default:
+		die("unknown object type for %s", sha1_to_hex(old));
+	}
+
+	if (write_sha1_file(new_buf.buf, new_buf.len, typename(type), new) < 0)
+		die("unable to write replacement object");
+	free(old_buf);
+	strbuf_release(&new_buf);
+}
+
 static int replace_object(const char *object_ref, const char *replace_ref,
 			  int force)
 {
@@ -90,7 +141,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 
 	if (get_sha1(object_ref, object))
 		die("Failed to resolve '%s' as a valid ref.", object_ref);
-	if (get_sha1(replace_ref, repl))
+	if (replace_ref && get_sha1(replace_ref, repl))
 		die("Failed to resolve '%s' as a valid ref.", replace_ref);
 
 	if (snprintf(ref, sizeof(ref),
@@ -105,6 +156,9 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
 
+	if (!replace_ref)
+		edit_object(object, repl);
+
 	lock = lock_any_ref_for_update(ref, prev, 0);
 	if (!lock)
 		die("%s: cannot lock the ref", ref);
@@ -144,7 +198,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 
 	/* Replace object */
 	if (!list && argc) {
-		if (argc != 2)
+		if (argc < 1 || argc > 2)
 			usage_msg_opt("bad number of arguments",
 				      git_replace_usage, options);
 		return replace_object(argv[0], argv[1], force);
