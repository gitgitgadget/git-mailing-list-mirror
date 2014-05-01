From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 00/42] Use ref transactions for all ref updates
Date: Thu,  1 May 2014 13:37:00 -0700
Message-ID: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:40:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxmg-0003xB-6x
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbaEAUhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:37:47 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:61963 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbaEAUhp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:45 -0400
Received: by mail-yh0-f74.google.com with SMTP id i57so521884yha.1
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vcAXujEN5HCmXpXOBihcoZbVJwUciAld646ab+FOrDs=;
        b=Ox/Ihv7hoa9zaCYrFw0+F7jtME/5NzeBFAMYixreBWhy9+ysAjwAgIkfMdvTHizsEe
         cJPRD9mDeIvKHRvnwaIGJOI4Ff5cPNELWRTUEsz6k42iv/BYGrB1YzMvNh9IRVoVE50k
         7CQr5a4GUzqws0eh2yH48xuD9Bk1pMDqd+IVUMQCHv8qLoQueMRt+aPqE+cUs1360irm
         7ejAJNyuiuaYL2ulS47n2CJIX+BJu+Hw/pDV2eQhf/s1y4ziiUbC6v6q8X/mvbYlb/zt
         cs3rU+IimoR/vyyCcXiWtXAwt6YTDws2m2A61M3iVOyKiNCPALEhuFEi/aXdMk1csxTC
         fBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vcAXujEN5HCmXpXOBihcoZbVJwUciAld646ab+FOrDs=;
        b=TGM7b8vjlM8x+fEHI2KnJfOVTAyWJDhJQ49uuFtTXVrffTPJVpphypwUH58LDONBf2
         tzdB6sMBalvSF9SpDD2+7wPrcEYFDE8rz5uFT3AdDAojXTVHJv4nQjuWPBvHt4TijdZ2
         lDc3NH17Dr8A0k6dC3OlscxdsT/sfUkOgxsTbqYK7zH01OJH9s85t814pucefWqC3O3E
         QHQouZZ+LIWcZyt0sTXGyaEOg/VFiicUrRXC9Rsvc/kAVw6H+lHaKlh8gaPLNrS4k0Zd
         Lb0/vkQATde9UD2+DmyhWGCQjDaTODhjPvPx5xPEdbO3MfTeiUBzFGHKjJf8JcvP2ElX
         CS+A==
X-Gm-Message-State: ALoCoQm73cCglAYPD3AOVytdosUDX6EwyczY3sO14CGnAyAC4QepBmHYJqXgvQtubld6ixC3to9v
X-Received: by 10.236.92.15 with SMTP id i15mr6073288yhf.8.1398976664588;
        Thu, 01 May 2014 13:37:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si3537607yhk.4.2014.05.01.13.37.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 60D9B31C1CC;
	Thu,  1 May 2014 13:37:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 032C0E097F; Thu,  1 May 2014 13:37:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247876>

This patch series is based on next and expands on the transaction API. It
converts all ref updates, inside refs.c as well as external, to use the
transaction API for updates. This makes most of the ref updates to become
atomic when there are failures locking or writing to a ref.

This version completes the work to convert all ref updates to use transactions.
Now that all updates are through transactions I will start working on
cleaning up the reading of refs and to create an api for managing reflogs but
all that will go in a different patch series.


Version 6:
 - Convert all updates in refs.c to use transactions too.

Version 5:
 - Reword commit messages for having _create/_delete/_update returning
   success/failure. There are no conditions yet that return an error from
   these failures but there will be in the future. So we still check the
   return from these functions in the callers in preparation for this.
 - Don't leak memory by just passing a strbuf_detach() pointer to functions.
   Use <obj>.buf and explicitely strbuf_release the data afterwards.
 - Remove the function update_ref_lock.
 - Remove the function update_ref_write.
 - Track transaction status and die(BUG:) if we call _create/_delete/_update/
   _commit for a transaction that is not OPEN.

Version 4:
 - Rename patch series from "Use ref transactions from most callers" to
   "Use ref transactions for all ref updates".
 - Convert all external ref writes to use transactions and make write_ref_sha1
   and lock_ref_sha1 static functions.
 - Change the ref commit and free handling so we no longer pass pointer to
   pointer to _commit. _commit no longer frees the transaction. The caller
   MUST call _free itself.
 - Change _commit to take a strbuf pointer instead of a char* for error
   reporting back to the caller.
 - Re-add the walker patch after fixing it.

