From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 00/13] Build in merge
Date: Sat, 21 Jun 2008 19:00:45 +0200
Message-ID: <cover.1214066798.git.vmiklos@frugalware.org>
References: <7vr6arazp9.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 19:02:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA6TS-0000Zo-BG
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 19:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbYFURBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 13:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbYFURBA
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 13:01:00 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:33718 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbYFURAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 13:00:52 -0400
Received: from vmobile.example.net (dsl5402CEE1.pool.t-online.hu [84.2.206.225])
	by yugo.frugalware.org (Postfix) with ESMTP id 88FF11DDC5C;
	Sat, 21 Jun 2008 19:00:49 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D1E0818E0E6; Sat, 21 Jun 2008 19:00:50 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <7vr6arazp9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85720>

On Sat, Jun 21, 2008 at 02:45:38AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>
> > +struct commit_list *filter_independent(unsigned char *head,
> > +   struct commit_list *heads)
> > +{
> > +   struct commit_list *b, *i, *j, *k, *bases = NULL, *ret = NULL;
> > +   struct commit_list **pptr = &ret;
> > +
> > +   commit_list_insert(lookup_commit(head), &heads);
>
> Isn't the special casing of head making this function less easier to
> reuse in other contexts?  "show-branch --independent" is about getting
> N commits and removing commits from that set that can be reachable
> from another commit, so there is no need nor reason to treat one
> "head" in any special way.

Yes, sure. It originally it was in builtin-merge.c and _there_ it was
easier this way but in commit.c this should be generalized.

> > +   for (i = heads; i; i = i->next) {
> > +           for (j = heads; j; j = j->next) {
> > +                   if (i == j)
> > +                           continue;
> > +                   b = get_merge_bases(i->item, j->item, 1);
> > +                   for (k = b; k; k = k->next)
> > +                           commit_list_insert(k->item, &bases);
> > +           }
> > +   }
>
> You run (N-1)*N merge-base computation to get all pairwise merge-bases
> here.  As merge-base(A,B) == merge-base(B,A), this is computing the
> same
> thing twice.
>
> Isn't your "b" leaking?
>
> > +   for (i = heads; i; i = i->next) {
> > +           int found = 0;
> > +           for (b = bases; b; b = b->next) {
> > +                   if (!hashcmp(i->item->object.sha1, b->item->object.sha1)) {
> > +                           found = 1;
>
> Then you see if the given heads exactly match one of the merge bases
> you
> found earlier.  But does this have to be in a separate pass?
>
> Isn't your "bases" list leaking?
>
> Even though you may be able to reduce more than 25 heads, you run N^2
> merge base traversals, which means 625 merge base traversals for 25
> heads;
> show-branch engine can do the same thing with a single traversal.
>
> Can't we do better than O(N^2)?

Right, actually my primary target was to achieve the right behaviour and
I did not care enough about performance and memory leaks, my bad.

> Let's step back a bit and think.  You have N commits (stop thinking
> about "my head and N other heads" like your function signature
> suggests).  For each one, you would want to see if it is reachable
> from any of the other (N-1) commits, and if so, you would exclude it
> from the resulting set.  And you do that for all N commits and you are
> done.  You can relatively easily do this with an O(N) traversals.
>
> Now, if you have one commit and other (N-1) commits, is there a way to
> efficiently figure out if that one commit is reachable from any of the
> other (N-1) commits?
>
> If there were a merge of these other (N-1) commits, and if you compute
> a merge base between that merge commit and the one commit you are
> looking at, what would you get?  Yes, you will get your commit back if
> and only if it is reachable from some of these (N-1) commits.
>
> If you recall the merge-base-many patch we discussed earlier, that is
> exactly what it computes, isn't it?

Exactly. :-)

Now I dropped the filter_independent() patch from my branch and replaced
it with your ones, since reduce_heads() does exactly the same, but it
performs much better.

So, changes since the previous series:

- added a testcase to make sure parents are reduced properly (as
  suggested by Dscho)

- port 037e98f20241bf013cd007b0924936a29c3cacfa to builtin-merge.c ("fix
  typo in usage message")

- dropped filter_independent() and replaced it with reduce_heads() (your
  two patches)

I'm not sending patches 01-08 (up to "Introduce
get_octopus_merge_bases()") since they are unchanged and to avoid
unnecessary traffic.

Junio C Hamano (2):
  Introduce get_merge_bases_many()
  Introduce reduce_heads()

Miklos Vajna (11):
  Move split_cmdline() to alias.c
  Move commit_list_count() to commit.c
  Move parse-options's skip_prefix() to git-compat-util.h
  Add new test to ensure git-merge handles pull.twohead and
    pull.octopus
  parseopt: add a new PARSE_OPT_ARGV0_IS_AN_OPTION option
  Move read_cache_unmerged() to read-cache.c
  git-fmt-merge-msg: make it usable from other builtins
  Introduce get_octopus_merge_bases() in commit.c
  Add new test to ensure git-merge handles more than 25 refs.
  Build in merge
  Add new test case to ensure git-merge filters for independent parents

 Makefile                                      |    3 +-
 alias.c                                       |   54 ++
 builtin-fmt-merge-msg.c                       |  157 ++--
 builtin-merge-recursive.c                     |    8 -
 builtin-merge.c                               | 1130 +++++++++++++++++++++++++
 builtin-read-tree.c                           |   24 -
 builtin-reduce-heads.c                        |   44 +
 builtin-remote.c                              |   39 +-
 builtin.h                                     |    5 +
 cache.h                                       |    3 +
 commit.c                                      |  136 +++-
 commit.h                                      |    4 +
 git-merge.sh => contrib/examples/git-merge.sh |    0 
 git-compat-util.h                             |    6 +
 git.c                                         |   55 +--
 parse-options.c                               |   11 +-
 parse-options.h                               |    1 +
 read-cache.c                                  |   31 +
 t/t7601-merge-pull-config.sh                  |   72 ++
 t/t7602-merge-octopus-many.sh                 |   52 ++
 t/t7603-merge-filter-independent.sh           |   63 ++
 21 files changed, 1709 insertions(+), 189 deletions(-)
 create mode 100644 builtin-merge.c
 create mode 100644 builtin-reduce-heads.c
 rename git-merge.sh => contrib/examples/git-merge.sh (100%)
 create mode 100755 t/t7601-merge-pull-config.sh
 create mode 100755 t/t7602-merge-octopus-many.sh
 create mode 100755 t/t7603-merge-filter-independent.sh
