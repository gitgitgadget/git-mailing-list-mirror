From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-merge segfault in 1.6.6 and master
Date: Thu, 21 Jan 2010 16:21:21 -0800
Message-ID: <7vhbqfj8fy.fsf@alter.siamese.dyndns.org>
References: <hj7abm$5vc$1@ger.gmane.org>
 <7vocko3802.fsf@alter.siamese.dyndns.org>
 <4B577C3F.7040608@brooklynpenguin.com>
 <7vtyugzabq.fsf@alter.siamese.dyndns.org>
 <4B5882BD.3090908@brooklynpenguin.com>
 <7viqavs4xc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Tim Olsen <tim@brooklynpenguin.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 01:21:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY7HW-000361-7r
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 01:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619Ab0AVAVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 19:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755584Ab0AVAVg
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 19:21:36 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828Ab0AVAVf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 19:21:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38F6B932CE;
	Thu, 21 Jan 2010 19:21:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5+4wmms+nzq2xzT1SLkMzILR6L0=; b=vdoyXH
	f1+Lg5RHXZY2uSuc1/SssdcM3t2hB8Ac2GvaQ/mu0b6PiKrB966J/n2sVzeDP4He
	amq7s4eZlVV2UUAEeIFRSXMdwQJp/0wKSziU4hZi1FhM5p2T3j3eZ1OJnhYquVwA
	qrgydV9WOTp+VP2gpXXmKI/Xzts3QiLaWYqOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ke2O+kgN38ys3wAVpDt+BLmRYZR1ayCK
	YGB3+lhTSlS02Is0rikQDviD6oD0dPXiq3Uv3ViTeGANlGm4E4OW0q9BqTqLcxyk
	snKkg3ikaK2DwcKsKf71w3xMSgcLLjoxvkyvW9lLvLL6VY6+tbHUfWVzMb5o0CkW
	0YdoM8vKTbI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E25BE932CB;
	Thu, 21 Jan 2010 19:21:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F929932C3; Thu, 21 Jan
 2010 19:21:22 -0500 (EST)
In-Reply-To: <7viqavs4xc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 21 Jan 2010 10\:12\:31 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 15027EBE-06EC-11DF-BE1D-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137702>

Junio C Hamano <gitster@pobox.com> writes:

> When they are called with non-zero o->call_depth, they are supposed to
> drop all the index entries that they handle down to stage #0 (even if the
> path had contents level conflict).  For example, you see this bit in
> process_entry():
>
> 	} else if (a_sha && b_sha) {
> 		/* Case C: Added in both (check for same permissions) and */
> 		/* case D: Modified in both, but differently. */
> 		const char *reason = "content";
> 		...
> 		mfi = merge_file(o, &one, &a, &b,
> 				 o->branch1, o->branch2);
>
> 		clean_merge = mfi.clean;
> 		if (!mfi.clean) {
> 			if (S_ISGITLINK(mfi.mode))
> 				reason = "submodule";
> 			output(o, 1, "CONFLICT (%s): Merge conflict in %s",
> 					reason, path);
> 		}
> 		update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
> 	} ...
>
> and update_file() eventually calls update_file_flags() to make sure that
> the content in mfi.sha is at the stage #0 of path when o->call_depth is
> non-zero (or mfi.clean is true).  process_renames() and process_entry()
> are humongous functions that handle full of different cases, but all
> codepaths must follow the rule not to leave non-stage #0 entries in the
> index before merge_trees() function calls write_tree_from_memory().
>
> We've fixed a similar bug in c94736a (merge-recursive: don't segfault
> while handling rename clashes, 2009-07-30) and I think there were similar
> breakages we fixed over time in the same area, but the two functions being
> as huge as they are, I suspect you are hitting a codepath that hasn't been
> fixed.

And there are.

For example, this (drop it as t9999-junk.sh in t/ directory, go there and
run "sh ./t-9999-junk.sh -v") shows one codepath that makes merge-recursive
fail to resolve the "common ancestor" merge.

-- -- store in t/t9999-junk.sh and run -- --
#!/bin/sh

test_description='common ancestor merge corner cases'

. ./test-lib.sh

test_expect_success 'setup' '
	mkdir D &&
	echo 1 >D/F1 &&
	echo 2 >D/F2 &&
	echo 3 >D/F3 &&
	echo 4 >D/F4 &&
	echo 5 >D/F5 &&
	echo 6 >D/F6 &&

	git add D &&
	test_tick &&
	git commit -m initial &&
	git branch side &&

	git checkout master &&
	git mv D/F1 D/M1 &&
	git rm D/F2 &&
	echo 7 >>D/F3 &&
	git mv D/F4 D/M4 &&
	git rm D/F5 &&
	mkdir D/F5 &&
	git mv D/F6 D/F5/M6 &&
	git add -u &&
	test_tick &&
	git commit -m master &&
	git tag A &&

	git checkout side &&
	git mv D/F1 D/S1 && # rename-rename conflict (dst)
	echo 8 >>D/F2 && # remove-modify conflict
	git mv D/F5 D/M4 && # rename-rename conflict (src)
	git add -u &&
	test_tick &&
	git commit -m side &&
	git tag B &&

	git checkout side &&
	test_tick &&
	git merge -s ours master &&
	git tag C &&

	git checkout master &&
	test_tick &&
	git merge -s ours B &&
	git tag D
'

test_expect_success 'criss-cross' '
	git checkout D &&
	test_must_fail git merge side
'

test_done
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

It dies after showing this (D/F5/M6 is left unresolved in the forced
"common ancestor" merge):

  Merging:
  f2f2f75 master
  7994826 side
  found 1 common ancestor(s):
  f561e36 initial
  CONFLICT (rename/rename): Rename "D/F1"->"D/M1" in branch "Temporary merge branch 1" rename "D/F1"->"D/S1" in "Temporary merge branch 2" (left unresolved)
  CONFLICT (rename/add): Rename D/F4->D/M4 in Temporary merge branch 1. D/M4 added in Temporary merge branch 2
  Adding merged D/M4
  Skipped D/M4 (merged same as existing)
  CONFLICT (rename/delete): Rename D/F5->D/M4 in Temporary merge branch 2 and deleted in Temporary merge branch 1
  Skipped D/F5/M6 (merged same as existing)
  CONFLICT (delete/modify): D/F2 deleted in Temporary merge branch 1 and modified in Temporary merge branch 2. Version Temporary merge branch 2 of D/F2 left in tree.
  There are unmerged index entries:
  2 D/F5/M6


The attached patch changes the behaviour to make this 9999-junk test pass,
but then it breaks t6036 (iow, the attached is _not_ a fix).

After I stared at the code for more than two hours, I gave up trying to
diagnose this by myself.  People more familiar with the merge-recursive
implementation might be able to help figuring this out and may prove my
suspicion wrong, but I have a feeling that without a fairly big rewrite
the code is unsalvageable.

-- >8 --
Not a fix

diff --git a/merge-recursive.c b/merge-recursive.c
index 1239647..132a6fc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1052,8 +1052,8 @@ static int process_renames(struct merge_options *o,
 							update_stages(ren1_dst,
 								      one, a, b, 1);
 					}
-					update_file(o, mfi.clean, mfi.sha, mfi.mode, ren1_dst);
 				}
+				update_file(o, mfi.clean, mfi.sha, mfi.mode, ren1_dst);
 			}
 		}
 	}
