From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 1/6] builtin-commit: fix author date with --amend
	--author=<author>
Date: Mon, 12 Nov 2007 14:38:54 -0500
Message-ID: <1194896334.2869.7.camel@hinata.boston.redhat.com>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
	 <Pine.LNX.4.64.0711111735100.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 20:45:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrfEC-0008D2-81
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 20:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757757AbXKLTpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 14:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757673AbXKLTp3
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 14:45:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37587 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755947AbXKLTp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 14:45:27 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lACJd2Ys015720;
	Mon, 12 Nov 2007 14:39:02 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lACJd168017810;
	Mon, 12 Nov 2007 14:39:01 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lACJcxEC012494;
	Mon, 12 Nov 2007 14:38:59 -0500
In-Reply-To: <Pine.LNX.4.64.0711111735100.4362@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64690>

On Sun, 2007-11-11 at 17:35 +0000, Johannes Schindelin wrote:
> When amending a commit with a new author, the author date is taken
> from the original commit.

The new determine_author_info() should fix this.  There was a problem
earlier that Junio pointed out and I sent a patch to update
determine_author_info() to do the right thing for amend commits.  The
test suite still pass without this patch, and if you look carefully a
determine_author_info(), you can see it does the right thing:

  1) Default to getenv for name, email and date

  2) If a commit has been specified (-c, -C or --amend), we parse the
author name, email and date from use_message_buffer, which holds the
commit, overriding the values from getenv.

  3) If --author has be passed, we parse name and email from the
argument and override whatever name and email the two previous steps
came up with.

Then we add the author line to the commit buffer under construction
based on these values.

I suggest we back this patch out.

cheers,
Kristian

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin-commit.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-commit.c b/builtin-commit.c
> index a84a729..6be6def 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -527,6 +527,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	} else if (amend) {
>  		struct commit_list *c;
>  		struct commit *commit;
> +		const char *author;
>  
>  		reflog_msg = "commit (amend)";
>  		commit = lookup_commit(head_sha1);
> @@ -536,6 +537,21 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		for (c = commit->parents; c; c = c->next)
>  			strbuf_addf(&sb, "parent %s\n",
>  				      sha1_to_hex(c->item->object.sha1));
> +
> +		/* determine author date */
> +		author = strstr(commit->buffer, "\nauthor");
> +		if (author && !memmem(commit->buffer,
> +					author + 1 - commit->buffer,
> +					"\n\n", 2)) {
> +			const char *email_end = strchr(author + 1, '>');
> +			const char *line_end = strchr(author + 1, '\n');
> +			if (email_end && line_end && email_end < line_end) {
> +				char *date = xstrndup(email_end + 1,
> +					line_end - email_end - 1);
> +				setenv("GIT_AUTHOR_DATE", date, 1);
> +				free(date);
> +			}
> +		}
>  	} else if (in_merge) {
>  		struct strbuf m;
>  		FILE *fp;
