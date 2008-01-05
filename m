From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff -B: splitting up complete renames
Date: Sat, 05 Jan 2008 11:18:20 -0800
Message-ID: <7vprwg84jn.fsf@gitster.siamese.dyndns.org>
References: <200801051818.40009.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 20:19:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBEXw-000230-M7
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 20:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176AbYAETS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 14:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756152AbYAETS3
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 14:18:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755884AbYAETS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 14:18:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C67974BA;
	Sat,  5 Jan 2008 14:18:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CE2474B9;
	Sat,  5 Jan 2008 14:18:22 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69681>

Jakub Narebski <jnareb@gmail.com> writes:

> ...
>   and if it detects that the file "file0" is completely rewritten,
>   it changes it to:
>
>   ------------------------------------------------
>   :100644 000000 bcd1234... 0000000... D file0
>   :000000 100644 0000000... 0123456... A file0
>   ------------------------------------------------
>
> Shouldn't the last block read for the modern git read:
>
>   ------------------------------------------------
>   :100644 000000 bcd1234... 0123456... M99 file0
>   ------------------------------------------------

Correct.  The description is based on an earlier round of the
code before 366175ef8c3b1e145f4ba846e63a1dea3ec3cacc (Rework -B
output).  "git show" of that patch has description in its
changes to Documentation/diffcore.txt.

The original motivation of -B was not about helping three way
renames it allows you when used with -M/-C.  It was about
showing textual diff more readably for quite dissimilar
filepairs.

> Third: Do "git diff --no-index" (filesystem diff) can show breaking / 
> use dissimilarity? I couldn't make it work...

It doesn't, for two reasons.

 * Look at diffcore_break().  It breaks filepairs with identical
   paths and nothing else.

   The reason for this check is that the caller can call
   diffcore_rename() _before_ diffcore_break() [*1*] and a
   filepair that was detected as renamed pair ought to be
   already found similar enough.  These days, I think you can
   replace the check with p->renamed_pair.

 * Look at diffcore_merge_broken(), which is responsible for
   re-merging a broken pair.  Because we match them by looking
   at their names (iow, we do not use pointers to link halves of
   a broken pair pointing at each other).

   This was correct before "no-index" stuff because "git diff"
   was about comparing pairs of blobs found at corresponding
   paths in two tree-like things (i.e. "a/one" and "b/one"
   corresponds to each other when you do "git diff -- one").
   The modification to introduce no-index forgot to update this
   logic.

If you wanted to fix this, you can change p->broken_pair from a
boolean to a pointer that points at the other half of the broken
pair (and record that when we break a pair in diffcore_break()),
and look at that pointer to decide which one to match up with
which other one in diffcore_merge_broken().  Together with a
change to look at p->renamed_pair instead of paths I mentioned,
I think it would work more like the regular git diff for
"no-index" case.

I consider that "no-index" frontend more or less a bolted on
half-baked hack that covers only minimally necessary cases to
serve as non-git "diff" replacement, without sharing enough with
the real "git diff" internals; I would not be surprised at all
if there are more corner cases like this that does not work.
But I do not think it is fundamentally unfixable.  The change to
add "no-index" support just needed to be more careful, and it is
not too late to make it so.


[Footnote]

*1* diffcore was designed as a generic library to allow
experimenting more combinations of transformations than what
then-current git used.  All of our existing callers ended up
calling the transformations in the same order (i.e. the order
diffcore_std() calls them), but individual transformations were
written not to assume too much about the order they would be
called.
