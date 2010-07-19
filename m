From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk: add "grep diff" selection criterion (Re: find commit
 adding/removing could use changing option)
Date: Mon, 19 Jul 2010 15:44:14 -0700
Message-ID: <7viq4bnlc1.fsf@alter.siamese.dyndns.org>
References: <D163BB49BCC4479AB3E4BA4F87826184@csmith>
 <20100716172806.GA15491@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Smith <smiles@worksmail.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 00:44:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oaz4f-00076p-1D
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 00:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760861Ab0GSWoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 18:44:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760858Ab0GSWo3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jul 2010 18:44:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C14B2C58D2;
	Mon, 19 Jul 2010 18:44:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=N+OY/6daZIZn
	5wj5zQKzesLlc5c=; b=xGVzr4rVtnWgbqu9gWSdR5f7far79CVPTvdutF0n8fWQ
	qaInNeez1z0eCGI8f1iw23g/6AEIsY0xOgXsvXXJiyiLpfS+mZWEaGrgGbXrAaPz
	38kw8gxjTakH6lcBMhsmQvVw641ofkJwNZ7EvF5omhdz0lloCsH52jmjFEY+lk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=A8tLt6
	gQzBk5sCmsyVGc+brPT5Y25gLt7BtOgfBm6usR950eWUyWLnd3J2kEqfs9HoKc6f
	VMOa5RIXaJfckGga549x3qcNL7ekR5v8LWcattR7nXpAa04cZyLErl//d9SiYtER
	syetTmUe55V/HpZNBNKA0G/j4FStEN/kZDVuo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79BA2C58CD;
	Mon, 19 Jul 2010 18:44:25 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F169C58CA; Mon, 19 Jul
 2010 18:44:20 -0400 (EDT)
