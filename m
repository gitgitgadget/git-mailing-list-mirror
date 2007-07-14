From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Sat, 14 Jul 2007 13:49:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707141140510.14781@racer.site>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671631635-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jul 14 14:50:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9h4o-0004Dc-2I
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 14:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbXGNMuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 08:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbXGNMuO
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 08:50:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:41817 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751526AbXGNMuM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 08:50:12 -0400
Received: (qmail invoked by alias); 14 Jul 2007 12:50:08 -0000
Received: from R063a.r.pppool.de (EHLO noname) [89.54.6.58]
  by mail.gmx.net (mp046) with SMTP; 14 Jul 2007 14:50:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Ou3MoX4BOr7l02kYuSsKoqTU/+bWeUwrinTL4w/
	RMuHXRWgyiTsJK
X-X-Sender: gene099@racer.site
In-Reply-To: <11842671631635-git-send-email-skimo@liacs.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52476>

Hi,

On Thu, 12 Jul 2007, skimo@liacs.nl wrote:

> +SYNOPSIS
> +--------
> +'git-rewrite-commits' [--index-filter <command>] [--commit-filter <command>]
> +	[<rev-list options>...]

--write-sha1-mappings is missing.

> +Filters
> +~~~~~~~
> +
> +The filters are applied in the order as listed below.  The <command>
> +argument is run as "sh -c '<command'>", with the $GIT_COMMIT
> +environment variable set to the commit that is being rewritten.
> +If any call to a filter fails, then git-rewrite-commits will abort.

Here you should note that a couple of helper functions are defined for 
ease of use.

> +--write-sha1-mapping
> +	Write mapping of old SHA1s to new SHA1s for use in filters.

Where?  How to use it?

> +<rev-list-options>::
> +	Selects the commits to be rewritten, defaulting to the history
> +	that lead to HEAD.

s/the history that lead to HEAD/the current branch/

> +Examples
> +--------
> +
> +Suppose you want to remove a file (containing confidential information
> +or copyright violation) from all commits:
> +
> +----------------------------------------------------------------------------
> +git rewrite-commits --index-filter 'git update-index --remove filename || :'

We seem to prefer "$ git" instead of just "git" in the other man pages' 
examples.

> +----------------------------------------------------------------------------
> +
> +Now, you will get the rewritten history saved in your current branch
> +(the old branch is saved in refs/original).

						The "|| :" construct 
+ prevents the filter to fail when the given file was not present in the 
+ index.

> +To move the whole tree into a subdirectory, or remove it from there:
> +
> +---------------------------------------------------------------
> +git rewrite-commits --index-filter \
> +	'git ls-files -s | sed "s-\t-&newsubdir/-" |
> +		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
> +			git update-index --index-info &&
> +	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE'
> +---------------------------------------------------------------

I imagine that this should be replaced (later! in a different patch!) by 
either --subdir-filter, or by a shell helper function.

> +#include "grep.h"

I did not compile test, but do you really need that?

> +struct decoration rewrite_decoration = { "rewritten as" };
> [...]
> +
> +struct rewrite_decoration {
> +	struct rewrite_decoration *next;
> +	unsigned char sha1[20];
> +};

I wonder why you give the instance of a "struct decoration" the same name 
as that of a _different_ struct. IOW it is confusing that there is a 
"struct rewrite_decoration", but the variable "rewrite_decoration" is no 
instance of that struct.

> +static void add_rewrite_decoration(struct object *obj, unsigned char *sha1)

Why "struct object *"?  You only rewrite commits.  Which makes me suspect 
that your "struct rewrite_decoration" should be a "struct commit_list" to 
begin with.

> +static char *add_parents(char *dest, struct commit_list *parents)

Since one commit can be rewritten to multiple commits now, you do not know 
how much space you need to add the parents.  Thus you should take a buf_p 
and a space_p, and use ALLOC_GROW() to grow the buffer as needed.

> +static int skip_one_line(char **buf_p, unsigned long *len_p)

Better rename get_one_line to get_line_length and export it, avoiding code 
duplication.  I have an upcoming patch series adding commit notes, which 
has that patch.

Besides, you do not _skip_ that line.  You use the line, but advance 
*buf_p before doing so.

> +static char *filter_index(char *orig_hex, struct commit *commit)

const char *, in both cases.  You do not plan to modify orig_hex, and you 
return a sha1_to_hex() buffer, which you also do not plan to modify.

