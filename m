From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin commands.
Date: Sat, 3 Nov 2007 13:56:24 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711031328500.4362@racer.site>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
 <1194017589-4669-2-git-send-email-krh@redhat.com>
 <1194017589-4669-3-git-send-email-krh@redhat.com>
 <1194017589-4669-4-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-922341384-1194097136=:4362"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 14:57:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoJVA-0003Fp-N6
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 14:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbXKCN5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 09:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbXKCN5M
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 09:57:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:38348 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753999AbXKCN5L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 09:57:11 -0400
Received: (qmail invoked by alias); 03 Nov 2007 13:57:10 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp043) with SMTP; 03 Nov 2007 14:57:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+H0qwCDQyHRtl7SzSrnU3ec95PtQwkyqsigpqalJ
	Z06sj4sjZ8ncjE
X-X-Sender: gene099@racer.site
In-Reply-To: <1194017589-4669-4-git-send-email-krh@redhat.com>
Content-ID: <Pine.LNX.4.64.0711031339060.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63270>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-922341384-1194097136=:4362
Content-Type: TEXT/PLAIN; CHARSET=utf-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0711031339061.4362@racer.site>

Hi,

On Fri, 2 Nov 2007, Kristian Høgsberg wrote:

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
> +		add_files_to_cache(verbose, NULL, files);
> +		if (write_cache(fd, active_cache, active_nr) || close(fd))
> +			die("unable to write new_index file");
> +		return lock_file.filename;
> +	} else if (also) {
> +		add_files_to_cache(verbose, prefix, files);
> +		if (write_cache(fd, active_cache, active_nr) || close(fd))
> +			die("unable to write new_index file");
> +		return lock_file.filename;
> +	}

Unless something slips by my mind, this could be written as

	if (all || also) {
		add_files_to_cache(verbose, also ? prefix : NULL, files);
		...
	}

> +
> +	if (interactive)
> +		interactive_add();
> +
> +	if (*files == NULL) {
> +		/* Commit index as-is. */
> +		rollback_lock_file(&lock_file);
> +		return get_index_file();
> +	}

Would an interactive add not conflict with this rollback?  And indeed with 
the locked index to begin with?

> +	/* update the user index file */
> +	add_files_to_cache(verbose, prefix, files);
> +	if (write_cache(fd, active_cache, active_nr) || close(fd))
> +		die("unable to write new_index file");

Does that mean that the index is _always_ written?  Even when not 
specifying and paths on the command line?

> +	/* Uh oh, abusing lock_file to create a garbage collected file */

It's not that bad.  But I would mention that it is a temporary index which 
you are building.

> +static const char sign_off_header[] = "Signed-off-by: ";

Funny, I thought it was a footer ;-)

> +	} else if (!stat(template_file, &statbuf)) {

Should this not test "if (template_file && " first?

> +/* Find out if the message starting at position 'start' in the strbuf
> + * contains only whitespace and Signed-off-by lines. */
> +static int message_is_empty(struct strbuf *sb, int start)
> +{
> +	struct strbuf tmpl;
> +	const char *nl;
> +	int eol, i;
> +
> +	/* See if the template is just a prefix of the message. */
> +	strbuf_init(&tmpl, 0);
> +	if (template_file && strbuf_read_file(&tmpl, template_file, 0) > 0) {
> +		stripspace(&tmpl, 1);
> +		if (start + tmpl.len <= sb->len &&
> +		    memcmp(tmpl.buf, sb->buf + start, tmpl.len) == 0)
> +			start += tmpl.len;
> +	}
> +	strbuf_release(&tmpl);

The release could go inside the if block, no?

> +static int run_hook(const char *index_file, const char *name, const char *arg)

Would this function not prefer to live in run-command.c?

> +{
> +	struct child_process hook;
> +	const char *argv[3], *env[2];
> +	char index[PATH_MAX];
> +
> +	argv[0] = git_path("hooks/%s", name);
> +	argv[1] = arg;
> +	argv[2] = NULL;
> +	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
> +	env[0] = index;
> +	env[1] = NULL;
> +
> +	if (access(argv[0], X_OK) < 0)
> +		return 0;

That check logically belongs 6 lines higher...

> +	rev.abbrev = 0;
> +	rev.diff = 1;
> +	rev.diffopt.output_format =
> +		DIFF_FORMAT_SHORTSTAT | DIFF_FORMAT_SUMMARY;
> +
> +	rev.verbose_header = 1;
> +	rev.show_root_diff = 1;
> +	rev.commit_format = get_commit_format("format:%h: %s");

That's interesting.  Wouldn't have thought of that.  Reusing the log_tree 
machinery to output the summary.  Cute.

Note that one relatively low-hanging fruit will be to teach builtin-commit 
to use a cheaper "no changes?" check when no_edit = 1.

Thanks,
Dscho

--8323584-922341384-1194097136=:4362--
