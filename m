From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn rebase screwing up commit messages
Date: Sat, 28 Jul 2007 06:10:49 -0700
Message-ID: <7vodhwptba.fsf@assigned-by-dhcp.cox.net>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
	<7v8x90sp25.fsf@assigned-by-dhcp.cox.net>
	<20070728083536.540e471d.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Jul 28 15:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEm4S-0003ce-Dt
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 15:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbXG1NKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 09:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbXG1NKx
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 09:10:53 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61392 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbXG1NKv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 09:10:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728131051.QMKN1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 09:10:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id V1Ap1X00S1kojtg0000000; Sat, 28 Jul 2007 09:10:50 -0400
In-Reply-To: <20070728083536.540e471d.seanlkml@sympatico.ca>
	(seanlkml@sympatico.ca's message of "Sat, 28 Jul 2007 08:35:36 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54031>

Sean <seanlkml@sympatico.ca> writes:

>> Do you mean by "my commits in Git" a commit you created with git
>> in your git repository?
>
> Tested this here (rc3.24.g83b3d) and can confirm the reported problem.
> After making a commit in git and then running "git svn rebase" to
> receive updates from the svn repo, the rebased commit has a borked
> description (multi-lined commit message appears all on one line).

In short, your original commit log message is broken.

The recommended convention for commit messages is to start it
with a single line that describes what it does, followed by a
blank line (i.e. the first paragraph consists of a single line),
followed by a longer explanation of why the change brought by
the commit is a good thing.

Following this convention is recommended to make other peoples'
lives more pleasant, and git assumes you follow this convention
at several places.  For example, "git log --pretty=oneline",
"git reflog", and "git show-branch" are ways to get concise
listing of commits; git-shortlog gives the list of such commit
titles in its output, omitting the longer explanation.  Patches
prepared for e-mail exchange ("git format-patch", and
--pretty=email) use the title on the Subject: line of the
message.  

The behaviour of these tools are _not_ the primarly reasons why
you are better off following the commit message convention.  The
reason behind the behaviour of these tools is to help readers of
your commit messages.  The punch line comes at the beginning,
single line short-and-sweet, and when readers want to get the
birds-eye view, that is the only thing they see.

Try them on a commit that has several lines in its first
paragraph and you will see why this is a good convention.

Until recently, we chomped a multi-line first paragraph at the
first line, and used the resulting partial sentence as the
title.  This had an interesting effect on badly formatted commit
like this:

        tree 2a003266ee6fda9305833a4f6e6dc7194018805a
        parent fef221460121c8a1b9e242422d8b521fbd0f6dc0
        author Junio C Hamano <gitster@pobox.com> 1185621830 -0700
        committer Junio C Hamano <gitster@pobox.com> 1185621830 -0700

        A long and unsightly commit
        log message that has more than
        one lines in the first paragraph

        Such a first paragraph is flattened by --pretty=email

When this was formatted for e-mail, it resulted in something
like this:

        From: Junio C Hamano <gitster@pobox.com>
        Date: Sat, 28 Jul 2007 04:23:50 -0700
        Subject: [PATCH] A long and unsightly commit
        log message that has more than
        one lines in the first paragraph

        Such a first paragraph is flattened by --pretty=email

As rebase/am uses the same machinery as e-mailed patch
acceptance, the paragraph was chomped at the first line, while
normalizing it for other git commands' use, like this:

        tree 842c159f584fd4f970b6aceed21f479c1b62e333
        parent 57887443c24e5a2b4b04e7db69b44b53d8e87b44
        author Junio C Hamano <gitster@pobox.com> 1185621830 -0700
        committer Junio C Hamano <gitster@pobox.com> 1185626445 -0700

        A long and unsightly commit

        log message that has more than
        one lines in the first paragraph

        Such a first paragraph is flattened by --pretty=email

This would mean that "oneline" format will see only the initial
part of the sentence.  If your message is properly formatted,
it is not a problem.

Recent enough git instead uses RFC2822 line-folding like this,
to help noncomforming messages somewhat:

        From 4c04a94...
        From: Junio C Hamano <gitster@pobox.com>
        Date: Sat, 28 Jul 2007 04:23:50 -0700
        Subject: [PATCH] A long and unsightly commit
         log message that has more than
         one lines in the first paragraph

        Such a first paragraph is flattened by --pretty=email

But this has an interesting side effect itself.  Such a folded
line is logically treated as a single line, and rebase/am makes
a commit like this out of such a message:

        tree 842c159f584fd4f970b6aceed21f479c1b62e333
        parent 57887443c24e5a2b4b04e7db69b44b53d8e87b44
        author Junio C Hamano <gitster@pobox.com> 1185621830 -0700
        committer Junio C Hamano <gitster@pobox.com> 1185626469 -0700

        A long and unsightly commit log message that has more than one lines in the first paragraph

        Such a first paragraph is flattened by --pretty=email

which is still unsightly (but the original message is unfriendly
to oneline summary format to begin with).  At least, this is an
improvement in that the new formatting does not lose information
when viewed in "oneline" format.

Having said all that, so that the readers understand the
background, here is a not-so-heavily-tested patch, which might
help.  It passes all the test suite as before, but that tells
how existing git-svn tests do not test many things.

I am not considering this for inclusion right now, by the way.

-- >8 --
Rebase/am: preserve multi-line first paragraph better.

This is actually three patches folded into one; as such it
should not be applied as-is.  It needs to be split into:

 * Changes to refs.c::log_ref_write() to sanitize embedded
   newlines from the log message, instead of chomping it at the
   first newline;

 * Changes to symbolic-ref and update-ref, so that they do not
   refuse a reflog message that has embedded newlines.  They
   have no business in dictating what the reflog message should
   look like.

 * Changes to builtin-mailinfo.c to preserve LF in Subject:
   header, when it is folded using RFC2822 header folding.

With this, the first paragraph of a commit message that has
multiple lines is reproduced by "am" without being squashed into
a single line.

---

 builtin-mailinfo.c     |   29 +++++++++++++++++++++++------
 builtin-symbolic-ref.c |    2 --
 builtin-update-ref.c   |    2 --
 refs.c                 |   39 +++++++++++++++++++++++----------------
 4 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index b4f6e91..9d2064a 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -272,15 +272,15 @@ static char *cleanup_subject(char *subject)
 	}
 }
 
