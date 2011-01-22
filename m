From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] vcs-svn: Start working on the dumpfile producer
Date: Fri, 21 Jan 2011 16:30:18 -0800
Message-ID: <7v39olok4l.fsf@alter.siamese.dyndns.org>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
 <1295415899-1192-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 22 01:30:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgRNJ-0000ae-9H
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 01:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016Ab1AVAaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 19:30:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933Ab1AVAae (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 19:30:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 181203EA5;
	Fri, 21 Jan 2011 19:31:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=tCD+i7LdlCTBFOWeR909K+CcJj4=; b=KKFAILLmnWCqxv0PLss11e6
	OyD5pnWEEY3d++P0P59ElJq8QO41E1I/N8fI/gpI3WQ2/Tda0q/3dUHxqc1jTBY3
	vb5YGim+WGnadL9o4pJeIYJ7L0P6ecNi/xGAcd/atrRSAYOxCS89w0BomqAAsV+x
	r6deRqg/mhg+N4YD/h70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=CTPYjiZtOU5buFMvvyHQngm8QVq8ssN6V2+W1voAiaEncaTcO
	Ex+8EXAwpG/eXb5kkfBCk8BonIz3UE61AdVax4BLWlhmwGASF83pzIeZAbP/XzaQ
	diLu23/mZYXmqzCKGAw6ob4mBEdK+hZMKPJiqBRPmWGD9KPxf1c9S3I0Tk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B9E643EA4;
	Fri, 21 Jan 2011 19:31:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B94833EA3; Fri, 21 Jan 2011
 19:31:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EAF7B3EE-25BE-11E0-BF00-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165403>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Start off with some broad design sketches. Compile succeeds, but
> parser is incorrect. Include a Makefile rule to build it into
> vcs-svn/lib.a.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

I initially thought I should refrain from doing a usual picky review for
contrib/ material, but realized this does not go to contrib/, so...

> diff --git a/vcs-svn/dump_export.c b/vcs-svn/dump_export.c
> new file mode 100644
> index 0000000..04ede06
> --- /dev/null
> +++ b/vcs-svn/dump_export.c
> @@ -0,0 +1,73 @@
> +/*
> + * Licensed under a two-clause BSD-style license.
> + * See LICENSE for details.
> + */
> +
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +#include "line_buffer.h"
> +#include "dump_export.h"
> +
> +void dump_export_begin_rev(int revision, const char *revprops,
> +			int prop_len) {

Style. "{" at the beginning of the next line (same everywhere).

> +void dump_export_node(const char *path, enum node_kind kind,
> +		enum node_action action, unsigned long text_len,
> +		unsigned long copyfrom_rev, const char *copyfrom_path) {
> +	printf("Node-path: %s\n", path);
> +	printf("Node-kind: ");
> +	switch (action) {
> +	case NODE_KIND_NORMAL:
> +		printf("file\n");
> +		break;
> +	case NODE_KIND_EXECUTABLE:
> +		printf("file\n");
> +		break;
> +	case NODE_KIND_SYMLINK:
> +		printf("file\n");
> +		break;
> +	case NODE_KIND_GITLINK:
> +		printf("file\n");
> +		break;
> +	case NODE_KIND_SUBDIR:
> +		die("Unsupported: subdirectory");
> +	default:
> +		break;
> +	}

Hmph, is it expected that the repertoire of node-kind stay the same, or
will it be extended over time?  It might make sense to change the above
switch a more table-driven one.  The same for node-action that follows
this part of the code.

> diff --git a/vcs-svn/svnload.c b/vcs-svn/svnload.c
> new file mode 100644
> index 0000000..7043ae7
> --- /dev/null
> +++ b/vcs-svn/svnload.c
> @@ -0,0 +1,294 @@
> ...
> +#define SVN_DATE_FORMAT "%Y-%m-%dT%H:%M:%S.000000Z"
> +#define SVN_DATE_LEN 28
> +#define LENGTH_UNKNOWN (~0)
> +
> +static struct line_buffer input = LINE_BUFFER_INIT;
> +static struct strbuf blobs[100];
> +	

Is there a rationale for "100", or is it just a random number that can be
tweakable at the source level?  Would we want to have a symbolic constant
for it?

The "blank" line has a trailing whitespace.

> +static struct {
> +	unsigned long prop_len, text_len, copyfrom_rev, mark;
> +	int text_delta, prop_delta; /* Boolean */
> +	enum node_action action;
> +	enum node_kind kind;
> +	struct strbuf copyfrom_path, path;
> +} node_ctx;
> + ...
> +static void reset_node_ctx(void)
> +{
> +	node_ctx.prop_len = LENGTH_UNKNOWN;
> +	node_ctx.text_len = LENGTH_UNKNOWN;
> +	node_ctx.mark = 0;
> +	node_ctx.copyfrom_rev = 0;
> +	node_ctx.text_delta = -1;
> +	node_ctx.prop_delta = -1;

Does your "Boolean" type take values 0 or -1?  Or is it perhaps a tristate
false=0, true=1, unknown=-1?  If so, the comment on the type above needs
to be fixed.

> +	strbuf_reset(&node_ctx.copyfrom_path);
> +	strbuf_reset(&node_ctx.path);
> +}
> +
> +static void populate_props(struct strbuf *props, const char *author,
> +			const char *log, const char *date) {

Style on "{" (look everywhere).

> +	strbuf_reset(props);	

Trailing whitespace.

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

Unwanted SP before "++" (look everywhere).

> +	tm_time = time_to_tm(strtoul(t, NULL, 10), atoi(tz_off));

Has your caller already verified tz_off is a reasonable integer?

> +void svnload_read(void) {
> ...
> +		switch (val - t - 1) {
> +		case 1:
> +			if (!memcmp(t, "D", 1)) {
> +				node_ctx.action = NODE_ACTION_DELETE;
> +			}
> +			else if (!memcmp(t, "C", 1)) {

Style: "} else if (...) {".

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

Is <mode> guaranteed to be a 6-digit octal, padded with 0 to the left?

The manual page of git-fast-import seems to hint that is the case, but I
am double checking, as the leading zero is an error in the tree object.

> +					node_ctx.kind = NODE_KIND_SUBDIR;
> +				else {
> +					if (!memcmp(val, "755", 3))
> +						node_ctx.kind = NODE_KIND_EXECUTABLE;
> +					else if(!memcmp(val, "644", 3))

Style; missing SP after "if/switch" (look everywhere).

> +						node_ctx.kind = NODE_KIND_NORMAL;
> +					else
> +						die("Unrecognized mode: %s", val);
> +					mode_incr = 4;
> +				}
> +				val += mode_incr;

Hmm, this whole thing is ugly.

Perhaps a table-lookup, or at least a helper function that translates
"val" to node-kind (while advancing val as the side effect) may make it
easier to read?

> +				t = strchr(val, ' ');
> +				*t++ = '\0';
> +				strbuf_reset(&node_ctx.path);
> +				strbuf_add(&node_ctx.path, t, strlen(t));
> +				if (!memcmp(val + 1, "inline", 6))
> +					die("Unsupported dataref: inline");
> +				else if (*val == ':')
> +					to_dump = &blobs[strtoul(val + 1, NULL, 10)];

Has anybody so far verified the decimal number at (val+1) is a reasonable
value, or am I seeing a future CVE here?

Do we care what follows the len of digits on this line?  Does a line in G-F-I
stream allow trailing garbage (this question is not limited to this part
of the code)?
> +int svnload_init(const char *filename)
> +{
> +	int i;
> +	if (buffer_init(&input, filename))
> +		return error("cannot open %s: %s", filename, strerror(errno));
> +	active_ctx = UNKNOWN_CTX;
> +	strbuf_init(&rev_ctx.props, MAX_GITSVN_LINE_LEN);
> +	...
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
> +	...
> +	strbuf_release(&node_ctx.copyfrom_path);
> +	for (i = 0; i < 100; i ++)
> +		strbuf_release(&blobs[i]);
> +	if (buffer_deinit(&input))
> +		fprintf(stderr, "Input error\n");
> +	if (ferror(stdout))
> +		fprintf(stderr, "Output error\n");
> +}

Whoever needs to add an element to rev_ctx must consistently touch reset,
init and deinit.  Would it help him/her if you moved the code so that
these functions are close together from the beginning?
