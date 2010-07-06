From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2 4/4] implement automatic fast forward merge for
 submodules
Date: Wed, 07 Jul 2010 01:52:16 +0200
Message-ID: <201007070152.17802.johan@herland.net>
References: <cover.1278444110.git.hvoigt@hvoigt.net>
 <f17d78656a71558fd290e0b84cad03f22f6fcbd8.1278444110.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com, jens.lehmann@web.de
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jul 07 01:52:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWHwD-0003IJ-Ig
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 01:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab0GFXwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 19:52:24 -0400
Received: from smtp.getmail.no ([84.208.15.66]:56080 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661Ab0GFXwX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 19:52:23 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5500B9HUB8YY60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 07 Jul 2010 01:52:20 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id F36D31EEF20A_C33C1B3B	for <git@vger.kernel.org>; Tue,
 06 Jul 2010 23:52:19 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 0FFC91EEC95F_C33C1B3F	for <git@vger.kernel.org>; Tue,
 06 Jul 2010 23:52:19 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5500DS3UB6WR30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 07 Jul 2010 01:52:19 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <f17d78656a71558fd290e0b84cad03f22f6fcbd8.1278444110.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150419>

On Tuesday 06 July 2010, Heiko Voigt wrote:
> This implements a simple merge strategy for submodule hashes. We check
> whether one side of the merge candidates is already contained in the
> other and then merge automatically.
> 
> If both sides contain changes we search for a merge in the submodule.
> In case a single one exists we check that out and suggest it as the
> merge resolution. A list of candidates is returned when we find multiple
> merges that contain both sides of the changes.
> 
> This is useful for a workflow in which the developers can publish topic
> branches in submodules and a seperate maintainer merges them. In case
> the developers always wait until their branch gets merged before tracking
> them in the superproject all merges of branches that contain submodule
> changes will be resolved automatically. If developers choose to track
> their feature branch the maintainer might get a conflict but git will
> search the submodule for a merge and suggest it/them as a resolution.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

In the commit subject: s/fast forward/fast-forward/

> diff --git a/submodule.c b/submodule.c

> +static int find_first_merges(struct object_array *result, const char *path,
> +		struct commit *a, struct commit *b)

[...]

> +	/* get all revisions that merge commit a */
> +	snprintf(merged_revision, sizeof(merged_revision), "^%s",
> +			find_unique_abbrev(a->object.sha1, 40));

Why do you call find_unique_abbrev(..., 40) here?
Isn't sha1_to_hex(a->object.sha1) a better solution?

> +	init_revisions(&revs, NULL);
> +	rev_opts.submodule = path;
> +	setup_revisions(sizeof(rev_args)/sizeof(char *)-1, rev_args, &revs, &rev_opts);
> +
> +	/* save all revisions from the above list that contain b */
> +	if (prepare_revision_walk(&revs))
> +		die("revision walk setup failed");
> +	while ((commit = get_revision(&revs)) != NULL) {
> +		struct object *o = &(commit->object);
> +		if (in_merge_bases(b, (struct commit **) &o, 1)) {

Why not s/(struct commit **) &o/&commit/ ?


> +static void print_commit(struct commit *commit)
> +{
> +	static const char *format = " %h: %m %s";

You don't need this 'format' variable; instead use the literal string below.

> +	struct strbuf sb = STRBUF_INIT;
> +	struct pretty_print_context ctx = {0};
> +	ctx.date_mode = DATE_NORMAL;
> +	format_commit_message(commit, format, &sb, &ctx);
> +	strbuf_addstr(&sb, "\n");
> +	fprintf(stderr, "%s", sb.buf);

Drop the strbuf_addstr() and add the newline directly in the fprintf()
format:

fprintf(stderr, "%s\n", sb.buf);


> +int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
> +		    const unsigned char a[20], const unsigned char b[20])

Watch your line wrapping. Max 80 chars.

> +		warning("Submodule rewound can not merge");

s/Submodule rewound can not merge/
  Failed to merge submodule %s (commits don't follow merge-base)/
	
> +	/* 1. case a is contained in b or vice versa */

s/1. case/Case #1:/

> +	/* 2. case there are one ore more merges that contain a and b in
> +	 * the submodule. If there is a single one present it as
> +	 * suggestion to the user but leave it marked unmerged so the
> +	 * user needs to confirm the resolution.
> +	 */

s/2. case/Case #2:/

s/one ore more/one or more/

s/If there is a single one present it as suggestion to the user but/
  If there is only one, then present it a suggestion to the user, but/


> +	/* find commit which merges them */
> +	parent_count = find_first_merges(&merges, path, commit_a, commit_b);
> +	if (!parent_count) {
> +		warning("Failed to merge submodule %s (merge not found)", path);

s/merge not found/merge following commits not found/

BTW, what about a

#define MERGE_WARNING(path, msg) \
	warning("Failed to merge submodule %s (%s)", path, msg);

towards the top of merge_submodule, so you don't have to repeat
the same string over and over?

> +		goto finish;
> +	}
> +
> +	if (parent_count != 1) {
> +		warning("Failed to merge submodule %s (multiple merges found):", path);
> +		for (i = 0; i < merges.nr; i++) {
> +			print_commit((struct commit *) merges.objects[i].item);
> +		}
> +		goto finish;
> +	}
> +
> +	warning("Failed to merge submodule %s (not fast-forward):\n", path);
> +	fprintf(stderr, "Found a possible merge resolution for the submodule:\n");
> +	print_commit((struct commit *) merges.objects[0].item);
> +	fprintf(stderr, "If this is correct simply add it to the index for example\n"
> +			"by using:\n\n"
> +			"  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
> +			"which will accept this suggestion.\n",
> +		sha1_to_hex(merges.objects[0].item->sha1), path);
> +
> +finish:
> +	free(merges.objects);
> +	return 0;
> +}

Hmm, you can get rid of the 'goto finish' by restructuring the code like this:

parent_count = find_first_merges(&merges, path, commit_a, commit_b);
switch (parent_count) {
case 0:
	MERGE_WARNING(path, "merge following commits not found");
	break;
case 1:
	MERGE_WARNING(path, "not fast-forward");
	fprintf(...
	...
	break;
default:
	MERGE_WARNING(path, "multiple merges found");
	for (i = 0; i < merges.nr; i++)
		print_commit((struct commit *) merges.objects[i].item);
}

free(merges.objects);
return 0;


> diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
> index 4a7b893..0f568ab 100755
> --- a/t/t7405-submodule-merge.sh
> +++ b/t/t7405-submodule-merge.sh
> @@ -54,13 +54,128 @@ test_expect_success setup '
>  	git merge -s ours a
>  '
> 
> -test_expect_success 'merging with modify/modify conflict' '
> +# History setup
> +#
> +#      b
> +#    /   \
> +#   a     d
> +#    \   /
> +#      c
> +#
> +# a in the main repository records to sub-a in the submodule and
> +# analogous b and c. d should be automatically found by merging c into
> +# b in the main repository.
> +test_expect_success 'setup for merge search' '
> +	mkdir merge-search &&
> +	cd merge-search &&
> +	git init &&
> +	mkdir sub &&
> +	(cd sub &&
> +	 git init &&
> +	 echo "file-a" > file-a &&
> +	 git add file-a &&
> +	 git commit -m "sub-a" &&
> +	 git checkout -b sub-a) &&

If you just need to create a new branch, but not necessarily check it out,
then use 'git branch <name>' instead of 'git checkout -b <name>'.

> +	git add sub &&
> +	git commit -m "a" &&
> +	git checkout -b a &&

Same as above

> +	git checkout -b b &&
> +	(cd sub &&
> +	 git checkout -b sub-b &&
> +	 echo "file-b" > file-b &&
> +	 git add file-b &&
> +	 git commit -m "sub-b") &&
> +	git commit -a -m "b" &&
> +
> +	git checkout -b c a &&
> +	(cd sub &&
> +	 git checkout -b sub-c sub-a &&
> +	 echo "file-c" > file-c &&
> +	 git add file-c &&
> +	 git commit -m "sub-c") &&
> +	git commit -a -m "c" &&
> +
> +	git checkout -b d a &&
> +	(cd sub &&
> +	 git checkout -b sub-d sub-b &&
> +	 git merge sub-c) &&
> +	git commit -a -m "d" &&
> +	git checkout -b test b &&

same as above

> +	cd ..
> +'
> +
> +test_expect_success 'merge with one side as a fast-forward of the other' '
> +	(cd merge-search &&
> +	 git checkout -b test-forward b &&
> +	 git merge d &&
> +	 git ls-tree test-forward | grep sub | cut -f1 | cut -f3 -d" " > actual &&

Use "git ls-tree test-forward sub" instead of "git ls-tree test-forward | grep sub"

> +	 (cd sub &&
> +	  git rev-parse sub-d > ../expect) &&
> +	 test_cmp actual expect)
> +'
> +
> +test_expect_success 'merging should conflict for non fast-forward' '
> +	(cd merge-search &&
> +	 git checkout -b test-nonforward b &&
> +	 (cd sub &&
> +	  git rev-parse sub-d > ../expect) &&
> +	 test_must_fail 	git merge c 2> actual  &&
> +	 grep $(<expect) actual > /dev/null &&

I cannot find the "$(<expect)" construct anywhere else in out test scripts.
Is it portable? Should we maybe use "$(cat expect)" instead?

> +	 git reset --hard)
> +'
> +
> +test_expect_success 'merging should fail for ambigous common parent' '

s/ambigous/ambiguous/

> +	cd merge-search &&
> +	git checkout -b test-ambigous b &&
> +	(cd sub &&
> +	 git checkout -b ambigous sub-b &&
> +	 git merge sub-c &&
> +	 git rev-parse sub-d > ../expect1 &&
> +	 git rev-parse ambigous > ../expect2) &&

s/ambigous/ambiguous/

> +	test_must_fail git merge c 2> actual &&
> +	grep $(<expect1) actual > /dev/null &&
> +	grep $(<expect2) actual > /dev/null &&

Same $(<foo) construct...

> +	git reset --hard &&
> +	cd ..
> +'
> +
> +# in a situation like this
> +#
> +# submodule tree:
> +#
> +#    sub-a --- sub-b --- sub-d
> +#
> +# main tree:
> +#
> +#    e (sub-a)
> +#   /
> +#  bb (sub-b)
> +#   \
> +#    f (sub-d)
> +#
> +# A merge should fail because one change points backwards.

Instead: A merge between e and f should fail because one of the submodule
commits (sub-a) don't descend from the submodule merge-base (sub-b).


Otherwise, it looks good to me. Thanks for the effort!


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