> +{
> +	int argc;
> +	const char *argv[10];
> +	static char index_env[16+PATH_MAX];

Style: "16 + PATH_MAX".  That happens elsewhere, too.

> +/* Replace any (short) sha1 of a rewritten commit by the new (short) sha1 */
> +static char *rewrite_body(char *dest, unsigned long len, char *buf)
> +{
> +	unsigned char sha1[20];
> +
> +	while (len) {
> +		size_t ll = non_hex_len(buf, len);
> +		memcpy(dest, buf, ll);
> +		dest += ll;
> +		buf += ll;
> +		len -= ll;

Why not make it simpler?

		while (!ishex(buf[i]))
			dest[i] = buf[i++];

> +		ll = hex_len(buf, len);

It is really shorter (because you spare the whole hex_len() function, to 
say

		for (ll = 0; i + ll < len && ishex(buf[i + ll]); ll++)
			; /* do nothing */

> +		if (ll >= 8 && ll <= 40 &&

AFAICT our abbreviation allows for 4 characters and up.  Default 
abbreviation is 7, IIRC.

> +		    !get_short_sha1(buf, ll, sha1, 1) &&
> +		    !get_rewritten_sha1(sha1))
> +			memcpy(dest, sha1_to_hex(sha1), ll);
> +		else
> +			memcpy(dest, buf, ll);

What do you do if the rewritten sha1, truncated to ll characters, is 
ambiguous?  Wouldn't you need more than

> +static int is_ref_to_be_rewritten(const char *ref)
> +{
> +	unsigned char sha1[20];
> +	int flag;
> +
> +	if (prefixcmp(ref, "refs/"))
> +		return 0;
> +	if (!prefixcmp(ref, "refs/remotes/"))
> +		return 0;
> +	if (!prefixcmp(ref+5, original_prefix))

Should original_prefix not be "refs/original", then?

> +static int is_pruned(struct commit *commit, int path_pruning)
> +{
> +	if (commit->object.flags & PRUNED)
> +		return 1;

Hmm.  I thought about changing get_revision_1() to mark that commit as 
uninteresting, since the parents were already added.  But I guess this has 
too much side effect potential.

In any case, I think that "NO_MATCH" would be a more descriptive name.

> +	if (path_pruning &&
> +	    !(commit->object.flags & (TREECHANGE | UNINTERESTING)))
> +		return 1;

Why only with "path_pruning"?  Ah yes.  Because otherwise, you would 
assume "A" in "A..B" to be pruned.  But what do you do if someone says

	git rewrite-commits A.. x/y

because she wants _only_ commits later than A rewritten, but everything 
from A backwards kept as-is?

If I understand your code correctly, the given command would cut off the 
history at A.

I wonder why you bother at all: my impression was that the revisions you 
want to filter out here were already filtered out by 
revision.c:rewrite_parents()...

> +static void rewrite_sha1(struct object *obj, unsigned char *new_sha1)
> +{
> +	if (!hashcmp(obj->sha1, new_sha1))
> +		return;
> +
> +	add_rewrite_decoration(obj, new_sha1);

This is not so much "rewrite_sha1", as "append_rewritten_sha1", right?

> +/*
> + * Replace any parent that has been removed by its parents
> + * and return the number of new parents.
> + * We directly modify the parent list, so any libification
> + * should probably adapt this function.

I do not think that this code will be libified any time soon.

> +static int rewrite_parents(struct commit *commit, int path_pruning)

Of course, you could always pass a "struct commit_list 
**rewritten_parents_p" to this function.

> +		get_rewritten_sha1(sha1);
> +		if (!is_null_sha1(sha1)) {
> +			hashclr(sha1);
> +			rewrite_sha1(&list->item->object, sha1);

I guess you'll admit that it is unintuitive to read 
"get_rewritten_sha1(sha1); rewrite_sha1(o, sha1);".  I thought: "What?  
Again?"  IMHO that is a strong hint that "rewrite_sha1" is not an apt name 
for that function.

> +static int rewrite_ref(const char *refname, const unsigned char *sha1,
> +			int flags, void *cb_data)
> +{
> +	int prefix_len;
> +	int len;
> +	char buffer[256], *p;
> +	struct object *obj = parse_object(sha1);
> +	unsigned char new_sha1[20];
> +	struct commit *commit;
> +	int pruned;
> +
> +	if (!obj)
> +		return 0;
> +	if (obj->type == OBJ_TAG)

Speaking of tags...  We will have to add (in a separate patch, to keep 
things reviewable) a method to rewrite them, too.

> +	if (!is_ref_to_be_rewritten(refname))
> +		return 0;

Hmm.  When looking at that code, I wonder if

	git rewrite-commits A..B

will rewrite C, too, if it happens to lie in A..B.  That would be not 
brilliant.

I guess you will need to copy the positive refs in revs->pending, if there 
are any, and later _not_ call for_each_ref if that list was empty.

> +	commit = lookup_commit_reference(sha1);
> +	pruned = is_pruned(commit, !!cb_data);
> +
> +	hashcpy(new_sha1, sha1);
> +	if (!pruned && get_rewritten_sha1(new_sha1))
> +		return 0;

So if pruned == 1, you _do_ rewrite it?  I'm not quite sure.  Care to 
explain?

> +static void filter_and_write_commit(char *commit_body, size_t len,
> +				    struct commit *commit, unsigned char *sha1)
> +{
> +	char commit_path[PATH_MAX];
> +	struct child_process cmd;
> +	int argc;
> +	const char *argv[10];
> +	int fd;
> +	const char *env[] = { commit_env, NULL };
> +	char hex[41];
> +	struct commit_list *list = NULL, **end = &list;
> +
> +	memcpy(commit_env+sizeof(commit_env)-41,
> +		sha1_to_hex(commit->object.sha1), 40);
> +
> +	fd = git_mkstemp(commit_path, sizeof(commit_path), ".commit_XXXXXX");;
> +	write_or_die(fd, commit_body, len);
> +
> +	argc = 0;
> +	argv[argc++] = "sh";
> +	argv[argc++] = "-c";
> +	argv[argc++] = commit_filter;
> +	argv[argc] = NULL;
> +	memset(&cmd, 0, sizeof(cmd));
> +	cmd.in = open(commit_path, O_RDONLY);
> +	if (cmd.in < 0)
> +		die("Unable to read commit from file '%s'", commit_path);
> +	unlink(commit_path);

This will fail on Windows.  You do not catch that error, so it is almost 
fine: just put the file into rewrite_dir, so the leftovers will be removed 
later anyway.

> +		hashclr(sha1);
> +		commit->object.flags |= PRUNED;
> +		/*
> +		 * If the filter returns two or more commits,
> +		 * we consider the original commit to have been
> +		 * removed and put the list in the old commit's
> +		 * parent list so that all the old commit's children
> +		 * will copy them.
> +		 */
> +		if (list) {
> +			free_commit_list(commit->parents);
> +			commit->parents = list;
> +		} else
> +		    add_sha1_map(commit->object.sha1, NULL);

That is almost certainly wrong.  If you step away from the notion that 
get_rewritten_sha1() returns _one_ SHA-1, all will become clearer.  And 
the filters should know about them SHA-1s, too.

> +	/* Make enough remove for n (possibly extra) parents */
> +	p = buf = xmalloc(orig_len + n*48);

As stated above, I'd prefer ALLOC_GROW().

> +	p = rewrite_header(p, &orig_len, &orig_buf, commit);
> +	p = rewrite_body(p, orig_len, orig_buf);
> +	if (!commit_filter) {
> +		if (write_sha1_file(buf, p-buf, commit_type, sha1))
> +			die("Unable to write new commit");
> +		add_sha1_map(commit->object.sha1, sha1);
> +	} else
> +		filter_and_write_commit(buf, p-buf, commit, sha1);
> +	free(buf);

You can really discard the commit->buffer, too, no?

> +
> +	rewrite_sha1(&commit->object, sha1);
> +}

> +static char aux_functions[] =
> +"export GIT_REWRITE_DIR=`pwd`\n"

Better put the correct absolute path there.

> +"commit()\n"
> +"{\n"
> +"	git-hash-object -w -t commit --stdin\n"
> +"}\n"
> +"map()\n"
> +"{\n"
> +"	# if it was not rewritten, take the original\n"
> +"	if test -r \"$GIT_REWRITE_DIR/map/$1\"\n"
> +"	then\n"
> +"		cat \"$GIT_REWRITE_DIR/map/$1\"\n"
> +"	else\n"
> +"		echo \"$1\"\n"
> +"	fi\n"
> +"}\n"
> +"cd t\n";

Then you do not need this extra fork() and cd all the time the filters 
source the helper file.

You do not even need the one static global buffer, if you put that script 
into the function writing it, inside an fprintf() call.

> +static char filter_prefix[] = ". aux;";

And here, I'd put the absolute path, too.

> +static char *create_filter(const char *command)
> +{
> +	int prefix_len = sizeof(filter_prefix)-1;
> +	int command_len = strlen(command);
> +	char *filter = xmalloc(prefix_len + command_len + 1);
> +
> +	memcpy(filter, filter_prefix, prefix_len);
> +	memcpy(filter+prefix_len, command, command_len+1);
> +	return filter;
> +}

I really like that approach.  This makes it so much more convenient for 
users.

> +static void setup_temp_dir()
> +{
> +	int aux;
> +
> +	absolute_git_dir = create_absolute_path(get_git_dir());
> +	setenv(GIT_DIR_ENVIRONMENT, absolute_git_dir, 1);
> +
> +	if (!rewrite_dir) {
> +		rewrite_dir = xstrdup(git_path("rewrite"));

I might read the code wrong, but this does not guarantee that rewrite_dir 
is an absolute path, right?

> +	if (mkdir(mkpath("%s/map", rewrite_dir), 0777))
> +		die("unable to create map directory '%s/map'", rewrite_dir);

Maybe make this dependent on --write-sha1-mappings, and have a check in 
"map ()"?

> +	if (index_filter || commit_filter)
> +		setup_temp_dir();
> +	else
> +		/* They'll never know.  BWUHAHA */
> +		write_sha1_mapping = 0;

I like the comment ;-)

> +	prepare_revision_walk(&rev);
> +	while ((commit = get_revision(&rev)) != NULL) {
> +		rewrite_commit(commit, !!rev.prune_fn);
> +	}

Please lose the curly brackets for single lines; otherwise it would look 
too perl like.

> +	rm_rf(git_path("refs/%s", original_prefix));

Would it not be better to move refs/original to refs/original/original?

Pooh.  A lot of comments.  Please take that as a sign that I am interested 
in rewrite-commits.  BTW did I mention already that I like the name 
"rewrite-commits"?

Ciao,
Dscho
