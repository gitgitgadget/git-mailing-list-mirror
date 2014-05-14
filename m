From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 00/31] Finish implementing ref and reflog transactions
Date: Wed, 14 May 2014 15:12:59 -0700
Message-ID: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:15:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhSU-0000zu-DB
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbaENWNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:13:33 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:34873 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaENWNc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:32 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so47128veb.4
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hQS91+sf9lf/x4j1Rui3Ii3MV2cmITejbpXDuvItI7c=;
        b=O7FmV0S4ARzyWfj4cWo+91/3K3jyOtyIzidnBw0+drWfYfRGcnUzBmLU7ylTNukhsD
         /RQ7S8Uc7GboXQRHt0y8ZVG+r7QZv8RllMxnlL9yFD2xopQtsnx6gzuVv6VMRDYXyGEX
         sVBCzYG8pQO9DApwwLOKIVNY7IxAeCU865zynmlE/UH7OhQss0u6XQCs8GNyLeC6PKUz
         6JPoOLzQ16thSpeLIG83iCCCzpzWXNg4nWaDx2zzo04uPmB0TJHLNJuFfqSZySoeuVFP
         FsdxIj4w+6hoqXiajHpnY3GLrNzQ2oP3SAhzRaFNH5G2QlH6VgRvGet9svqxOD6ETuu/
         utWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hQS91+sf9lf/x4j1Rui3Ii3MV2cmITejbpXDuvItI7c=;
        b=Y42InXIdQm3oDWSd2xmuwHNDUjp5qrQGGx4Pge7tKY1WWZ63Qr5j+cN5FZLMrGCQSa
         Q5L5l8bg8OKRQ++7NfbCqtW//oeSqOF2m/LCwWBs6BSPirW80vO7ZmbCBVxWVurvy5+g
         XYKhSY5DZo6qCJ/QtdkpM4PhLUeypn+mG/c5AnXCbon6b4zp4MXbR7ARs5fOy/WpmXgE
         K2ij9rRUdd6HyN+a+kL88T7gZ/8wtncU7pbVZNbIvdfbaXDzAxBfxuaY39CFkBT/xa4b
         AXX2ZOC6DtyiypE/SYmTXHGrI7Fqh8rNtBiTTb1bz2HojCui6md1626tu4A7ZsiRBKTU
         SgaQ==
X-Gm-Message-State: ALoCoQm7uMDxenh//ap3MDxiPCqzkJyyVxoBMydEo7KUi1A01nWNLc6VRre0WFiPX5VpneSHACQ6
X-Received: by 10.58.225.197 with SMTP id rm5mr3021895vec.5.1400105612279;
        Wed, 14 May 2014 15:13:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r79si152481yhj.2.2014.05.14.15.13.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 24FEF5A41E5;
	Wed, 14 May 2014 15:13:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B8179E038E; Wed, 14 May 2014 15:13:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249036>

This patch series is available also from
https://github.com/rsahlberg/git/tree/ref-transactions-next
and is based on
https://github.com/rsahlberg/git/tree/ref-transactions

This is a preview of the direction for the transaction work and finished
converting also reflog handling to transactions. This greatly simplifies
both the implementation of rename_ref in refs.c as well as reflog.c

This patch series is not fully finished and can not be applied until
the previous series is merged. Once this series is finished we will be
in pretty good shape to start experimenting with alternative refs backends
such as a TDB database.



Ronnie Sahlberg (31):
  refs.c make ref_transaction_create a wrapper to ref_transaction_update
  refs.c: make ref_transaction_delete a wrapper for
    ref_transaction_update
  refs.c: rename the transaction functions
  refs.c: add a new update_type field to ref_update
  refs.c: add a function to append a reflog entry to a fd
  refs.c: add a transaction function to append a reflog entry
  refs.c: add a flag to allow reflog updates to truncate the log
  refs.c: only write reflog update if msg is non-NULL
  refs.c: allow multiple reflog updates during a single transaction
  reflog.c: use a reflog transaction when writing during expire
  refs.c: null terminate the string in copy_msg
  refs.c: track the refnames we are deleting in the transaction
    structure
  refs.c: update the list of deleted refs during _update instead of
    _commit
  refs.c: return error instead of dying when locking fails during
    transaction
  refs.c: lock the ref during _update instead of during _commit
  refs.c: add an error argument to create/delete/update just like commit
  refs.c: make _update_reflog take an error argument
  refs.c: return immediately from _commit if the transaction has an
    error
  tests: move tests for -z update/delete/verify to after the ref is
    created
  refs.c: check for lock conflicts already in _update
  refs.c allow multiple updates of the same ref in a transaction
  refs.c: release all remaining locks during transaction_free
  reflog.c: use the existing transaction to also lock and update the ref
  refs.c: make unlock_ref static
  refs.c: make close_ref static
  refs.c: make commit_ref static
  refs.c: remove the function lock_any_ref_for_update
  refs.c: make struct ref_lock private to refs.c
  refs.c: allow passing raw git_committer_info as email to
    _update_reflog
  refs.c: move ref_update and other definitions to earlier in the file
  refs.c: use the transaction to manage the reflog in rename_refs

 branch.c               |  11 +-
 builtin/commit.c       |  14 +-
 builtin/fetch.c        |  10 +-
 builtin/receive-pack.c |  11 +-
 builtin/reflog.c       |  76 +++---
 builtin/replace.c      |  10 +-
 builtin/tag.c          |  10 +-
 builtin/update-ref.c   |  34 +--
 fast-import.c          |  26 ++-
 refs.c                 | 611 +++++++++++++++++++++++++++++++++----------------
 refs.h                 |  86 +++----
 sequencer.c            |  12 +-
 t/t1400-update-ref.sh  |  59 +++--
 walker.c               |  15 +-
 14 files changed, 610 insertions(+), 375 deletions(-)

-- 
2.0.0.rc3.506.g3739a35
