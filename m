From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] "am" state file fix with write_file() clean-up
Date: Mon, 24 Aug 2015 13:58:04 -0700
Message-ID: <1440449890-29490-1-git-send-email-gitster@pobox.com>
References: <xmqqzj1g31e5.fsf@gitster.dls.corp.google.com>
Cc: Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 22:58:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTyos-0006qD-6p
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 22:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbbHXU6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 16:58:13 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32972 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbbHXU6M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 16:58:12 -0400
Received: by pacti10 with SMTP id ti10so32072762pac.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e1lSkKCF44JtVSCcUiNf+QHH6IXKG715LUfT55PaJKg=;
        b=nLR8+ELoE53eYDHDsIBHYNbV6Ys6zVgPLPJiJ8B6UBul9hR2N/5v4PXZ/HksaZFXxu
         JkEY68A6+H2uNUpcNVGwIO3mEzg4zUYvgY1k9731sjXCPjK2qiavDMCkcDJqUQUP6W+V
         UOusTRNQjyGxdD6VlxZVUFWl43JzzuxfwPCcRghj589X2QttSUdBlZEcCz/TS1PYz70O
         vW0LA8Rf+ngD0/6rclWE+X1bOk+FyzwxMJmtnmfpj9WGx0qhjECTKNmVKzj92zUHELBN
         vZC6xXgX1H/MYK+gEwJGpcSTOmzEgvWJ34sQoLSytCDYXIWjD5UcQC87CEKuqskhNVkh
         rI6w==
X-Received: by 10.68.250.228 with SMTP id zf4mr49275790pbc.90.1440449891991;
        Mon, 24 Aug 2015 13:58:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id vv2sm15511401pab.21.2015.08.24.13.58.11
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 13:58:11 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-568-g53a3e28
In-Reply-To: <xmqqzj1g31e5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276480>

"git am" was recently reimplemented in C.  While the implementation
was done conservatively and followed the original logic in the
scripted version fairly faithfully, the state files it left in the
$GIT_DIR/rebase-apply directory were made slightly different by
mistake---they lacked the final LF, leaving their last line
incomplete.

The patch [1/6] is Peff's idea to consolidate callers in "am", in a
more concrete form.

The patch [2/6] is the fix to the state files with incomplete lines.

The workhorse helper function that implements "we have this (short)
body of text; create a new file that contains it" has a "fatal"
parameter, to which 1 was passed by almost all callers, but to
casual readers, it was unclear what that 1 meant.  The patch [3/6]
splits it to write_file() and write_file_gently() and drops this
parameter that looks mysterious at the callsites.  A common helper
function write_file_v() is introduced to implement these two as thin
wrappers of it.

The patch [4/6] updates write_file_v() so that it does the "we are
writing a text file.  Make sure it does not end with an incomplete
line" logic that [2/6] added only to builtin/am.c, thusly reverting
what was done to builtin/am.c in [2/6].

The patch [5/6] stops all callers that creates a single-liner file
using write_file() and write_file_gently() from including the final
LF to the format they pass.  This should not change the behaviour,
but it probably makes it conceptually cleaner.  You have the contents
to be placed on a single line, and the helper turns the contents
into a proper "line".

The patch [6/6] drops the final LF from the parameter to create a
multi-line file; while this does not hurt in the sense that the
callee will add a necessary LF back, I do not think it should be
applied.  Conceptually, if you have a buffer that contains a bunch
of lines and throw it at a helper to create a file, you'd better
have the terminating LF yourself before asking the helper to put
them in the file.

Junio C Hamano (6):
  builtin/am: introduce write_state_*() helper functions
  builtin/am: make sure state files are text
  write_file(): drop "fatal" parameter
  write_file_v(): do not leave incomplete line at the end
  write_file(): drop caller-supplied LF from calls to create a one-liner
    file
  write_file(): drop caller-supplied LF from multi-line file

 builtin/am.c       | 69 ++++++++++++++++++++++++++++++++----------------------
 builtin/branch.c   |  4 ++--
 builtin/init-db.c  |  2 +-
 builtin/worktree.c | 10 ++++----
 cache.h            |  5 ++--
 daemon.c           |  2 +-
 setup.c            |  2 +-
 submodule.c        |  2 +-
 transport.c        |  2 +-
 wrapper.c          | 36 ++++++++++++++++++++++++----
 10 files changed, 88 insertions(+), 46 deletions(-)

-- 
2.5.0-568-g53a3e28
