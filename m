From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/27] Clean up update-refs --stdin and implement ref_transaction
Date: Mon, 24 Mar 2014 18:56:33 +0100
Message-ID: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:59:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS99Y-0002sC-HI
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbaCXR5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:13 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54318 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752653AbaCXR5L (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:11 -0400
X-AuditID: 12074413-f79076d000002d17-d8-533071f50850
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 6D.E5.11543.5F170335; Mon, 24 Mar 2014 13:57:10 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xW028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:07 -0400
X-Mailer: git-send-email 1.9.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsUixO6iqPut0CDYYGuyxc51EhZdV7qZLBp6
	rzBbzLu7i8ni9or5zBY/WnqYLT52LmB2YPf4+/4Dk8fOWXfZPS69/M7m8fHZcnaPZ717GD0u
	XlL2+LxJLoA9itsmKbGkLDgzPU/fLoE7Y+rkM4wFG6UrGjbtYm9gPC/SxcjJISFgIrHoXQcT
	hC0mceHeerYuRi4OIYHLjBLr512Dck4wScw/MYEFpIpNQFdiUU8zWIeIgJrExLZDLCBFzAJX
	GCWufNwOViQsECLxasI5sCIWAVWJxSfbwGxeAReJa2sXMkOsk5OY8nsB+wRG7gWMDKsY5RJz
	SnN1cxMzc4pTk3WLkxPz8lKLdM31cjNL9FJTSjcxQkJJeAfjrpNyhxgFOBiVeHg3mBoEC7Em
	lhVX5h5ilORgUhLlZcsFCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhtQwHyvGmJFZWpRblw6Sk
	OViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHizCoAaBYtS01Mr0jJzShDSTBycIMO5pESK
	U/NSUosSS0sy4kHBHl8MDHeQFA/QXodCkL3FBYm5QFGI1lOMilLivNdA5gqAJDJK8+DGwhLE
	K0ZxoC+FedVA2nmAyQWu+xXQYCagweFNeiCDSxIRUlINjP0mv2+k5R9SPCh284qE3v71X2aK
	dnnEl08+wXfpKo/QVfV3v5bVOTM6vv85obF/Fes7My+WGbWW7iY7T20+afHM8Kv17ASDAuPq
	jaYtetn7vnPp83ar1LDpnD7Reujx8tYqjhNvs2u8cno31V6OuDHpqNiEkpBgFxZd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244857>

This is v2 of this patch series.  See also [1] for more context.

Thanks to Brad, Junio, and Johan for their feedback on v1 [2].  I
think I have addressed all of your points.

Changes relative to v1:

* Rename the functions associated with ref_transactions to be more
  reminiscent of database transactions:

  * create_ref_transaction() -> ref_transaction_begin()
  * free_ref_transaction() -> ref_transaction_rollback()
  * queue_update_ref() -> ref_transaction_update()
  * queue_create_ref() -> ref_transaction_create()
  * queue_delete_ref() -> ref_transaction_delete()
  * commit_ref_transaction() -> ref_transaction_commit()

* Change ref_transaction_commit() to also free the transaction, so the
  user doesn't have to think about memory resources at all.

* Fix backwards compatibility of "git update-ref --stdin -z"'s
  handling of the "create" command: allow <newvalue> to be the empty
  string, treating it the same zeros.  But deprecate this usage.

* Rebased to current master (there were no conflicts).

[1] http://article.gmane.org/gmane.comp.version-control.git/243726
[2] http://thread.gmane.org/gmane.comp.version-control.git/243731

Michael Haggerty (27):
  t1400: Fix name and expected result of one test
  t1400: Provide more usual input to the command
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
  t1400: Test that stdin -z update treats empty <newvalue> as zeros
  update-ref.c: Extract a new function, parse_next_sha1()
  update-ref --stdin -z: Deprecate interpreting the empty string as
    zeros
  t1400: Test one mistake at a time
  update-ref --stdin: Improve the error message for unexpected EOF
  update-ref --stdin: Harmonize error messages
  refs: Add a concept of a reference transaction
  update-ref --stdin: Reimplement using reference transactions
  refs: Remove API function update_refs()
  struct ref_update: Rename field "ref_name" to "refname"
  struct ref_update: Store refname as a FLEX_ARRAY.
  ref_transaction_commit(): Introduce temporary variables
  struct ref_update: Add a lock member
  struct ref_update: Add type field
  ref_transaction_commit(): Work with transaction->updates in place

 Documentation/git-update-ref.txt       |  18 +-
 builtin/checkout.c                     |   2 +-
 builtin/clone.c                        |   9 +-
 builtin/merge.c                        |   6 +-
 builtin/notes.c                        |   6 +-
 builtin/reset.c                        |   6 +-
 builtin/update-ref.c                   | 425 ++++++++++++++++++++-------------
 contrib/examples/builtin-fetch--tool.c |   3 +-
 notes-cache.c                          |   2 +-
 notes-utils.c                          |   3 +-
 refs.c                                 | 192 +++++++++++----
 refs.h                                 |  94 ++++++--
 t/t1400-update-ref.sh                  | 100 +++++---
 13 files changed, 582 insertions(+), 284 deletions(-)

-- 
1.9.0
