From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: check for empty files when detecting
 creation patch
Date: Tue, 13 May 2008 14:48:00 -0700
Message-ID: <7vprrpswof.fsf@gitster.siamese.dyndns.org>
References: <1210257579-30975-1-git-send-email-imre.deak@gmail.com>
 <7vlk2h8t4d.fsf@gitster.siamese.dyndns.org>
 <500f3d130805131316m59898392l46e0dbf7cb352981@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Imre Deak" <imre.deak@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 13 23:49:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw2Mx-0004V7-ED
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 23:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758008AbYEMVsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 17:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756013AbYEMVsP
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 17:48:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbYEMVsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 17:48:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EF66145FF;
	Tue, 13 May 2008 17:48:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D909C45FC; Tue, 13 May 2008 17:48:08 -0400 (EDT)
In-Reply-To: <500f3d130805131316m59898392l46e0dbf7cb352981@mail.gmail.com>
 (Imre Deak's message of "Tue, 13 May 2008 23:16:11 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 491EAFE4-2136-11DD-A6B0-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82047>

"Imre Deak" <imre.deak@gmail.com> writes:

> On Sun, May 11, 2008 at 5:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Imre Deak <imre.deak@gmail.com> writes:
>>
>>  > When we can only guess if we have a creation patch, we do
>>  > this by treating the patch as such if there weren't any old
>>  > lines. Zero length files can be patched without old lines
>>  > though, so do an extra check for file size.
>>
>>  You described what your patch does, but you did not explain why it is a
>>  good addition.  One way to do so is to illustrate in what occasion what
>>  the existing code does is insufficient.
>
> The patch makes it possible to apply foreign patches (not created with
> git diff) to zero length files already existing in the index. The problem:
>
> $ git init
> Initialized empty Git repository in .git/
> $ rm -rf a
> $ touch a
> $ git add a
> $ git commit -madd
> Created initial commit 818f2b7: add
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 a
> $ echo 123 > a.new
> $ diff -u a a.new > patch
> $ git apply patch
> error: a: already exists in working directory
>
> The error happens because git guesses that `patch` is a creation patch
> and since `a` already exists in the index it will bail out.

Ok, that is much clearer.  How about this two-liner instead, then (the
first hunk is just an unreleated typofix)?

Originally when Linus wrote "git-apply" he was trying to be very cautious
and used the /dev/null cue only in a positive way (i.e. if the patch is
from /dev/null it is a creation).  But the preimage being something other
than /dev/null was not used as a statement that the patch is not a
creation.

Non SCM patches of any nontrivial size would be created by comparing two
trees with "diff -ru" (with some more combination of options).  We would
reliably use /dev/null cue in this case --- if the patch is from /dev/null
it is creation but more importantly if it is not from /dev/null it is not
creation but modification.

Patches from foreign SCMs also follow the /dev/null convention (e.g. SVN
and CVS --- I did not check Hg but I would be surprised if it didn't
follow suit), and we can reliably use the lack of /dev/null as a cue that
it is not a creation patch.

A single-file non SCM patches are done by comparing $a.orig and $a, $a~
and $a, etc., i.e. a pair of files the original and the modified with some
file suffixes.  What would people do to represent a creation in such a
case?  --- You are right.  By doing "diff -u /dev/null $a" (it is more
cumbersome to do "touch $a.empty; diff -u $a.empty $a").

So I think it is reasonable to use non-/dev/null-ness of first as a cue
that it is not a creation patch.

Linus, what do you think?  FYR, the original patch that led to this
conversation was:

    http://thread.gmane.org/gmane.comp.version-control.git/81531

---

 builtin-apply.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 1103625..9d7cb05 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -418,7 +418,7 @@ static int guess_p_value(const char *nameline)
 }
 
 /*
- * Get the name etc info from the --/+++ lines of a traditional patch header
+ * Get the name etc info from the ---/+++ lines of a traditional patch header
  *
  * FIXME! The end-of-filename heuristics are kind of screwy. For existing
  * files, we can happily check the index for a match, but for creating a
@@ -451,6 +451,8 @@ static void parse_traditional_patch(const char *first, const char *second, struc
 		name = find_name(first, NULL, p_value, TERM_SPACE | TERM_TAB);
 		patch->old_name = name;
 	} else {
+		patch->is_new = 0;
+		patch->is_delete = 0;
 		name = find_name(first, NULL, p_value, TERM_SPACE | TERM_TAB);
 		name = find_name(second, name, p_value, TERM_SPACE | TERM_TAB);
 		patch->old_name = patch->new_name = name;
