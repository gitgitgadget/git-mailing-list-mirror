From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 03/18] Add the basic data structure for line level history
Date: Thu, 5 Aug 2010 23:09:02 +0200
Message-ID: <201008052309.03193.trast@student.ethz.ch>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com> <1281024717-7855-4-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <Jens.Lehmann@web.de>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 23:09:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh7gn-00009I-RT
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 23:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933087Ab0HEVJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 17:09:12 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:31066 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932594Ab0HEVJG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 17:09:06 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 5 Aug
 2010 23:09:04 +0200
Received: from thomas.site (84.74.100.241) by CAS22.d.ethz.ch (172.31.51.112)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 5 Aug 2010 23:09:04
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <1281024717-7855-4-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152716>

Bo Yang wrote:
> 'struct diff_line_range' is the main data structure to keep
> track of the line ranges we are currently interested in. The
> user starts digging from a line range, and after examining the
> diff that affects that range by a commit, we can find a new
> range that corresponds to this range. So, we will associate this
> new range with the commit's parent commit.
> 
> There is one 'diff_line_range' for each file, and there are
> multiple 'struct range' in each 'diff_line_range'. In this way,
> we support multiple ranges.
> 
> Within 'struct range', there are multiple 'struct print_range'
> which represent a diff hunk.
> 
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>

> diff --git a/line.c b/line.c

Some error messages could be improved, e.g.

> +		if (obj->type != OBJ_COMMIT)
> +			die("Non commit %s?", revs->pending.objects[i].name);

"'%s' is not a commit"

> +		if (commit)
> +			die("More than one commit to dig from: %s and %s?",
> +			    revs->pending.objects[i].name,
> +				revs->pending.objects[found].name);

"You must specify exactly one starting commit for line history"

Showing two revisions from the command line is fairly arbitrary, what
if the user specified three?  It also results in such oddness as

  $ ./git-log next^@ -L 1,2 README
  fatal: More than one commit to dig from: next and next?

assuming the tip of 'next' is a merge.

> +	if (commit == NULL)
> +		die("No commit specified?");

"You must specify a starting commit for line history"

> +		if (get_tree_entry(commit->object.sha1, r->spec->path,
> +			sha1, &mode))
> +			goto error;
[...]
> +	return;
> +error:
> +	die("There is no path %s in the commit", r->spec->path);

Since die() never returns, you can move it in the place of the goto
and make Dijkstra happy.

> +/*
> + * copied from blame.c, indeed, we can even to use this to test
> + * whether line log works. :)
> + */
> +static const char *parse_loc(const char *spec, struct diff_filespec *file,
> +			     long lines, unsigned long *line_ends,
> +			     long begin, long *ret)

You immediately refactor this in the next commit, which is cute to
test the feature as indicated in the comment, but for a nicer series
please move the refactoring before this commit and just reuse the
code.

> +static void parse_range(long lines, unsigned long *line_ends,
> +		struct range *r, struct diff_filespec *spec)
> +{
> +	const char *term;
> +
> +	term = parse_loc(r->arg, spec, lines, line_ends, 1, &r->start);
> +	if (*term == ',') {
> +		term = parse_loc(term + 1, spec, lines, line_ends,
> +			r->start + 1, &r->end);
> +		if (*term) {
> +			die("-L parameter's argument should be <start>,<end>");

"-L argument must be <start>,<end>"

Though git-blame seems to imply ',$' if you do not give an end.  Any
particular reason why we do not want to be compatible with blame here?

> +	if (*term)
> +		die("-L parameter's argument should be <start>,<end>");

See above.

> +/*
> + * Insert a new line range into a diff_line_range struct, and keep the
> + * r->ranges sorted by their starting line number.
> + */
> +struct range *diff_line_range_insert(struct diff_line_range *r, const char *arg,
> +		int start, int end)

If I read the code correctly, it also ensures that no two ranges have
overlapping extents, i.e., it will merge them if they overlap.

Which leads to the question: is this a requirement for the users of
the data structure, or just an optimization?  If it's a requirement,
please put this in a comment somewhere.

> +	/*
> +	 * Note we support -M/-C to detect file rename
> +	 */
> +	opt->nr_paths = 0;

Do we? :-)

Out of curiosity: Without looking any further, I assume this disables
the path filtering stage that you had in early versions.  Did you
notice any speed hit or improvement by doing so?

> diff --git a/line.h b/line.h
[...]
> +struct range {
> +	const char *arg;	/* The argument to specify this line range */
> +	long start, end;	/* The start line number, inclusive */
> +	long pstart, pend;	/* The end line number, inclusive */

So 'end' is a start line number, and 'pstart' is an end line number?

You are using 'pstart' and 'pend' in other places in the header, too.
What do they mean?  In line.c I inferred ptwo was "previous two", but
here it seems to be "printing start"?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