Version 3:
 - Remove the walker patch for now. Walker needs more complex solution
   so defer it until the basics are done.
 - Remove the onerr argument to ref_transaction_commit(). All callers
   that need to die() on error now have to do this explicitely.
 - Pass an error string from ref_transaction_commit() back to the callers
   so that they can craft a nice error message upon failures.
 - Make ref_transaction_rollback() accept NULL as argument.
 - Change ref_transaction_commit() to take a pointer to pointer argument for
   the transaction and have it clear the callers pointer to NULL when
   invoked. This allows for much nicer handling of transaction rollback on
   failure.

Version 2:
 - Add a patch to ref_transaction_commit to make it honor onerr even if the
   error triggered in ref_Transaction_commit itself rather than in a call
   to other functions (that already honor onerr).
 - Add a patch to make the update_ref() helper function use transactions
   internally.
 - Change ref_transaction_update to die() instead of error() if we pass
   if a NULL old_sha1 but have have_old == true.
 - Change ref_transaction_create to die() instead of error() if new_sha1
   is false but we pass it a null_sha1.
 - Change ref_transaction_delete die() instead of error() if we pass
   if a NULL old_sha1 but have have_old == true.
 - Change several places to do  if(!transaction || ref_transaction_update()
   || ref_Transaction_commit()) die(generic-message) instead of checking each
   step separately and having a different message for each failure.
   Most users are likely not interested in what step of the transaction
   failed and only whether it failed or not.
 - Change commit.c to only pass a pointer to ref_transaction_update
   iff current_head is non-NULL.
   The previous patch used to compute a garbage pointer for
   current_head->object.sha1 and relied on the fact that ref_transaction_update
   would not try to dereference this pointer if !!current_head was 0.
 - Updated commit message for the walker_fetch change to try to justify why
   the change in locking semantics should not be harmful.

Ronnie Sahlberg (42):
  refs.c: constify the sha arguments for
    ref_transaction_create|delete|update
  refs.c: allow passing NULL to ref_transaction_free
  refs.c: add a strbuf argument to ref_transaction_commit for error
    logging
  refs.c: make ref_update_reject_duplicates take a strbuf argument for
    errors
  update-ref.c: log transaction error from the update_ref
  refs.c: make update_ref_write update a strbuf on failure
  refs.c: remove the onerr argument to ref_transaction_commit
  refs.c: change ref_transaction_update() to do error checking and
    return status
  refs.c: change ref_transaction_create to do error checking and return
    status
  refs.c: ref_transaction_delete to check for error and return status
  tag.c: use ref transactions when doing updates
  replace.c: use the ref transaction functions for updates
  commit.c: use ref transactions for updates
  sequencer.c: use ref transactions for all ref updates
  fast-import.c: change update_branch to use ref transactions
  branch.c: use ref transaction for all ref updates
  refs.c: change update_ref to use a transaction
  refs.c: free the transaction before returning when number of updates
    is 0
  refs.c: ref_transaction_commit should not free the transaction
  fetch.c: clear errno before calling functions that might set it
  fetch.c: change s_update_ref to use a ref transaction
  fetch.c: use a single ref transaction for all ref updates
  receive-pack.c: use a reference transaction for updating the refs
  fast-import.c: use a ref transaction when dumping tags
  walker.c: use ref transaction for ref updates
  refs.c: make write_ref_sha1 static
  refs.c: make lock_ref_sha1 static
  refs.c: add transaction.status and track OPEN/CLOSED/ERROR
  refs.c: remove the update_ref_lock function
  refs.c: remove the update_ref_write function
  refs.c: remove lock_ref_sha1
  refs.c: make prune_ref use a transaction to delete the ref
  refs.c: make delete_ref use a transaction
  refs.c: pass the ref log message to _create/delete/update instead of
    _commit
  refs.c: pass NULL as *flags to read_ref_full
  refs.c: pack all refs before we start to rename a ref
  refs.c: move the check for valid refname to lock_ref_sha1_basic
  refs.c: call lock_ref_sha1_basic directly from commit
  refs.c: add a new flag for transaction delete for refs we know are
    packed only
  refs.c: pass a skip list to name_conflict_fn
  refs.c: make rename_ref use a transaction
  refs.c: remove forward declaraion of write_ref_sha1

 branch.c               |  31 ++--
 builtin/commit.c       |  24 ++-
 builtin/fetch.c        |  29 ++--
 builtin/receive-pack.c |  20 +--
 builtin/replace.c      |  15 +-
 builtin/tag.c          |  15 +-
 builtin/update-ref.c   |  32 ++--
 fast-import.c          |  39 +++--
 refs.c                 | 404 +++++++++++++++++++++++++++----------------------
 refs.h                 |  49 +++---
 sequencer.c            |  24 ++-
 t/t3200-branch.sh      |   2 +-
 walker.c               |  51 ++++---
 13 files changed, 414 insertions(+), 321 deletions(-)

-- 
2.0.0.rc1.351.g4d2c8e4
