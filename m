From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: git log: fatal: internal error in diff-resolve-rename-copy
Date: Fri, 13 Aug 2010 10:36:01 -0700
Message-ID: <7vhbiyl8ji.fsf@alter.siamese.dyndns.org>
References: <AANLkTikPhWgeeLBV3dbLZ5UM3UDmkOmpqrmwqPmGfn7Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 19:36:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjyB1-0002SA-Rs
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 19:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761908Ab0HMRgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 13:36:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761905Ab0HMRgN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 13:36:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79D5FCD739;
	Fri, 13 Aug 2010 13:36:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=StDiXzAbSxESU7Ncfe3JTL/c4Qk=; b=FFfPcO
	892f3tyqWW4DRM3rRrykveMwkbdZGsAvpNHU4G97hRFPfeykobyDA1l43OHQxTfC
	RePgjiIWy+99W/X2LyhSVGIRcwh4kLtwMMc7yxoFYne/fTNH302C1ubBrHMkFUeF
	kCVAVHe7p0OGigKt3hOtnNDaxSm8gHtySjH7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jAZLnXqBeHKcVK+Y496Cwl19HeqS8Kw1
	d7btKTJVjlHU1N1vlUh1LcgzfBTzImaP0/gkbw5VDiEICBtwIXWCxNoncjsE0AUJ
	n6I4aT0SvWWIFBFwIsFWQJITlPo6hZaHKI+/NRnrlx/g/cdqcbixyGBdmfYYRTX4
	ZIJRNzdUnQs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 35596CD730;
	Fri, 13 Aug 2010 13:36:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21B63CD72B; Fri, 13 Aug
 2010 13:36:02 -0400 (EDT)
In-Reply-To: <AANLkTikPhWgeeLBV3dbLZ5UM3UDmkOmpqrmwqPmGfn7Z@mail.gmail.com>
 (Constantine Plotnikov's message of "Fri\, 13 Aug 2010 15\:25\:57 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 419A7ACA-A701-11DF-928C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153481>

Constantine Plotnikov <constantine.plotnikov@gmail.com> writes:

> Somewhere between the git 1.7.0.2 and the git 1.7.2.0 the rename
> detection started to fail with fatal error on some files in our
> repository. The bug could be seen on the public IntelliJ IDEA
> repository (about 760M in size), but our users have reported it as
> well.
>
> To reproduce the error, run the following sequence of the commands:
>
> git clone git://git.jetbrains.org/idea/community.git idea
> cd idea
> git log -M --follow --name-only --
> platform/lang-api/src/com/intellij/lang/documentation/CompositeDocumentationProvider.java
>
> As result "fatal: internal error in diff-resolve-rename-copy" is
> written on stderr. This is somewhat unexpected result. Git 1.7.0.2 and
> 1.6.5.2 seems to work without visible problems.

This is interesting.  I actually see another potential "funny" (and that
is why Linus is CC'ed --- scroll down to "funny"), which is unrelated.

diff_tree_sha1() essentially:

 - given two trees, runs straightforward diff-tree without any rename
   detection;

 - under --follow mode, if it has only one change that deletes a path,
   runs try_to_follow_renames(), which:

   - runs the same diff-tree with deep rename detection but without any
     path limiter;

   - if we find a rename or copy that explains why we saw the deletion in
     the first step, replace the deletion record with the rename or copy.
     also set up to follow the old name from now on.

 - then return to the caller.

The diff frontends (diff-tree, diff-files and diff-index) are expected to
leave vanilla filepairs and let the diffcore backend to find renames and
copies via a call to diff_resolve_rename_copy() in diffcore_std().

We however have a special "hack" in "diff-tree --follow".  If it finds
only one diff_queue entry that creates a path, it internally runs itself
again with the rename/copy detection on, without any pathspec, to see if
the creation is an artifact of the pathspec (iow, if there is a source of
rename/copy into the created path), and replaces that creation record with
a rename record in the diff_queue.  When this is done, we do not want the
regular resolve_rename_copy() to kick in (i.e. the "follow" hack already
made a pair).

But what 1da6175 (Make diffcore_std only can run once before a diff_flush,
2010-05-06) did is clearly wrong.  Not wanting to call resolve-rename-copy
does not mean we do not want to run the rest of what diffcore_std() does
at all!  For example, "-S" and "--diff-filter=" options are processed in
that function; the exit status of the command based on the presense of
difference is computed in the function, too.

Another potential "funny" is this (unrelated to the reported issue).

The "--follow" logic is called from diff_tree_sha1() function, but the
input trees to diff_tree_sha1() are not necessarily the top-level trees
(compare_tree_entry() calls it while it recursively descends into
subtrees).  For example, with the example Constantine gave us, the first
"try-to-follow-renames" call happens with the "base" set to "platform/"
but the rename source is actually "lang-api/src/com/intellij/..."
hierarchy, so it is a wasted call.  I think we only want to run the rename
following at the very top level, i.e. like the attached patch.

Linus, what do you think?  Am I missing something obvious?

diff --git a/tree-diff.c b/tree-diff.c
index 1fb3e94..5b68c08 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -412,7 +412,7 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 	init_tree_desc(&t1, tree1, size1);
 	init_tree_desc(&t2, tree2, size2);
 	retval = diff_tree(&t1, &t2, base, opt);
-	if (DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename()) {
+	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename()) {
 		init_tree_desc(&t1, tree1, size1);
 		init_tree_desc(&t2, tree2, size2);
 		try_to_follow_renames(&t1, &t2, base, opt);