-static void cleanup_space(char *buf)
+static void cleanup_space(char *buf, int keep_LF)
 {
 	unsigned char c;
 	while ((c = *buf) != 0) {
 		buf++;
-		if (isspace(c)) {
+		if (isspace(c) && (!keep_LF || c != '\n')) {
 			buf[-1] = ' ';
 			c = *buf;
-			while (isspace(c)) {
+			while (isspace(c) && (!keep_LF || c != '\n')) {
 				int len = strlen(buf);
 				memmove(buf, buf+1, len);
 				c = *buf;
@@ -425,6 +425,7 @@ static int read_one_header_line(char *line, int sz, FILE *in)
 			if (addlen >= sz - len)
 				addlen = sz - len - 1;
 			memcpy(line + len, continuation, addlen);
+			line[len] = '\n';
 			len += addlen;
 		}
 	}
@@ -846,6 +847,22 @@ static void handle_body(void)
 	return;
 }
 
+static void output_header_lines(FILE *fout, const char *hdr, char *data)
+{
+	while (1) {
+		char *ep = strchr(data, '\n');
+		int len;
+		if (!ep)
+			len = strlen(data);
+		else
+			len = ep - data;
+		fprintf(fout, "%s: %.*s\n", hdr, len, data);
+		if (!ep)
+			break;
+		data = ep + 1;
+	}
+}
+
 static void handle_info(void)
 {
 	char *sub;
@@ -864,14 +881,14 @@ static void handle_info(void)
 
 		if (!memcmp(header[i], "Subject", 7)) {
 			sub = cleanup_subject(hdr);
-			cleanup_space(sub);
-			fprintf(fout, "Subject: %s\n", sub);
+			cleanup_space(sub, 1);
+			output_header_lines(fout, "Subject", sub);
 		} else if (!memcmp(header[i], "From", 4)) {
 			handle_from(hdr);
 			fprintf(fout, "Author: %s\n", name);
 			fprintf(fout, "Email: %s\n", email);
 		} else {
-			cleanup_space(hdr);
+			cleanup_space(hdr, 0);
 			fprintf(fout, "%s: %s\n", header[i], hdr);
 		}
 	}
diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index d41b406..9eb95e5 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -43,8 +43,6 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 			msg = argv[1];
 			if (!*msg)
 				die("Refusing to perform update with empty message");
-			if (strchr(msg, '\n'))
-				die("Refusing to perform update with \\n in message");
 		}
 		else if (!strcmp("--", arg)) {
 			argc--;
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index feac2ed..8339cf1 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -23,8 +23,6 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 			msg = argv[++i];
 			if (!*msg)
 				die("Refusing to perform update with empty message.");
-			if (strchr(msg, '\n'))
-				die("Refusing to perform update with \\n in message.");
 			continue;
 		}
 		if (!strcmp("-d", argv[i])) {
diff --git a/refs.c b/refs.c
index 2694e70..98e3202 100644
--- a/refs.c
+++ b/refs.c
@@ -1036,6 +1036,27 @@ void unlock_ref(struct ref_lock *lock)
 	free(lock);
 }
 
+static int copy_msg(char *buf, const char *msg)
+{
+	char *cp = buf;
+	char c;
+	int wasspace = 1;
+
+	*cp++ = '\t';
+	while ((c = *msg++)) {
+		if (wasspace && isspace(c))
+			continue;
+		wasspace = isspace(c);
+		if (wasspace)
+			c = ' ';
+		*cp++ = c;
+	}
+	while (buf < cp && isspace(cp[-1]))
+		cp--;
+	*cp++ = '\n';
+	return cp - buf;
+}
+
 static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg)
 {
@@ -1080,21 +1101,7 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 
 	adjust_shared_perm(log_file);
 
-	msglen = 0;
-	if (msg) {
-		/* clean up the message and make sure it is a single line */
-		for ( ; *msg; msg++)
-			if (!isspace(*msg))
-				break;
-		if (*msg) {
-			const char *ep = strchr(msg, '\n');
-			if (ep)
-				msglen = ep - msg;
-			else
-				msglen = strlen(msg);
-		}
-	}
-
+	msglen = msg ? strlen(msg) : 0;
 	committer = git_committer_info(-1);
 	maxlen = strlen(committer) + msglen + 100;
 	logrec = xmalloc(maxlen);
@@ -1103,7 +1110,7 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 		      sha1_to_hex(new_sha1),
 		      committer);
 	if (msglen)
-		len += sprintf(logrec + len - 1, "\t%.*s\n", msglen, msg) - 1;
+		len += copy_msg(logrec + len - 1, msg) - 1;
 	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
 	free(logrec);
 	if (close(logfd) != 0 || written != len)
