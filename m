From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: learn to fill comment section of email
 from notes
Date: Tue, 23 Feb 2010 13:56:55 -0800
Message-ID: <7vmxyzehug.fsf@alter.siamese.dyndns.org>
References: <201002231810.18960.trast@student.ethz.ch>
 <6cf9010742df96e0c68ef8adc1ab392c08525bc2.1266946262.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:57:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2km-0000qP-6x
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab0BWV5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 16:57:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242Ab0BWV5H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:57:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF55C9CFD0;
	Tue, 23 Feb 2010 16:57:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=n4aDXyAuqwAzub+xKBDIeLDPnIc=; b=IIoNF7cG1DrCVXWhmLPmgq8
	uDFZZe7rx2Ixxbnp8q5nEvzRNCUsTLoTvYntdUqyjgGCTiCzdmpbVjtXh2t/urMn
	pS2mg6Sqy4Ge5kERneB05WAJijsdbj2anxxErSU9i4uOKkaUvZL460YMB5ALvGdo
	PPITjmgFUUSzHI1/Yhe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nBvTB50o+JZu0le1/oVRpaLTAki8E6+zkIaqjKtxwl+e28ueK
	hoUvdVSyehsS5E2YL8tKe4teMi2QHfvgH6AEPUHdYTHDGzclrOgbgOP8L0cK10oq
	mdnQZKOkxWFW615rZUsml1nkpDX8A+cDWiqqbTTC1ZEb7QZF5PeB23p0vQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F7CE9CFC1;
	Tue, 23 Feb 2010 16:57:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38E519CFBD; Tue, 23 Feb
 2010 16:56:57 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F94DABE-20C6-11DF-81C7-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140851>

Thomas Rast <trast@student.ethz.ch> writes:

> Teach git-format-patch a new option --comment-notes (with config
> format.commentNotes) which takes a notes ref argument.  These notes
> are then added to the patch email between the --- separator and the
> diffstat/diff.

Hmmm, why do I find this an ugly hack?

You already have a nice "format_display_notes()" infrastructure to allow
users to get notes from arbitrary notes namespaces, yet this limits the
user to a single notes namespace.  What was the infrastructure built for
if not used in places like this uniformly?

If the answer is "because notes.displayref is a configuration and it is
cumbersome to change every time", then I don't have a sympathy ;-) as that
is exactly why I said config without command line override is a bad thing.

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 9674f9d..afe7e41 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -198,6 +198,16 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>  	range are always formatted as creation patches, independently
>  	of this flag.
>  
> +--comment-notes=<ref>::
> +	Use the notes from <ref> to fill the comment section of the
> +	email, i.e., the part between the `\---` separator and the
> +	patch.  See linkgit:git-notes[1].
> ++
> +Warning: the code currently does not guard against a line in the notes
> +that starts with `diff`, which will be treated as the start of the
> +patch by 'git-am'.

It is customary to indent the material after --- by one place (or more) so
it probably is a good idea to do that for notes as well, if we are going
to put it after the three dash lines.  Notice that diffstat output is
already indented that way ;-).

