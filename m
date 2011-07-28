From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/WIP 6/7] fast-import: workaround data corruption
Date: Thu, 28 Jul 2011 08:31:34 +0200
Message-ID: <20110728063134.GA4179@elie>
References: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
 <1311828370-30477-7-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 08:31:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmK8S-0004XE-6u
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 08:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab1G1Gbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 02:31:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55690 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026Ab1G1Gbu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 02:31:50 -0400
Received: by fxh19 with SMTP id 19so950505fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 23:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aszxCn9voTq5112em9mUItIqQ1kZE02dPOfqoLebzc8=;
        b=G/3o1e1UmElylKCurIuxE9pK+8r/4q2YXatZIm17zPMAk7yS5qsrHQqqjI2tvk2Bfb
         356VIXzWDzUHnU9MzNZMevIg+IU32+WrZuceGqsITJJLizzpwLafVIjHML2U+AyJz19v
         lg8ZOoZDkGTSzoLc7/ZwaV2QZ1K7h12QpqWXw=
Received: by 10.223.160.65 with SMTP id m1mr866992fax.28.1311834709000;
        Wed, 27 Jul 2011 23:31:49 -0700 (PDT)
Received: from elie (adsl-165-140-99.teol.net [109.165.140.99])
        by mx.google.com with ESMTPS id 9sm277579far.13.2011.07.27.23.31.46
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 23:31:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311828370-30477-7-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178042>

Hi!

Dmitry Ivankov wrote:

> fast-import keeps track of some delta-base for tree objects. When it is
> time to compute the delta, base object is constructed from in-memory
> tree representation using children's delta bases sha1. But these can be
> unrelated due to several bugs, and it leads to object with wrong sha1
> being delta-written to the packfile.

This seems like as good a starting point as any.  Small language
nitpicks:

 - "some delta-base" is somewhat vague

 - missing article (probably "the") before "base object" and
   "children's"

 - does "children's delta bases sha1" mean "the pre-computed object
   names and modes in versions[0].{sha1,mode} for each tree entry" or
   something else?

 - when you say "unrelated": unrelated to what?

> We have the base sha1 and what we think it's data is. Verify sha1 and if
> it doesn't match, report it to stderr and don't use delta for this tree.

At any rate, if I understand correctly, the idea is that when store_tree()
is being called, root->versions[0].sha1 does not match the tree object
implied by root->tree->entries[*]->{name,versions[0].{mode,sha1}}.  This
patch adds a quick check to notice when that happens.

Makes a lot of sense, especially as a demonstration of the problem.
store_object() returns early in many cases so this probably does make
the bug easier to find (good).

I wonder if it would make more sense to perform this sanity check in
store_object() so blobs could benefit, too.  How much does the check slow
fast-import down (if at all)?

> We could also die() here when bugs are fixed.

If the check is fast, sure, why not? :)  The only reason I can think
of is that computing a SHA-1 is an O(size of object) cost which it
would be nice to avoid if profiling shows it is noticeable.

> Or we can see if the data
> we've got is from our pack file and so still try to use it as a base.

Can you elaborate?  When would versions[0].sha1 not match the data
but the data still be in the pack file?

> --- a/fast-import.c
> +++ b/fast-import.c
[...]
> @@ -1486,10 +1487,21 @@ static void store_tree(struct tree_entry *root)
>  
>  	le = find_object(root->versions[0].sha1);
>  	if (S_ISDIR(root->versions[0].mode) && le && le->pack_id == pack_id) {
> +		unsigned char sh[20];

What does "sh" stand for?

>  		mktree(t, 0, &old_tree);
>  		lo.data = old_tree;
>  		lo.offset = le->idx.offset;
>  		lo.depth = t->delta_depth;
> +
> +		prepare_object_hash(OBJ_TREE, &old_tree, NULL, NULL, sh);
> +		if (hashcmp(sh, root->versions[0].sha1)) {
> +			fprintf(stderr, "internal sha1 delta base mismatch,"
> +					" won't use delta for that tree\n");
> +			lo.data = empty;

To avoid a memory leak and introducing an unnecessary variable:

			strbuf_reset(&lo.data);

Thanks, that was interesting.
