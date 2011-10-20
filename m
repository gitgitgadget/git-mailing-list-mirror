From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/5] Signed-commit
Date: Wed, 19 Oct 2011 17:36:58 -0700
Message-ID: <1319071023-31919-1-git-send-email-gitster@pobox.com>
References: <1318983645-18897-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 02:37:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGgdL-0007SN-2j
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 02:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755622Ab1JTAhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 20:37:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32928 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755501Ab1JTAhG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 20:37:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59FAB693D
	for <git@vger.kernel.org>; Wed, 19 Oct 2011 20:37:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/Jgb
	L4FJYLzVlR3pG1HWav+Gius=; b=gXvgi7LphVlzUBT4KF3eoiKYDZNzQxX1cX4T
	5CWsUJmwzpQaZAUzPEpB0UvM5PC557TRWRoExTT9pff1d8gDOYlFByFitMClOecr
	H1Xq3Lb2XmydMwiztd05hkZSNdui5AvCPFvZKmMQ2wJPy/iTSCHdnje/9lJivWCy
	f0fZIw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BVb4+v
	R0WLzT8r6yoziX3UYEgaQsGAeE2I8U3Lxkbi29+7Ic+UcMm3AHJg+f2GAvmeuqC/
	h+7AkZ9u7Mzs3XPLKmNr0hioBQet4nWGNCDHsTffSH5KBZG91EpUAGLW+wN07Her
	CNjexuAum/AdIjv3CF1KGpnx11rewy/Qu41RA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51823693C
	for <git@vger.kernel.org>; Wed, 19 Oct 2011 20:37:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C53B8693B for
 <git@vger.kernel.org>; Wed, 19 Oct 2011 20:37:04 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.498.g3f2e50
In-Reply-To: <1318983645-18897-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A22EC2B8-FAB3-11E0-8739-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183991>

The fourth iteration.

 - The first patch refactors where the current code invokes gpg for
   signing and verification of tags;

 - The second patch introduces signed commit objects (unchanged);

 - The third patch teaches "git log/show" to show the signature (adjusted
   to the updated "gpg output capture" API, with colors);

 - The fourth patch refactors helper bits to test GPG related features
   out of existing "tag -s" && "tag --verify" test script (new); and

 - The fifth patch adds tests for "commit [--amend] -S", "merge -S",
   and "show --show-signature" (new).

I think the internal API to drive "gpg" in this iteration is good to go.
The verification side has been updated to allow the callers to capture
output from GPG in a strbuf, so that they can pretty-print it in a format
more suitable in their context, rather than just spewing it out to the
standard error stream.

Junio C Hamano (5):
  Split GPG interface into its own helper library
  commit: teach --gpg-sign option
  log: --show-signature
  t7004: extract generic "GPG testing" bits
  test "commit -S" and "log --show-signature"

 Makefile                 |    2 +
 builtin/commit-tree.c    |   24 +++++++-
 builtin/commit.c         |   12 +++-
 builtin/merge.c          |   16 +++++-
 builtin/tag.c            |   76 ++-----------------------
 builtin/verify-tag.c     |   35 ++----------
 commit.c                 |   74 ++++++++++++++++++++++++-
 commit.h                 |    5 +-
 gpg-interface.c          |  138 ++++++++++++++++++++++++++++++++++++++++++++++
 gpg-interface.h          |   10 +++
 log-tree.c               |   39 +++++++++++++
 notes-cache.c            |    2 +-
 notes-merge.c            |    2 +-
 revision.c               |    2 +
 revision.h               |    1 +
 t/lib-gpg.sh             |   29 ++++++++++
 t/lib-gpg/pubring.gpg    |  Bin 0 -> 1164 bytes
 t/lib-gpg/random_seed    |  Bin 0 -> 600 bytes
 t/lib-gpg/secring.gpg    |  Bin 0 -> 1237 bytes
 t/lib-gpg/trustdb.gpg    |  Bin 0 -> 1280 bytes
 t/t7004-tag.sh           |   29 +---------
 t/t7004/pubring.gpg      |  Bin 1164 -> 0 bytes
 t/t7004/random_seed      |  Bin 600 -> 0 bytes
 t/t7004/secring.gpg      |  Bin 1237 -> 0 bytes
 t/t7004/trustdb.gpg      |  Bin 1280 -> 0 bytes
 t/t7510-signed-commit.sh |   60 ++++++++++++++++++++
 tag.c                    |    5 ++
 27 files changed, 422 insertions(+), 139 deletions(-)
 create mode 100644 gpg-interface.c
 create mode 100644 gpg-interface.h
 create mode 100644 t/lib-gpg.sh
 create mode 100644 t/lib-gpg/pubring.gpg
 create mode 100644 t/lib-gpg/random_seed
 create mode 100644 t/lib-gpg/secring.gpg
 create mode 100644 t/lib-gpg/trustdb.gpg
 delete mode 100644 t/t7004/pubring.gpg
 delete mode 100644 t/t7004/random_seed
 delete mode 100644 t/t7004/secring.gpg
 delete mode 100644 t/t7004/trustdb.gpg
 create mode 100755 t/t7510-signed-commit.sh

-- 
1.7.7.498.g3f2e50
