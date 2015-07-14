From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v5 00/44] Make git-am a builtin
Date: Tue, 14 Jul 2015 18:08:03 +0800
Message-ID: <20150714100803.GA23901@yoshi.chippynet.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
 <xmqqh9p7y9iu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 12:08:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEx8M-0007vl-Uc
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 12:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbbGNKIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 06:08:13 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34918 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092AbbGNKIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 06:08:09 -0400
Received: by pdrg1 with SMTP id g1so3525511pdr.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Vk1STmCokjI/w7lZ11HKvK9e+sDVCO7lZH53ZGsv/LA=;
        b=M2X9G+TKLJVW/oZZCBh+iG7ellG24lXiiPKr7gp/TSd4kDB/JC/zNjpNFmZ5AEQp44
         cAQVQ77iVQi3VsHFdUcdrcVex50Awsjp6EOOmBK/pWzUDx9WuFxTrgf5QTUCg6PIh0wP
         I71FtG8q6jHSCm8jX+SclGY5RKLasaABsZNIO2xerAZDJqvqNFyCe7uGGhklgZBXWu4+
         e+8BaEUpl46G+ruilYVE+ox+h4cLKM3NHBTPipfiHjbfZ8la6JSE1+wXeJaaBRNh+pjk
         AKnuU+hh7Afg8z614CJSEpg7qr9IJ/H4qCs78uNnXRDuzRJPhiIppQe7MDa3TVW7SX2M
         kPvw==
X-Received: by 10.66.161.135 with SMTP id xs7mr80016430pab.154.1436868489430;
        Tue, 14 Jul 2015 03:08:09 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm819093pad.11.2015.07.14.03.08.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 03:08:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqh9p7y9iu.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273946>

On Mon, Jul 13, 2015 at 03:31:37PM -0700, Junio C Hamano wrote:
> A fix is to edit the patch to replace that "flags);" line with full
> "return delete_ref()" line and save it.  Then running
> 
>   $ git am
> 
> (no argument) is supposed to read from the corrected patch file and
> continue the application.
> 
> This no longer works with the version with this series, it seems.

Ah, this is actually the same bug as the previous one, and it actually
all stems from the fact that I completely overlooked the code path
change introduced by 271440e (git-am: make it easier after fixing up an
unapplicable patch., 2005-10-25). When "git am" is run again while
paused, the mail message should not be re-parsed at all.

So, I'm thinking of something like the following as a separate patch in
this series to re-implement the feature:

diff a/builtin/am.c b/builtin/am.c
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1714,6 +1692,21 @@ static void do_commit(const struct am_state *state)
 }
 
 /**
+ * Validates the am_state for resuming -- the "msg" and authorship fields must
+ * be filled up.
+ */
+static void validate_resume_state(const struct am_state *state)
+{
+	if (!state->msg)
+		die(_("cannot resume: %s does not exist."),
+			am_path(state, "final-commit"));
+
+	if (!state->author_name || !state->author_email || !state->author_date)
+		die(_("cannot resume: %s does not exist."),
+			am_path(state, "author-script"));
+}
+
+/**
  * Interactively prompt the user on whether the current patch should be
  * applied.
  *
@@ -1774,8 +1767,12 @@ static int do_interactive(struct am_state *state)
 
 /**
  * Applies all queued mail.
+ *
+ * If `resume` is true, we are "resuming". The "msg" and authorship fields, as
+ * well as the state directory's "patch" file is used as-is for applying the
+ * patch and committing it.
  */
-static void am_run(struct am_state *state)
+static void am_run(struct am_state *state, int resume)
 {
 	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
 	struct strbuf sb = STRBUF_INIT;
@@ -1793,21 +1790,28 @@ static void am_run(struct am_state *state)
 
 	while (state->cur <= state->last) {
 		const char *mail = am_path(state, msgnum(state));
-		int apply_status, skip;
+		int apply_status;
 
 		if (!file_exists(mail))
 			goto next;
 
-		if (state->rebasing)
-			skip = parse_mail_rebase(state, mail);
-		else
-			skip = parse_mail(state, mail);
+		if (resume) {
+			validate_resume_state(state);
+			resume = 0;
+		} else {
+			int skip;
+
+			if (state->rebasing)
+				skip = parse_mail_rebase(state, mail);
+			else
+				skip = parse_mail(state, mail);
 
-		if (skip)
-			goto next; /* mail should be skipped */
+			if (skip)
+				goto next; /* mail should be skipped */
 
-		write_author_script(state);
-		write_commit_msg(state);
+			write_author_script(state);
+			write_commit_msg(state);
+		}
 
 		if (state->interactive && do_interactive(state))
 			goto next;
@@ -1880,13 +1884,7 @@ next:
  */
 static void am_resolve(struct am_state *state)
 {
-	if (!state->msg)
-		die(_("cannot resume: %s does not exist."),
-			am_path(state, "final-commit"));
-
-	if (!state->author_name || !state->author_email || !state->author_date)
-		die(_("cannot resume: %s does not exist."),
-			am_path(state, "author-script"));
+	validate_resume_state(state);
 
 	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
@@ -1915,7 +1913,7 @@ static void am_resolve(struct am_state *state)
 
 next:
 	am_next(state);
-	am_run(state);
+	am_run(state, 0);
 }
 
 /**
@@ -2040,7 +2038,7 @@ static void am_skip(struct am_state *state)
 		die(_("failed to clean index"));
 
 	am_next(state);
-	am_run(state);
+	am_run(state, 0);
 }
 
 /**
@@ -2136,6 +2134,7 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 
 enum resume_mode {
 	RESUME_FALSE = 0,
+	RESUME_APPLY,
 	RESUME_RESOLVED,
 	RESUME_SKIP,
 	RESUME_ABORT
@@ -2271,6 +2270,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			die(_("previous rebase directory %s still exists but mbox given."),
 				state.dir);
 
+		if (resume == RESUME_FALSE)
+			resume = RESUME_APPLY;
+
 		am_load(&state);
 	} else {
 		struct argv_array paths = ARGV_ARRAY_INIT;
@@ -2310,7 +2312,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	switch (resume) {
 	case RESUME_FALSE:
-		am_run(&state);
+		am_run(&state, 0);
+		break;
+	case RESUME_APPLY:
+		am_run(&state, 1);
 		break;
 	case RESUME_RESOLVED:
 		am_resolve(&state);

At this point I've accumulated a lot of changes on my end so I'll do a
re-roll.

Thanks,
Paul
