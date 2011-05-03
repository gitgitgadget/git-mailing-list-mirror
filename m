From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC] require-work-tree wants more than what its name says
Date: Tue, 03 May 2011 16:33:41 -0700
Message-ID: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 01:34:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHP6W-0005W1-Hk
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 01:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab1ECXdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 19:33:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab1ECXdt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 19:33:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C08F44043;
	Tue,  3 May 2011 19:35:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=z
	+ksC+/R16UyeabpVfRLiy3vzcw=; b=VmZvMb9hsqsjSpT4AJM4PmxcNb9XEVOrB
	nCTik64W79+7AmtOVKVw5mbbwPDA0ltnCYDYHxkc5Zcv8rAFUm/p+13NY1X8BQ4R
	kQRe3ngit5+iAdwTMfB/7d8jCgGoYIZ7bDhnuUOLvGFHqkXMyithaXlJC/+iUTkt
	519AVnzJnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=WRR
	rX9+GeO50RStS+X72vwz8DEawlqkiJ4iRHOpLMfxRKcEIVHDGuNE/0Y0F9js+yrG
	B0ilGKk5wdhVsk0idnMqWFqXTyHuEyyYFwP6zZietSp7bzPMtl6rJWgRSEIeBiaB
	M1M3N2ldGKdzvmxANaYz7PrMIZzzOF0fr2FD/7vE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ACBF74042;
	Tue,  3 May 2011 19:35:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E700B4041; Tue,  3 May 2011
 19:35:47 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13C8C442-75DE-11E0-B2DC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172702>

Somebody tried "git pull" from a random place completely outside the work
tree, while exporting GIT_DIR and GIT_WORK_TREE that are set to correct
places, e.g.

	GIT_WORK_TREE=$HOME/git.git
        GIT_DIR=$GIT_WORK_TREE/.git
        export GIT_WORK_TREE GIT_DIR
        cd /tmp
        git pull

At the beginning of git-pull, we check "require-work-tree" and then
"cd-to-toplevel".  I _think_ the original intention when I wrote the
command was "we MUST have a work tree, our $(cwd) might not be at the
top-level directory of it", and no stronger than that.  That check is a
very sensible thing to do before doing cd-to-toplevel.  We check that the
place we would want to go exists, and then go there.

But the implementation of require_work_tree we have today is quite
different.  I don't have energy to dig the history, but currently it says:

 	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
 	die "fatal: $0 cannot be used without a working tree."

Which is completely bogus.  Even though we may happen to be just outside
of it right now, we may have a working tree that we can cd_to_toplevel
back to.

I recall there was a discussion sometime last year about this topic, and
vaguely recall somebody proposed to swap the order of cd-to-toplevel and
require-work-tree.  While I agree that would sweep the issue under the rug,
I think the right solution would be to apply the attached patch; and then
audit all the callers that call "require_work_tree" to see if any of them
meant "No, it is not Ok just to have working tree somewhere! I want you to
be IN that working tree when you call me", and convert them to call the
new require_to_be_in_work_tree instead.

Thoughts?

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index aa16b83..0b25f12 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -141,6 +141,13 @@ cd_to_toplevel () {
 }
 
 require_work_tree () {
+	if test "z$(git rev-parse --is-bare-repository)" != zfalse
+	then
+		die "fatal: $0 cannot be used without a working tree."
+	fi
+}
+
+require_to_be_in_work_tree () {
 	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
 	die "fatal: $0 cannot be used without a working tree."
 }
