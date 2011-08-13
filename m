From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] fast-import: add a check for tree delta base sha1
Date: Sat, 13 Aug 2011 16:02:21 -0500
Message-ID: <20110813210221.GA16194@elie.gateway.2wire.net>
References: <1313145170-24471-1-git-send-email-divanorama@gmail.com>
 <1313145170-24471-3-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 23:02:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsLLo-0005wb-SQ
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 23:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235Ab1HMVCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 17:02:32 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55631 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab1HMVCb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 17:02:31 -0400
Received: by gya6 with SMTP id 6so2630311gya.19
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 14:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=W50/vDiLtkJ2iIRgTYucC1DxauuPJnGjwGwgFxM586U=;
        b=VnpYQdYdbw/ARl8k2s3NJGPFlKRJY2URR4NcDpUKDaS8N2rxGeZQJJR49K3GY2juwJ
         C3LQO9JcDSIKPj1ijrIGUILLEK58fhhcVh5ITwhfYp3TmupVCBIlRvoCgKfxe/QXsXUQ
         +2BMSu8VCPuAN3Ub0CyQ2UoJqwO9GcQzFSyl8=
Received: by 10.236.92.194 with SMTP id j42mr2169291yhf.223.1313269350882;
        Sat, 13 Aug 2011 14:02:30 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-106-30.dsl.chcgil.ameritech.net [68.255.106.30])
        by mx.google.com with ESMTPS id b24sm2812883yhm.53.2011.08.13.14.02.29
        (version=SSLv3 cipher=OTHER);
        Sat, 13 Aug 2011 14:02:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313145170-24471-3-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179296>

Hi,

Dmitry Ivankov wrote:

> fast-import is able to write imported tree objects in delta format.
> It holds a tree structure in memory where each tree entry may have
> a delta base sha1 assigned. When delta base data is needed it is
> reconstructed from this in-memory structure. Though sometimes the
> delta base data doesn't match the delta base sha1 so wrong or even
> corrupt pack is produced.

I'm having trouble parsing this; not sure why.  Some guesses:

 - dropping the word "imported" could help, since it is the
   content of trees that comes from the user, not the tree objects

 - it's not clear to me what the second sentence is saying.  Do you
   mean that git looks at the versions[0].sha1 fields of item in
   t->entries to construct an in-memory tree object to delta against,
   instead of finding the object named by versions[0].sha1, inflating
   it, and using it directly?

 - the third sentence seems to be describing a problem, but I'm not
   sure what the relationship is to this patch: will this patch fix
   that problem, or does it just add a test illustrating it?

> To create a small easily reproducible test, add an excessive check
> for delta base sha1. It's not likely that computing sha1 for each
> tree delta base costs us much.

Since the first word in fast-import is "fast", I would be much
happier with some measurements with a typical import (i.e., one that
doesn't use --cat-blob-fd) than the statement "It's not likely". :)

If this tweak will continue to be useful after the fix, perhaps it
could be made optional.  I haven't thought carefully about this,
though.

On to the patch.

[...]
> +++ b/fast-import.c
> @@ -1455,12 +1455,22 @@ static void store_tree(struct tree_entry *root)
>  			store_tree(t->entries[i]);
>  	}
>  
> +	if (!is_null_sha1(root->versions[0].sha1)
> +					&& S_ISDIR(root->versions[0].mode)) {
> +		unsigned char old_tree_sha1[20];
> +		mktree(t, 0, &old_tree);
> +		prepare_object_hash(OBJ_TREE, &old_tree,
> +						NULL, NULL, old_tree_sha1);
> +
> +		if (hashcmp(old_tree_sha1, root->versions[0].sha1))
> +			die("internal tree delta base sha1 mismatch");

This is the heart of the patch; it involves several changes.

 1. construct the base object tree whether the base object is in the
    current pack or not

 2. calculate its hash and compare to ->versions[0].sha1 as a sanity
    check.

For large trees, I fear it could be an important slowdown.

> +
> -		le = find_object(root->versions[0].sha1);
> -		if (S_ISDIR(root->versions[0].mode) && le && le->pack_id == pack_id) {
> -			mktree(t, 0, &old_tree);
> +		le = find_object(root->versions[0].sha1);
> +		if (le && le->pack_id == pack_id) {
>  			lo.data = old_tree;
>  			lo.offset = le->idx.offset;
>  			lo.depth = t->delta_depth;
>  		}
> +	}
[...]
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -734,6 +734,44 @@ test_expect_success \
[...]
> +cat >input2 <<INPUT_END
> +commit refs/heads/L2
> +committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +data <<COMMIT
> +update L2
> +COMMIT
> +from refs/heads/L2^0
> +M 040000 @A g
> +M 040000 @E g/b
> +M 040000 @E g/b/h
> +INPUT_END
> +
> +test_expect_failure \
> +    'L: verify internal tree delta base' \
> +	'git fast-import <input &&
> +	A=$(git ls-tree L2 a | tr " " "\t" | cut -f 3) &&
> +	E=$(git ls-tree L2 a/e | tr " " "\t" | cut -f 3) &&
> +	cat input2 | sed -e "s/@A/$A/" -e "s/@E/$E/" >input &&
> +	git fast-import <input'

The description ("L: verify internal tree delta base" here) should
describe something we want to work --- a facility or a statement ---
and should leave out words like "verify" unless it is a test of
verification facilities.

In this example, I guess it is testing something like "delta base is
not corrupted when replacing one directory by another"?  (That's a
random, wild guess and not meant as an example to be used verbatim.)

I suppose I would be happier if we can find a way to reproduce this
without modifying the behavior in such an invasive way.  Which should
be easier while thinking about the fix, so I'll move on to that.