> @@ -457,6 +458,7 @@ int log_tree_diff_flush(struct rev_info *opt)
>  	}
>  
>  	if (opt->loginfo && !opt->no_commit_id) {
> +		const unsigned char *sha1 = opt->loginfo->commit->object.sha1;
>  		/* When showing a verbose header (i.e. log message),
>  		 * and not in --pretty=oneline format, we would want
>  		 * an extra newline between the end of log and the
> @@ -467,10 +469,20 @@ int log_tree_diff_flush(struct rev_info *opt)
>  		    opt->verbose_header &&
>  		    opt->commit_format != CMIT_FMT_ONELINE) {
>  			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
> -			if ((pch & opt->diffopt.output_format) == pch)
> +			if ((pch & opt->diffopt.output_format) == pch
> +			    || (opt->commit_format == CMIT_FMT_EMAIL
> +				&& opt->show_notes))

This adds a lot of logic to a code that used to be simple "if we have more
stuff to add after message, delimit with "---\n"".  Perhaps the whole body
of the "if" statement ll. 460- should be made into a static helper
function with a single callsite that a clever compiler would inline.

Also I think you would emit "---" even if the commit in question does not
happen to have note with this code.

I've attached a "how about doing it this way" weatherbaloon patch to be
applied on top of this patch at the end---I didn't bother to indent the
notes text nor change it to use format_display_notes(), but hopefully you
will agree the code structure would be easier to follow this way.

> diff --git a/pretty.c b/pretty.c
> index 6ba3da8..10d7812 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1095,7 +1095,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
>  	if (fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
>  		strbuf_addch(sb, '\n');
>  
> -	if (context->show_notes)
> +	if (context->show_notes && fmt != CMIT_FMT_EMAIL)
>  		format_display_notes(commit->object.sha1, sb, encoding,
>  				     NOTES_SHOW_HEADER | NOTES_INDENT);

This is a good fix to prevent notes from getting injected above the
separator line, regardless of your series, I think.

 log-tree.c |   71 +++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 9baf306..af65d33 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -445,6 +445,52 @@ void show_log(struct rev_info *opt)
 	strbuf_release(&msgbuf);
 }
 
+static void log_tree_after_message(struct rev_info *opt)
+{
+	const int pch = (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_PATCH);
+	struct strbuf sb = STRBUF_INIT;
+
+	/*
+	 * When showing a verbose header (i.e. log message),
+	 * and not in --pretty=oneline format, we would want
+	 * an extra newline between the end of log and the
+	 * output for readability.
+	 */
+	if (! ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
+	       opt->verbose_header &&
+	       opt->commit_format != CMIT_FMT_ONELINE) )
+		return;
+
+	/*
+	 * Prepare notes if any...
+	 */
+	if (opt->commit_format == CMIT_FMT_EMAIL && opt->show_notes)
+		format_note(NULL, opt->loginfo->commit->object.sha1,
+			    &sb, NULL, 0);
+
+	/*
+	 * Will we have something other than the message itself?  If
+	 * so we would need three-dashes.
+	 */
+	if (((pch & opt->diffopt.output_format) == pch) || sb.len)
+		printf("---");
+
+	/*
+	 * Then the promised newline...
+	 */
+	putchar('\n');
+
+	/*
+	 * And finally the notes...
+	 */
+	if (sb.len) {
+		putchar('\n');
+		fwrite(sb.buf, 1, sb.len, stdout);
+		strbuf_release(&sb);
+		putchar('\n');
+	}
+}
+
 int log_tree_diff_flush(struct rev_info *opt)
 {
 	diffcore_std(&opt->diffopt);
@@ -458,31 +504,8 @@ int log_tree_diff_flush(struct rev_info *opt)
 	}
 
 	if (opt->loginfo && !opt->no_commit_id) {
-		const unsigned char *sha1 = opt->loginfo->commit->object.sha1;
-		/* When showing a verbose header (i.e. log message),
-		 * and not in --pretty=oneline format, we would want
-		 * an extra newline between the end of log and the
-		 * output for readability.
-		 */
 		show_log(opt);
-		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
-		    opt->verbose_header &&
-		    opt->commit_format != CMIT_FMT_ONELINE) {
-			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
-			if ((pch & opt->diffopt.output_format) == pch
-			    || (opt->commit_format == CMIT_FMT_EMAIL
-				&& opt->show_notes))
-				printf("---");
-			putchar('\n');
-		}
-		if (opt->commit_format == CMIT_FMT_EMAIL && opt->show_notes) {
-			struct strbuf sb = STRBUF_INIT;
-			putchar('\n');
-			format_note(NULL, sha1, &sb, NULL, 0);
-			fwrite(sb.buf, 1, sb.len, stdout);
-			strbuf_release(&sb);
-			putchar('\n');
-		}
+		log_tree_after_message(opt);
 	}
 	diff_flush(&opt->diffopt);
 	return 1;