In-Reply-To: <20100716172806.GA15491@burratino> (Jonathan Nieder's message of
 "Fri\, 16 Jul 2010 12\:28\:06 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2E831786-9387-11DF-A587-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151288>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ah, so you want a cousin to =E2=80=98log -S=E2=80=99 that /does/ sear=
ch through
> diffs.  See [1].
> ...
> If that proves useful, afterwards one could teach =E2=80=98diff-tree=E2=
=80=99 to do
> the check itself...
> [1] http://thread.gmane.org/gmane.comp.version-control.git/122478

A better quote might have been:

    http://thread.gmane.org/gmane.comp.version-control.git/112077/focus=
=3D112114

And the attached should be a good starting point if anybody is interest=
ed.
I didn't bother to check for leaks and premature free()s, add tests nor
document it, though.

Not yet anyway.

-- >8 --
Subject: [PATCH] git log: add -G<regexp> that greps in the patch text

Teach "-G<regexp>" that is similar to "-S<regexp> --pickaxe-regexp" to =
the
"git diff" family of commands.  This limits the diff queue to filepairs
whose patch text actually has an added or deleted line that matches the
given regexp.  Unlike "-S<regexp>" changing other parts of the line tha=
t
has a substring that matches the given regexp IS counted as a change, a=
s
such a change would appear as one deletion followed by one addition in =
a
patch text.

Unlike -S (pickaxe) that is intended to be used to quickly detect a com=
mit
that changes the number of occurrences of hits between the preimage and
the postimage to serve as a part of larger toolchain, this new feature =
is
meant to be used as the top-level Porcelain feature.

This implementation unfortunately has to run "diff" twice if you are
running "log" family of commands to produce patches in the final output
(e.g. "git log -p" or "git format-patch").  I think we _could_ cache th=
e
result in-core if we wanted to, but that would require larger surgery t=
o
the diffcore machinery (i.e. adding an extra pointer in the filepair
structure to keep a pointer to a strbuf around, stuff the textual diff =
to
the strbuf inside diffgrep_consume(), and make use of it in later stage=
s
when it is available) and it may not be worth it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile            |    1 +
 diff.c              |    6 ++-
 diff.h              |    1 +
 diffcore-log-grep.c |  145 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 diffcore.h          |    1 +
 5 files changed, 153 insertions(+), 1 deletions(-)
 create mode 100644 diffcore-log-grep.c

diff --git a/Makefile b/Makefile
index bc3c570..4213f40 100644
--- a/Makefile
+++ b/Makefile
@@ -562,6 +562,7 @@ LIB_OBJS +=3D date.o
 LIB_OBJS +=3D decorate.o
 LIB_OBJS +=3D diffcore-break.o
 LIB_OBJS +=3D diffcore-delta.o
+LIB_OBJS +=3D diffcore-log-grep.o
 LIB_OBJS +=3D diffcore-order.o
 LIB_OBJS +=3D diffcore-pickaxe.o
 LIB_OBJS +=3D diffcore-rename.o
diff --git a/diff.c b/diff.c
index 17873f3..f4bf1fd 100644
--- a/diff.c
+++ b/diff.c
@@ -2904,7 +2904,7 @@ int diff_setup_done(struct diff_options *options)
 	/*
 	 * Also pickaxe would not work very well if you do not say recursive
 	 */
-	if (options->pickaxe)
+	if (options->pickaxe || options->log_grep)
 		DIFF_OPT_SET(options, RECURSIVE);
 	/*
 	 * When patches are generated, submodules diffed against the work tre=
e
@@ -3184,6 +3184,8 @@ int diff_opt_parse(struct diff_options *options, =
const char **av, int ac)
 		options->rename_limit =3D strtoul(arg+2, NULL, 10);
 	else if (!prefixcmp(arg, "-S"))
 		options->pickaxe =3D arg + 2;
+	else if (!prefixcmp(arg, "-G"))
+		options->log_grep =3D arg + 2;
 	else if (!strcmp(arg, "--pickaxe-all"))
 		options->pickaxe_opts =3D DIFF_PICKAXE_ALL;
 	else if (!strcmp(arg, "--pickaxe-regex"))
@@ -4075,6 +4077,8 @@ void diffcore_std(struct diff_options *options)
 		diffcore_merge_broken();
 	if (options->pickaxe)
 		diffcore_pickaxe(options->pickaxe, options->pickaxe_opts);
+	if (options->log_grep)
+		diffcore_log_grep(options->log_grep, options->pickaxe_opts);
 	if (options->orderfile)
 		diffcore_order(options->orderfile);
 	diff_resolve_rename_copy();
diff --git a/diff.h b/diff.h
index 063d10a..ebd128b 100644
--- a/diff.h
+++ b/diff.h
@@ -96,6 +96,7 @@ struct diff_options {
 	const char *filter;
 	const char *orderfile;
 	const char *pickaxe;
+	const char *log_grep;
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	unsigned flags;
diff --git a/diffcore-log-grep.c b/diffcore-log-grep.c
new file mode 100644
index 0000000..501ae46
--- /dev/null
+++ b/diffcore-log-grep.c
@@ -0,0 +1,145 @@
+/*
+ * Copyright (C) 2010 Junio C Hamano
+ */
+#include "cache.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "xdiff-interface.h"
+
+struct diffgrep_cb {
+	regex_t *regexp;
+	int hit;
+};
+
+static void diffgrep_consume(void *priv, char *line, unsigned long len=
)
+{
+	struct diffgrep_cb *data =3D priv;
+	regmatch_t regmatch;
+	int hold;
+
+	if (line[0] !=3D '+' && line[0] !=3D '-')
+		return;
+	if (data->hit)
+		/*
+		 * NEEDSWORK: we should have a way to terminate the
+		 * caller early.
+		 */
+		return;
+	/* Yuck -- line ought to be "const char *"! */
+	hold =3D line[len];
+	line[len] =3D '\0';
+	data->hit =3D !regexec(data->regexp, line + 1, 1, &regmatch, 0);
+	line[len] =3D hold;
+}
+
+static void fill_one(struct diff_filespec *one,
+		     mmfile_t *mf, struct userdiff_driver **textconv)
+{
+	if (DIFF_FILE_VALID(one)) {
+		*textconv =3D get_textconv(one);
+		mf->size =3D fill_textconv(*textconv, one, &mf->ptr);
+	} else {
+		memset(mf, 0, sizeof(*mf));
+	}
+}
+
+static int diff_grep(struct diff_filepair *p, regex_t *regexp)
+{
+	regmatch_t regmatch;
+	struct userdiff_driver *textconv_one =3D NULL;
+	struct userdiff_driver *textconv_two =3D NULL;
+	mmfile_t mf1, mf2;
+	int hit;
+
+	if (diff_unmodified_pair(p))
+		return 0;
+
+	fill_one(p->one, &mf1, &textconv_one);
+	fill_one(p->two, &mf2, &textconv_two);
+
+	if (!mf1.ptr) {
+		if (!mf2.ptr)
+			return 0; /* ignore unmerged */
+		/* created "two" -- does it have what we are looking for? */
+		hit =3D !regexec(regexp, p->two->data, 1, &regmatch, 0);
+	} else if (!mf2.ptr) {
+		/* removed "one" -- did it have what we are looking for? */
+		hit =3D !regexec(regexp, p->one->data, 1, &regmatch, 0);
+	} else {
+		/*
+		 * We have both sides; need to run textual diff and see if a
+		 * line that match the pattern appears in +/- line.
+		 */
+		struct diffgrep_cb ecbdata;
+		xpparam_t xpp;
+		xdemitconf_t xecfg;
+
+		memset(&xpp, 0, sizeof(xpp));
+		memset(&xecfg, 0, sizeof(xecfg));
+		ecbdata.regexp =3D regexp;
+		ecbdata.hit =3D 0;
+		xdi_diff_outf(&mf1, &mf2, diffgrep_consume, &ecbdata,
+			      &xpp, &xecfg);
+		hit =3D ecbdata.hit;
+	}
+	if (textconv_one)
+		free(mf1.ptr);
+	if (textconv_two)
+		free(mf2.ptr);
+	return hit;
+}
+
+void diffcore_log_grep(const char *needle, int opts)
+{
+	struct diff_queue_struct *q =3D &diff_queued_diff;
+	int i, has_changes, err;
+	regex_t regex, *regexp =3D NULL;
+	struct diff_queue_struct outq;
+	outq.queue =3D NULL;
+	outq.nr =3D outq.alloc =3D 0;
+
+	err =3D regcomp(&regex, needle, REG_EXTENDED | REG_NEWLINE);
+	if (err) {
+		char errbuf[1024];
+		regerror(err, &regex, errbuf, 1024);
+		regfree(&regex);
+		die("invalid log-grep regex: %s", errbuf);
+	}
+	regexp =3D &regex;
+
+	if (opts & DIFF_PICKAXE_ALL) {
+		/* Showing the whole changeset if needle exists */
+		for (i =3D has_changes =3D 0; !has_changes && i < q->nr; i++) {
+			struct diff_filepair *p =3D q->queue[i];
+			if (diff_grep(p, regexp))
+				has_changes++;
+		}
+		if (has_changes)
+			return; /* not munge the queue */
+
+		/* otherwise we will clear the whole queue
+		 * by copying the empty outq at the end of this
+		 * function, but first clear the current entries
+		 * in the queue.
+		 */
+		for (i =3D 0; i < q->nr; i++)
+			diff_free_filepair(q->queue[i]);
+	} else {
+		/* Showing only the filepairs that has the needle */
+		for (i =3D 0; i < q->nr; i++) {
+			struct diff_filepair *p =3D q->queue[i];
+			if (diff_grep(p, regexp))
+				diff_q(&outq, p);
+			else
+				diff_free_filepair(p);
+		}
+	}
+
+	if (opts & DIFF_PICKAXE_REGEX) {
+		regfree(&regex);
+	}
+
+	free(q->queue);
+	*q =3D outq;
+	return;
+}
diff --git a/diffcore.h b/diffcore.h
index 491bea0..e3f8f05 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -110,6 +110,7 @@ extern void diffcore_break(int);
 extern void diffcore_rename(struct diff_options *);
 extern void diffcore_merge_broken(void);
 extern void diffcore_pickaxe(const char *needle, int opts);
+extern void diffcore_log_grep(const char *needle, int opts);
 extern void diffcore_order(const char *orderfile);
=20
 #define DIFF_DEBUG 0
--=20
1.7.2.rc3.270.gb7c60
