From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/3] Signed-commit
Date: Tue, 18 Oct 2011 17:20:42 -0700
Message-ID: <1318983645-18897-1-git-send-email-gitster@pobox.com>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 02:20:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGJtt-0007BK-5w
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 02:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968Ab1JSAUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 20:20:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48265 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269Ab1JSAUs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 20:20:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AA4644DA
	for <git@vger.kernel.org>; Tue, 18 Oct 2011 20:20:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=EY1I
	1hrrwA6kmx+Jwx2QvLRZwOY=; b=I4wkIEG6l6ADx6PcpPJsY/t5DOEqEGreUokW
	59qy61nxddQMDSK/aXvUie9COwXMXLwuMkRFQXqIX0wt44MvE5doKS2k6oEByupd
	kvt6WaQoOO/RHgyfm7V7fDmEdNToBEVBjWIDdDkLHkz0K7d5KWc6Jc6BLF8cfnAQ
	heE3aRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Ge2Qo7
	uYn6fE+a0UVRKkY78I8wiq2yrxFQVzniX35umODN+FGvw3QxeS7IGpCdQmsW1ZQa
	30NANU50uaqKboFJYjFcpKlLIuEIepuDVUAwrkz6xPuyjLy3+ccfKfI/3/sj/mol
	cingNZaRUx/R3pfJRAD87IiHOA7x+0JZKvoi4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81BE844D9
	for <git@vger.kernel.org>; Tue, 18 Oct 2011 20:20:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05D4E44D8 for
 <git@vger.kernel.org>; Tue, 18 Oct 2011 20:20:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.388.g3a4b7
In-Reply-To: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 30F7055E-F9E8-11E0-96C7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183909>

This is another re-roll of the signed-commit topic.

 - The first patch refactors where the current code invokes gpg for
   signing and verification of tags;

 - The second patch introduces signed commit objects;

 - The third patch teaches "git log/show" to show the signature.

The internal API to drive "gpg" has been updated to better suit the
verification side, but I suspect that it needs another round of revamp to
slurp in the diagnostic message "gpg" produces to give us better control
of the formatting of the output. e.g.

    $ git show --format="%h %s%n%gpgsign" -s HEAD

might want to say:

    a030b7cf log: --show-signature
    RSA key ID 96AFE6CB, Good signature from "Junio C Hamano <gitster@pobox.com>"

or something like that, but the series is not there yet.

Junio C Hamano (3):
  Split GPG interface into its own helper library
  commit: teach --gpg-sign option
  log: --show-signature

 Makefile              |    2 +
 builtin/commit-tree.c |   24 ++++++++-
 builtin/commit.c      |   12 ++++-
 builtin/merge.c       |   16 +++++-
 builtin/tag.c         |   76 ++-------------------------
 builtin/verify-tag.c  |   36 ++-----------
 commit.c              |   74 ++++++++++++++++++++++++++-
 commit.h              |    5 ++-
 gpg-interface.c       |  137 +++++++++++++++++++++++++++++++++++++++++++++++++
 gpg-interface.h       |   10 ++++
 log-tree.c            |   17 ++++++
 notes-cache.c         |    2 +-
 notes-merge.c         |    2 +-
 revision.c            |    2 +
 revision.h            |    1 +
 tag.c                 |    5 ++
 16 files changed, 310 insertions(+), 111 deletions(-)
 create mode 100644 gpg-interface.c
 create mode 100644 gpg-interface.h

-- 
1.7.7.388.g3a4b7
