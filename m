From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/13] Improve "refs" module encapsulation
Date: Mon,  8 Jun 2015 13:45:34 +0200
Message-ID: <cover.1433763494.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:46:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vVW-0005Ml-HV
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbbFHLqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:46:15 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61237 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752333AbbFHLqG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 07:46:06 -0400
X-AuditID: 1207440e-f79fc6d000000caf-e5-55758070f372
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 61.58.03247.07085755; Mon,  8 Jun 2015 07:45:52 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58Bjoov017042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 07:45:51 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqFvQUBpq8LPJ1qLrSjeTRUPvFWaL
	2yvmM1v8aOlhtti8uZ3FgdXj7/sPTB4LNpV6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGdvmLWQsOClQMXFzE1MD412eLkZODgkBE4knd18wQthiEhfurWfrYuTiEBK4zChxZf9X
	VgjnBJPEzLXvWECq2AR0JRb1NDOB2CICahIT2w6xgBQxC3QwSlxYvo0dJCEsYCXR3jObGcRm
	EVCVWP5zDpjNK2Au0bAZYpCEgJzE+eM/mScwci9gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5da
	pGusl5tZopeaUrqJERIkfDsY29fLHGIU4GBU4uE9sKgkVIg1say4MvcQoyQHk5Iob1dZaagQ
	X1J+SmVGYnFGfFFpTmrxIUYJDmYlEV4mC6Acb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2
	ampBahFMVoaDQ0mCd04dUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KNjji4Hh
	DpLiAdq7CqSdt7ggMRcoCtF6ilGX48G/n4uYhFjy8vNSpcR5H4MUCYAUZZTmwa2ApYRXjOJA
	HwvzfgSp4gGmE7hJr4CWMAEt+f61GGRJSSJCSqqBMWHDbFOX2fO5th2LOHt7l8GkbCn3py83
	v9WSdAsJ273ZOujHge3Owg/XrpS3OeIwXUP+odbZJ26d/zYrM6ZfuDWv8kDtCceM6KgDOUq3
	pHfle3K0vBU7UJx80P1KScFKy7dJXNY/7qxVDnihFv654Fh5yR7eWh9rwS9Mf57K 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271017>

Add functions to the reference API to

* Delete a bunch of references at once, but *without* failing the
  whole transaction if one of the deletions fails. This functionality
  is used by `git remote remove` and `git remote prune`.

* Create initial references during `git clone`. (During clone,
  references are written directly to the `packed-refs` file without
  any locking.)

Also move the remaining "refs" function declarations from `cache.h` to
`refs.h`.

This improves the encapsulation of the refs module. Especially, it
means that code outside of the refs module should no longer need to
care about the distinction between loose and packed references.

These patches are also available from my GitHub account [1] as branch
"init-delete-refs-api".

[1] https://github.com/mhagger/git

Michael Haggerty (13):
  delete_ref(): move declaration to refs.h
  remove_branches(): remove temporary
  delete_ref(): handle special case more explicitly
  delete_refs(): new function for the refs API
  delete_refs(): improve error message
  delete_refs(): convert error message to lower case
  prune_remote(): use delete_refs()
  repack_without_refs(): make function private
  initial_ref_transaction_commit(): function for initial ref creation
  refs: remove some functions from the module's public interface
  initial_ref_transaction_commit(): check for duplicate refs
  initial_ref_transaction_commit(): check for ref D/F conflicts
  refs: move the remaining ref module declarations to refs.h

 archive.c               |   1 +
 builtin/blame.c         |   1 +
 builtin/clone.c         |  19 ++++-
 builtin/fast-export.c   |   1 +
 builtin/fmt-merge-msg.c |   1 +
 builtin/init-db.c       |   1 +
 builtin/log.c           |   1 +
 builtin/remote.c        |  33 +-------
 cache.h                 |  68 ----------------
 refs.c                  | 167 +++++++++++++++++++++++++++++++++++---
 refs.h                  | 210 +++++++++++++++++++++++++++++++-----------------
 remote-testsvn.c        |   1 +
 12 files changed, 316 insertions(+), 188 deletions(-)

-- 
2.1.4
