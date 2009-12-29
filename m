From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/9] Undoing conflict resolution
Date: Tue, 29 Dec 2009 13:42:29 -0800
Message-ID: <1262122958-9378-1-git-send-email-gitster@pobox.com>
References: <7v6393mfqz.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 22:44:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjq3-0003CU-PF
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbZL2Vmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbZL2Vmn
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:42:43 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbZL2Vmm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:42:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4EAB8C7E6
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:references:in-reply-to; s=sasl; bh=s2g7
	J4veSqq/qcEdGWCIkP1ECno=; b=wh9LPrc1R0YIGnH4vN4Exbn3SbWYQUQdvgQo
	4JunIygt5a2nP8CwxhGj7saxpZSZ0v51bYpEREVhATKohds+TqBS3RJNswSPDL7Q
	N+F877zE8vJ1fxxiGYmtbfXxV/t1bSU94IE8MwDg1edxozdgll3fcNSAYpk/2mJh
	JFkjANA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:references:in-reply-to; q=dns; s=sasl; b=YuCDlr
	emJKPv383Hkzf+MmtPQyK8cK8racFGnPwEO+XTDnRjNXy6a0CPVP7aS2zbSCLCXI
	gWb/QObb84pDiAxpSy8QKOGd9tZLAFD3dqSk7eocD8VZ2STtLF5RlKoTryk7VtZK
	sKbgHvtSHbQMzxZySDuWZGoVu+dkJd79EyN4I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C09958C7E5
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 537258C7E4 for
 <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:40 -0500 (EST)
X-Mailer: git-send-email 1.6.6.60.gc2ff1
In-Reply-To: <7v6393mfqz.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 16E3ECEE-F4C3-11DE-83E2-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135833>

This series resurrects the topic we discussed later November.

I wrote a bit about this in http://gitster.livejournal.com/43665.html but
as usual with my patches, they do come with minimum set of tests but it
contains no documentation updates.  The user visible changes are:

 - ls-files has a new option primarily for debugging;
 - update-index has a new option --clear-resolve-undo;
 - rerere has a new subcommand forget.

Junio C Hamano (9):
  builtin-merge.c: use standard active_cache macros
  resolve-undo: record resolved conflicts in a new index extension
    section
  resolve-undo: basic tests
  resolve-undo: allow plumbing to clear the information
  resolve-undo: "checkout -m path" uses resolve-undo information
  resolve-undo: teach "update-index --unresolve" to use resolve-undo
    info
  rerere: remove silly 1024-byte line limit
  rerere: refactor rerere logic to make it independent from I/O
  rerere forget path: forget recorded resolution

 Makefile                  |    2 +
 builtin-checkout.c        |    6 +
 builtin-ls-files.c        |   43 +++++++-
 builtin-merge.c           |    9 +-
 builtin-read-tree.c       |    2 +
 builtin-rerere.c          |    2 +
 builtin-update-index.c    |   18 +++-
 cache.h                   |    4 +
 read-cache.c              |   18 +++
 rerere.c                  |  259 +++++++++++++++++++++++++++++++++++++-------
 rerere.h                  |    1 +
 resolve-undo.c            |  176 ++++++++++++++++++++++++++++++
 resolve-undo.h            |   16 +++
 t/t2030-unresolve-info.sh |  140 ++++++++++++++++++++++++
 14 files changed, 648 insertions(+), 48 deletions(-)
 create mode 100644 resolve-undo.c
 create mode 100644 resolve-undo.h
 create mode 100755 t/t2030-unresolve-info.sh
