From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 9/9] Implement git commit as a builtin command.
Date: Thu, 6 Sep 2007 17:59:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709061741370.28586@racer.site>
References: <11890382183913-git-send-email-krh@redhat.com>
 <11890382242333-git-send-email-krh@redhat.com> <11890382243290-git-send-email-krh@redhat.com>
 <11890382253220-git-send-email-krh@redhat.com> <11890382252522-git-send-email-krh@redhat.com>
 <1189038225525-git-send-email-krh@redhat.com> <11890382262161-git-send-email-krh@redhat.com>
 <11890382264046-git-send-email-krh@redhat.com> <11890382271931-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-252589586-1189096989=:28586"
Cc: git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:01:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKiF-0004K5-R9
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 19:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXIFRAK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 13:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbXIFRAK
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 13:00:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:47032 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750832AbXIFRAI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 13:00:08 -0400
Received: (qmail invoked by alias); 06 Sep 2007 17:00:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 06 Sep 2007 19:00:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ndcd7bbkN3XHaU6V8rPiyFkj44o2araenHmJmE/
	YQ4eliVW89xl7s
X-X-Sender: gene099@racer.site
In-Reply-To: <11890382271931-git-send-email-krh@redhat.com>
Content-ID: <Pine.LNX.4.64.0709061743190.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57907>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-252589586-1189096989=:28586
Content-Type: TEXT/PLAIN; CHARSET=utf-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0709061743191.28586@racer.site>

Hi,

On Wed, 5 Sep 2007, Kristian Høgsberg wrote:

>  contrib/examples/git-commit.sh |  665 +++++++++++++++++++++++++++++++++++
>  git-commit.sh                  |  665 -----------------------------------

You might want to use "git format-patch -M" next time ;-)

> @@ -357,7 +358,6 @@ BUILTIN_OBJS = \
>  	builtin-rev-parse.o \
>  	builtin-revert.o \
>  	builtin-rm.o \
> -	builtin-runstatus.o \

Better keep it; some people's scripts could depend on it.

> +struct option {
> +    enum option_type type;
> +    const char *long_name;
> +    char short_name;
> +    void *value;
> +};
> +
> +static int scan_options(const char ***argv, struct option *options)
> +{

I would not (no longer, anyway) be opposed to replacing the option parsing 
in git with getopt(); I hear that it is small enough to keep a copy in 
compat/getopt.c.

But let's go forward with builtin-commit; getopt() can come later.

> +static char *
> +prepare_index(const char **files, const char *prefix)
> +{
> +	int fd;
> +	struct tree *tree;
> +	struct lock_file *next_index_lock;
> +
> +	fd = hold_locked_index(&lock_file, 1);
> +	if (read_cache() < 0)
> +		die("index file corrupt");
> +
> +	if (all) {
> +		add_files_to_cache(fd, files, NULL);
> +		return lock_file.filename;
> +	} else if (also) {
> +		add_files_to_cache(fd, files, prefix);
> +		return lock_file.filename;
> +	}
> +
> +	if (interactive)
> +		interactive_add();
> +
> +	if (*files == NULL) {
> +		/* Commit index as-is. */
> +		rollback_lock_file(&lock_file);
> +		return get_index_file();
> +	}
> +
> +	/*
> +	 * FIXME: Warn on unknown files.  Shell script does
> +	 *
> +	 *   commit_only=`git-ls-files --error-unmatch -- "$@"`
> +	 */
> +
> +	/*
> +	 * FIXME: shell script does
> +	 *
> +	 *   git-read-tree --index-output="$TMP_INDEX" -i -m HEAD
> +	 *
> +	 * which warns about unmerged files in the index.
> +	 */
> +
> +	/* update the user index file */
> +	add_files_to_cache(fd, files, prefix);

I suspect this, or ...

> +
> +	if (!initial_commit) {
> +		tree = parse_tree_indirect(head_sha1);
> +		if (!tree)
> +			die("failed to unpack HEAD tree object");
> +		if (read_tree(tree, 0, NULL))
> +			die("failed to read HEAD tree object");
> +	}
> +
> +	/* Uh oh, abusing lock_file to create a garbage collected file */
> +	next_index_lock = xmalloc(sizeof(*next_index_lock));
> +	fd = hold_lock_file_for_update(next_index_lock,
> +				       git_path("next-index-%d", getpid()), 1);
> +	add_files_to_cache(fd, files, prefix);

... this, but not both.

> +/* Find out if the message starting at position 'start' in the strbuf
> + * contains only whitespace and Signed-off-by lines. */
> +static int message_is_empty(struct strbuf *sb, int start)
> +{
> +	static const char signed_off_by[] = "Signed-off-by: ";

I think you already defined that globally earlier.

In the function message_is_empty() you write:

> +	/* See if the template is just a prefix of the message. */
> +	strbuf_init(&tmpl);
> +	if (template_file && strbuf_read_path(&tmpl, template_file) > 0) {
> +		stripspace(&tmpl, 1);
> +		if (start + tmpl.len <= sb->len &&
> +		    memcmp(tmpl.buf, sb->buf + start, tmpl.len) == 0)
> +			start += tmpl.len;

Could we not bail out here, if there is no match?  In that case, the 
message is clearly not empty...

> +	/* Check if the rest is just whitespace and Signed-of-by's. */
> +	for (i = start; i < sb->len; i++) {
> +		nl = memchr(sb->buf + i, '\n', sb->len - i);
> +		if (nl)
> +			eol = nl - sb->buf;
> +		else
> +			eol = sb->len;

Why not just "if (isspace(sb->buf[i]) || sb->buf[i] == '\n') continue;"? 
This would also catch the cases where people indent their S-O-Bs.

> +
> +		if (strlen(signed_off_by) <= eol - i &&
> +		    !prefixcmp(sb->buf + i, signed_off_by)) {
> +			i = eol;
> +			continue;
> +		}
> +		while (i < eol)
> +			if (!isspace(sb->buf[i++]))
> +				return 0;
> +	}
> +
> +	return 1;
> +}

I did not review the rest of the code closely yet...

All in all: well done!

Ciao,
Dscho

--8323584-252589586-1189096989=:28586--
