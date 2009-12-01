From: Junio C Hamano <gitster@pobox.com>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 16:20:23 -0800
Message-ID: <7vmy23bl4o.fsf@alter.siamese.dyndns.org>
References: <cover.1259524136.git.brlink@debian.org>
 <7v8wdnooza.fsf@alter.siamese.dyndns.org>
 <20091201071234.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Bernhard R. Link" <brlink@debian.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 01:20:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFGUC-00044H-V9
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 01:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbZLAAUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 19:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbZLAAUd
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 19:20:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbZLAAU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 19:20:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 54B2CA2B71;
	Mon, 30 Nov 2009 19:20:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9wJqhTuKM06lFn7tB+hIrByxPcE=; b=gjOK09
	0gWptZKkdVAj70twXvfAullpBlJKWUs92+i7N0Z7rpW0o7+GQmyXY4tBWZxfKuGA
	MyMEs1RPbS8Y0RFAOJwx3HrREFcua3Khfz4rjaEMib19TKACXUGFV0XIRg81H/8Y
	MvhcslO5SxqQFHsf1ohocPWrWZ074WsNfps+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DFAQqt8jTQrlkmpgF8PzF/OGVcVKMDMx
	gBsiNPFaoDfO2IwE+xF8KQWHGuUuFluwmgYnMUWGmvWvMFzOba7jQ9K+dRMPI+jS
	2ovsoqsIczmQpVD25w0DSHwz6tSndhwL7dYG8vD4kkEwpFBnvaUjMNbzW0VEiiZB
	OGvcJw0Xwk8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 24C0EA2B6F;
	Mon, 30 Nov 2009 19:20:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 08091A2B6E; Mon, 30 Nov 2009
 19:20:24 -0500 (EST)
In-Reply-To: <20091201071234.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Tue\, 01 Dec 2009 07\:12\:34 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 55ADB11E-DE0F-11DE-9569-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134154>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> I think you can record a merge commit that has an unusual 
> list of parents for this. For example, you can record the 
> latest version twice, as the first and the second parents, 
> and make the previous version the third parent. Because 
> such a merge can't be created with git-merge command, you 
> can reliably tell that it is an unusual 'marker' merge.

That's too ugly a hack, and hints an undesirable attitude that this will
be the last feature that needs such cleverness, without leaving the door
open for others who need similar "magic marker" capability added to commit
objects.  The approach will not scale, unless you consider "first and
second parents being the same means it is 'rebased branches magic', and
first, second and third parents being the same means some other matic, 
etc." as scalable.

As I said, if the approach this series takes turns out to be useful, it is
Ok to implement it as a new header in the commit object if necessary.

We try very hard to avoid adding random headers to commits because a
commit that records the same history should be named the same way in the
object store namespace and adding random headers will make it easier to
create the same commit with different names, but what we are discussing
is a special purpose pseudo commit and it _is_ a feature that the object
name of a commit, after SHA-1 hashing, is different with and without the
special header in this case.

> No matter what techinique is used to mark the special 
> 'marker', if it happens in real life for two or more people 
> who worked independantly to arrive at the same conclusion, 
> I don't think dismissing it as 'by chance' and discarding 
> the contribution from the second branch is a good solution. 
> If git is meant to work smoothly in projects where more than 
> one person see and accept patches from the same origin, the 
> condition is not met 'by chance'; the tool is by design 
> supposed to handle it as a regular situation.

I said the same thing, and I agree that two (or more) people creating the
same state should be treated as a normal event.  But I am not so sure
about a merge that binds two such histories together.  The person who
makes such a merge can go on without making one as far as tree-state is
concerned (i.e. such a merge will result in the same tree with both
parents), and the _only_ reason a merge between the two branches is
created is to cauterize one (or both) of the branches, declare that
everything that happened in the branch is now part of this branch.
In other words, such a merge is an operation to purely affect the history
and not contents.

As J6t pointed out, when we tell the revision walking machinery to limit
by path, we already simplify the history we show to the user, and if path
happens to name the whole tree, such a history is already simplified to
show only one side of the story.  So perhaps it is not as grave an offence
to ignore contribution from one side when both of the parents of a merge
record the same tree as I originally thought.  It also justifies not
introducing a new header in commits.  The implementation of Bernhard's
series might become simpler if it used the trick to use "." pathspec
internally instead of introducing a new traversal option to the revision
machinery.

> On the other hand, if you made the marker reliable, I think 
> you don't have to disable this feature by default like you 
> said in your (2).

That is true, but as you may be able to tell, I am undecided if the marker
should be _that_ explicit, or should be implicit and the fact that a merge
that whose all parents have the same tree should make it automatically a
marker (iow, I earlier said "misidentify" but now I am wondering if it
makes sense to define any merge with the property an "alternative history
binding marker", no matter how it was created).

> As a side note, I have a bug to report. I tried this sequence 
> of commands to make sure git-merge doesn't record the same 
> parent twice (the last git-merge is made on the slave branch 
> and tries to have slave, master and slave as its three 
> parents).
>
>  % git init
>  % echo hello >world
>  % git add . ; git commit -m first
>  % echo again >world
>  % git commit -a -m master
>  % git checkout -b slave master^
>  % echo again >world
>  % git commit -a -m slave
>  % git merge master slave
>
> But I got the "usage: ..." error message from git-merge.

Well, you did not quote the usage string you got, but it should have began
like this:

    usage: git merge [options] <remote>...
       or: git merge [options] <msg> HEAD <remote>

The parser misinterpreted your request as the latter form (which is
ancient and probably predates your involvement with the git project),
noticed that you did not give any <remote> commit, and then gave the
usage message.

I think we really should start deprecating the ancient form, but the
original sample script using this syntax from Linus was copied by many
people and are still found everywhere, I think, and people may still
use their scripts that were written with the ancient syntax.

In any case, at least this patch will make it start behaving a bit
more sanely.

-- >8 --
Subject: Do not misidentify "git merge foo HEAD" as an old-style invocation

This was misinterpreted as an ancient style "git merge <message> HEAD
<commit> <commit>..." that merges one (or more) <commit> into the current
branch and record the resulting commit with the given message.  Then a
later sanity check found that there is no <commit> specified and gave
a usage message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

diff --git a/builtin-merge.c b/builtin-merge.c
index e95c5dc..e5cf795 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -792,7 +792,7 @@ static int suggest_conflicts(void)
 static struct commit *is_old_style_invocation(int argc, const char **argv)
 {
 	struct commit *second_token = NULL;
-	if (argc > 1) {
+	if (argc > 2) {
 		unsigned char second_sha1[20];
 
 		if (get_sha1(argv[1], second_sha1))
