From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 37/48] merge-recursive: Fix modify/delete resolution in
 the recursive case
Date: Thu, 21 Jul 2011 11:43:31 -0700
Message-ID: <7voc0n1nl8.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-38-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 20:43:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjyDj-0004yM-BG
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 20:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507Ab1GUSne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 14:43:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45399 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481Ab1GUSnd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 14:43:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C304304C;
	Thu, 21 Jul 2011 14:43:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=eGttNJIQVJUJjt8b+2CyyO87h5w=; b=NDN2m5csI91w+JXr3KE4
	Il5SgWMQwiu64PPANcOfZa3KyCqgD/KGYkyuDVl91KKCgOvHBsHNlHdaMLutYE5M
	wtVEJVeGfvruHz9omgng15XqS38RWhDkDGtXZEUmE5SUw/MOh81mDDINhSlTuW+P
	O64qkTEpdAm9Y0Jm+XaS/Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VdOGyoIy9J1AHLjyn4AoOsxOw2wqEO0PXdxFuwwHxxNMra
	nLRCae6k1v4Dwt3Lm9pXCyMhe1rfDF6j24iYULBMPaHZDEl+Uvh8MQzcMZ+60Eqa
	Iwfw3mGASz24hUsa3GXhURjwGsOm7BI8f9xwlyd7/kBZwaVFnT6CMh0g5545A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D299304B;
	Thu, 21 Jul 2011 14:43:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CDC4304A; Thu, 21 Jul 2011
 14:43:32 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 557DB25C-B3C9-11E0-BBB7-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177612>

Elijah Newren <newren@gmail.com> writes:

> When o->call_depth>0 and we have conflicts, we try to find "middle ground"
> when creating the virtual merge base.  In the case of content conflicts,
> this can be done by doing a three-way content merge and using the result.
> In all parts where the three-way content merge is clean, it is the correct
> middle ground, and in parts where it conflicts there is no middle ground
> but the conflict markers provide a good compromise since they are unlikely
> to accidentally match any further changes.
>
> In the case of a modify/delete conflict, we cannot do the same thing.
> Accepting either endpoint as the resolution for the virtual merge base
> runs the risk that when handling the non-recursive case we will silently
> accept one person's resolution over another without flagging a conflict.
> In this case, the closest "middle ground" we have is actually the merge
> base of the candidate merge bases.  (We could alternatively attempt a
> three way content merge using an empty file in place of the deleted file,
> but that seems to be more work than necessary.)

What did we use before this patch as the "middle ground"?

Doesn't the "middle ground" also need to contain information from both
sides?  At the content level, The half-merge result with conflict marker
contains all the necessary information on what both sides agreed to do
outside the marker area, while showing what each side wished to do inside,
so as you describe, it is a good "middle ground".

Using the merge-base would mean that at the tree-structural level of this
merge you ignore the wish of one side that wanted to delete the path, and
then at the content level you also ignore the wish of both sides (the side
that wanted to delete the path wanted to leave zero content, while the
other side wanted to modify from the version in merge-base, all of which
is ignored by the above argument).

When you want to make a criss-corss merge between E and F that looks like
this:

      A---C---E---?
     / \ /       /
    O   .       /
     \ / \     /
      B---D---F

if there is no deletion, we run a content level merge between C and D by
using X that is a potentially conflicting merge between A and B as a
"virtual" ancestor.

      A---C---E---?
     / \ /       /
    O   X       /
     \ / \     /
      B---D---F

X would contain both what both A and B agreed to do on top of O, and what
A and B wanted to do that they do not agree with. The differing opinion of
A and B are recorded inside the conflict markers.  The change that turns X
into E contains C's opinion (i.e. it would likely agree to take what both
A and B agreed to do, and it may agree with A and the result in E would
resemble what A wanted to bring to the result despite B's objection). If C
and D both agree how to resolve the conflict, then B's "objection" will
cancel out from the three-way merge between E and F that uses X as the
ancestor.

In a delete/modify situation (e.g. A modified while B deleted), there are
three possibilities:

 * C and D both agree to delete the path;

 * C and D both agree to keep the path, with modifications that may or may
   not conflict (which can be handled by the usual content-level merge);

 * C decides to delete, while D decides to modify (or vice versa).

And in the last case, the outer merge ? needs to decide if it wants to
keep or delete the path anyway, so a simplest solution is to punt the
whole recursive business and make it the responsibility of the user to
resolve it as a merge between E and F using O as the common ancestor.
This patch does so in all three cases.

I however wonder if we can do better in the second case (I do not think
the first case would come into the picture, as we would not see such a
path when merging E and F as it would have been long gone from both
branches). We wouldn't know which commits C and D are exactly, but we do
have E and F. If A modified the path and B deleted it, and C and D both
decided to keep the path and E and F both inherited that path, wouldn't it
be fair to say that what both branches wanted to do is closer to what A
did than what B did? In other words, instead of using O, wouldn't it give
us a better result if we used A (the side that did not delete) as the
common ancestor for the content level merge when both E and F has the
path?

> diff --git a/merge-recursive.c b/merge-recursive.c
> index da507a3..5a70a87 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1309,11 +1309,26 @@ error_return:
>  
>  static void handle_delete_modify(struct merge_options *o,
>  				 const char *path,
> -				 const char *new_path,
> +				 unsigned char *o_sha, int o_mode,
>  				 unsigned char *a_sha, int a_mode,
>  				 unsigned char *b_sha, int b_mode)
>  {
> -	if (!a_sha) {
> +	char *new_path = NULL;
> +	int free_me = 0;

No need for free_me anymore, no?

> +	if (dir_in_way(path, !o->call_depth)) {
> +		new_path = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
> +		free_me = 1;
> +	}
> +
> +	if (o->call_depth) {
> +		/*
> +		 * We cannot arbitrarily accept either a_sha or b_sha as
> +		 * correct; since there is no true "middle point" between
> +		 * them, simply reuse the base version for virtual merge base.
> +		 */
> +		remove_file_from_cache(path);
> +		update_file(o, 0, o_sha, o_mode, new_path ? new_path : path);
> +	} else if (!a_sha) {
>  		output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
>  		       "and modified in %s. Version %s of %s left in tree%s%s.",
>  		       path, o->branch1,
> @@ -1330,6 +1345,9 @@ static void handle_delete_modify(struct merge_options *o,
>  		       NULL == new_path ? "" : new_path);
>  		update_file(o, 0, a_sha, a_mode, new_path ? new_path : path);
>  	}
> +	if (free_me)
> +		free(new_path);
> +

... as new_path is non-NULL only when we allocated it.
