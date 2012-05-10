From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/8] "git apply --threeway"
Date: Wed,  9 May 2012 23:02:17 -0700
Message-ID: <1336629745-22436-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 08:02:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSMSU-00025a-4w
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 08:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574Ab2EJGC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 02:02:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449Ab2EJGC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 02:02:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7DE85FAC
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=DO5NzCLE0g4ABw8LLMACLHxZEOc
	=; b=Fop2SpCtKcN2Jbh2mrtGnHVHulKyvjApRlNsVwHof77eB19f9kf13v4+6DL
	b6iv5q3UEHqV5CNcSE4kqWHP2oF5R75usVvUC4jx5jlxj/j9hhCr0p9tHAaxG11+
	Zm4nFBmZIDovsHFq9U04qKzQtOCrKv/klax3Apvd6gR+VD80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=heFt29KNZ+ygJW8AVv2XRDOOMBGR8
	2Y1S2w/ty8SVX3ZpoGdk9il/WOj+sV4c6IgNgD+GTyuWPrLU2ktFS0QGvtf6g0f1
	wS9rogMHQp3wFJ2jhpUYI9LmMBKOrvmikJmKQlubN8QiJDNgsO7gdijYnmqYz1Ns
	PPeNFRp3q+uGJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF5075FAB
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 335F15FAA for
 <git@vger.kernel.org>; Thu, 10 May 2012 02:02:27 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.562.gfc79b1c
X-Pobox-Relay-ID: B84C22B4-9A65-11E1-BDD3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197538>

This series teaches "git apply" the same "three-way merge fallback" logic
that makes "am -3" so useful when flipping patches around.  For people who
do not know how "am -3" magic works, the basic idea goes like this:

 0) Suppose you have this history leading to commit E:

        O---A---B---...---E

 1) Also suppose you have a patch that is based on an older version; it no
    longer applies to the version of the file you have.  The patch would
    apply cleanly to the file in an older version, say A, and would result
    in file in a fictitious version X:

              X
             /
        O---A---B---...---E

    You can think of X as a commit where this patch was taken from, but
    there may not be any such commit in your object database.

 2) A useful observation to make here is that the result of applying such
    a patch to your current version should look similar to the result of
    merging X and E:

              X-------------M merge!
             /             /
        O---A---B---...---E

And this feature works exactly like that.

 - After trying and failing to apply the patch text, we inspect our object
   database and see if there is a blob object that matches what is
   recorded on the "index" line of the patch as its preimage.  We may not
   have such a blob object, and we give up in such a case.

 - And then we try to apply the patch text to that blob.  This also could
   fail, as the patch author could have tweaked the patch text after
   producing the patch with "git diff" without adjusting the "index" line.
   Again we simply give up in such a case.

 - When we successfully apply the patch to the older blob, the result
   would be what would appear in the fictitious commit X in the above
   picture.  We then try the usual file-level three-way merge between X
   and E using A as the base version.  This could cleanly merge, in which
   case we successfully applied the patch.  Or this could conflict, in
   which case we record the conflicted stages in the index, just like a
   conflicted "merge" or an "am -3" does, and leave the conflict markers
   in the result.

I've wanted to see this for the past few years, and even suggested that
this is a good bite-sized GSoC project, but unfortunately nobody bit it;
you have to do it yourself if you really want it, I guess.

Note that this iteration still does not do a few things:

 - We probably should call into the rerere machinery to have it help the
   user deal with the conflicts.

 - The "--threeway" option probably should be made explicitly incompatible
   with the "--reject" option (implement it when the command line is
   parsed).

 - It might make sense to make "--threeway" imply "--index", but it is not
   strictly necessary (see the second test case in t4108).

 - Documentation updates are missing.

 - "am -3" should be rewritten by using this.  That in turn means that the
   "--build-fake-ancestor" option of "git apply" will lose the only and
   the last in-tree user, but we may not be able to drop it immediately as
   there may be out-of-tree users.  On the other hand, any out-of-tree
   user that uses the "--build-fake-ancestor" option is reimplementing the
   three-way fallback on their own, and they can be updated to use the new
   "--threeway" option of "git apply".

 - Once this proves useful, it may deserve to use short-and-sweet "-3"
   option.

Junio C Hamano (8):
  apply: reformat comment
  apply: accept --threeway command line option
  apply: split load_preimage() helper function out
  apply: clear_image() clears things a bit more
  apply: refactor read_file_or_gitlink()
  apply: fall back on three-way merge
  apply: plug the three-way merge logic in
  apply: register conflicted stages to the index

 builtin/apply.c           | 198 +++++++++++++++++++++++++++++++++++++++++-----
 t/t4108-apply-threeway.sh |  78 ++++++++++++++++++
 2 files changed, 257 insertions(+), 19 deletions(-)
 create mode 100755 t/t4108-apply-threeway.sh

-- 
1.7.10.1.562.gfc79b1c
