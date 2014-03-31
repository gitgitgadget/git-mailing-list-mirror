From: Siddharth Agarwal <sid0@fb.com>
Subject: Re: [PATCH] add `ignore_missing_links` mode to revwalk
Date: Mon, 31 Mar 2014 14:48:45 -0700
Message-ID: <5339E2BD.3090303@fb.com>
References: <533239ED.5040503@fb.com> <20140328100043.GA16502@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Vicent Marti <tanoku@gmail.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:49:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUk4e-0000MS-FZ
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbaCaVsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:48:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38048 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751004AbaCaVsv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2014 17:48:51 -0400
Received: from pps.filterd (m0044008 [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s2VLjTXI003912;
	Mon, 31 Mar 2014 14:48:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : references : in-reply-to : content-type
 : content-transfer-encoding; s=facebook;
 bh=skM2X4BiOKhBBpUY5IkMfj+aY1xNRN9ronTWOXPBsQw=;
 b=I9HbcFRApBIMAxn8co3MIDhtxNos+CUnXHWDRg60AbrRGmazCs7qdUp0YfOI3qJFI5k1
 U3gp9gY2NiUAZSPG9pze/Q8SagELkwDtbNTXhb7bb7J99oFvtvWS7hRDSVZeJBxfMk6B
 07ewlQQmDOOjXdWpOYrNip/G8ACHdvTXrPo= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0a-00082601.pphosted.com with ESMTP id 1jydr5rxvc-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Mon, 31 Mar 2014 14:48:49 -0700
Received: from [172.25.69.14] (192.168.57.29) by mail.TheFacebook.com
 (192.168.16.17) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 31 Mar
 2014 14:48:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140328100043.GA16502@sigill.intra.peff.net>
X-Originating-IP: [192.168.57.29]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-03-31_04:2014-03-31,2014-03-31,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 kscore.is_bulkscore=0
 kscore.compositescore=0 circleOfTrustscore=0
 compositescore=0.322118847394922 urlsuspect_oldscore=0.322118847394922
 suspectscore=0 recipient_domain_to_sender_totalscore=45 phishscore=0
 bulkscore=0 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=2524143
 rbsscore=0.322118847394922 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1402240000
 definitions=main-1403310113
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245541>

On 03/28/2014 03:00 AM, Jeff King wrote:
> From: Vicent Marti <tanoku@gmail.com>
>
> When pack-objects is computing the reachability bitmap to
> serve a fetch request, it can erroneously die() if some of
> the UNINTERESTING objects are not present. Upload-pack
> throws away HAVE lines from the client for objects we do not
> have, but we may have a tip object without all of its
> ancestors (e.g., if the tip is no longer reachable and was
> new enough to survive a `git prune`, but some of its
> reachable objects did get pruned).

Thanks for this patch. It looks pretty sensible.

Unfortunately, I can't provide feedback on running it in production 
because we've decided to set aside experimenting with bitmaps for a bit. 
I hope to get back to it in a couple of months.



>
> In the non-bitmap case, we do a revision walk with the HAVE
> objects marked as UNINTERESTING. The revision walker
> explicitly ignores errors in accessing UNINTERESTING commits
> to handle this case (and we do not bother looking at
> UNINTERESTING trees or blobs at all).
>
> When we have bitmaps, however, the process is quite
> different.  The bitmap index for a pack-objects run is
> calculated in two separate steps:
>
> First, we perform an extensive walk from all the HAVEs to
> find the full set of objects reachable from them. This walk
> is usually optimized away because we are expected to hit an
> object with a bitmap during the traversal, which allows us
> to terminate early.
>
> Secondly, we perform an extensive walk from all the WANTs,
> which usually also terminates early because we hit a commit
> with an existing bitmap.
>
> Once we have the resulting bitmaps from the two walks, we
> AND-NOT them together to obtain the resulting set of objects
> we need to pack.
>
> When we are walking the HAVE objects, the revision walker
> does not know that we are walking it only to mark the
> results as uninteresting. We strip out the UNINTERESTING flag,
> because those objects _are_ interesting to us during the
> first walk. We want to keep going to get a complete set of
> reachable objects if we can.
>
> We need some way to tell the revision walker that it's OK to
> silently truncate the HAVE walk, just like it does for the
> UNINTERESTING case. This patch introduces a new
> `ignore_missing_links` flag to the `rev_info` struct, which
> we set only for the HAVE walk.
>
> It also adds tests to cover UNINTERESTING objects missing
> from several positions: a missing blob, a missing tree, and
> a missing parent commit. The missing blob already worked (as
> we do not care about its contents at all), but the other two
> cases caused us to die().
>
> Note that there are a few cases we do not need to test:
>
>    1. We do not need to test a missing tree, with the blob
>       still present. Without the tree that refers to it, we
>       would not know that the blob is relevant to our walk.
>
>    2. We do not need to test a tip commit that is missing.
>       Upload-pack omits these for us (and in fact, we
>       complain even in the non-bitmap case if it fails to do
>       so).
>
> Reported-by: Siddharth Agarwal <sid0@fb.com>
> Signed-off-by: Vicent Marti <tanoku@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I believe this should solve the problem you're seeing, and I think any
> solution is going to be along these lines.
>
> This covers all code paths that can be triggered by pack-objects.  But
> it does not necessarily cover all code paths that a revision walker
> might use (e.g., it is still possible to die in try_to_simplify_commit,
> but we would never hit that in pack-objects, because we do not do
> pathspec limiting).
>
> So it's a tradeoff. On the one hand, leaving it like this creates a flag
> in rev_info that may surprise somebody later by not being as generally
> useful. On the other hand, covering every die() is extra code churn, and
> creates complexity for cases that cannot actually be triggered in
> practice (complexity because each site has to decide how to handle a
> failure to access the object).
>
>   list-objects.c          |  5 ++++-
>   pack-bitmap.c           |  2 ++
>   revision.c              |  8 +++++---
>   revision.h              |  3 ++-
>   t/t5310-pack-bitmaps.sh | 31 +++++++++++++++++++++++++++++++
>   5 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/list-objects.c b/list-objects.c
> index 206816f..3595ee7 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -81,8 +81,11 @@ static void process_tree(struct rev_info *revs,
>   		die("bad tree object");
>   	if (obj->flags & (UNINTERESTING | SEEN))
>   		return;
> -	if (parse_tree(tree) < 0)
> +	if (parse_tree(tree) < 0) {
> +		if (revs->ignore_missing_links)
> +			return;
>   		die("bad tree object %s", sha1_to_hex(obj->sha1));
> +	}
>   	obj->flags |= SEEN;
>   	show(obj, path, name, cb_data);
>   	me.up = path;
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index ae0b57b..91e4101 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -727,8 +727,10 @@ int prepare_bitmap_walk(struct rev_info *revs)
>   	revs->pending.objects = NULL;
>   
>   	if (haves) {
> +		revs->ignore_missing_links = 1;
>   		haves_bitmap = find_objects(revs, haves, NULL);
>   		reset_revision_walk();
> +		revs->ignore_missing_links = 0;
>   
>   		if (haves_bitmap == NULL)
>   			die("BUG: failed to perform bitmap walk");
> diff --git a/revision.c b/revision.c
> index 8508550..b3b88e1 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2929,9 +2929,11 @@ static struct commit *get_revision_1(struct rev_info *revs)
>   			if (revs->max_age != -1 &&
>   			    (commit->date < revs->max_age))
>   				continue;
> -			if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0)
> -				die("Failed to traverse parents of commit %s",
> -				    sha1_to_hex(commit->object.sha1));
> +			if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
> +				if (!revs->ignore_missing_links)
> +					die("Failed to traverse parents of commit %s",
> +						sha1_to_hex(commit->object.sha1));
> +			}
>   		}
>   
>   		switch (simplify_commit(revs, commit)) {
> diff --git a/revision.h b/revision.h
> index 1eb94c1..0d997de 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -73,7 +73,8 @@ struct rev_info {
>   	enum rev_sort_order sort_order;
>   
>   	unsigned int	early_output:1,
> -			ignore_missing:1;
> +			ignore_missing:1,
> +			ignore_missing_links:1;
>   
>   	/* Traversal flags */
>   	unsigned int	dense:1,
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index d3a3afa..caea802 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -3,6 +3,10 @@
>   test_description='exercise basic bitmap functionality'
>   . ./test-lib.sh
>   
> +objpath() {
> +	echo ".git/objects/$(echo "$1" | sed -e 's|\(..\)|\1/|')"
> +}
> +
>   test_expect_success 'setup repo with moderate-sized history' '
>   	for i in $(test_seq 1 10); do
>   		test_commit $i
> @@ -112,6 +116,33 @@ test_expect_success 'fetch (full bitmap)' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'create objects for missing-HAVE tests' '
> +	blob=$(echo "missing have" | git hash-object -w --stdin) &&
> +	tree=$(printf "100644 blob $blob\tfile\n" | git mktree) &&
> +	parent=$(echo parent | git commit-tree $tree) &&
> +	commit=$(echo commit | git commit-tree $tree -p $parent) &&
> +	cat >revs <<-EOF
> +	HEAD
> +	^HEAD^
> +	^$commit
> +	EOF
> +'
> +
> +test_expect_success 'pack with missing blob' '
> +	rm $(objpath $blob) &&
> +	git pack-objects --stdout --revs <revs >/dev/null
> +'
> +
> +test_expect_success 'pack with missing tree' '
> +	rm $(objpath $tree) &&
> +	git pack-objects --stdout --revs <revs >/dev/null
> +'
> +
> +test_expect_success 'pack with missing parent' '
> +	rm $(objpath $parent) &&
> +	git pack-objects --stdout --revs <revs >/dev/null
> +'
> +
>   test_lazy_prereq JGIT '
>   	type jgit
>   '
