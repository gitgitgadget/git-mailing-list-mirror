From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Sat, 06 Sep 2008 22:27:44 -0700
Message-ID: <7vzlmkpltb.fsf@gitster.siamese.dyndns.org>
References: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl>
 <1220634785-55543-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun Sep 07 07:29:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcCpZ-0004ZR-B0
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 07:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbYIGF1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 01:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbYIGF1x
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 01:27:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYIGF1w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 01:27:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6EF055EC54;
	Sun,  7 Sep 2008 01:27:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6823E5EC53; Sun,  7 Sep 2008 01:27:46 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B67E359C-7C9D-11DD-A4CB-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95112>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> This outputs the current branch on which a commit was created, just for
> reference. For example:
>
> 	Created commit 6d42875 on master: Fix submodule invalid command error
>
> This also reminds the committer when he is on a detached HEAD:
>
> 	Created commit 02a7172 on detached HEAD: Also do this for 'git commit --amend'
>

Given the recent "reminder" discussion, I suspect people without $PS1 set
to show the current branch would like this, majority of others would be
neutral, while some may actively hate it for cluttering the output even
more.  But I also suspect the initial annoyance the third camp may feel
will pass rather quickly after they get used to seeing these.

> diff --git a/builtin-commit.c b/builtin-commit.c
> index 8165bb3..a82483d 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -878,10 +878,31 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  	return commitable ? 0 : 1;
>  }
>  
> +static char* get_commit_format_string()

Style.

	static char *get_commit_format_string(void)

> +{
> +	unsigned char sha[20];
> +	const char* head = resolve_ref("HEAD", sha, 0, NULL);

Style.

	const char *head = ...

> ...
> +	else if (!prefixcmp(head, "refs/heads/")) {
> +		strbuf_addstr(&buf, " on ");
> +		strbuf_addstr(&buf, head + 11);

Isn't this function crafting a format string for format_commit_message()?
What happens if your branch name has % in it?

> +	}
> +	strbuf_addstr(&buf, ": %s");
> +
> +	return buf.buf;

API violation, I think; see strbuf_detach().

> +}
> +
>  static void print_summary(const char *prefix, const unsigned char *sha1)
>  {
>  	struct rev_info rev;
>  	struct commit *commit;
> +	char* format = get_commit_format_string();

Style.

	char *format = ...

> @@ -910,10 +931,11 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
>  
>  	if (!log_tree_commit(&rev, commit)) {
>  		struct strbuf buf = STRBUF_INIT;
> -		format_commit_message(commit, "%h: %s", &buf, DATE_NORMAL);
> +		format_commit_message(commit, format + 7, &buf, DATE_NORMAL);
> 		printf("%s\n", buf.buf);
> 		strbuf_release(&buf);

I somehow suspect it might be much simpler, more contained and robust if you:

 (1) chuck get_commit_format_string(), and leave all the existing code as-is;

 (2) format "%h: %s" into buf here;

 (3) call resolve_ref(HEAD) here to see if you are on detached HEAD (or
     otherwise what branch you are on) after (2),

 (4) find the first ':' in buf.buf and do your "on HEAD"/"on master"
     magic, using the result from (3).
