From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/23] Add reflog_expire() to the references API
Date: Fri,  5 Dec 2014 00:08:12 +0100
Message-ID: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:08:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfW4-0002oj-IF
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933316AbaLDXIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:08:50 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60069 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933201AbaLDXIs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:08:48 -0500
X-AuditID: 1207440e-f79d26d000001b6e-7e-5480e97a1648
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id E9.67.07022.A79E0845; Thu,  4 Dec 2014 18:08:42 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8ddv027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:08:40 -0500
X-Mailer: git-send-email 2.1.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqFv1siHE4E4jl0XXlW4mi4beK8wW
	b28uYbS4vWI+s0Vv3ydWi82b21kc2Dz+vv/A5LFz1l12jwWbSj0uXlL2+LxJLoA1itsmKbGk
	LDgzPU/fLoE74/G0yYwFs2Qqbu64yNzAOF28i5GTQ0LAROL6rCY2CFtM4sK99UA2F4eQwGVG
	iee7OpkgnGNMEi9nHWcEqWIT0JVY1NPMBGKLCKhJzFw1G6yDWeAEo8Svyd1ARRwcwgIOEuuu
	5IDUsAioSmx7eYgNJMwr4CKx52s0iCkhICexdZ33BEbuBYwMqxjlEnNKc3VzEzNzilOTdYuT
	E/PyUot0jfVyM0v0UlNKNzFCAoVvB2P7eplDjAIcjEo8vAW760OEWBPLiitzDzFKcjApifKe
	fdoQIsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE1/gIUI43JbGyKrUoHyYlzcGiJM6rtkTdT0gg
	PbEkNTs1tSC1CCYrw8GhJMFb+gKoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4U
	5vHFwEAHSfEA7S0DaectLkjMBYpCtJ5iVJQS57UGSQiAJDJK8+DGwuL/FaM40JfCENt5gKkD
	rvsV0GAmoMFnG2pBBpckIqSkGhh73x6+4+brlq27IsO/5JVlD4PbHh7vv1ceGycKf542I0P/
	A5ezYP4KP6+QTGZzFdbn941qmh73iEwSeyS6fPsi4fT7d7/dEJq5TYb1y3oG1rr4hjVHZGzE
	TDdNcdtQvbene97F1proWbWCaxVUXpQJbnzc21JUF3zv5JfJSgf8o4u2u99/OleJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260812>

I propose this patch series as an alternative to Ronnie's "reflog
transactions" series.

Both alternatives have been discussed exhaustively on the list [1,2].
My opinion is that there is no need to allow arbitrary reflog changes
via the ref_transaction API, because just about the only things we
want to do are

* Append an entry to a reflog when a reference is updated. This should
  (and is already) done as a side effect of the reference update.

* Expire or delete old reflog entries based on relatively complicated
  logic, possibly repairing the remaining entries so as to preserve
  the continuity of the reflog chain.

This patch series shows that the latter can be done with a single,
fairly simple, purpose-made function, expire_reflog(), in the
references API. The policy for what reflog entries should be expired
is specified by the caller via three callback functions that don't
have to know anything about how reflogs are stored. The locking,
iteration, repair, and writing is implemented within the references
module, in a function that can easily be swapped out when pluggable
reference backends are implemented.

The remaining reflog operations (enabling/disabling reflogs for a
reference, renaming the reflog when a reference is renamed) are not
especially difficult but will be brought into the same framework in a
future patch series.

The first few patches and the last few are taken from Ronnie's and
Stefan's work. I chose *not* to rename the ref_transaction functions
for obvious reasons. A couple of the later patches from their series
would make sense but are not duplicated here.

This branch is also available on GitHub:

    https://github.com/mhagger/git.git, branch reflog-expire-api-v1

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/259712/focus=259770
[2] http://thread.gmane.org/gmane.comp.version-control.git/260731/focus=260767

Michael Haggerty (17):
  expire_reflog(): remove unused parameter
  expire_reflog(): rename "ref" parameter to "refname"
  expire_reflog(): exit early if the reference has no reflog
  expire_reflog(): use a lock_file for rewriting the reflog file
  Extract function should_expire_reflog_ent()
  expire_reflog(): extract two policy-related functions
  expire_reflog(): add a "flags" argument
  expire_reflog(): move dry_run to flags argument
  expire_reflog(): move updateref to flags argument
  Rename expire_reflog_cb to expire_reflog_policy_cb
  struct expire_reflog_cb: a new callback data type
  expire_reflog(): pass flags through to expire_reflog_ent()
  expire_reflog(): move verbose to flags argument
  expire_reflog(): move rewrite to flags argument
  Move newlog and last_kept_sha1 to "struct expire_reflog_cb"
  expire_reflog(): treat the policy callback data as opaque
  reflog_expire(): new function in the reference API

Ronnie Sahlberg (5):
  refs.c: make ref_transaction_create a wrapper for
    ref_transaction_update
  refs.c: make ref_transaction_delete a wrapper for
    ref_transaction_update
  refs.c: add a function to append a reflog entry to a fd
  refs.c: remove unlock_ref/close_ref/commit_ref from the refs api
  lock_any_ref_for_update(): inline function

Stefan Beller (1):
  refs.c: don't expose the internal struct ref_lock in the header file

 builtin/reflog.c | 259 ++++++++++++++++++++++---------------------------------
 refs.c           | 251 +++++++++++++++++++++++++++++++++++------------------
 refs.h           |  74 ++++++++++------
 3 files changed, 319 insertions(+), 265 deletions(-)

-- 
2.1.3
