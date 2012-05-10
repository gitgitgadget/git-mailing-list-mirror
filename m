From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/9] "git apply --3way"
Date: Thu, 10 May 2012 15:32:44 -0700
Message-ID: <1336689173-15822-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 00:33:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSbuw-00062j-Hb
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 00:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444Ab2EJWc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 18:32:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36604 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118Ab2EJWc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 18:32:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B19E8423
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:32:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=OidhDXbUD0eNTrfRfpvobNLX3io
	=; b=GBhN2ZNE400X0YObP6X7PnREzJNPD81KUpAB2kSoWugBFZo3fwj4Qasm2Cu
	ubvqs8GyFDdeUE3+MlQOpNjjws2IlCyqhGG5Uoor3D01dqPIZEmUHa2cGembnr22
	jjLhvoJZ2W6wcpUO/BCpKA/6eXISJCgiVv0kjfe/6uZ6oX8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=N+cMe309GNh4JEOtE/aquhHu6onVF
	egc2OBVsrGphMOGR0v3DkbUMxVPK/iV4V+Xr5WzwyyuVtdetqu0AaZwm4cfRyMmj
	GwyAs/3IrDpYoWsHtZowtT2YZtqs1d0lBmCkW0K7aN8AQ4uCMFTdvEjGLt5nb5Xj
	guBlgb9QGtr2sU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32C338422
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:32:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A80118421 for
 <git@vger.kernel.org>; Thu, 10 May 2012 18:32:54 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.574.g840b38f
X-Pobox-Relay-ID: 15D59980-9AF0-11E1-A61C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197637>

Here is its second round.  Changes from the previous one are:

 - The series has been reordered to have refactoring patches early.

 - The option name is corrected to "--3way" and also takes short-and-sweet
   "-3" to parallel "am".

 - An invocation to ask "--3way" together with "--reject" is rejected.

 - The rerere machinery is given a chance to work on the resulting
   conflicts.

 - The option is now documented.

There are minor things that I still find suboptimal, but as a standalone
new feature, I consider it more or less good to go otherwise.

Here are some things people might be interested in enhancing (hint, hint):

 - Buffer error() messages from the first pass (i.e. attempting to apply
   to your current version) if the command is running under --3way mode,
   and show them if it turns out that we cannot fall back to the three-way
   logic (e.g. when the preimage on which the patch was allegedly based is
   not available, or the patch fails to apply to such a preimage).
   Otherwise discard the error messages from the first pass and show only
   the messages from the three-way merge phase.

 - Probably support add/add conflicts.  Note that this is prevented much
   earlier in the codepath and some surgery is needed to allow us to skip
   the first pass and go directly to the three-way codepath.

 - Similarly, a patch that attempts to delete a path that you no longer
   have is rejected early in the codepath. I have a hunch that it is not
   worth worrying about, because we do not know what we removed and cannot
   tell if what they removed is compatible with our earlier removal.

Junio C Hamano (9):
  apply: clear_image() clears things a bit more
  apply: refactor read_file_or_gitlink()
  apply: split load_preimage() helper function out
  apply: accept -3/--3way command line option
  apply: fall back on three-way merge
  apply: plug the three-way merge logic in
  apply: register conflicted stages to the index
  apply: allow rerere() upon --3way results
  apply: document --3way option

 Documentation/git-apply.txt |  10 ++-
 builtin/apply.c             | 202 +++++++++++++++++++++++++++++++++++++++-----
 t/t4108-apply-threeway.sh   | 103 ++++++++++++++++++++++
 t/t4117-apply-reject.sh     |   8 ++
 4 files changed, 303 insertions(+), 20 deletions(-)
 create mode 100755 t/t4108-apply-threeway.sh

-- 
1.7.10.1.574.g840b38f
