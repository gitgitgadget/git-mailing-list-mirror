From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/19] "git apply --3way"
Date: Wed, 13 Jun 2012 12:32:41 -0700
Message-ID: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:34:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetKa-0001yQ-C0
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab2FMTdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754472Ab2FMTdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DE2786E8
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=1yZ4DtJi3WjLem628NAFG3vnS0U
	=; b=N5t97jquA+0I5RGyiQZ/c3OFw7Vo9xHjjkDXcv0/dWZmFT2VmFp7Cy/Ac5B
	p4AnToT92q9XS360eG+hgPhoyrRvnv1k3WfRCfPJukR6G2jBqTHUjbn6ishHEDcC
	8fJimXDVSMl6Qp9Lh+W2BdSn2k9ZCrDsqmdz6GhZxk+JtG/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=LXZOT30n0r7rmhJ6oCDGnwHvjRXP4
	mwtGKGcUegunnCQWDi/a58vqKMHmWZjp7C6CKRi4p3J//rU61WjipW0EJaazR2xQ
	TCPbQuPV7xzoeQaCmZsT/NRIRsumFt7nYM4bUBBFnrFmgdojTCj2SutEHyq8HLI6
	+8bTmbTpE2hLMg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75E1E86E7
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03E0486E6 for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
X-Pobox-Relay-ID: 96F20072-B58E-11E1-ABE3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199936>

Here is the third round.  Previous ones are:

    http://thread.gmane.org/gmane.comp.version-control.git/197538
    http://thread.gmane.org/gmane.comp.version-control.git/197637

"git am -3" is useful when you have to accept a patch submission to
a tree that has slightly been modified, but when you are reordeing
your own work, you would be picking some parts of a later commits to
earlier codebase without wanting to make commits out of individual
steps.

Teach "git apply" a similar "-3"way merge fallback option with this
series, and you can now apply your patches without having to reduce
context.  As it will leave the conflicted halves in the index and
let you manually resolve conflicts in the working tree, "--3way"
implies "--index", and cannot be used with "--cached".

Note that this does not call merge-recursive like "am -3" does, and
does not implement renames (i.e. a patch wants to modify path A,
your codebase has the corresponding contents at path B---"git am -3"
will end up modifying path B, but the round of this series does
not).  It should be more or less straightforward to enhance it,
though.  Instead of aborting with "preimage A does not exist in the
index nor the working tree", after finding the necessary blob that
the patch author had at path A, you run the similarity algorithm
with the blob in your tree to find path B, update the "struct patch"
to rewrite it to apply to path B, and let the existing code take
care of the rest.

Given that I started this early last month, even discounting the
fact that I was looking at it only in the background, the whole
thing would have been a bit too big for a student inexperienced to
the code base to swallow.  I would say that it would be a good
bite-sized GSoC project next summer to build on this series and make
it replace the "am -3" implementation (that means the above "apply a
patch to A to path B" needs to be added), which lets us kill the
ugly "--build-fake-ancestor" hack.

Junio C Hamano (19):
  apply: fix an incomplete comment in check_patch()
  apply: a bit more comments on PATH_TO_BE_DELETED
  apply: clear_image() clears things a bit more
  apply: refactor read_file_or_gitlink()
  apply: factor out checkout_target() helper function
  apply: split load_preimage() helper function out
  apply: refactor "previous patch" logic
  apply: further split load_preimage()
  apply: move check_to_create_blob() closer to its sole caller
  apply: move "already exists" logic to check_to_create()
  apply: accept -3/--3way command line option
  apply: fall back on three-way merge
  apply: plug the three-way merge logic in
  apply: move verify_index_match() higher
  apply: --3way with add/add conflict
  apply: register conflicted stages to the index
  apply: allow rerere() upon --3way results
  apply: document --3way option
  apply --3way: tests

 Documentation/git-apply.txt |  11 +-
 builtin/apply.c             | 550 ++++++++++++++++++++++++++++++++++----------
 t/t4108-apply-threeway.sh   | 157 +++++++++++++
 t/t4117-apply-reject.sh     |   8 +
 4 files changed, 608 insertions(+), 118 deletions(-)
 create mode 100755 t/t4108-apply-threeway.sh

-- 
1.7.11.rc3.30.g3bdace2
