From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/2] format-patch: add format.cover-letter configuration
Date: Sat, 6 Apr 2013 23:46:51 -0600
Message-ID: <CAMP44s14Bd4U2w=wso6MAF3rQO_=m4o9R4Mr8z_b9w6BO5vcvg@mail.gmail.com>
References: <1365239012-15079-1-git-send-email-felipe.contreras@gmail.com>
	<1365239012-15079-3-git-send-email-felipe.contreras@gmail.com>
	<7vk3of817v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 07:47:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOiRY-0007fe-Lv
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 07:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513Ab3DGFqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 01:46:54 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:45788 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab3DGFqx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 01:46:53 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so4823176lbi.28
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 22:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=C49O6hWliJn78zknb3FZKZF+XSF3XgUxzEAjO7DYm0E=;
        b=c3ELrb3ZI7dHy8uexQObkKpz7zflC98wzwk0Vo6lBwNjw0gRnmEm/s+EOphMQh9sV6
         VZo4OM8sJN6kmW3ddDgfOVucL9eCjLe0gEc2FSgApjJmIiISReZBAMDz7a7idMLwOiOM
         ufsS+tfnxBMc4EaxH8d5DVv2eCfRlJDYs173x1SecuGaXrc+UtVUet3Qx7seqWucJH+9
         itJZxxGsB3UbquQwVcOaod45O+MDwBEFvFd01toapP9F07uoGG3PNW87HYk4WbPPDwvc
         S/qrbqBgVpT2rNNWjp4tq3MfQftqOQ+nVA4HI1xG9OjYA5SXqKpP6fXHtEZo1ajY7ovr
         7j0w==
X-Received: by 10.112.145.8 with SMTP id sq8mr9284834lbb.55.1365313611697;
 Sat, 06 Apr 2013 22:46:51 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sat, 6 Apr 2013 22:46:51 -0700 (PDT)
In-Reply-To: <7vk3of817v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220279>

On Sat, Apr 6, 2013 at 9:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Also, add a new option: 'auto', so if there's more than one patch, the
>> cover letter is generated, otherwise it's not.
>
> Very sensible goal.
>
>> This has the slight disadvantage that a piece of code will always be run
>> even if the user doesn't want a cover letter, and thus waste a few
>> cycles.
>
> I am not sure what overhead you are referring to.
>
> We need to count how many we are emitting with or without the cover
> letter, and count is stored in "total".  Even when the user said
> "auto" (which I personally think should become the default in the
> longer term, but that is a separate issue), we shouldn't have to
> spend any extra cost if you moved the code that does anything heavy
> for cover letter generation after we know what that "total" is, no?
>
> I think the reason you did not move the "find the branch for use in
> the cover letter" code down was because it uses the rev->pending
> interface, which you cannot read out of after you count the commits,
> but that logic to use rev->pending predates the introduction of a
> more modern rev->cmdline mechanism, which is already used by the
> find_branch_name() function in the same codepath, and it is not
> clobbered by prepare_revision_walk().
>
> So perhaps by moving that code down after we know what value "total"
> has, and rewriting "what was the positive commit the user gave us"
> logic using rev->cmdline, you do not have to do unnecessary work at
> all.

I did try to do that, but somehow missed a few possibilities that I
see now. Perhaps something like this (after this, it's possible to
move the find_branch_name() code):

diff --git a/builtin/log.c b/builtin/log.c
index ed89c10..32add91 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1061,15 +1061,6 @@ static char *find_branch_name(struct rev_info *rev)
 	if (0 <= positive) {
 		ref = rev->cmdline.rev[positive].name;
 		tip_sha1 = rev->cmdline.rev[positive].item->sha1;
-	} else if (!rev->cmdline.nr && rev->pending.nr == 1 &&
-		   !strcmp(rev->pending.objects[0].name, "HEAD")) {
-		/*
-		 * No actual ref from command line, but "HEAD" from
-		 * rev->def was added in setup_revisions()
-		 * e.g. format-patch --cover-letter -12
-		 */
-		ref = "HEAD";
-		tip_sha1 = rev->pending.objects[0].item->sha1;
 	} else {
 		return NULL;
 	}
@@ -1299,28 +1290,41 @@ int cmd_format_patch(int argc, const char
**argv, const char *prefix)
 	}

 	if (rev.pending.nr == 1) {
+		unsigned char sha1[20];
+		const char *ref;
+		int check_head = 0;
+
 		if (rev.max_count < 0 && !rev.show_root_diff) {
 			/*
 			 * This is traditional behaviour of "git format-patch
 			 * origin" that prepares what the origin side still
 			 * does not have.
 			 */
-			unsigned char sha1[20];
-			const char *ref;
-
 			rev.pending.objects[0].item->flags |= UNINTERESTING;
 			add_head_to_pending(&rev);
-			ref = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
-			if (ref && !prefixcmp(ref, "refs/heads/"))
-				branch_name = xstrdup(ref + strlen("refs/heads/"));
-			else
-				branch_name = xstrdup(""); /* no branch */
+			check_head = 1;
 		}
 		/*
 		 * Otherwise, it is "format-patch -22 HEAD", and/or
 		 * "format-patch --root HEAD".  The user wants
 		 * get_revision() to do the usual traversal.
 		 */
+
+		if (!strcmp(rev.pending.objects[0].name, "HEAD"))
+			/*
+			 * No actual ref from command line, but "HEAD" from
+			 * rev->def was added in setup_revisions()
+			 * e.g. format-patch --cover-letter -12
+			 */
+			check_head = 1;
+
+		if (check_head) {
+			ref = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
+			if (ref && !prefixcmp(ref, "refs/heads/"))
+				branch_name = xstrdup(ref + strlen("refs/heads/"));
+			else
+				branch_name = xstrdup(""); /* no branch */
+		}
 	}

 	/*
@@ -1329,24 +1333,6 @@ int cmd_format_patch(int argc, const char
**argv, const char *prefix)
 	 */
 	rev.show_root_diff = 1;

-	/*
-	 * NEEDSWORK:randomly pick one positive commit to show
-	 * diffstat; this is often the tip and the command
-	 * happens to do the right thing in most cases, but a
-	 * complex command like "--cover-letter a b c ^bottom"
-	 * picks "c" and shows diffstat between bottom..c
-	 * which may not match what the series represents at
-	 * all and totally broken.
-	 */
-	for (i = 0; i < rev.pending.nr; i++) {
-		struct object *o = rev.pending.objects[i].item;
-		if (!(o->flags & UNINTERESTING))
-			head = (struct commit *)o;
-	}
-	/* There is nothing to show; it is not an error, though. */
-	if (!head)
-		return 0;
-
 	if (!branch_name)
 		branch_name = find_branch_name(&rev);

@@ -1381,6 +1367,16 @@ int cmd_format_patch(int argc, const char
**argv, const char *prefix)
 		list = xrealloc(list, nr * sizeof(list[0]));
 		list[nr - 1] = commit;
 	}
+	/*
+	 * NEEDSWORK:randomly pick one positive commit to show
+	 * diffstat; this is often the tip and the command
+	 * happens to do the right thing in most cases, but a
+	 * complex command like "--cover-letter a b c ^bottom"
+	 * picks "c" and shows diffstat between bottom..c
+	 * which may not match what the series represents at
+	 * all and totally broken.
+	 */
+	head = list[0];
 	total = nr;
 	if (!keep_subject && auto_number && total > 1)
 		numbered = 1;


-- 
Felipe Contreras
