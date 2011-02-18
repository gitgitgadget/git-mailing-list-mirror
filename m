From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Teach commit about CHERRY_PICK_HEAD
Date: Thu, 17 Feb 2011 18:29:40 -0600
Message-ID: <20110218002913.GB12182@elie>
References: <20110217051919.GA7740@elie>
 <1297921850-94962-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 01:29:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqEEN-000086-Pj
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 01:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757617Ab1BRA3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 19:29:49 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46599 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab1BRA3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 19:29:48 -0500
Received: by qyk12 with SMTP id 12so3263930qyk.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 16:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Z35Zg0Ua8WCEXK8qNUu4PI1CottXJlglxI1Z52lAfZU=;
        b=r/x4GSDs9tzEEHVcYvFgyLc/56mF+p7xKrlcHc3PAUAVi7G+2w6E7jZEsJmiWL8Dua
         ovYiJyKmol/t8lSF/MciMnIAGf1J+1FG6a9ichg67sIWZ4VCWUBbUSjX50nknfTRhPPM
         IFilcPyzPA7e8OOAaz5ebDwIGkQ7/vtdm7qLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sSMsjFkdINtxI1PVJP40r4h9IyFyEZpke33bJUCZKz1eV7EI62I5azsvm9ETMvJLxZ
         9CjpAXimkvZ7BIe5Tx6g66NO6eHSwv6Ku563lZ3h1puBG3zZWILF/uUFE6xaxHThTKyE
         PoYAXbXksjBJpMNNkggvLm78HXZEst4vMtlsI=
Received: by 10.229.247.68 with SMTP id mb4mr42682qcb.294.1297988987097;
        Thu, 17 Feb 2011 16:29:47 -0800 (PST)
Received: from elie ([69.209.72.148])
        by mx.google.com with ESMTPS id l17sm1116284qck.32.2011.02.17.16.29.44
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 16:29:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297921850-94962-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167140>

Jay Soffian wrote:

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -54,9 +54,16 @@ static const char empty_amend_advice[] =
>  "it empty. You can repeat your command with --allow-empty, or you can\n"
>  "remove the commit entirely with \"git reset HEAD^\".\n";
>  
> +static const char empty_cherry_pick_advice[] =
> +"The most recent cherry-pick is empty. If you wish to commit it, use:\n"
> +"\n"
> +"    git commit --allow-empty\n"
> +"\n"
> +"Otherwise, please remove the file %s\n";

After scratching my head a little, this seems to mean

	After conflict resolution, your last cherry-pick does not
	introduce any changes. To commit it as an empty commit, use:\n
	\n
	    git commit --allow-empty\n
	\n
	Alternatively, you can cancel the cherry-pick by removing\n
	the file %s\n

It suspect it might be more intuitive to say

	Alternatively, you can cancel the cherry-pick by running\n
	"git reset".\n

which works because the index is known to be clean at that point.

> +/*
> + * The _message variables are commit names from which to take
> + * the commit message and/or authorship.
> + */

Makes sense, thanks.  I'll think more about an intuitive and
consistent name for these and hopefully send a patch for it later as a
separate topic.

> +       if (whence == FROM_CHERRY_PICK && !renew_authorship) {
> +               author_message = "CHERRY_PICK_HEAD";
> +               author_message_buffer = read_commit_message(author_message);

I mentioned in a side thread that script authors might be happier if
their carefully prepared GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL do not
get overridden in this case, but I was wrong[*].  Might make sense
to add a test for that:

	GIT_AUTHOR_NAME="Someone else" &&
	GIT_AUTHOR_EMAIL=someone@else.example.com &&
	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
	git cherry-pick something &&

	git diff-tree -s --format="%an <%ae>" >actual &&
	test_cmp expect actual

(This is just a side note; the patch is good.)

In the $GIT_CHERRY_PICK_HELP set case, won't the CHERRY_PICK_HEAD
behavior be harmless?  rebase --interactive --continue wants to set
GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL but that is only in order to copy
the author identity from the original commit.

> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -60,7 +60,7 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
>  	color_fprintf_ln(s->fp, c, "# Unmerged paths:");
>  	if (!advice_status_hints)
>  		return;
> -	if (s->in_merge)
> +	if (s->whence != FROM_COMMIT)
>  		;
>  	else if (!s->is_initial)
>  		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);

The advice 'use "git reset HEAD -- <file>..." to unstage' makes
perfect sense to me in the cherry-pick case, no?  The operator is
replaying an existing commit, and tweaking the result amounts to
pretending she made the change herself and tweaking that.

> @@ -77,7 +77,7 @@ static void wt_status_print_cached_header(struct wt_status *s)
>  	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
>  	if (!advice_status_hints)
>  		return;
> -	if (s->in_merge)
> +	if (s->whence != FROM_COMMIT)
>  		; /* NEEDSWORK: use "git reset --unresolve"??? */

Likewise.

> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -24,6 +24,13 @@ enum untracked_status_type {
>  	SHOW_ALL_UNTRACKED_FILES
>  };
>  
> +/* from where does this commit originate */
> +enum commit_whence {
> +	FROM_COMMIT,     /* normal */
> +	FROM_MERGE,      /* commit came from merge */
> +	FROM_CHERRY_PICK /* commit came from cherry-pick */
> +};

I think these comments are not in a place that will help a person
understand the code, but I don't have the energy to go back and forth
on it.

