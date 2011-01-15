From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH 2/3] vcs-svn: Start working on the dumpfile producer
Date: Sat, 15 Jan 2011 08:39:25 +0100
Message-ID: <20110115073925.GA21744@m62s10.vlinux.de>
References: <1295074272-19559-1-git-send-email-artagnon@gmail.com>
 <1295074272-19559-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 15 08:40:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pe0k7-0002Gr-ML
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 08:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120Ab1AOHjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 02:39:33 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:45367 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750930Ab1AOHjc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 02:39:32 -0500
Received: (qmail invoked by alias); 15 Jan 2011 07:39:30 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp022) with SMTP; 15 Jan 2011 08:39:30 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19zdMFsOd5zHFUSsaoAH2UL7dKK39jqDdJZ7xff9M
	4GWne+8HW9o9sm
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 05C09D4004; Sat, 15 Jan 2011 08:39:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295074272-19559-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165142>

On Sat, Jan 15, 2011 at 12:21:11PM +0530, Ramkumar Ramachandra wrote:
> Start off with some broad design sketches. Compile succeeds, but
> parser is incorrect. Include a Makefile rule to build it into
> vcs-svn/lib.a.
> 
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Makefile              |    2 +-
>  vcs-svn/dump_export.c |   73 ++++++++++++
>  vcs-svn/svnload.c     |  294 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 368 insertions(+), 1 deletions(-)
>  create mode 100644 vcs-svn/dump_export.c
>  create mode 100644 vcs-svn/svnload.c
> 
...
> diff --git a/vcs-svn/svnload.c b/vcs-svn/svnload.c
> new file mode 100644
> index 0000000..7043ae7
> --- /dev/null
> +++ b/vcs-svn/svnload.c
> @@ -0,0 +1,294 @@
> +/*
> + * Produce a dumpfile v3 from a fast-import stream.
> + * Load the dump into the SVN repository with:
> + * svnrdump load <URL> <dumpfile
> + *
> + * Licensed under a two-clause BSD-style license.
> + * See LICENSE for details.
> + */
> +
> +#include "cache.h"
> +#include "git-compat-util.h"
> +#include "line_buffer.h"
> +#include "dump_export.h"
> +#include "strbuf.h"
> +
> +#define SVN_DATE_FORMAT "%Y-%m-%dT%H:%M:%S.000000Z"
> +#define SVN_DATE_LEN 28
> +#define LENGTH_UNKNOWN (~0)
> +
> +static struct line_buffer input = LINE_BUFFER_INIT;
> +static struct strbuf blobs[100];
> +	
> +static struct {
> +	unsigned long prop_len, text_len, copyfrom_rev, mark;
> +	int text_delta, prop_delta; /* Boolean */
> +	enum node_action action;
> +	enum node_kind kind;
> +	struct strbuf copyfrom_path, path;
> +} node_ctx;
> +
> +static struct {
> +	int rev, text_len;
> +	struct strbuf props, log;
> +	struct strbuf svn_author, author, committer;
> +	struct strbuf author_date, committer_date;
> +	struct strbuf author_email, committer_email;
> +} rev_ctx;
> +
> +static enum {
> +	UNKNOWN_CTX,
> +	COMMIT_CTX,
> +	BLOB_CTX
> +} active_ctx;
> +
> +static void reset_rev_ctx(int revision)
> +{
> +	rev_ctx.rev = revision;
> +	strbuf_reset(&rev_ctx.props);
> +	strbuf_reset(&rev_ctx.log);
> +	strbuf_reset(&rev_ctx.svn_author);
> +	strbuf_reset(&rev_ctx.author);
> +	strbuf_reset(&rev_ctx.committer);
> +	strbuf_reset(&rev_ctx.author_date);
> +	strbuf_reset(&rev_ctx.committer_date);
> +	strbuf_reset(&rev_ctx.author_email);
> +	strbuf_reset(&rev_ctx.committer_email);
> +}
> +
> +static void reset_node_ctx(void)
> +{
> +	node_ctx.prop_len = LENGTH_UNKNOWN;
> +	node_ctx.text_len = LENGTH_UNKNOWN;
> +	node_ctx.mark = 0;
> +	node_ctx.copyfrom_rev = 0;
> +	node_ctx.text_delta = -1;
> +	node_ctx.prop_delta = -1;
> +	strbuf_reset(&node_ctx.copyfrom_path);
> +	strbuf_reset(&node_ctx.path);
> +}
> +
> +static void populate_props(struct strbuf *props, const char *author,
> +			const char *log, const char *date) {
> +	strbuf_reset(props);	
> +	strbuf_addf(props, "K\nsvn:author\nV\n%s\n", author);
> +	strbuf_addf(props, "K\nsvn:log\nV\n%s", log);
> +	strbuf_addf(props, "K\nsvn:date\nV\n%s\n", date);
> +	strbuf_add(props, "PROPS-END\n", 10);
> +}
> +
> +static void parse_author_line(char *val, struct strbuf *name,
> +			struct strbuf *email, struct strbuf *date) {
> +	char *t, *tz_off;
> +	char time_buf[SVN_DATE_LEN];
> +	const struct tm *tm_time;
> +
> +	/* Simon Hausmann <shausman@trolltech.com> 1170199019 +0100 */
> +	strbuf_reset(name);
> +	strbuf_reset(email);
> +	strbuf_reset(date);
> +	tz_off = strrchr(val, ' ');
> +	*tz_off++ = '\0';
> +	t = strrchr(val, ' ');
> +	*(t - 1) = '\0'; /* Ignore '>' from email */
> +	t ++;
> +	tm_time = time_to_tm(strtoul(t, NULL, 10), atoi(tz_off));
> +	strftime(time_buf, SVN_DATE_LEN, SVN_DATE_FORMAT, tm_time);
> +	strbuf_add(date, time_buf, SVN_DATE_LEN);
> +	t = strchr(val, '<');
> +	*(t - 1) = '\0'; /* Ignore ' <' from email */
> +	t ++;
> +	strbuf_add(email, t, strlen(t));
> +	strbuf_add(name, val, strlen(val));
> +}
> +
> +void svnload_read(void) {
> +	char *t, *val;
> +	int mode_incr;
> +	struct strbuf *to_dump;
> +
> +	while ((t = buffer_read_line(&input))) {
> +		val = strchr(t, ' ');
> +		if (!val) {
> +			if (!memcmp(t, "blob", 4))
> +				active_ctx = BLOB_CTX;
> +			else if (!memcmp(t, "deleteall", 9))
> +				;
> +			continue;

Having actually no idea what the input you are reading from might look like, but
seeing those two memcmp compares above makes me wonder if 't' might ever be smaller
than 4 (or 9 for the else part). Which obviously would lead to a SEGFAULT. 
In the code below there are also memcmp class which might step out of the
buffer.

> +		}
> +		*val++ = '\0';
> +
> +		/* strlen(key) */
> +		switch (val - t - 1) {
> +		case 1:
> +			if (!memcmp(t, "D", 1)) {
> +				node_ctx.action = NODE_ACTION_DELETE;
> +			}
> +			else if (!memcmp(t, "C", 1)) {
> +				node_ctx.action = NODE_ACTION_ADD;
> +			}
> +			else if (!memcmp(t, "R", 1)) {
> +				node_ctx.action = NODE_ACTION_REPLACE;
> +			}
> +			else if (!memcmp(t, "M", 1)) {
> +				node_ctx.action = NODE_ACTION_CHANGE;
> +				mode_incr = 7;
> +				if (!memcmp(val, "100644", 6))
> +					node_ctx.kind = NODE_KIND_NORMAL;
> +				else if (!memcmp(val, "100755", 6))
> +					node_ctx.kind = NODE_KIND_EXECUTABLE;
> +				else if (!memcmp(val, "120000", 6))
> +					node_ctx.kind = NODE_KIND_SYMLINK;
> +				else if (!memcmp(val, "160000", 6))
> +					node_ctx.kind = NODE_KIND_GITLINK;
> +				else if (!memcmp(val, "040000", 6))
> +					node_ctx.kind = NODE_KIND_SUBDIR;
> +				else {
> +					if (!memcmp(val, "755", 3))
> +						node_ctx.kind = NODE_KIND_EXECUTABLE;
> +					else if(!memcmp(val, "644", 3))
> +						node_ctx.kind = NODE_KIND_NORMAL;
> +					else
> +						die("Unrecognized mode: %s", val);
> +					mode_incr = 4;
> +				}
> +				val += mode_incr;
> +				t = strchr(val, ' ');
> +				*t++ = '\0';
> +				strbuf_reset(&node_ctx.path);
> +				strbuf_add(&node_ctx.path, t, strlen(t));
> +				if (!memcmp(val + 1, "inline", 6))
> +					die("Unsupported dataref: inline");
> +				else if (*val == ':')
> +					to_dump = &blobs[strtoul(val + 1, NULL, 10)];
> +				else
> +					die("Unsupported dataref: sha1");
> +				dump_export_node(node_ctx.path.buf, node_ctx.kind,
> +						node_ctx.action, to_dump->len,
> +						0, NULL);
> +				printf("%s", to_dump->buf);
> +			}
> +			break;
> +		case 3:
> +			if (!memcmp(t, "tag", 3))
> +				continue;
> +			break;
> +		case 4:
> +			if (!memcmp(t, "mark", 4))
> +				switch(active_ctx) {
> +				case COMMIT_CTX:
> +					/* What do we do with commit marks? */
> +					continue;
> +				case BLOB_CTX:
> +					node_ctx.mark = strtoul(val + 1, NULL, 10);
> +					break;
> +				default:
> +					break;
> +				}
> +			else if (!memcmp(t, "from", 4))
> +				continue;
> +			else if (!memcmp(t, "data", 4)) {
> +				switch (active_ctx) {
> +				case COMMIT_CTX:
> +					strbuf_reset(&rev_ctx.log);
> +					buffer_read_binary(&input,
> +							&rev_ctx.log,
> +							strtoul(val, NULL, 10));
> +					populate_props(&rev_ctx.props,
> +						rev_ctx.svn_author.buf,
> +						rev_ctx.log.buf,
> +						rev_ctx.author_date.buf);
> +					dump_export_begin_rev(rev_ctx.rev,
> +							rev_ctx.props.buf,
> +							rev_ctx.props.len);
> +					break;
> +				case BLOB_CTX:
> +					node_ctx.text_len = strtoul(val, NULL, 10);
> +					buffer_read_binary(&input,
> +							&blobs[node_ctx.mark],
> +							node_ctx.text_len);
> +					break;
> +				default:
> +					break;
> +				}
> +			}
> +			break;
> +		case 5:
> +			if (!memcmp(t, "reset", 5))
> +				continue;
> +			if (!memcmp(t, "merge", 5))
> +				continue;
> +			break;
> +		case 6:
> +			if (!memcmp(t, "author", 6)) {
> +				parse_author_line(val, &rev_ctx.author,
> +						&rev_ctx.author_email,
> +						&rev_ctx.author_date);
> +				/* Build svn_author */
> +				t = strchr(rev_ctx.author_email.buf, '@');
> +				strbuf_reset(&rev_ctx.svn_author);
> +				strbuf_add(&rev_ctx.svn_author,
> +					rev_ctx.author_email.buf,
> +					t - rev_ctx.author_email.buf);
> +
> +			}
> +			else if (!memcmp(t, "commit", 6)) {
> +				rev_ctx.rev ++;
> +				active_ctx = COMMIT_CTX;
> +			}
> +			break;
> +		case 9:
> +			if (!memcmp(t, "committer", 9))
> +				parse_author_line(val, &rev_ctx.committer,
> +						&rev_ctx.committer_email,
> +						&rev_ctx.committer_date);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +int svnload_init(const char *filename)
> +{
> +	int i;
> +	if (buffer_init(&input, filename))
> +		return error("cannot open %s: %s", filename, strerror(errno));
> +	active_ctx = UNKNOWN_CTX;
> +	strbuf_init(&rev_ctx.props, MAX_GITSVN_LINE_LEN);
> +	strbuf_init(&rev_ctx.log, MAX_GITSVN_LINE_LEN);
> +	strbuf_init(&rev_ctx.author, MAX_GITSVN_LINE_LEN);
> +	strbuf_init(&rev_ctx.committer, MAX_GITSVN_LINE_LEN);
> +	strbuf_init(&rev_ctx.author_date, MAX_GITSVN_LINE_LEN);
> +	strbuf_init(&rev_ctx.committer_date, MAX_GITSVN_LINE_LEN);
> +	strbuf_init(&rev_ctx.author_email, MAX_GITSVN_LINE_LEN);
> +	strbuf_init(&rev_ctx.committer_email, MAX_GITSVN_LINE_LEN);
> +	strbuf_init(&node_ctx.path, MAX_GITSVN_LINE_LEN);
> +	strbuf_init(&node_ctx.copyfrom_path, MAX_GITSVN_LINE_LEN);
> +	for (i = 0; i < 100; i ++)
> +		strbuf_init(&blobs[i], 10000);
> +	return 0;
> +}
> +
> +void svnload_deinit(void)
> +{
> +	int i;
> +	reset_rev_ctx(0);
> +	reset_node_ctx();
> +	strbuf_release(&rev_ctx.props);
> +	strbuf_release(&rev_ctx.log);
> +	strbuf_release(&rev_ctx.author);
> +	strbuf_release(&rev_ctx.committer);
> +	strbuf_release(&rev_ctx.author_date);
> +	strbuf_release(&rev_ctx.committer_date);
> +	strbuf_release(&rev_ctx.author_email);
> +	strbuf_release(&rev_ctx.committer_email);
> +	strbuf_release(&node_ctx.path);
> +	strbuf_release(&node_ctx.copyfrom_path);
> +	for (i = 0; i < 100; i ++)
> +		strbuf_release(&blobs[i]);
> +	if (buffer_deinit(&input))
> +		fprintf(stderr, "Input error\n");
> +	if (ferror(stdout))
> +		fprintf(stderr, "Output error\n");
> +}
> -- 
> 1.7.4.rc1.7.g2cf08.dirty
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
