From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH] diff: do not use creation-half of -B as a rename target candidate
Date: Sun, 01 Feb 2015 19:18:35 -0800
Message-ID: <xmqqfvapuhkk.fsf@gitster.dls.corp.google.com>
References: <xmqqegqaahnh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 04:18:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YI7XA-0008VA-0P
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 04:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbbBBDSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2015 22:18:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754556AbbBBDSi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2015 22:18:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A985235E7A;
	Sun,  1 Feb 2015 22:18:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9kxybt7VHdJRqSY1gqGGfeGjbVc=; b=BDtvtT
	GlK4SwD8dOlTmGB2GYa8gFXT56gzbwCblnVnDuj4naAwaAOr/aO5KvcvfQLr7cu4
	Sjz6L6sAWm2c69i1/72VX/RM4xG+F1N9acUYmTP16C/f6Pp/kJBQECCwjBEHNRvw
	IzG5lLvcU3PHUhpGvZJUmfdjNI47YzkRa2sO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pzekxSscLJdzG4JL+MavVZwh4fpGCMQ3
	ZaWlUVeR+uDIoDZ2/9GsYhOOVcmoVm5XOlCVlEevRhz47lHMYJi2wX50LGas0mwe
	zFbGsUWrpe5wzHCpguUTO1/76wce38cYoK4XfdXw5z26diMhKUtGX1ZSizwkkv+q
	XItxCc75Y5k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A075A35E79;
	Sun,  1 Feb 2015 22:18:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 255E235E78;
	Sun,  1 Feb 2015 22:18:37 -0500 (EST)
In-Reply-To: <xmqqegqaahnh.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 31 Jan 2015 11:12:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2D63282C-AA8A-11E4-ACCF-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263247>

When a commit creates new file B by copying the contents of an
existing file A and making a small edit and makes large edit to A,
"diff -M" would not see any copying or renaming, because the file A
appears in both preimage and postimage.  The output ends up showing
two large patches, one that adds almost the entirety of original A
to the newly created file B, and the other that removes almost the
entirety of the original contents from A and adds new material to
it.

"diff -B -M" was invented to allow us notice this case and instead
express the change as one patch that copies A to B with small edit,
and rewrites A with contents unrelated to its original.  The patch
expressed this way becomes much easier to read, because the reader
can see that most of the contents in B after the change came from
the original A (the patch header shows "copy from A" for B), and A
was completely rewritten by the patch (the patch body shows
everything removed first and then all new material added).

However this logic has a bug to incorrectly produce an unapplicable
patch in other cases.  Starting from existing files A and B, when a
commit removes A and makes the resulting B similar to the original
contents of A, it incorrectly expressed it as a change that renames
A to B and then makes small edits.  Such a patch will not apply to
the original state the patch was taken from, as B exists there.

The root cause of the problem is that after the complete rewrite of
B is detected and is internally split into deletion of old B and
creation of new B, the rename detection machinery matches the old
contents of A (which will go away) with the newly created B, because
they are similar.  Considering the deletion-half of the change to B
as possible rename source (i.e. from which a new file is created) is
good, but considering the creation-half as possible rename
destination (i.e. the file is created by taking whole contents from
elsewhere) is bad---because we know B being a broken filepair means
it already existed, and cannot have been newly _created_.

For a simple reproduction, go to your copy of the kernel tree and do
this:

    $ git diff -B -M v2.6.13 v2.6.12 -- \
        arch/ppc64/kernel/rtas_pci.c arch/ppc64/kernel/pSeries_pci.c >:patch

    $ git reset --hard
    $ git checkout v2.6.13

    $ git apply --cached --whitespace=nowarn :patch
    error: arch/ppc64/kernel/pSeries_pci.c: already exists in index

In this example, rtas_pci.c and pSeries_pci.c corresponds to files A
and B, respectively, in the more general description of the problem
given earlier.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Here is what I am at the moment; I cannot quite explain (hence I
   cannot convince myself) why this is the right solution, but it
   seems to make the above sample case work without breaking any
   existing tests.  It is possible that the tests that would break
   without the "&& !p->score" bit are expecting wrong results, but I
   didn't look at them in detail.

 diffcore-rename.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6c7a72f..f4e8e00 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -516,6 +516,8 @@ void diffcore_rename(struct diff_options *options)
 			else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
 				 is_empty_blob_sha1(p->two->sha1))
 				continue;
+			else if (p->broken_pair && !p->score)
+				continue;
 			else
 				locate_rename_dst(p->two, 1);
 		}
-- 
2.3.0-rc2-165-gbd2cd9b