Everything not mentioned above except the --no-commit case mentioned
by Junio looks good to me, though I haven't tested.

Thanks for your thoughtfulness.
Jonathan

[*]
-- 8< --
Subject: [BAD IDEA] commit: let GIT_AUTHOR_NAME/EMAIL take effect when commiting a cherry-pick

commit -c/-C/--amend to take the commit message and author from
another message has always overridden the GIT_AUTHOR_NAME and
GIT_AUTHOR_EMAIL variables.  Letting the command line override the
environment in this way is generally convenient and more intuitive if
a person has forgotten what is in the environment:

	GIT_AUTHOR_NAME=me
	GIT_AUTHOR_EMAIL=email@example.com
	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL

	...
	git commit;	# using identity from environment
	...
	git commit;	# another commit as me
	...
	# commit by someone else
	git commit --author='Someone Else <other@example.com>'
	...
	# commit by someone else
	git commit -c someone-elses-commit

The new CHERRY_PICK_HEAD feature inherits the same semantics.
Uncareful scripts that want to commit with a different author name and
email when taking over after a failed cherry-pick use authorship from
the cherry-picked commit instead of the environment:

	! git cherry-pick complicated;	# failed cherry-pick
	... resolve the conflict ...
	git commit

While that could theoretically break some scripts, it's worth it for
consistency, the intuitiveness-when-user-forgets-environment issue
mentioned above, and because cherry-pick itself, which internally
does something like

	git cherry-pick --no-commit $1;	# simple cherry-pick
	git commit

has always ignored the GIT_AUTHOR_NAME/EMAIL environment settings.

The patch below makes commit with CHERRY_PICK_HEAD respect
GIT_AUTHOR_NAME/EMAIL anyway, to demonstrate how broken that is.  It
breaks tests t3404 and t3506.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/commit.c |   59 ++++++++++++++++++++++++++++++++---------------------
 1 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 35eb024..f398910 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -80,6 +80,7 @@ static const char *template_file;
  * the commit message and/or authorship.
  */
 static const char *author_message, *author_message_buffer;
+static int author_message_overrides_environ;
 static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
 static int all, edit_flag, also, interactive, only, amend, signoff;
@@ -504,6 +505,38 @@ static int is_a_merge(const unsigned char *sha1)
 
 static const char sign_off_header[] = "Signed-off-by: ";
 
+static void reuse_author_info(char **name, char **email, char **date)
+{
+	const char *a, *lb, *rb, *eol;
+
+	if (author_message_overrides_environ)
+		*name = *email = *date = NULL;
+
+	a = strstr(author_message_buffer, "\nauthor ");
+	if (!a)
+		die("invalid commit: %s", author_message);
+
+	lb = strchrnul(a + strlen("\nauthor "), '<');
+	rb = strchrnul(lb, '>');
+	eol = strchrnul(rb, '\n');
+	if (!*lb || !*rb || !*eol)
+		die("invalid commit: %s", author_message);
+
+	if (!*name) {
+		if (lb == a + strlen("\nauthor "))
+			/* \nauthor <foo@example.com> */
+			*name = xcalloc(1, 1);
+		else
+			*name = xmemdupz(a + strlen("\nauthor "),
+					 (lb - strlen(" ") -
+					  (a + strlen("\nauthor "))));
+	}
+	if (!*email)
+		*email = xmemdupz(lb + strlen("<"), rb - (lb + strlen("<")));
+	if (!*date)
+		*date = xmemdupz(rb + strlen("> "), eol - (rb + strlen("> ")));
+}
+
 static void determine_author_info(struct strbuf *author_ident)
 {
 	char *name, *email, *date;
@@ -512,29 +545,8 @@ static void determine_author_info(struct strbuf *author_ident)
 	email = getenv("GIT_AUTHOR_EMAIL");
 	date = getenv("GIT_AUTHOR_DATE");
 
-	if (author_message) {
-		const char *a, *lb, *rb, *eol;
-
-		a = strstr(author_message_buffer, "\nauthor ");
-		if (!a)
-			die("invalid commit: %s", author_message);
-
-		lb = strchrnul(a + strlen("\nauthor "), '<');
-		rb = strchrnul(lb, '>');
-		eol = strchrnul(rb, '\n');
-		if (!*lb || !*rb || !*eol)
-			die("invalid commit: %s", author_message);
-
-		if (lb == a + strlen("\nauthor "))
-			/* \nauthor <foo@example.com> */
-			name = xcalloc(1, 1);
-		else
-			name = xmemdupz(a + strlen("\nauthor "),
-					(lb - strlen(" ") -
-					 (a + strlen("\nauthor "))));
-		email = xmemdupz(lb + strlen("<"), rb - (lb + strlen("<")));
-		date = xmemdupz(rb + strlen("> "), eol - (rb + strlen("> ")));
-	}
+	if (author_message)
+		reuse_author_info(&name, &email, &date);
 
 	if (force_author) {
 		const char *lb = strstr(force_author, " <");
@@ -1034,6 +1046,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 			author_message = use_message;
 			author_message_buffer = use_message_buffer;
 		}
+		author_message_overrides_environ = 1;
 	}
 	if (whence == FROM_CHERRY_PICK && !renew_authorship) {
 		author_message = "CHERRY_PICK_HEAD";
-- 
1.7.4.1
