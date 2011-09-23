From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff_index: honor in-index, not working-tree,
 .gitattributes
Date: Fri, 23 Sep 2011 09:44:24 -0700
Message-ID: <7vobybw6mv.fsf@alter.siamese.dyndns.org>
References: <1316727861-90460-1-git-send-email-jaysoffian@gmail.com>
 <1316727861-90460-2-git-send-email-jaysoffian@gmail.com>
 <7v8vpgxkvb.fsf@alter.siamese.dyndns.org>
 <CAG+J_DzUQ3OGfiX=vHVGC7SHvwToVjD7uwFyDa8Tq6t7YwX12Q@mail.gmail.com>
 <CAG+J_Dyh=t2VAZ6rAqcF2meEgBCN5c+J_m_YvVQbKfvXeJ8WGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 18:44:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R78rZ-00040D-P9
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 18:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab1IWQo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 12:44:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46366 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147Ab1IWQo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 12:44:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2A19505D;
	Fri, 23 Sep 2011 12:44:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ocs4RbxPbhNgnY2kBqMOeeNlT04=; b=GM1uUF
	X5Zu6rOmun0gLWmKISdDMIe8LhcMC519yypIPtzzf6FrfoEQUgYUvXsPnZAml79R
	SI9qpoI3v+B4vp/uY13lIymLe75ren6SmRavacnkho1/Hmnd69Y2iMFI/nX25EbK
	YKtxCd69tbZ+o7Sd7OUEVhRcgFPLQv9roF6Og=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pf7W/+1og49PLQaTx0lZzUvcbc+NK+oe
	BGgWTj8WeN0Y2E20b9eXhV3hYck/vOsvckQu/y3C+4g79u1Et90n2XuCSnpAQeqT
	sC8dAif2b/6RPqCF+wXQ77ZDx80qnVAawSLKoGE4j3xbZQ+O3pkyYmIZMgN7abfP
	w9hUjxZFQMs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9F9B505C;
	Fri, 23 Sep 2011 12:44:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 257D8505B; Fri, 23 Sep 2011
 12:44:26 -0400 (EDT)
In-Reply-To: <CAG+J_Dyh=t2VAZ6rAqcF2meEgBCN5c+J_m_YvVQbKfvXeJ8WGA@mail.gmail.com> (Jay
 Soffian's message of "Fri, 23 Sep 2011 01:37:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C5E3BA8-E603-11E0-A49A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181977>

Jay Soffian <jaysoffian@gmail.com> writes:

> This area of git is still black magic to me. My best guess is
> something like this:
>
> diff --git a/tree-diff.c b/tree-diff.c
> index b3cc2e4753..6fd84eb2bb 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -280,6 +282,19 @@ int diff_tree_sha1(const unsigned char *old,
> const unsigned char *new, const cha
>  		die("unable to read destination tree (%s)", sha1_to_hex(new));
>  	init_tree_desc(&t1, tree1, size1);
>  	init_tree_desc(&t2, tree2, size2);
> +
> +	if (is_bare_repository()) {
> +		struct unpack_trees_options unpack_opts;
> +		memset(&unpack_opts, 0, sizeof(unpack_opts));
> +		unpack_opts.index_only = 1;
> +		unpack_opts.head_idx = -1;
> +		unpack_opts.src_index = &the_index;
> +		unpack_opts.dst_index = &the_index;
> +		unpack_opts.fn = oneway_merge;
> +		if (unpack_trees(1, DIFF_OPT_TST(opt, REVERSE_DIFF) ? &t1 : &t2,
> &unpack_opts) == 0)
> +			git_attr_set_direction(GIT_ATTR_INDEX, &the_index);
> +	}

This is hooking at too low a level in the callchain. diff_tree_sha1() is
meant to be a general purpose "I have two tree-ish objects and I want the
comparison machinery to work on them" library function [*1*].

 - One of the more important uses is the history simplification done
   during revision traversal by checking if the subtrees and the blobs
   have the same SHA-1, and we should not pay penalty of reading the index
   for each and every tree here.

 - The caller may be using the index for its own purposes, and your use of
   "the_index" here will break them.

If you want to allow use of in-tree attributes in _all_ callers of
diff_tree_sha1(), then the right approach is to add an instance of "struct
index_state" to "struct diff_options", have the caller _explicitly_ ask
for use of in-tree attributes by setting a bit somewhere in "struct
diff_options", and read the tree into that separate index_state using
tree.c::read_tree(). I however doubt it is worth it.

I would think it makes more sense to add a codeblock like that at the
beginning of builtin/diff.c::builtin_diff_tree() when a new command option
asks for it. In that codepath, you _know_ that we are not using the index
at all, and reading the index there will not interfere with other uses of
the index in the program.


[Footnote]

*1* which means that it is not a good justification to say "no current
    caller is broken by this change". We need to make the library usable
    for future callers.
