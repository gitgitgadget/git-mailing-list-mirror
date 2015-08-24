From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] "am" state file fix with write_file() clean-up
Date: Mon, 24 Aug 2015 10:09:41 -0700
Message-ID: <1440436186-7894-1-git-send-email-gitster@pobox.com>
References: <20150824065033.GA4124@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 19:09:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTvFq-000596-HP
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 19:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbbHXRJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 13:09:49 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35452 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbbHXRJs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 13:09:48 -0400
Received: by pdob1 with SMTP id b1so55569293pdo.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K78xU1o7r5PmIP9dT3rrqFoUcJSM8xU36h5czwvOjR0=;
        b=WZt/YF7/mpks31gGuB7AwAtzAfoVgaHkf2x/+dSPcVUx/p6Z/7ftFxLDlKFA/tgn+H
         XIFo2fhY+1X29f3jCjogli1i4HT3OsqAB9ZfTQD0tSiqklhnIEspId+Y3/A/LgM1ZY6O
         kEDI540cotU7ETAUkJ0WB0QyPhv7QBzjZ9q76M5zQUjivVQB85A3rgID9huMakWCW4bU
         UjlhLDWP0R+euoWhMhH5Ivn/o7A1UVS9J9r95O1X1JfMyLD6r2fcdN3ZyWijehWM8EZN
         AZ5Cczu/Q4ps21Dpy9T3dUelvXrQY/wmUR1mR0KtM+91MJ9HetzvWggf8QO0yArQM7x9
         Cx9Q==
X-Received: by 10.70.38.101 with SMTP id f5mr46896963pdk.140.1440436187777;
        Mon, 24 Aug 2015 10:09:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id mj1sm16617193pab.29.2015.08.24.10.09.47
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 10:09:47 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-568-g53a3e28
In-Reply-To: <20150824065033.GA4124@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276460>

So here is an solution based on the "write_file() is primarily to
produce text, so it should be able to correct the incomplete line
at the end" approach.

The first one is Peff's idea to consolidate callers in "am", in a
more concrete form.

The second is the fix to $gmane/276238.

The remainder is to clean up write_file() helper function.  All
callers except for two were passing 1 as one parameter, whose
meaning was not all obvious to a casual reader.

In patch 3/5, we flip the default behaviour of write_file() to die
upon error unless explicitly asked not to with WRITE_FILE_GENTLY
flag, and change the two oddball callers to pass this new flag.

In patch 4/5, we enhance the default behaviour of write_file() to
complete an incomplete line at the end, unless asked not to with
WRITE_FILE_BINARY flag; nobody passes this because all existing
callers want to produce a text file.

In patch 5/5, the transitional noise left by patches 3 and 4 are
cleaned up by updating the non-binary callers not to add LF
themselves and by changing the callers that pass 1 as flags
parameter to pass 0 (as bit (1<<0) is a no-op since patch 3/5).

The series is built on top of b5e8235, the current tip of the
pt/am-builtin-options topic.


Junio C Hamano (5):
  builtin/am: introduce write_state_*() helper functions
  builtin/am: make sure state files are text
  write_file(): introduce an explicit WRITE_FILE_GENTLY request
  write_file(): do not leave incomplete line at the end
  write_file(): clean up transitional mess of flag words and terminating LF

 builtin/am.c       | 68 ++++++++++++++++++++++++++++++++----------------------
 builtin/init-db.c  |  2 +-
 builtin/worktree.c | 10 ++++----
 cache.h            | 16 ++++++++++++-
 daemon.c           |  2 +-
 setup.c            |  2 +-
 submodule.c        |  2 +-
 transport.c        |  2 +-
 wrapper.c          | 13 +++++++++--
 9 files changed, 77 insertions(+), 40 deletions(-)

-- 
2.5.0-568-g53a3e28
