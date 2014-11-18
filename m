From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 00/16] ref-transaction-rename
Date: Mon, 17 Nov 2014 17:44:41 -0800
Message-ID: <1416275097-3616-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:46:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXsA-0004DS-VJ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbaKRBpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:45:04 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:57719 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaKRBpC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:45:02 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so3392126igb.5
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bkoJggEoS1Dxyqx6qPV5N5FJHdab+pq0jH7q1l8JnhM=;
        b=E5Ei1kJaNZEn5ayjkCRfKYQD2koprcDZlPUDuW0ZsygIylUMLue8ZD4II9A8d1yT/4
         c0DAJ12kez+MjV9HLjhV2u7eUqmNaEbnWHEkjge8yu1LMq46GM1nYSgEHFabyn78cJ2e
         5C/EWupJL8r0ysufU2vvo5tVEoWhq03OAqhoIO7VnF2/WoAbVcRFRXC1wGxuWScLPzBi
         CLMz8WLxfH7gZUpDpHUY9kUzcGLH5QX7JhxNqQgc+GiVKc0nPriAcbhakBahWqx2YRvI
         3DSW9qweslaq+Y+/XZFupazeFFDjzt6EB56MGayGHISrDJ+TnZmDL7UwQdjIXx+Yu+VU
         3ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bkoJggEoS1Dxyqx6qPV5N5FJHdab+pq0jH7q1l8JnhM=;
        b=Td2vOTstAYbcQUoJU1MVVIFoc0pygcV8U0FMT3JWnATUjJwk84kWKyD6ktoh7pF+QH
         D9mRJ+e02hCjVCdM0iWpPSvae1FguiCFdX1sy/CxgenZ96RvJA63k6wd58AJooXbje00
         Jc8nEpG3jKYje01fB8tulWCz7arZ+oowzLVE5bWEBZ4tZ/j3k5PV2nErX7qRPhufnXxY
         w7TwnZnafnZzzJhL5U9H/Z6DhXyK4cHBKWQQKNs7zab3WUn1v9L4SjRw69ubWArWdT/K
         RygBPE9oGJ/U0ri1xeXU+ia2QrURznvUmkmIDZxdrvvVPlbAcbn+N2qYeZ7N04NSPag2
         hfbw==
X-Gm-Message-State: ALoCoQmRKNUdztrLB/cIgTQcEVAV0J590fXUzS4+dEo5ZVrBb2i6Fa4W4a7iF/2itIHHxLcd64gt
X-Received: by 10.107.133.17 with SMTP id h17mr14920916iod.47.1416275101791;
        Mon, 17 Nov 2014 17:45:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id y2sm6880218igl.8.2014.11.17.17.45.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:45:01 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This series builds on the previous series : ref-transaction-reflog
as applied to master. This series has been sent to the list before[1]

This series can also be found at github[2] as well as googlesource[3].

This series converts ref rename to use a transaction. This addesses several
issues in the old implementation, such as colliding renames might overwrite
someone elses reflog, and it makes the rename atomic.

As part of the series we also move changes that cover multiple refs to happen
as an atomic transaction/rename to the pacekd refs file. This makes it possible
to have both the rename case (one deleted ref + one created ref) as well
as any operation that updates multiple refs to become one atomic rename()
applied to the packed refs file. Thus all such changes are now also atomic
to all external observers.

Thanks,
Stefan

Version 2:
- Changed to not use potentially iterators to copy the reflog entries one
  by one. Instead adding two new functions. One to read an existing reflog
  as one big blob, and a second function to, in a transaction, write a new
  complete reflog from said blob.
  The idea is that each future reflog backend will provide optimized
  versions for these "read whole reflog" "write whole reflog" functions.

Version 3:
- Rename and redo the API for updating a whole reflog in one single operation
  to transaction_rename_reflog()

Version 4:
 * As Ronnie announced to change employers soon, he'll have only limited
   time to work on git in the near future. As this is a rather large patch
   series, he is handing this work over to me. That's why I'm sending the
   patches this time.

[1] http://www.spinics.net/lists/git/msg241352.html
[2] https://github.com/stefanbeller/git/tree/ref-transactions-rename
[3] https://code-review.googlesource.com/#/q/topic:ref-transaction-rename

Ronnie Sahlberg (16):
  refs.c: allow passing raw git_committer_info as email to
    _update_reflog
  refs.c: return error instead of dying when locking fails during
    transaction
  refs.c: use packed refs when deleting refs during a transaction
  refs.c: use a stringlist for repack_without_refs
  refs.c: add transaction support for renaming a reflog
  refs.c: update rename_ref to use a transaction
  refs.c: rollback the lockfile before we die() in repack_without_refs
  refs.c: move reflog updates into its own function
  refs.c: write updates to packed refs when a transaction has more than
    one ref
  remote.c: use a transaction for deleting refs
  refs.c: make repack_without_refs static
  refs.c: make the *_packed_refs functions static
  refs.c: replace the onerr argument in update_ref with a strbuf err
  refs.c: make add_packed_ref return an error instead of calling die
  refs.c: make lock_packed_refs take an err argument
  refs.c: add an err argument to pack_refs

 builtin/checkout.c    |   7 +-
 builtin/clone.c       |  36 ++-
 builtin/merge.c       |  20 +-
 builtin/notes.c       |  24 +-
 builtin/pack-refs.c   |   8 +-
 builtin/reflog.c      |  19 +-
 builtin/remote.c      |  69 +++---
 builtin/reset.c       |  12 +-
 builtin/update-ref.c  |   7 +-
 notes-cache.c         |   2 +-
 notes-utils.c         |   5 +-
 refs.c                | 616 ++++++++++++++++++++++++++++++--------------------
 refs.h                |  79 +++----
 t/t3200-branch.sh     |   7 -
 t/t5516-fetch-push.sh |   2 +-
 transport-helper.c    |   7 +-
 transport.c           |   9 +-
 17 files changed, 552 insertions(+), 377 deletions(-)

-- 
2.2.0.rc2.5.gf7b9fb2
