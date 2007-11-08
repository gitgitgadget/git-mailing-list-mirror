From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Port git commit to C.
Date: Thu, 08 Nov 2007 15:14:46 -0800
Message-ID: <7vy7d8z5w9.fsf@gitster.siamese.dyndns.org>
References: <1194541140-3062-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIFI-00047A-VR
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762220AbXKHX45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 18:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761979AbXKHX44
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 18:56:56 -0500
Received: from lollipop.listbox.com ([208.210.124.78]:52865 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756221AbXKHX4z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 18:56:55 -0500
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by lollipop.listbox.com (Postfix) with ESMTP id 7FC1846C1E1
	for <git@vger.kernel.org>; Thu,  8 Nov 2007 18:17:47 -0500 (EST)
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 682CC2F0;
	Thu,  8 Nov 2007 18:15:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8FE2593A15;
	Thu,  8 Nov 2007 18:15:11 -0500 (EST)
In-Reply-To: <1194541140-3062-1-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Thu, 8 Nov 2007 11:59:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64095>

A huge diff.

I'll quote the difference between this version and the version
previously parked on 'pu', and comment, after re-reverting what
you reverted from the parked version (which has minor tweaks
such as removing git-runstatus from .gitignore I made
previously).

>  builtin-commit.c |   88 +++++++++++++++++++++++++++---------------------------
>  1 files changed, 44 insertions(+), 44 deletions(-)
> 
> diff --git a/builtin-commit.c b/builtin-commit.c
> index f108e90..669cc6b 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -70,25 +70,22 @@ static char *prepare_index(const char **files, const char *prefix)
>  	struct tree *tree;
>  	struct lock_file *next_index_lock;
>  
> +	if (interactive) {
> +		interactive_add();
> +		return get_index_file();
> +	}
> +

So interactive bypasses everything else, which makes sense.

What happens when the user aborts interactive_add, wishing to
abort the whole commit process?

> @@ -267,36 +264,41 @@ static int message_is_empty(struct strbuf *sb, int start)
>  
>  static void determine_author_info(struct strbuf *sb)
>  {
> -	char *p, *eol;
> -	char *name = NULL, *email = NULL;
> +	char *name, *email, *date;
>  
> -	if (force_author) {
> -		const char *eoname = strstr(force_author, " <");
> -		const char *eomail = strchr(force_author, '>');
> +	name = getenv("GIT_AUTHOR_NAME");
> +	email = getenv("GIT_AUTHOR_EMAIL");
> +	date = getenv("GIT_AUTHOR_DATE");
>  
> -		if (!eoname || !eomail)
> -			die("malformed --author parameter\n");
> -		name = xstrndup(force_author, eoname - force_author);
> -		email = xstrndup(eoname + 2, eomail - eoname - 2);
> -		/* REVIEW: drops author date from amended commit on --amend --author=<author> */
> -		strbuf_addf(sb, "author %s\n",
> -			    fmt_ident(name, email,
> -				      getenv("GIT_AUTHOR_DATE"), 1));
> -		free(name);
> -		free(email);
> -	} else if (use_message) {
> -		p = strstr(use_message_buffer, "\nauthor");
> -		if (!p)
> +	if (use_message) {
> +		const char *a, *lb, *rb, *eol;
> +
> +		a = strstr(use_message_buffer, "\nauthor ");
> +		if (!a)
>  			die("invalid commit: %s\n", use_message);

You know in what sense it is invalid here and ...

> -		p++;
> -		eol = strchr(p, '\n');
> -		if (!eol)
> +
> +		lb = strstr(a + 8, " <");
> +		rb = strstr(a + 8, "> ");
> +		eol = strchr(a + 8, '\n');
> +		if (!lb || !rb || !eol)
>  			die("invalid commit: %s\n", use_message);

... here.  Would it be more helpful to say "No author line", and
"Cannot parse author line", I wonder.  Probably too much.

> -		strbuf_add(sb, p, eol + 1 - p);
> -	} else {
> -		strbuf_addf(sb, "author %s\n", git_author_info(1));
> +		name = xstrndup(a + 8, lb - (a + 8));
> +		email = xstrndup(lb + 2, rb - (lb + 2));
> +		date = xstrndup(rb + 2, eol - (rb + 2));
>  	}
> +
> +	if (force_author) {
> +		const char *lb = strstr(force_author, " <");
> +		const char *rb = strchr(force_author, '>');
> +
> +		if (!lb || !rb)
> +			die("malformed --author parameter\n");
> +		name = xstrndup(force_author, lb - force_author);
> +		email = xstrndup(lb + 2, rb - (lb + 2));
> +	}
> +
> +	strbuf_addf(sb, "author %s\n", fmt_ident(name, email, date, 1));

I see a slight leak here of name/email/date depending on how
they are obtained.  Probably it is too much hassle to deal with
for too little gain.
