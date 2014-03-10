From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/26] Clean up update-refs --stdin and implement ref_transaction
Date: Mon, 10 Mar 2014 13:46:17 +0100
Message-ID: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:46:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzbc-000718-8u
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbaCJMqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:46:51 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:57324 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753488AbaCJMqu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:46:50 -0400
X-AuditID: 1207440f-f79326d000003c9f-c1-531db43933b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 5B.EA.15519.934BD135; Mon, 10 Mar 2014 08:46:49 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwO025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:46:47 -0400
X-Mailer: git-send-email 1.9.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqGu5RTbY4FePqMXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO+PJ5eMsBXflK96dP8vcwDhFoouRk0NCwETi8eUL
	LBC2mMSFe+vZuhi5OIQELjNKzLi9khHCOcEk8a79KTNIFZuArsSinmYmEFtEQE1iYtshFpAi
	ZoErjBKfv/5iB0kICwRKdP86ATaWRUBVYvvuPawgNq+As8TS5VtYIdbJSUz5vYB9AiP3AkaG
	VYxyiTmlubq5iZk5xanJusXJiXl5qUW6Jnq5mSV6qSmlmxghwcS/g7FrvcwhRgEORiUe3gNv
	ZYKFWBPLiitzDzFKcjApifJOXCsbLMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN3MxUI43JbGy
	KrUoHyYlzcGiJM6rvkTdT0ggPbEkNTs1tSC1CCYrw8GhJMF7eDNQo2BRanpqRVpmTglCmomD
	E2Q4l5RIcWpeSmpRYmlJRjwo2OOLgeEOkuIB2rsNpJ23uCAxFygK0XqKUVFKnHcOSEIAJJFR
	mgc3FpYiXjGKA30pzNsKUsUDTC9w3a+ABjMBDW4+LgUyuCQRISXVwMhpolIoF7nNIMMi4Oiu
	DlcW5nVMu+R6ShodCjZP3OoTvernux/lsaF3bUUmWsaa9iQws+pPcHz9YubrHGuNR+2L41yZ
	zNNXz977d/K750cyNpn1sP/5ERqb8+RBSMVTkZ7mt9G8Fxau5/VM5zBVbftQ9vBm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243731>

I just sent an email to the list [1] describing how I want to
decouple reference-handling code from the rest of Git, and implement
pluggable reference storage backends.  This patch series is the first
movement in that direction.

update_refs() and "update-ref --stdin" implement the beginning of
transactions for git references, by allowing a group of reference
changes to be done in an all-or-nothing fashion.  The main point of
this patch series is to increase the abstraction level of the API for
dealing with reference transactions, by moving the handling of the
transaction to refs.c.  The new API for dealing with reference
transactions is

    ref_transaction *transaction = create_ref_transaction();
    queue_create_ref(transaction, refname, new_sha1, ...);
    queue_update_ref(transaction, refname, new_sha1, old_sha1, ...);
    queue_delete_ref(transaction, refname, old_sha1, ...);
    ...
    if (commit_ref_transaction(transaction, msg, ...))
        die(...);

When implementing this I found a number of minor problems in the
implementation of "git update-ref --stdin", not to mention that it
used "struct ref_update" all the way up and down its parser call
stack.  So most of the commits in this series are actually cleanups in
builtin/update-ref.c.  I also spend some time making the error
messages emitted by that command more uniform.

Then, in just a couple of commits, the ref_transaction abstraction is
introduced, update-ref is changed to use it, and update_refs() is
removed from the refs API (it was only used by this one caller).

Finally, now that refs.c owns the data structures for dealing with
transactions, it is possible to make a few simplifications.  More
changes in this neighborhood will be coming in future patches.

[1] http://article.gmane.org/gmane.comp.version-control.git/243726

Michael Haggerty (26):
  t1400: Fix name and expected result of one test
  t1400: Provide sensible input to the command
  t1400: Pass a legitimate <newvalue> to update command
  parse_arg(): Really test that argument is properly terminated
  t1400: Add some more tests involving quoted arguments
  refs.h: Rename the action_on_err constants
  update_refs(): Fix constness
  update-ref --stdin: Read the whole input at once
  parse_cmd_verify(): Copy old_sha1 instead of evaluating <oldvalue>
    twice
  update-ref.c: Extract a new function, parse_refname()
  update-ref --stdin: Improve error messages for invalid values
  update-ref --stdin: Make error messages more consistent
  update-ref --stdin: Simplify error messages for missing oldvalues
  update-ref.c: Extract a new function, parse_next_sha1()
  update-ref --stdin: Improve the error message for unexpected EOF
  update-ref --stdin: Harmonize error messages
  refs: Add a concept of a reference transaction
  update-ref --stdin: Reimplement using reference transactions
  refs: Remove API function update_refs()
  struct ref_update: Rename field "ref_name" to "refname"
  struct ref_update: Store refname as a FLEX_ARRAY.
  commit_ref_transaction(): Introduce temporary variables
  struct ref_update: Add a lock member
  struct ref_update: Add type field
  commit_ref_transaction(): Also free the ref_transaction
  commit_ref_transaction(): Work with transaction->updates in place

 builtin/checkout.c                     |   2 +-
 builtin/clone.c                        |   9 +-
 builtin/merge.c                        |   6 +-
 builtin/notes.c                        |   6 +-
 builtin/reset.c                        |   6 +-
 builtin/update-ref.c                   | 402 +++++++++++++++++++--------------
 contrib/examples/builtin-fetch--tool.c |   3 +-
 notes-cache.c                          |   2 +-
 notes-utils.c                          |   3 +-
 refs.c                                 | 184 +++++++++++----
 refs.h                                 |  93 ++++++--
 t/t1400-update-ref.sh                  |  86 ++++---
 12 files changed, 524 insertions(+), 278 deletions(-)

-- 
1.9.0
