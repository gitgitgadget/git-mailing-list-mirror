From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/4] Using transactions for the reflog
Date: Wed, 26 Nov 2014 21:34:41 -0800
Message-ID: <1417066485-24921-1-git-send-email-sbeller@google.com>
References: <20141120181701.GB15945@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, gitster@pobox.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 06:34:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtrjC-0005BL-12
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 06:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbaK0Fet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 00:34:49 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:63951 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbaK0Fet (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 00:34:49 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so3949645ier.4
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 21:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T2Yalkd+laFlWCMFwwkKA7wPPd/H9+tXbWWlRktdYRY=;
        b=MVEf6sSiBZlFcRaBdugfgKrNPmiMbBTCWhs9Dcmo4ltEENBCrF5h+lnGIMEDiuCumi
         vnAs6TgwOtIKQ8Aq4hcvAnSIMf+rNP06JzerrI2xXzuX2xg8i3CMGQrwC2Poy8uzXrmB
         UX1C+b+jWShJIar8BwUzEgRQA3XrtP1ySssgMoYQ4rKMWE4AeSewaQO0QF3qM/28hMti
         I79aIv6gtfviWlHFpEeVc3kurbFIa7jDF3sl10iwl8bE7i+rZ+8Ii2t7LufnOH5AASZK
         Ha41NqN+ngCAncMaj4NuGUr8Jz6QAGd915XaV4PkmoaWkLLd8xQ6Y1kza/oMdRnPzo8Y
         oHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T2Yalkd+laFlWCMFwwkKA7wPPd/H9+tXbWWlRktdYRY=;
        b=GYwS8Wm6QMREfYb6MMUsNExEa1QZj2948dKu3pdQnX3Iecd7l+g9dWM2tRZURGnv8x
         L6ByFaJObRRX4bzEKqM53mG9rw4Kp/P+MYZsWUZNFFkn4axF3AGSsUAIO4d1w0+Jp8GX
         Vq/csk8OguOK2PBQ2O7DkDE2y0ay/QH3i6y2uiuecb2WxKV/t7uQUtCWGLz3w5qpUGK1
         WPMCUh/UFDcIL0X5HaNfkY5NlqpJdsm3YzOJ1LHdR+/A/8OEBnv1MUyX0Qlxdg/nUJ+t
         lSykndiRNn1Gfj0gjrU9Nc0bFBLyHxXsyZd4JGVqoR//XxE7W+hpYbiBHeS6lUoCuL6/
         Z3ow==
X-Gm-Message-State: ALoCoQmBL9o2EEz0sIegyLhPBcNmsTfIXpSndhZayA8HFF5ThOhafgRBlIXfzYdiLR2VbMriaewo
X-Received: by 10.50.79.135 with SMTP id j7mr26560091igx.14.1417066488177;
        Wed, 26 Nov 2014 21:34:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:3190:a053:325e:48b2])
        by mx.google.com with ESMTPSA id hi15sm8703878igb.19.2014.11.26.21.34.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Nov 2014 21:34:47 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <20141120181701.GB15945@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260335>

This is the core part of the refs-transactions-reflog series[1],
which was in discussion for a bit already.

The idea is to have the reflog being part of the transactions, which
the refs are already using, so the we're moving towards a database
like API in the long run. This makes git easier to maintain as well 
as opening the possibility to replace the backend with a real database.

The first patch is essentially just some sed magic with reformatting
the code, so the naming convention fits better, because the transactions 
will handle both the refs as well as the reflog after this series. 

The second patch introduces a new enum field to indicate, if we deal with
a ref or with a reflog entry in the transaction. 

The meat and most of the lines of code are found in the 3rd patch.
We introduce a rather lengthy function transaction_update_reflog,
which prepares all the reflog related changes.
The transaction_commit function will then also put the reflog changes
in place in a "best effort" atomic way.
Unlike in previous versions, we don't keep all the reflog in memory,
but use a temporary file in $GIT_DIR instead and the update can be done
using an atomic rename(...).

One of my todos is to make the error handling in the transaction_update_reflog
function a bit less repetitive either during the discussion of this series
or as a follow up.

The last patch in this series makes use of the transaction system in the 
user facing code, when running "git reflog expire" for example. 

I'd appreciate any comments. 

Apart from sending feedback on the list, you can find this series 
at github[2] embedded into the longer version of the series.
In that series at github there are a few more patches[3], which are already
reviewed and residing in Junios repository or considered trivial cleanups.

Thanks,
Stefan

[1] http://comments.gmane.org/gmane.comp.version-control.git/259712
[2] https://github.com/stefanbeller/git/commits/todo_sb13_ref-transactions-reflog-as-file
[3] The first 2 commits on top of Git 2.2-rc3 are origin/sb/ref-transaction-unify-to-update, 
    the third is in origin/sb/log-ref-write-fd, then comes this series in 4 patches. 
    The remaining latest 4 patches are clean up patches, mainly removing parts from the refs API
    which are no longer in use. I do not include these in this patch series, as I don't want to
    scare people away with a huge bulk of messages.

Ronnie Sahlberg (4):
  refs.c: rename the transaction functions
  refs.c: add a new update_type field to ref_update
  refs.c: add a transaction function to append a reflog entry
  reflog.c: use a reflog transaction when writing during expire

 branch.c               |  13 +--
 builtin/commit.c       |  10 +-
 builtin/fetch.c        |  12 +--
 builtin/receive-pack.c |  13 ++-
 builtin/reflog.c       |  85 ++++++++---------
 builtin/replace.c      |  10 +-
 builtin/tag.c          |  10 +-
 builtin/update-ref.c   |  26 ++---
 fast-import.c          |  22 ++---
 refs.c                 | 251 ++++++++++++++++++++++++++++++++++++++++---------
 refs.h                 |  57 +++++++----
 sequencer.c            |  12 +--
 walker.c               |  10 +-
 13 files changed, 352 insertions(+), 179 deletions(-)

-- 
2.2.0.rc3
