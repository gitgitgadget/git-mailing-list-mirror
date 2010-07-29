From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4 v2] Allow detached form (e.g. "git log --grep foo")
	in log options.
Date: Wed, 28 Jul 2010 21:46:38 -0500
Message-ID: <20100729024638.GM29156@dert.cs.uchicago.edu>
References: <vpqr5ioukca.fsf@bauges.imag.fr> <1280310062-16793-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 29 04:46:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeJ8v-0004Ih-Ou
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 04:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab0G2Cqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 22:46:40 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:57375 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab0G2Cqj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 22:46:39 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 2F568A0BE;
	Wed, 28 Jul 2010 21:46:39 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id EF7236914; Wed, 28 Jul 2010 21:46:38 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1280310062-16793-3-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152153>

Matthieu Moy wrote:

> +++ b/revision.c
[...]
> @@ -1295,27 +1305,32 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->pretty_given = 1;
>  		get_commit_format(arg+8, revs);
>  	} else if (!prefixcmp(arg, "--pretty=") || !prefixcmp(arg, "--format=")) {
> +		/*
> +		 * Detached form ("--pretty X" as opposed to "--pretty=X")
> +		 * not allowed, since the argument is optional.
> +		 */
>  		revs->verbose_header = 1;
>  		revs->pretty_given = 1;
>  		get_commit_format(arg+9, revs);
>  	} else if (!strcmp(arg, "--show-notes")) {
>  		revs->show_notes = 1;
>  		revs->show_notes_given = 1;
> -	} else if (!prefixcmp(arg, "--show-notes=")) {
> +	} else if ((argcount = diff_long_opt("show-notes", argv, &optarg))) {

Why is this not like the --pretty case?

[...]
> @@ -1343,12 +1358,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->abbrev = 0;
>  	} else if (!strcmp(arg, "--abbrev")) {
>  		revs->abbrev = DEFAULT_ABBREV;
> -	} else if (!prefixcmp(arg, "--abbrev=")) {
> -		revs->abbrev = strtoul(arg + 9, NULL, 10);
> +	} else if ((argcount = diff_long_opt("abbrev", argv, &optarg))) {
> +		revs->abbrev = strtoul(optarg, NULL, 10);

Likewise.

> +	test_must_fail git log -1 --pretty="tformat:%s" --grep

Thanks for checking an edge case.

With or without the following change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git a/revision.c b/revision.c
index 92035a3..7006340 100644
--- a/revision.c
+++ b/revision.c
@@ -1315,22 +1315,21 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--show-notes")) {
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
-	} else if ((argcount = diff_long_opt("show-notes", argv, &optarg))) {
+	} else if (!prefixcmp(arg, "--show-notes=")) {
 		struct strbuf buf = STRBUF_INIT;
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
 		if (!revs->notes_opt.extra_notes_refs)
 			revs->notes_opt.extra_notes_refs = xcalloc(1, sizeof(struct string_list));
-		if (!prefixcmp(optarg, "refs/"))
+		if (!prefixcmp(arg+13, "refs/"))
 			/* happy */;
-		else if (!prefixcmp(optarg, "notes/"))
+		else if (!prefixcmp(arg+13, "notes/"))
 			strbuf_addstr(&buf, "refs/");
 		else
 			strbuf_addstr(&buf, "refs/notes/");
-		strbuf_addstr(&buf, optarg);
+		strbuf_addstr(&buf, arg+13);
 		string_list_append(revs->notes_opt.extra_notes_refs,
 				   strbuf_detach(&buf, NULL));
-		return argcount;
 	} else if (!strcmp(arg, "--no-notes")) {
 		revs->show_notes = 0;
 		revs->show_notes_given = 1;
@@ -1358,13 +1357,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->abbrev = 0;
 	} else if (!strcmp(arg, "--abbrev")) {
 		revs->abbrev = DEFAULT_ABBREV;
-	} else if ((argcount = diff_long_opt("abbrev", argv, &optarg))) {
-		revs->abbrev = strtoul(optarg, NULL, 10);
+	} else if (!prefixcmp(arg, "--abbrev=")) {
+		revs->abbrev = strtoul(arg + 9, NULL, 10);
 		if (revs->abbrev < MINIMUM_ABBREV)
 			revs->abbrev = MINIMUM_ABBREV;
 		else if (revs->abbrev > 40)
 			revs->abbrev = 40;
-		return argcount;
 	} else if (!strcmp(arg, "--abbrev-commit")) {
 		revs->abbrev_commit = 1;
 	} else if (!strcmp(arg, "--full-diff")) {
-- 
