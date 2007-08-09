From: David Kastrup <dak@gnu.org>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 09 Aug 2007 20:06:40 +0200
Message-ID: <86abt0inv3.fsf@lola.quinscape.zz>
References: <20070809163026.GD568@mbox.bz> <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 20:07:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJCPY-0003nY-Ku
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 20:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbXHISG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 14:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbXHISG5
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 14:06:57 -0400
Received: from main.gmane.org ([80.91.229.2]:53882 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207AbXHISG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 14:06:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IJCPM-0007JJ-6P
	for git@vger.kernel.org; Thu, 09 Aug 2007 20:06:52 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 20:06:52 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 20:06:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:wlIhatsum0TU8YiaRLqSNLQH5lc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55466>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 9 Aug 2007, moe wrote:
>> 
>> i made some tests on latest master branch
>> (1.5.3.rc4.29.g74276) and it seems like git
>> hits a wall somewhere above ~50k files.
>
> Good catch. Definitely not acceptable performance.
>
> We seem to spend a lot of our time in memcpy:

[...]

> Doing an ltrace on it shows tons and tons of:
>
> 	...
> 	strlen("35")
> 	strlen("349")
> 	calloc(1, 72)
> 	memcpy(0x73034e, "10/", 3)
> 	memcpy(0x730351, "349", 4)
> 	memmove(0x2ab637f41e80, 0x2ab637f41e78, 781768)
> 	...
>
> but I haven't looked at where they come from yet.

Ok, preaching to the pope here, but: moving memory is bad.  Make sure
data can stay where it starts.  In particular: don't use realloc.  And
if you do, grow the size _exponentially_ (like a factor of 1.5).  If
you grow the size exponentially, at least the movery hits the
algorithm with O(n lg n).  If data stays put, even in badly scattered
linear lists, we have O(n).  If you grow realloc _linearly_ (constant
size increment), then the algorithm is hit with O(n^2).

Technically, basically _all_ operations of git can be done by doing
list merges of presorted lists.  The index can be kept sorted.  All
requests into the index can be collected in readdir order into one
linear list, this gets sorted once using a merge sort with O(n lg n),
then it gets merged with the index O(n+N).  As long as the whole index
is read in, it can't be done faster.  It is not necessary to organize
the read data into trees or more complicate structures: a single
linear list is sufficient.  One can use the hierarchical structure of
a directory to shave off some part of the sorting cost, though, and it
considerably will lessen memory impact (and copying costs) if a
file/directory/tree entry can contain a relative file name and a
"pointer to prefix" where the rest of the file path is to be found.

Anyway, so much for some theory.  Now let's look at bad points in the
code, judging from your benchmarks.

A grep for realloc is appaling.  Let's see what is actually involved
here.

attr.c:

struct git_attr *git_attr(const char *name, int len)
{

	a->attr_nr = attr_nr++;
	git_attr_hash[pos] = a;

	check_all_attr = xrealloc(check_all_attr,
				  sizeof(*check_all_attr) * attr_nr);

[...]

Full O(n^2) behavior of the worst kind (increment 1!).

builtin-commit-tree.c:

static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
{
	size = *sizep;
	newsize = size + len + 1;
	alloc = (size + 32767) & ~32767;

[size rounded to next 32k (inconsistent! needs to be size+1 rounded up)]

	buf = *bufp;
	if (newsize > alloc) {
		alloc = (newsize + 32767) & ~32767;

[newsize rounded to next 32k]

		buf = xrealloc(buf, alloc);

[O(n^2): constant increment.  Important?  No idea.]

		*bufp = buf;
	}
	*sizep = newsize - 1;

	memcpy(buf + size, one_line, len);
}

[...]

int register_commit_graft(struct commit_graft *graft, int ignore_dups)
{

[...]
	if (commit_graft_alloc <= ++commit_graft_nr) {
		commit_graft_alloc = alloc_nr(commit_graft_alloc);
		commit_graft = xrealloc(commit_graft,
					sizeof(*commit_graft) *
					commit_graft_alloc);
	}
	if (pos < commit_graft_nr)
		memmove(commit_graft + pos + 1,
			commit_graft + pos,
			(commit_graft_nr - pos - 1) *
			sizeof(*commit_graft));
	commit_graft[pos] = graft;
	return 0;
}

Eeek.  Start with a linear list, not an array.

objects.c:


void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode)
{
	unsigned nr = array->nr;
	unsigned alloc = array->alloc;
	struct object_array_entry *objects = array->objects;

	if (nr >= alloc) {
		alloc = (alloc + 32) * 2;
		objects = xrealloc(objects, alloc * sizeof(*objects));
		array->alloc = alloc;

Constant increment, O(n^2).

pathlist.c:

static int add_entry(struct path_list *list, const char *path)
{
	int exact_match;
	int index = get_entry_index(list, path, &exact_match);

	if (exact_match)
		return -1 - index;

	if (list->nr + 1 >= list->alloc) {
		list->alloc += 32;
		list->items = xrealloc(list->items, list->alloc
				* sizeof(struct path_list_item));
	}

Constant increment, O(n^2).

That's just a cursory examination.  In my opinion, pretty much every
realloc should be replaced by some sort of list structure.  That would
be the nicest thing.  I have sped up some awk scripts that built up
argument lists by a factor of 100 by replacing
a[index] = a[index] " " thenewstuff
with
a[index,nr[index]++] = thenewstuff
and then never concatenating the strings, but just outputting them in
a loop.


Anyway, short of that, don't realloc by fixed increments, always use
alloc_nr as soon as multiple reallocs are to be expected.

And they certainly are in some of the above cited code passages.

-- 
David Kastrup
