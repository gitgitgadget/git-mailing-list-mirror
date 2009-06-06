From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 3/3] Use die_errno() instead of die() when checking syscalls
Date: Sat, 6 Jun 2009 23:02:08 +0200
Message-ID: <200906062302.08616.j6t@kdbg.org>
References: <cover.1244299302.git.trast@student.ethz.ch> <095b4af080c11b4ad3fcfaefc9cdf49d383cb714.1244299302.git.trast@student.ethz.ch> <62538974f2c0f4561428507e514daa87dbfcac01.1244299302.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jun 06 23:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD31v-0000vS-Ph
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 23:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbZFFVCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 17:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbZFFVCJ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 17:02:09 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:41448 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbZFFVCI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 17:02:08 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DBB1B2C4002;
	Sat,  6 Jun 2009 23:02:08 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B27363FFB6;
	Sat,  6 Jun 2009 23:02:08 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <62538974f2c0f4561428507e514daa87dbfcac01.1244299302.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120937>

On Samstag, 6. Juni 2009, Thomas Rast wrote:
> Lots of die() calls did not actually report the kind of error, which
> can leave the user confused as to the real problem.  Use die_errno()
> where we check a system/library call that sets errno on failure, or
> one of the following that wrap such calls:
>
>   Function              Passes on error from
>   --------              --------------------
>   odb_pack_keep         open
>   read_ancestry         fopen
>   read_in_full          xread
>   strbuf_read           xread
>   strbuf_read_file      open or strbuf_read_file
>   strbuf_readlink       readlink
>   write_in_full         xwrite
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---

> @@ -2262,7 +2262,6 @@ int cmd_blame(int argc, const char **argv, const char
> *prefix)
>
>  	if (revs_file && read_ancestry(revs_file))
>  		die_errno("reading graft file '%s' failed", revs_file);
> -
>  	if (cmd_is_annotate) {
>  		output_option |= OUTPUT_ANNOTATE_COMPAT;
>  		blame_date_mode = DATE_ISO8601;

Unrelated and not an improvement.

> @@ -220,13 +220,12 @@ static void copy_or_link_directory(struct strbuf
> *src, struct strbuf *dest)
>
>  	dir = opendir(src->buf);
>  	if (!dir)
> -		die("failed to open %s", src->buf);
> -
> +		die_errno("failed to open '%s'", src->buf);

Here (and in other cases) you remote an empty line. I don't think that is an 
improvement.

> @@ -472,7 +472,6 @@ static int prepare_to_commit(const char *index_file,
> const char *prefix) fp = fopen(git_path(commit_editmsg), "w");
>  	if (fp == NULL)
>  		die_errno("could not open '%s'", git_path(commit_editmsg));
> -
>  	if (cleanup_mode != CLEANUP_NONE)
>  		stripspace(&sb, 0);
>

Unrelated.

> @@ -496,7 +495,6 @@ static int prepare_to_commit(const char *index_file,
> const char *prefix)
>
>  	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
>  		die_errno("could not write commit template");
> -
>  	strbuf_release(&sb);
>
>  	determine_author_info();

Ditto.

> @@ -1018,8 +1017,10 @@ int cmd_commit(int argc, const char **argv, const
> char *prefix)
>
>  	if (commit_index_files())
>  		die ("Repository has been updated, but unable to write\n"
> -		     "new_index file. Check that disk is not full or quota is\n"
> -		     "not exceeded, and then \"git reset HEAD\" to recover.");
> +		     "new_index file: %s.\n"
> +		     "Check that disk is not full or quota is not exceeded,\n"
> +		     "and then \"git reset HEAD\" to recover.",
> +		     strerror(errno));

This change should probably not be in this patch.

> @@ -452,7 +452,6 @@ static void import_marks(char *input_file)
>  	FILE *f = fopen(input_file, "r");
>  	if (!f)
>  		die_errno("cannot read '%s'", input_file);
> -
>  	while (fgets(line, sizeof(line), f)) {
>  		uint32_t mark;
>  		char *line_end, *mark_end;

Unrelated.

> diff --git a/csum-file.c b/csum-file.c
> index 9cc93ba..4d50cc5 100644
> --- a/csum-file.c
> +++ b/csum-file.c
> @@ -55,8 +55,7 @@ int sha1close(struct sha1file *f, unsigned char *result,
> unsigned int flags) if (flags & CSUM_FSYNC)
>  			fsync_or_die(f->fd, f->name);
>  		if (close(f->fd))
> -			die_errno("%s: sha1 file error on close",
> -			    f->name);
> +			die_errno("%s: sha1 file error on close", f->name);

This should be in 2/3.

-- Hannes
