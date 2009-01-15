From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] checkout: implement "-" shortcut name for last branch
Date: Thu, 15 Jan 2009 12:11:31 -0800
Message-ID: <7vocy8s51o.fsf@gitster.siamese.dyndns.org>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
 <1231978322-21228-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 15 21:13:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNYas-0006ar-0n
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 21:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbZAOULl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 15:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932806AbZAOULj
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 15:11:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627AbZAOULi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 15:11:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C8C98906F2;
	Thu, 15 Jan 2009 15:11:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 69722906EF; Thu,
 15 Jan 2009 15:11:33 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B65F78B4-E340-11DD-8F3E-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105873>

Thomas Rast <trast@student.ethz.ch> writes:

> Let git-checkout save the old branch as a symref in LAST_HEAD, and
> make 'git checkout -' switch back to LAST_HEAD, like 'cd -' does in
> the shell.

I do not like this for two reasons.

I will not dispute that you would need to have "checkout" and other branch
switching operations to record where you were in order to be able to refer
to "where I was".  And as Dscho and others point out, there already is an
existing mechanism that does exactly that, so it _might_ be easier to work
with an extra LAST_HEAD, it is not absolutely necessary.

I do not see a reason to limit the new notation "where I was" only to "git
checkout".  Wouldn't it be handy if you can use the notation as the other
branch to merge from, or the commit to rebase on?

"cd -" is a very good analogy why your "-" shortcut is a short-sighted
convenience feature that is too narrow and not well designed.  "cd -" can
go back, but you cannot say "ls -" to list the contents of the previous
directory.

So if this topic were "Introduce LAST_HEAD to always keep track of the
branch I was on before the current branch", and were advertised as "You
can use this throughout git to say things like 'git checkout LAST_HEAD',
'git merge LAST_HEAD', and 'git rebase LAST_HEAD'", I think it might have
made a bit more sense.  You could _additionally_ say "because switching to
LAST_HEAD happens very often, there is another short cut 'checkout -' but
that is exactly the same as 'checkout LAST_HEAD'".

Another reason is the one level limitation.  If we do not use LAST_HEAD,
and instead used HEAD reflog, to get to this information, there is no
reason we cannot to give an equally easy access to the second from the
last branch the user was on.

So I think it is just the matter of coming up with a clever syntax that
works on reflogs to name the nth last branch we were on and teach that
syntax to both get_sha1() and resolve_ref().

With the attached illustration patch,

     $ git checkout junk
     $ git chekcout master
     $ git checkout @{-1}

will take you back to junk branch.  It probably would serve as a starting
point, if anybody is interested.

NOTE!

 * It will report "Switched to branch "junk", not "junk (@{-1})" or
   anything that hints the user used this new syntax.  switch_branches()
   may need to be given more information to distinguish the name the end
   user spelled to specify the branch (e.g. "@{-1}") and the actual name
   of the branch (e.g. "junk"), and use the former together with the
   latter when reporting to the end user and use the latter only to record
   what happened to the reflog.  But this is a very minor point.

 * The reflog parser only parses "checkout" and not rebase action.  It
   also does not notice "git checkout HEAD^" is not switching to a real
   branch.

 * The code read the reflog twice, first to count how many branch
   switching there are and then to locate the N-th entry we are interested
   in, because I was lazy.  We may want an API to enumerate reflog entries
   in reverse.

 * interpret_nth_last_branch() is not hooked to get_sha1() codepath in
   this patch, so this is still only applicable to "git checkout".  But it
   should be trivial to do so.

 builtin-checkout.c |   10 +++++-
 cache.h            |    1 +
 sha1_name.c        |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git c/builtin-checkout.c w/builtin-checkout.c
index b5dd9c0..a3b69d6 100644
--- c/builtin-checkout.c
+++ w/builtin-checkout.c
@@ -361,8 +361,14 @@ struct branch_info {
 static void setup_branch_path(struct branch_info *branch)
 {
 	struct strbuf buf = STRBUF_INIT;
-	strbuf_addstr(&buf, "refs/heads/");
-	strbuf_addstr(&buf, branch->name);
+
+	if (!interpret_nth_last_branch(branch->name, &buf)) {
+		branch->name = xstrdup(buf.buf);
+		strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
+	} else {
+		strbuf_addstr(&buf, "refs/heads/");
+		strbuf_addstr(&buf, branch->name);
+	}
 	branch->path = strbuf_detach(&buf, NULL);
 }
 
diff --git c/cache.h w/cache.h
index 8e1af26..0dd9168 100644
--- c/cache.h
+++ w/cache.h
@@ -663,6 +663,7 @@ extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
+extern int interpret_nth_last_branch(const char *str, struct strbuf *);
 
 extern int refname_match(const char *abbrev_name, const char *full_name, const char **rules);
 extern const char *ref_rev_parse_rules[];
diff --git c/sha1_name.c w/sha1_name.c
index 159c2ab..6377264 100644
--- c/sha1_name.c
+++ w/sha1_name.c
@@ -674,6 +674,84 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 	return retval;
 }
 
+struct grab_nth_branch_switch_cbdata {
+	int counting;
+	int nth;
+	struct strbuf *buf;
+};
+
+static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
+				  const char *email, unsigned long timestamp, int tz,
+				  const char *message, void *cb_data)
+{
+	struct grab_nth_branch_switch_cbdata *cb = cb_data;
+	const char *match = NULL;
+
+	if (!prefixcmp(message, "checkout: moving to "))
+		match = message + strlen("checkout: moving to ");
+	else if (!prefixcmp(message, "checkout: moving from ")) {
+		const char *cp = message + strlen("checkout: moving from ");
+		if ((cp = strstr(cp, " to ")) != NULL) {
+			match = cp + 4;
+		}
+	}
+
+	if (!match)
+		return 0;
+
+	if (cb->counting) {
+		cb->nth++;
+		return 0;
+	}
+
+	if (--cb->nth <= 0) {
+		size_t len = strlen(match);
+		while (match[len-1] == '\n')
+			len--;
+		strbuf_reset(cb->buf);
+		strbuf_add(cb->buf, match, len);
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * This reads "@{-N}" syntax, finds the name of the Nth previous
+ * branch we were on, and places the name of the branch in the given
+ * buf and returns 0 if successful.
+ *
+ * If the input is not of the accepted format, it returns a negative
+ * number to signal an error.
+ */
+int interpret_nth_last_branch(const char *name, struct strbuf *buf)
+{
+	int nth, i;
+	struct grab_nth_branch_switch_cbdata cb;
+
+	if (name[0] != '@' || name[1] != '{' || name[2] != '-')
+		return -1;
+	for (i = 3, nth = 0; name[i] && name[i] != '}'; i++) {
+		char ch = name[i];
+		if ('0' <= ch && ch <= '9')
+			nth = nth * 10 + ch - '0';
+		else
+			return -1;
+	}
+	if (nth < 0 || 10 <= nth)
+		return -1;
+
+	cb.counting = 1;
+	cb.nth = 0;
+	cb.buf = buf;
+	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
+
+	cb.counting = 0;
+	cb.nth -= nth;
+	cb.buf = buf;
+	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
+	return 0;
+}
+
 /*
  * This is like "get_sha1_basic()", except it allows "sha1 expressions",
  * notably "xyz^" for "parent of xyz"
